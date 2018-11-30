unit uGerente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Conexao,
  Vcl.Grids, Vcl.ComCtrls, Vcl.Mask, Vcl.Buttons;

type
  TfrmGerente = class(TForm)
    pcGerente: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    medCPF: TMaskEdit;
    ledNome: TLabeledEdit;
    ledSenha: TLabeledEdit;
    btCadastro: TButton;
    sgClientes: TStringGrid;
    bbtRemover: TBitBtn;
    bbtEditar: TBitBtn;
    cbCCorrente: TCheckBox;
    cbCSalario: TCheckBox;
    cbCPoupanca: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btCadastroClick(Sender: TObject);
    procedure TabSheet1Show(Sender: TObject);
    procedure sgClientesClick(Sender: TObject);
    procedure bbtRemoverClick(Sender: TObject);
    procedure bbtEditarClick(Sender: TObject);
    procedure VerificarContas(var cc, cs, cp: boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGerente: TfrmGerente;
  Conexao: TConexao;
  CPFo: string;

implementation

{$R *.dfm}

procedure TfrmGerente.bbtEditarClick(Sender: TObject);
var nomeO, senhaO, contasO: string;
begin
  CPFo := sgClientes.Cells[0, sgClientes.Row];
  nomeO := sgClientes.Cells[1, sgClientes.Row];
  senhaO := sgClientes.Cells[2, sgClientes.Row];
  contasO := sgClientes.Cells[6, sgCLientes.Row];

  TabSheet1.Show;
  TabSheet2.Enabled := false;
  medCPF.SetFocus;

  if 'c' in [contasO[1], contasO[2], contasO[3]] then
    cbCCorrente.Checked := true;
  if 's' in [contasO[1], contasO[2], contasO[3]] then
    cbCSalario.Checked := true;
  if 'p' in [contasO[1], contasO[2], contasO[3]] then
    cbCPoupanca.Checked := true;

  medCPF.Text := CPFo;
  ledNome.Text := nomeO;
  ledSenha.Text := senhaO;
  btCadastro.Tag := 1;
end;

procedure TfrmGerente.bbtRemoverClick(Sender: TObject);
var CPF: string;
begin
  CPF := sgClientes.Cells[0, sgClientes.Row];

  if (messagedlg('Deseja mesmo apagar o cliente?',mtError, mbOKCancel, 0) = mrOK) then
  begin
    Conexao.RemoverCliente(CPF);

    Conexao.AtualizaGrid(sgClientes);
  end;
end;

procedure TfrmGerente.btCadastroClick(Sender: TObject);
var CPF, nome, senha: string;
    cc, cs, cp: boolean;
begin
  if (medCPF.Text <> '') and (ledNome.Text <> '') and (ledSenha.Text <> '')
  and ((cbCCorrente.Checked) or (cbCSalario.Checked) or (cbCpoupanca.Checked)) then
  begin
    CPF := medCPF.Text;
    nome := ledNome.Text;
    senha := ledSenha.Text;

    VerificarContas(cc, cs, cp);

    //Cadastro de novo cliente
    if (btCadastro.Tag = 0) then
    begin
      if (Conexao.InsereCliente(CPF, nome, senha, cc, cs, cp) = true) then
      begin
        ShowMessage('Cliente cadastrado com sucesso!)');

        medCPF.Clear;
        ledNome.Clear;
        ledSenha.Clear;
        cbCCorrente.Checked := false;
        cbCSalario.Checked := false;
        cbCPoupanca.Checked := false;

        TabSheet2.Show;
        Conexao.AtualizaGrid(sgClientes);
      end;
    end
    //Edição
    else
    begin
      if (Conexao.EditaCliente(CPFo, CPF, nome, senha, cc, cs, cp) = true) then
      begin
        ShowMessage('Cliente editado com sucesso!)');

        medCPF.Clear;
        ledNome.Clear;
        ledSenha.Clear;
        cbCCorrente.Checked := false;
        cbCSalario.Checked := false;
        cbCPoupanca.Checked := false;

        Conexao.AtualizaGrid(sgClientes);
        TabSheet2.Enabled := true;
        TabSheet2.Show;
        btCadastro.Tag := 0;
      end;
    end;
  end;
end;

procedure TfrmGerente.FormCreate(Sender: TObject);
var ipv4, usuario, senha, banco: string;
begin
  Conexao := TConexao.Create();

  ipv4 := '35.199.122.71';
  usuario := 'lucasjulio';
  senha := 'Q6n?:a';
  banco := 'lucasjulio';

  Conexao.ConectaMySQL(ipv4,usuario,senha,banco);
end;

procedure TfrmGerente.sgClientesClick(Sender: TObject);
begin
  if(sgClientes.Row <> 0) then
  begin
  // Habilita os botões de edição e remoção
  bbtRemover.Enabled := true;
  bbtEditar.Enabled := true;
  end;
end;

procedure TfrmGerente.TabSheet1Show(Sender: TObject);
begin
  sgClientes.Cells[0, 0] := 'CPF';
  sgClientes.Cells[1, 0] := 'Nome';
  sgClientes.Cells[2, 0] := 'Senha';
  sgClientes.Cells[3, 0] := 'C Corrente';
  sgClientes.Cells[4, 0] := 'C Salário';
  sgClientes.Cells[5, 0] := 'C Poupança';
  sgClientes.Cells[6, 0] := 'Contas';

  sgClientes.ColWidths[0] := 30;
  sgClientes.ColWidths[1] := 40;
  sgClientes.ColWidths[2] := 45;
  sgClientes.ColWidths[3] := 25;
  sgClientes.ColWidths[4] := 25;
  sgClientes.ColWidths[5] := 25;
  sgClientes.ColWidths[6] := 15;

  Conexao.AtualizaGrid(sgClientes);
end;

procedure TfrmGerente.VerificarContas(var cc, cs, cp: boolean);
begin
  cc := false;
  cs := false;
  cp := false;

  if cbCCorrente.Checked then
    cc := true;
  if cbCSalario.Checked then
    cs := true;
  if cbCPoupanca.Checked then
    cp := true;
end;

end.
