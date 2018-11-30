unit uJL;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Conexao, uGerente, uATM,
  Vcl.Mask;

type
  TLogin = class(TForm)
    pnGerente: TPanel;
    btGerenteLogin: TButton;
    edGerenteSenha: TEdit;
    LbSenhaGer: TLabel;
    lbLoginGer: TLabel;
    Label1: TLabel;
    pnPrincipal: TPanel;
    btATM: TButton;
    btGerente: TButton;
    pnCliente: TPanel;
    LbLoginCli: TLabel;
    LbSenhaCli: TLabel;
    edClienteSenha: TEdit;
    btClienteLogin: TButton;
    Label2: TLabel;
    btVoltarC: TButton;
    btVoltarG: TButton;
    medGerenteCPF: TMaskEdit;
    medClienteCPF: TMaskEdit;
    procedure FormCreate(Sender: TObject);
    procedure btGerenteLoginClick(Sender: TObject);
    procedure btATMClick(Sender: TObject);
    procedure btGerenteClick(Sender: TObject);
    procedure btVoltarCClick(Sender: TObject);
    procedure btClienteLoginClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Login: TLogin;
  Conexao: TConexao;

implementation

{$R *.dfm}

procedure TLogin.btATMClick(Sender: TObject);
begin
  pnPrincipal.visible := false;
  pnGerente.visible := false;
  pnCliente.visible := true;
end;

procedure TLogin.btClienteLoginClick(Sender: TObject);
var cpf, senha: string;
begin
  if (medClienteCPF.Text <> '') and (edClienteSenha.Text <> '') then
  begin
    cpf := medClienteCPF.Text;
    senha := edClienteSenha.Text;

    if (Conexao.LoginCliente(cpf, senha) = true) then
    begin
      frmATM.lbCPFCliente.Caption := cpf;
      frmATM.ShowModal;

      medClienteCPF.Text := '';
      edClienteSenha.Text := '';
    end
    else
    begin
      ShowMessage('Verifique suas informações');
    end;
  end
  else
  begin
    ShowMessage('Faltam informações');
  end;
end;

procedure TLogin.btGerenteClick(Sender: TObject);
begin
  pnPrincipal.visible := false;
  pnGerente.visible := true;
  pnCliente.visible := false;
end;

procedure TLogin.btGerenteLoginClick(Sender: TObject);
var cpf, senha: string;
begin
  if (medGerenteCPF.Text <> '') and (edGerenteSenha.Text <> '') then
  begin
    cpf := medGerenteCPF.Text;
    senha := edGerenteSenha.Text;

    if (Conexao.LoginGerente(cpf, senha) = true) then
    begin
      medGerenteCPF.Text := '';
      edGerenteSenha.Text := '';

      frmGerente.ShowModal;
    end
    else
    begin
      ShowMessage('Verifique suas informações');
    end;
  end
  else
  begin
    ShowMessage('Faltam informações');
  end;
end;

procedure TLogin.btVoltarCClick(Sender: TObject);
begin
  pnPrincipal.visible := true;
  pnGerente.visible := false;
  pnCliente.visible := false;
end;

procedure TLogin.FormCreate(Sender: TObject);
var ipv4, usuario, senha, banco: string;
begin
  Conexao := TConexao.Create();

  ipv4 := '35.199.122.71';
  usuario := 'lucasjulio';
  senha := 'Q6n?:a';
  banco := 'lucasjulio';

  if Conexao.ConectaMySQL(ipv4,usuario,senha,banco) = TRUE then
  begin
    showmessage('Conectou ao banco na Google!');
  end
  else
  begin
    showmessage('Não foi possível conectar ao banco na Google!');
  end;
end;

end.
