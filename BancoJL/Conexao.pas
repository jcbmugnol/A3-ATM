unit Conexao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls , Vcl.grids,
  Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Data.SqlExpr , DBxMysQL;

type

  TConexao = class

    private

    MySQLConnection: TSQLConnection;
    MySQLQuery: TSQLQuery;

    public

    constructor Create();
    function ConectaMySQL (ipv4,usuario,senha,banco: string): boolean;
    function LoginCliente (CPF, senha: string): boolean;
    function InsereGerente (CPF, nome, senha: string): boolean;
    function InsereCliente (CPF, nome, senha: string; cc, cs, cp: boolean): boolean;
    function VerificaGerente (CPF, senha: string): boolean;
    function LoginGerente (CPF, senha: string): boolean;
    function ListarContas (CPF: string): boolean;
    function ListarSaldo (conta, CPF: string): real;
    function ListarLimite (CPF: string): real;
    function RealizaSaque (CPF, Conta: string; valor: real): boolean;
    function CalculaRendimentos (CPF: string; cod: integer): real;
    function RemoverCliente (CPF: string): boolean;
    function RemoverContaCorrente (CPF: string; cod: integer): boolean;
    function RemoverContaSalario (CPF: string; cod: integer): boolean;
    function RemoverContaPoupanca (CPF: string; cod: integer): boolean;
    function RealizaDeposito (CPF, Conta: string; valor: real): boolean;
    function EditaCliente (CPFo, CPFn, nome, senha: string; cc, cs, cp: boolean): boolean;
    function RealizaTransferencia (origem, destino: string; valor: real; dataHora: TDateTime): boolean;
    function SaqueExtrato (CPF: string; valor: real; dataHora: TDateTime): boolean;
    function DepositoExtrato (CPF: string; valor: real; data: TDateTime): boolean;
    function MaiorCodigo (table: string): integer;
    function TransferenciaCP (CPF, de, para: string; valor: real; data: TDateTime): boolean;
    function TransferenciaPC (CPF, de, para: string; valor: real; data: TDateTime): boolean;
    function TransferenciaSC (CPF, de, para: string; valor: real; data: TDateTime): boolean;
    function TransferenciaSP (CPF, de, para: string; valor: real; data: TDateTime): boolean;
    procedure AtualizaGrid (var grid: TStringGrid);

  end;

implementation

{ TConexao }

procedure TConexao.AtualizaGrid(var grid: TStringGrid);
var cont, tCPF, tNome, tSenha: integer;
begin
  MySQLQuery.SQL.Clear;

  MySQLQuery.SQL.Text := ('SELECT * FROM Cliente');
  MySQLQuery.ExecSQL;

  MySQLQuery.Open;
  MySQLQuery.First;

  cont := 1;
  grid.RowCount := 1;
  tCPF := 10;
  tNome := 10;
  tSenha := 10;

  while not (MySQLQuery.Eof) do
  begin
    grid.RowCount := grid.RowCount + 1;
    grid.Cells[0, cont] := MySQLQuery.FieldByName('CPF').AsString;
    grid.Cells[1, cont] := MySQLQuery.FieldByName('Nome').AsString;
    grid.Cells[2, cont] := MySQLQuery.FieldByName('Senha').AsString;
    grid.Cells[3, cont] := MySQLQuery.FieldByName('Saldo_CC').AsFloat.ToString;
    grid.Cells[4, cont] := MySQLQuery.FieldByName('Saldo_CS').AsFloat.ToString;
    grid.Cells[5, cont] := MySQLQuery.FieldByName('Saldo_CP').AsFloat.ToString;
    grid.Cells[6, cont] := MySQLQuery.FieldByName('Contas').AsString;

    if (tCPF <= grid.Cells[0, cont].Length) then
      tCPF := grid.Cells[0, cont].Length;

    if (tNome <= grid.Cells[1, cont].Length) then
      tCPF := grid.Cells[1, cont].Length;

    if (tSenha <= grid.Cells[2, cont].Length) then
      tCPF := grid.Cells[2, cont].Length;

    Inc(cont);

    MySQLQuery.Next;
  end;

  MySQLQuery.Close;
  grid.ColWidths[0] := tCPF*8;
  grid.ColWidths[1] := tNome*8;
  grid.ColWidths[2] := tSenha*8;
  grid.ColWidths[3] := 20;
  grid.ColWidths[4] := 20;
  grid.ColWidths[5] := 20;
  grid.ColWidths[6] := 20;

end;

function TConexao.CalculaRendimentos(CPF: string; cod: integer): real;
begin

end;

function TConexao.ConectaMySQL(ipv4, usuario, senha, banco: string): boolean;
begin

  MySQLConnection := TSQLConnection.Create(MySQLConnection);
  MySQLConnection.DriverName := 'MySQL';
  MySQLConnection.GetDriverFunc := 'getSQLDriverMYSQL';
  MySQLConnection.LibraryName := 'dbxmys.dll';
  MySQLConnection.VendorLib := 'LIBMYSQL.dll';
  MySQLConnection.Params.Values['HostName'] := ipv4;
  MySQLConnection.Params.Values['User_Name'] := usuario;
  MySQLConnection.Params.Values['Password'] := senha;
  MySQLConnection.Params.Values['Database'] := banco;
  MySQLConnection.Params.Values['ServerCharSet'] := 'utf8';
  MySQLConnection.LoginPrompt := False;

  try
  begin

    MySQLConnection.Connected := True;
    MySQLQuery := TSQLQuery.Create(MySQLQuery);
    MySQLQuery.SQLConnection := MySQLConnection;
    Result := True;

  end;
  except on E: Exception do
  begin
     Result := False;
  end;

  end;
end;

constructor TConexao.Create;
begin

end;

function TConexao.DepositoExtrato(CPF: string; valor: real; data: TDateTime): boolean;
var cod: integer;
begin
  MySQLQuery.SQL.Clear;

  MySQLQuery.SQL.Add('INSERT INTO ContaCorrente (Origem, Valor, DataHoraLiq, Descr)');
  MySQLQuery.SQL.Add('VALUES (:Origem, :Valor, :DataHoraLiq, "Depósito")');
  MySQLQuery.Params[0].AsString := CPF;
  MySQLQuery.Params[1].AsFloat := valor;
  MySQLQuery.Params[2].AsDate := data;

  MySQLQuery.ExecSQL;
  MySQLQuery.Close;

  result := true;
end;

function TConexao.EditaCliente(CPFo, CPFn, nome, senha: string; cc, cs, cp: boolean): boolean;
var contas: string;
begin
  contas := '';
  if cc then
    contas := contas + 'c';
  if cs then
    contas := contas + 's';
  if cp then
    contas := contas + 'p';

  MySQLQuery.SQL.Clear;

  MySQLQuery.SQL.Add('UPDATE Cliente');
  MySQLQuery.SQL.Add('SET CPF = :CPFn, Nome = :nome, Senha = :senha, Contas = :contas WHERE CPF = :CPFo');
  MySQLQuery.Params[0].AsString := CPFn;
  MySQLQuery.Params[1].AsString := nome;
  MySQLQuery.Params[2].AsString := senha;
  MySQLQuery.Params[3].AsString := contas;
  MySQLQuery.Params[4].AsString := CPFo;
  MySQLQuery.ExecSQL;
  MySQLQuery.Close;

  result := true;
end;

function TConexao.InsereCliente(CPF, nome, senha: string; cc, cs, cp: boolean): boolean;
var contas: string;
begin
  contas := '';
  if cc then
    contas := contas + 'c';
  if cs then
    contas := contas + 's';
  if cp then
    contas := contas + 'p';

  MySQLQuery.SQL.Clear;

  MySQLQuery.SQL.Add('INSERT INTO Cliente (CPF,Nome,Senha,Saldo_CC,Saldo_CS,Saldo_CP,Contas)');
  MySQLQuery.SQL.Add('VALUES (:CPF, :nome, :senha, :Saldo_CC, :Saldo_CS, :Saldo_CP, :Contas)');

  MySQLQuery.Params[0].AsString := CPF;
  MySQLQuery.Params[1].AsString := nome;
  MySQLQuery.Params[2].AsString := senha;
  MySQLQuery.Params[3].AsFloat := 0.0;
  MySQLQuery.Params[4].AsFloat := 0.0;
  MySQLQuery.Params[5].AsFloat := 0.0;
  MySQLQuery.Params[6].AsString := contas;

  MySQLQuery.ExecSQL;
  MySQLQuery.Close;

  result := true;
end;

function TConexao.InsereGerente(CPF, nome, senha: string): boolean;
var query: string;
begin
  MySQLQuery.SQL.Clear;

  MySQLQuery.SQL.Add('INSERT INTO Gerente (CPF,Nome,Senha)');
  MySQLQuery.SQL.Add('VALUES (:CPF, :nome, :senha)');
	MySQLQuery.Params[0].AsString := CPF;
  MySQLQuery.Params[1].AsString := nome;
  MySQLQuery.Params[2].AsString := senha;
  MySQLQuery.ExecSQL;
  MySQLQuery.Close;

  result := true;
end;

function TConexao.ListarContas(CPF: string): boolean;
begin

end;

function TConexao.ListarLimite(CPF: string): real;
begin

end;

function TConexao.ListarSaldo(conta, CPF: string): real;
var c: string;
    saldo: real;
    query:string;
begin
  if conta = 'c' then
    c := 'Saldo_CC';
  if conta = 's' then
    c := 'Saldo_CS';
  if conta = 'p' then
    c := 'Saldo_CP';

  saldo := 0;

  MySQLQuery.SQL.Clear;
  query:= 'SELECT ' + c + ' FROM Cliente WHERE CPF = ' + CPF + ';';
  MySQLQuery.SQL.Text := 'SELECT ' + c + ' FROM Cliente WHERE CPF = ' + CPF + ';';

  MySQLQuery.ExecSQL;

  MySQLQuery.Open;
  MySQLQuery.First;

  saldo := MySQLQuery.FieldByName(c).AsFloat;

  MySQLQuery.Close;

  result := saldo;

end;

function TConexao.LoginCliente(CPF, senha: string): boolean;
var query: string;
begin
  MySQLQuery.SQL.Clear;

  query := 'SELECT * FROM Cliente;';

  MySQLQuery.SQL.Text := query;
  MySQLQuery.ExecSQL;

  MySQLQuery.Open;
  MySQLQuery.First;

  Result := false;
  while not MySQLQuery.Eof do
  begin
    if ((MySQLQuery.FieldByName('CPF').AsString) = CPF)  and
       ((MySQLQuery.FieldByName('Senha').AsString) = Senha) then
    begin
      Result := true;
      break;
    end;

    MySQLQuery.Next;
  end;

  MySQLQuery.Close;
end;

function TConexao.LoginGerente(CPF, senha: string): boolean;
var query: string;
begin
  MySQLQuery.SQL.Clear;

  query := 'SELECT * FROM Gerente;';

  MySQLQuery.SQL.Text := query;
  MySQLQuery.ExecSQL;

  MySQLQuery.Open;
  MySQLQuery.First;

  Result := false;
  while not MySQLQuery.Eof do
  begin
    if ((MySQLQuery.FieldByName('CPF').AsString) = CPF)  and
       ((MySQLQuery.FieldByName('Senha').AsString) = Senha) then
    begin
      Result := true;
      break;
    end;

    MySQLQuery.Next;
  end;

  MySQLQuery.Close;
end;

function TConexao.MaiorCodigo(table: string): integer;
var c: string;
    max: integer;
begin
  if table = 'ContaCorrente' then
    c := 'Cod_CC';
  if table = 'ContaSalario' then
    c := 'Cod_CS';
  if table = 'ContaPoupanca' then
    c := 'Cod_CP';

  MySQLQuery.SQL.Clear;

  MySQLQuery.SQL.Text := 'SELECT MAX(' + c + ') FROM ' + table + '';
  //ShowMessage(MySQLQuery.SQL.Text);
  MySQLQuery.ExecSQL;

  MySQLQuery.Open;
  MySQLQuery.First;

  //max := MySQLQuery.FieldByName('MAX(' + c + ')').AsInteger;
  max := MySQLQuery.Fields[0].AsInteger;
  ShowMessage(max.ToString);
  result := max + 1;
end;

function TConexao.RealizaDeposito(CPF, Conta: string; valor: real): boolean;
var Saldo: Real;
    c: string;
begin
  if conta = 'c' then
    c := 'Saldo_CC';
  if conta = 's' then
    c := 'Saldo_CS';
  if conta = 'p' then
    c := 'Saldo_CP';

  MySQLQuery.SQL.Clear;

  MySQLQuery.SQL.Text := '';
  saldo := ListarSaldo(Conta,CPF) ;
  saldo:= saldo + valor;

  MySQLQuery.SQL.Clear;

  MySQLQuery.SQL.Add('UPDATE Cliente') ;
  MySQLQuery.SQL.Add('SET ' + c + ' = :saldo');
  MySQLQuery.SQL.Add('WHERE CPF = :CPF');
  MySQLQuery.Params[0].AsFloat := saldo;
  MySQLQuery.Params[1].AsString := CPF;

  MySQLQuery.ExecSQL;
  MySQLQuery.Close;
end;

function TConexao.RealizaSaque(CPF, Conta: string; valor: real): boolean;
var Saldo: Real;
    c: string;
begin
  if conta = 'c' then
    c := 'Saldo_CC';
  if conta = 's' then
    c := 'Saldo_CS';
  if conta = 'p' then
    c := 'Saldo_CP';

  MySQLQuery.SQL.Clear;

  MySQLQuery.SQL.Text := '';
  saldo := ListarSaldo(Conta,CPF) ;
  saldo:= saldo - valor;

  MySQLQuery.SQL.Clear;

  MySQLQuery.SQL.Add('UPDATE Cliente') ;
  MySQLQuery.SQL.Add('SET ' + c + ' = :saldo');
  MySQLQuery.SQL.Add('WHERE CPF = :CPF');
  MySQLQuery.Params[0].AsFloat := saldo;
  MySQLQuery.Params[1].AsString := CPF;

  MySQLQuery.ExecSQL;
  MySQLQuery.Close;
end;

function TConexao.RealizaTransferencia(origem, destino: string; valor: real; dataHora: TDateTime): boolean;
begin
  RealizaSaque(origem, 'c', valor);
  RealizaDeposito(destino, 'c', valor);

  MySQLQuery.SQL.Clear;

  MySQLQuery.SQL.Add('INSERT INTO ContaCorrente(Origem, Destino, Valor, DataHoraLiq, Descr)');
  MySQLQuery.SQL.Add('VALUES (:Origem, :Destino, :Valor, :DataHoraLiq, "Transferência")');
  MySQLQuery.Params[0].AsString := origem;
  MySQLQuery.Params[1].AsString := destino;
  MySQLQuery.Params[2].AsFloat := valor;
  MySQLQuery.Params[3].AsDateTime := dataHora;
  MySQLQuery.ExecSQL;
  MySQLQuery.Close;
end;

function TConexao.RemoverCliente(CPF: string): boolean;
begin
  MySQLQuery.SQL.Clear;

  MySQLQuery.SQL.Text := 'DELETE FROM Cliente WHERE CPF = ' + CPF;
  MySQLQuery.ExecSQL;

  MySQLQuery.Close;
end;

function TConexao.RemoverContaCorrente(CPF: string; cod: integer): boolean;
begin

end;

function TConexao.RemoverContaPoupanca(CPF: string; cod: integer): boolean;
begin

end;

function TConexao.RemoverContaSalario(CPF: string; cod: integer): boolean;
begin

end;

function TConexao.SaqueExtrato(CPF: string; valor: real; dataHora: TDateTime): boolean;
begin
  MySQLQuery.SQL.Clear;

  MySQLQuery.SQL.Add('INSERT INTO ContaCorrente(Origem, Valor, DataHoraLiq, Descr)');
  MySQLQuery.SQL.Add('VALUES (:Origem, :Valor, :DataHoraLiq, "Saque")');
  MySQLQuery.Params[0].AsString := CPF;
  MySQLQuery.Params[1].AsFloat := valor;
  MySQLQuery.Params[2].AsDateTime := dataHora;
  MySQLQuery.ExecSQL;
  MySQLQuery.Close;
end;

function TConexao.TransferenciaCP(CPF, de, para: string; valor: real;
  data: TDateTime): boolean;
begin
  RealizaSaque(CPF, de, valor);
  RealizaDeposito(CPF, para, valor);

  MySQLQuery.SQL.Clear;

  MySQLQuery.SQL.Add('INSERT INTO ContaCorrente(Origem, Valor, DataHoraLiq, Descr)');
  MySQLQuery.SQL.Add('VALUES (:Origem, :Valor, :DataHoraLiq, "TransferênciaCP")');
  MySQLQuery.Params[0].AsString := CPF;
  MySQLQuery.Params[1].AsFloat := valor;
  MySQLQuery.Params[2].AsDateTime := data;
  MySQLQuery.ExecSQL;
  MySQLQuery.Close;

  MySQLQuery.SQL.Clear;

  MySQLQuery.SQL.Add('INSERT INTO ContaPoupanca(Destino, Valor, DataHoraLiq, Descr)');
  MySQLQuery.SQL.Add('VALUES (:Destino, :Valor, :DataHoraLiq, "TransferênciaCP")');
  MySQLQuery.Params[0].AsString := CPF;
  MySQLQuery.Params[1].AsFloat := valor;
  MySQLQuery.Params[2].AsDateTime := data;
  MySQLQuery.ExecSQL;
  MySQLQuery.Close;

  result := true;
end;

function TConexao.TransferenciaPC(CPF, de, para: string; valor: real;
  data: TDateTime): boolean;
begin
  RealizaSaque(CPF, de, valor);
  RealizaDeposito(CPF, para, valor);

  MySQLQuery.SQL.Clear;

  MySQLQuery.SQL.Add('INSERT INTO ContaPoupanca(Origem, Valor, DataHoraLiq, Descr)');
  MySQLQuery.SQL.Add('VALUES (:Origem, :Valor, :DataHoraLiq, "TransferênciaPC")');
  MySQLQuery.Params[0].AsString := CPF;
  MySQLQuery.Params[1].AsFloat := valor;
  MySQLQuery.Params[2].AsDateTime := data;
  MySQLQuery.ExecSQL;
  MySQLQuery.Close;

  MySQLQuery.SQL.Clear;

  MySQLQuery.SQL.Add('INSERT INTO ContaCorrente(Destino, Valor, DataHoraLiq, Descr)');
  MySQLQuery.SQL.Add('VALUES (:Destino, :Valor, :DataHoraLiq, "TransferênciaPC")');
  MySQLQuery.Params[0].AsString := CPF;
  MySQLQuery.Params[1].AsFloat := valor;
  MySQLQuery.Params[2].AsDateTime := data;
  MySQLQuery.ExecSQL;
  MySQLQuery.Close;
end;

function TConexao.TransferenciaSC(CPF, de, para: string; valor: real;
  data: TDateTime): boolean;
begin
  RealizaSaque(CPF, de, valor);
  RealizaDeposito(CPF, para, valor);

  MySQLQuery.SQL.Clear;

  MySQLQuery.SQL.Add('INSERT INTO ContaSalario(Origem, Valor, DataHoraLiq, Descr)');
  MySQLQuery.SQL.Add('VALUES (:Origem, :Valor, :DataHoraLiq, "TransferênciaSC")');
  MySQLQuery.Params[0].AsString := CPF;
  MySQLQuery.Params[1].AsFloat := valor;
  MySQLQuery.Params[2].AsDateTime := data;
  MySQLQuery.ExecSQL;
  MySQLQuery.Close;

  MySQLQuery.SQL.Clear;

  MySQLQuery.SQL.Add('INSERT INTO ContaCorrente(Destino, Valor, DataHoraLiq, Descr)');
  MySQLQuery.SQL.Add('VALUES (:Destino, :Valor, :DataHoraLiq, "TransferênciaPC")');
  MySQLQuery.Params[0].AsString := CPF;
  MySQLQuery.Params[1].AsFloat := valor;
  MySQLQuery.Params[2].AsDateTime := data;
  MySQLQuery.ExecSQL;
  MySQLQuery.Close;
end;

function TConexao.TransferenciaSP(CPF, de, para: string; valor: real;
  data: TDateTime): boolean;
begin
  RealizaSaque(CPF, de, valor);
  RealizaDeposito(CPF, para, valor);

  MySQLQuery.SQL.Clear;

  MySQLQuery.SQL.Add('INSERT INTO ContaSalario(Origem, Valor, DataHoraLiq, Descr)');
  MySQLQuery.SQL.Add('VALUES (:Origem, :Valor, :DataHoraLiq, "TransferênciaPC")');
  MySQLQuery.Params[0].AsString := CPF;
  MySQLQuery.Params[1].AsFloat := valor;
  MySQLQuery.Params[2].AsDateTime := data;
  MySQLQuery.ExecSQL;
  MySQLQuery.Close;

  MySQLQuery.SQL.Clear;

  MySQLQuery.SQL.Add('INSERT INTO ContaPoupanca(Destino, Valor, DataHoraLiq, Descr)');
  MySQLQuery.SQL.Add('VALUES (:Destino, :Valor, :DataHoraLiq, "TransferênciaSP")');
  MySQLQuery.Params[0].AsString := CPF;
  MySQLQuery.Params[1].AsFloat := valor;
  MySQLQuery.Params[2].AsDateTime := data;
  MySQLQuery.ExecSQL;
  MySQLQuery.Close;
end;

function TConexao.VerificaGerente(CPF, senha: string): boolean;
begin

end;

end.
