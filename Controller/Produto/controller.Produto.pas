unit controller.Produto;

interface

uses
  model.Produto, UFuncoes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL, Data.DB, FireDAC.Comp.Client, System.SysUtils;

Type TControllerProduto = class(TModelProduto)
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

procedure TControllerProduto.Atualizar;
var QryExec : TFDQuery;
begin
  if ID = 0 then
    Exit;

  try
    QryExec := CriarQuery(vConexao);

    QryExec.SQL.Add('UPDATE PRODUTOS SET');
    QryExec.SQL.Add('DESCRICAO = :DESCRICAO, PRECO_VENDA = :PRECO_VENDA');
    QryExec.SQL.Add('WHERE');
    QryExec.SQL.Add('ID = :ID');
    QryExec.ParamByName('ID').AsInteger           := ID;
    QryExec.ParamByName('DESCRICAO').AsString     := Descricao;
    QryExec.ParamByName('PRECO_VENDA').AsCurrency := PrecoVenda;

    QryExec.ExecSQL;

    FreeAndNil(QryExec);
  except on e: exception do
    raise exception.Create('Erro ao Atualizar Produtos... ' + e.Message);
  end;
end;

procedure TControllerProduto.Cadastrar;
var QryExec : TFDQuery;
begin
  try
    QryExec := CriarQuery(vConexao);

    QryExec.SQL.Add('INSERT INTO PRODUTOS');
    QryExec.SQL.Add('(DESCRICAO, PRECO_VENDA)');
    QryExec.SQL.Add('VALUES');
    QryExec.SQL.Add('(:DESCRICAO, :PRECO_VENDA)');
    QryExec.ParamByName('DESCRICAO').AsString     := Descricao;
    QryExec.ParamByName('PRECO_VENDA').AsCurrency := PrecoVenda;

    QryExec.ExecSQL;

    ID := vConexao.ExecSQLScalar('SELECT LAST_INSERT_ID()');

    FreeAndNil(QryExec);
  except on e: exception do
    raise exception.Create('Erro ao Cadastrar Produtos... ' + e.Message);
  end;
end;

constructor TControllerProduto.Create(AConn: TFDConnection);
begin
  vConexao := AConn;
end;

procedure TControllerProduto.Deletar;
var QryExec : TFDQuery;
begin
  if id = 0 then
    exit;

  try
    QryExec := CriarQuery(vConexao);

    QryExec.SQL.Add('DELETE FROM PRODUTOS WHERE ID = :ID');
    QryExec.ParamByName('ID').AsInteger := ID;
    QryExec.ExecSQL;

    FreeAndNil(QryExec);
  except on e: exception do
    raise exception.Create('Erro ao Deletar Produtos... ' + e.Message);
  end;
end;

function TControllerProduto.RetornaQryConsulta: TFDquery;
var QryCons : TFDQuery;
begin
  try
    QryCons := CriarQuery(vConexao);

    QryCons.SQL.Add('SELECT * FROM PRODUTOS WHERE DESCRICAO LIKE :DESCRICAO');
    QryCons.ParamByName('DESCRICAO').AsString := '%' + Descricao + '%';
    QryCons.Open;

    Result := QryCons;

  except on e: exception do
    raise exception.Create('Erro ao Consultar Produtos... ' + e.Message);
  end;
end;

procedure TControllerProduto.Carregar;
var QryCons : TFDQuery;
begin
  if id = 0 then
    exit;

  try
    QryCons := CriarQuery(vConexao);

    QryCons.SQL.Add('SELECT * FROM PRODUTOS');
    QryCons.SQL.Add('WHERE');
    QryCons.SQL.Add('ID = :ID');
    QryCons.ParamByName('ID').AsInteger := ID;
    QryCons.Open;

    PrecoVenda := QryCons.FieldByName('PRECO_VENDA').AsCurrency;
    Descricao  := QryCons.FieldByName('DESCRICAO').AsString;

    FreeAndNil(QryCons);
  except on e: exception do
    raise exception.Create('Erro ao Carregar Produtos... ' + e.Message);
  end;
end;

end.

