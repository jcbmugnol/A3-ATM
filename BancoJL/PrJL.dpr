program PrJL;

uses
  Vcl.Forms,
  uJL in 'uJL.pas' {Login},
  Conexao in 'Conexao.pas',
  uGerente in 'uGerente.pas' {frmGerente},
  uATM in 'uATM.pas' {frmATM};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TLogin, Login);
  Application.CreateForm(TfrmGerente, frmGerente);
  Application.CreateForm(TfrmATM, frmATM);
  Application.Run;
end.
