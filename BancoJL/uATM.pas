unit uATM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Conexao, Vcl.StdCtrls, Vcl.Mask,
  Vcl.ExtCtrls;

type
  TfrmATM = class(TForm)
    btSaque: TButton;
    btTransferencia: TButton;
    btDeposito: TButton;
    btExtrato: TButton;
    pnSaque: TPanel;
    medSaque: TMaskEdit;
    Label1: TLabel;
    btSacar: TButton;
    lbCPFCliente: TLabel;
    rgConta: TRadioGroup;
    pnDeposito: TPanel;
    Label2: TLabel;
    medDeposito: TMaskEdit;
    btDepositar: TButton;
    lbSaldo: TLabel;
    pnTrans: TPanel;
    pnExtrato: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    btReaExtrato: TButton;
    lstExtrato: TListBox;
    medDatLim: TMaskEdit;
    medDatIni: TMaskEdit;
    Button1: TButton;
    Button2: TButton;
    medCPFTrans: TMaskEdit;
    lbTrans: TLabel;
    rgTransConta: TRadioGroup;
    medValorTrans: TMaskEdit;
    lbValorTrans: TLabel;
    btTrans: TButton;
    procedure btSaqueClick(Sender: TObject);
    procedure rgContaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btSacarClick(Sender: TObject);
    procedure btDepositarClick(Sender: TObject);
    procedure btDepositoClick(Sender: TObject);
    procedure btTransferenciaClick(Sender: TObject);
    procedure btExtratoClick(Sender: TObject);
    procedure btTransClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmATM: TfrmATM;
  CPF, nome: string;
  Conexao: TConexao;
  saldo: real;

implementation

{$R *.dfm}

function SelecionaConta(rg: TRadioGroup): string;
begin
  if rg.ItemIndex = 0 then
    result := 'c';
  if rg.ItemIndex = 1 then
    result := 's';
  if rg.ItemIndex = 2 then
    result := 'p';
end;

procedure TfrmATM.btDepositarClick(Sender: TObject);
var valorDeposito, saldo: real;
begin
  valorDeposito := StrToFloat(medDeposito.Text);

  Conexao.RealizaDeposito(CPF, SelecionaConta(rgConta), valorDeposito);

  saldo := Conexao.ListarSaldo(SelecionaConta(rgConta), CPF);
  lbSaldo.Caption := 'Saldo: ' + floattostr(saldo);

  Conexao.DepositoExtrato(CPF, valorDeposito, now);

  medDeposito.Clear;
end;

procedure TfrmATM.btDepositoClick(Sender: TObject);
begin
  pnSaque.Visible := false;
  pnDeposito.Visible := true;
  pnTrans.Visible := false;
  pnExtrato.Visible := false;
end;

procedure TfrmATM.btExtratoClick(Sender: TObject);
begin
  pnSaque.Visible := false;
  pnDeposito.Visible := false;
  pnTrans.Visible := false;
  pnExtrato.Visible := true;
end;

procedure TfrmATM.btSacarClick(Sender: TObject);
var valorSaque, saldo: real;
    dataHora: TDateTime;
begin
  valorSaque := StrToFloat(medSaque.Text);

  Conexao.RealizaSaque(CPF, SelecionaConta(rgConta), valorSaque);

  saldo := Conexao.ListarSaldo(SelecionaConta(rgConta), CPF);
  lbSaldo.Caption := 'Saldo: ' + floattostr(saldo);

  dataHora := now;
  Conexao.SaqueExtrato(CPF, valorSaque, dataHora);

  medSaque.Clear;
end;

procedure TfrmATM.btSaqueClick(Sender: TObject);
begin
  pnSaque.Visible := true;
  pnDeposito.Visible := false;
  pnTrans.Visible := false;
  pnExtrato.Visible := false;
end;

procedure TfrmATM.btTransClick(Sender: TObject);
var destino: string;
    valor, saldo: real;
begin
  valor := strtofloat(medValorTrans.Text);

  if btTrans.Tag = 1 then
  begin
    if (rgConta.ItemIndex = 0) then
    begin
      Conexao.TransferenciaCP(CPF, 'c', 'p', valor, now);
    end
    else
    if (rgConta.ItemIndex = 1) then
    begin
      if (rgTransConta.ItemIndex = 0) then
      begin
        Conexao.TransferenciaSC(CPF, 's', 'c', valor, now);
      end
      else
      if (rgTransConta.ItemIndex = 1) then
      begin
        Conexao.TransferenciaSP(CPF, 's', 'p', valor, now);
      end;
    end
    else
    if (rgConta.ItemIndex = 2) then
    begin
      Conexao.TransferenciaPC(CPF, 'p', 'c', valor, now);
    end;
  end
  else
  begin
    destino := medCPFTrans.Text;

    Conexao.RealizaTransferencia(CPF, destino, valor, now);
  end;

  saldo := Conexao.ListarSaldo(SelecionaConta(rgConta), CPF);
  lbSaldo.Caption := 'Saldo: ' + floattostr(saldo);

  medValorTrans.Clear;
  medCPFTrans.Clear;
  rgTransConta.ItemIndex := -1;
end;

procedure TfrmATM.btTransferenciaClick(Sender: TObject);
begin
  pnSaque.Visible := false;
  pnDeposito.Visible := false;
  pnTrans.Visible := true;
  pnExtrato.Visible := false;
end;

procedure TfrmATM.Button1Click(Sender: TObject);
begin
  lbValorTrans.Visible := true;
  medValorTrans.Visible := true;
  lbTrans.Visible := false;
  medCPFTrans.Visible := false;
  rgTransConta.Visible := true;

  btTrans.Tag := 1;
end;

procedure TfrmATM.Button2Click(Sender: TObject);
begin
  lbValorTrans.Visible := true;
  medValorTrans.Visible := true;
  lbTrans.Visible := true;
  medCPFTrans.Visible := true;
  rgTransConta.Visible := false;

  btTrans.Tag := 2;
end;

procedure TfrmATM.FormActivate(Sender: TObject);
var ipv4, usuario, senha, banco: string;
begin
  Conexao := TConexao.Create();

  ipv4 := '35.199.122.71';
  usuario := 'lucasjulio';
  senha := 'Q6n?:a';
  banco := 'lucasjulio';

  Conexao.ConectaMySQL(ipv4,usuario,senha,banco);

  CPF := lbCPFCliente.Caption;
end;

procedure TfrmATM.rgContaClick(Sender: TObject);
begin
  btSaque.Enabled := true;
  btTransferencia.Enabled := true;
  btDeposito.Enabled := true;
  btExtrato.Enabled := true;

  saldo := Conexao.ListarSaldo(SelecionaConta(rgConta), CPF);

  lbSaldo.Caption := 'Saldo: ' + FloatToStr(Saldo);

  if (rgConta.ItemIndex = 0) then
  begin
    rgTransConta.Items.Clear;
    rgTransConta.Items.Add('CP');
  end
  else
  if (rgConta.ItemIndex = 1) then
  begin
    rgTransConta.Items.Clear;
    rgTransConta.Items.Add('CC');
    rgTransConta.Items.Add('CP');
  end
  else
  if (rgConta.ItemIndex = 2) then
  begin
    rgTransConta.Items.Clear;
    rgTransConta.Items.Add('CC');
  end;
end;

end.
