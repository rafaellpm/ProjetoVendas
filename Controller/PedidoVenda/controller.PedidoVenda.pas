unit controller.PedidoVenda;

interface

uses
  model.PedidoVenda, UFuncoes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL, Data.DB, FireDAC.Comp.Client,
  System.SysUtils, controller.Cliente;

Type TControllerPedidoVenda = class(TModelPedidoVenda)
  private
    vConexao : TFDConnection;
  public
    Cliente : TControllerCliente;
    procedure Carregar;
    procedure Cadastrar;
    procedure Atualizar;
    procedure Deletar;
    procedure Clear;

    function RetornaQryConsulta: TFDquery;
    function RetornaTotalPedido: Currency;

    constructor Create(AConn : TFDConnection);
end;

implementation

{ TControllerCliente }

procedure TControllerPedidoVenda.Atualizar;
var QryExec : TFDQuery;
begin
  if ID = 0 then
    exit;

  try
    QryExec := CriarQuery(vConexao);

    QryExec.SQL.Add('UPDATE PEDIDO_VENDA SET');
    QryExec.SQL.Add('CD_CLIENTE = :CD_CLIENTE, VALOR_TOTAL = :VALOR_TOTAL');
    QryExec.SQL.Add('WHERE');
    QryExec.SQL.Add('ID = :ID');
    QryExec.ParamByName('ID').AsInteger           := ID;
    QryExec.ParamByName('VALOR_TOTAL').AsCurrency := ValorTotal;
    QryExec.ParamByName('CD_CLIENTE').AsInteger   := CdCliente;

    QryExec.ExecSQL;

    FreeAndNil(QryExec);
  except on e: exception do
    raise exception.Create('Erro ao Atualizar PedidoVenda... ' + e.Message);
  end;
end;

procedure TControllerPedidoVenda.Cadastrar;
var QryExec : TFDQuery;
begin
  try
    QryExec := CriarQuery(vConexao);

    QryExec.SQL.Add('INSERT INTO PEDIDO_VENDA');
    QryExec.SQL.Add('(CD_CLIENTE, VALOR_TOTAL, DT_EMISSAO)');
    QryExec.SQL.Add('VALUES');
    QryExec.SQL.Add('(:CD_CLIENTE, :VALOR_TOTAL, :DT_EMISSAO)');
    QryExec.ParamByName('VALOR_TOTAL').AsCurrency := 0;
    QryExec.ParamByName('CD_CLIENTE').AsInteger   := CdCliente;
    QryExec.ParamByName('DT_EMISSAO').AsDateTime  := Now;

    QryExec.ExecSQL;

    ID := vConexao.ExecSQLScalar('SELECT LAST_INSERT_ID()');

    FreeAndNil(QryExec);

  except on e: exception do
    raise exception.Create('Erro ao Cadastrar PedidoVenda... ' + e.Message);
  end;
end;

procedure TControllerPedidoVenda.Carregar;
var QryCons : TFDQuery;
begin
  if ID = 0 then
    exit;

  try
    QryCons := CriarQuery(vConexao);

    QryCons.SQL.Add('SELECT * FROM PEDIDO_VENDA');
    QryCons.SQL.Add('WHERE');
    QryCons.SQL.Add('ID = :ID');
    QryCons.ParamByName('ID').AsInteger := ID;
    QryCons.Open;

    ValorTotal := QryCons.FieldByName('VALOR_TOTAL').AsCurrency;
    CdCliente  := QryCons.FieldByName('CD_CLIENTE').AsInteger;
    DtEmissao  := QryCons.FieldByName('DT_EMISSAO').AsDateTime;

    Cliente.ID := CdCliente;
    Cliente.Carregar;

    FreeAndNil(QryCons);

  except on e: exception do
    raise exception.Create('Erro ao Carregar PedidoVenda... ' + e.Message);
  end;
end;

procedure TControllerPedidoVenda.Clear;
begin
  ID          := 0;
  CdCliente   := 0;
  ValorTotal  := 0;
end;

constructor TControllerPedidoVenda.Create(AConn: TFDConnection);
begin
  vConexao := AConn;
  Cliente  := TControllerCliente.Create(vConexao);
end;

procedure TControllerPedidoVenda.Deletar;
var QryExec : TFDQuery;
begin
  if ID = 0 then
    exit;

  try
    QryExec := CriarQuery(vConexao);

    QryExec.SQL.Add('DELETE FROM PEDIDO_VENDA WHERE ID = :ID');
    QryExec.ParamByName('ID').AsInteger := ID;

    QryExec.ExecSQL;

    FreeAndNil(QryExec);
  except on e: exception do
    raise exception.Create('Erro ao Deletar PedidoVenda... ' + e.Message);
  end;
end;

function TControllerPedidoVenda.RetornaQryConsulta: TFDquery;
var QryCons : TFDQuery;
begin
  try
    QryCons := CriarQuery(vConexao);

    QryCons.SQL.Add('SELECT PV.*, C.NOME_CLIENTE FROM PEDIDO_VENDA AS PV');
    QryCons.SQL.Add('INNER JOIN CLIENTES AS C ON C.ID = PV.CD_CLIENTE');
    QryCons.SQL.Add('WHERE NOME_CLIENTE LIKE :NOME_CLIENTE');
    QryCons.ParamByName('NOME_CLIENTE').AsString := '%' + Cliente.NomeCliente + '%';
    QryCons.Open;

    Result := QryCons;

  except on e: exception do
    raise exception.Create('Erro ao Consultar Produtos... ' + e.Message);
  end;
end;

function TControllerPedidoVenda.RetornaTotalPedido: Currency;
var QryCons : TFDQuery;
begin
  if ID = 0 then
    exit;

  try
    QryCons := CriarQuery(vConexao);

    QryCons.SQL.Add('SELECT VALOR_TOTAL FROM PEDIDO_VENDA');
    QryCons.SQL.Add('WHERE');
    QryCons.SQL.Add('ID = :ID');
    QryCons.ParamByName('ID').AsInteger := ID;
    QryCons.Open;

    Result := QryCons.FieldByName('VALOR_TOTAL').AsCurrency;

    FreeAndNil(QryCons);

  except on e: exception do
    raise exception.Create('Erro ao Retornar Total PedidoVenda... ' + e.Message);
  end;
end;

end.

