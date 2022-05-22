unit controller.Cliente;

interface

uses
  model.Cliente, UFuncoes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL, Data.DB, FireDAC.Comp.Client, System.SysUtils;

Type TControllerCliente = class(TModelCliente)
  private
    vConexao : TFDConnection;
  public
    procedure Carregar;
    procedure Cadastrar;
    procedure Atualizar;
    procedure Deletar;

    function RetornaQryConsulta: TFDquery;

    constructor Create(AConn : TFDConnection);
end;

implementation

{ TControllerCliente }

procedure TControllerCliente.Atualizar;
var QryExec : TFDQuery;
begin
  if ID = 0 then
    exit;

  try
    QryExec := CriarQuery(vConexao);

    QryExec.SQL.Add('UPDATE CLIENTES SET');
    QryExec.SQL.Add('NOME_CLIENTE = :NOME_CLIENTE, CIDADE = :CIDADE, UF = :UF');
    QryExec.SQL.Add('WHERE');
    QryExec.SQL.Add('ID = :ID');
    QryExec.ParamByName('ID').AsInteger          := ID;
    QryExec.ParamByName('NOME_CLIENTE').AsString := NomeCliente;
    QryExec.ParamByName('CIDADE').AsString       := Cidade;
    QryExec.ParamByName('UF').AsString           := UF;

    QryExec.ExecSQL;

    FreeAndNil(QryExec);

  except on e: exception do
    raise exception.Create('Erro ao Atualizar Cliente... ' + e.Message);
  end;
end;

procedure TControllerCliente.Cadastrar;
var QryExec : TFDQuery;
begin
  try
    QryExec := CriarQuery(vConexao);

    QryExec.SQL.Add('INSERT INTO CLIENTES');
    QryExec.SQL.Add('(NOME_CLIENTE, CIDADE, UF)');
    QryExec.SQL.Add('VALUES');
    QryExec.SQL.Add('(:NOME_CLIENTE, :CIDADE, :UF)');
    QryExec.ParamByName('NOME_CLIENTE').AsString := NomeCliente;
    QryExec.ParamByName('CIDADE').AsString       := Cidade;
    QryExec.ParamByName('UF').AsString           := UF;

    QryExec.ExecSQL;

    ID := vConexao.ExecSQLScalar('SELECT LAST_INSERT_ID()');

    FreeAndNil(QryExec);

  except on e: exception do
    raise exception.Create('Erro ao Cadastrar Cliente... ' + e.Message);
  end;
end;

constructor TControllerCliente.Create(AConn: TFDConnection);
begin
  vConexao := AConn;
end;

procedure TControllerCliente.Deletar;
var QryExec : TFDQuery;
begin
  if ID = 0 then
    exit;

  try
    QryExec := CriarQuery(vConexao);

    QryExec.SQL.Add('DELETE FROM CLIENTES WHERE ID = :ID');
    QryExec.ParamByName('ID').AsInteger := ID;

    QryExec.ExecSQL;

    FreeAndNil(QryExec);

  except on e: exception do
    raise exception.Create('Erro ao Deletar Cliente... ' + e.Message);
  end;
end;

function TControllerCliente.RetornaQryConsulta: TFDquery;
var QryCons : TFDQuery;
begin
  try
    QryCons := CriarQuery(vConexao);

    QryCons.SQL.Add('SELECT * FROM CLIENTES WHERE NOME_CLIENTE LIKE :NOME_CLIENTE');
    QryCons.ParamByName('NOME_CLIENTE').AsString := '%' + NomeCliente + '%';
    QryCons.Open;

    Result := QryCons;

  except on e: exception do
    raise exception.Create('Erro ao Consultar Produtos... ' + e.Message);
  end;
end;

procedure TControllerCliente.Carregar;
var QryCons : TFDQuery;
begin
  if ID = 0 then
    exit;

  try
    QryCons := CriarQuery(vConexao);

    QryCons.SQL.Add('SELECT * FROM CLIENTES');
    QryCons.SQL.Add('WHERE');
    QryCons.SQL.Add('ID = :ID');
    QryCons.ParamByName('ID').AsInteger := ID;
    QryCons.Open;

    NomeCliente := QryCons.FieldByName('NOME_CLIENTE').AsString;
    Cidade      := QryCons.FieldByName('CIDADE').AsString;
    UF          := QryCons.FieldByName('UF').AsString;

    FreeAndNil(QryCons);

  except on e: exception do
    raise exception.Create('Erro ao Carregar Cliente... ' + e.Message);
  end;
end;


end.
