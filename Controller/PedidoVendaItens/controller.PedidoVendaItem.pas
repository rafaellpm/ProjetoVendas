unit controller.PedidoVendaItem;

interface

uses
  model.PedidoVendaItem, UFuncoes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL, Data.DB, FireDAC.Comp.Client, System.SysUtils;

Type TControllerPedidoVendaItem = class(TModelPedidoVendaItem)
  private
    vConexao : TFDConnection;
    procedure RecalcularTotalPedidoVenda;
  public
    procedure Inserir;
    procedure Atualizar;
    procedure Deletar;
    procedure Clear;

    function RetornaQryConsulta: TFDquery;

    constructor Create(AConn : TFDConnection);
end;

implementation

{ TControllerCliente }

procedure TControllerPedidoVendaItem.Atualizar;
var QryExec : TFDQuery;
begin
  if id = 0 then
    Exit;

  try
    QryExec := CriarQuery(vConexao);

    QryExec.SQL.Add('UPDATE PEDIDO_VENDA_ITENS SET');
    QryExec.SQL.Add('CD_PRODUTO = :CD_PRODUTO, QUANTIDADE = :QUANTIDADE,');
    QryExec.SQL.Add('VALOR_UNITARIO = :VALOR_UNITARIO, VALOR_TOTAL = :VALOR_TOTAL');
    QryExec.SQL.Add('WHERE');
    QryExec.SQL.Add('ID = :ID AND NR_PEDIDO = :NR_PEDIDO');
    QryExec.ParamByName('ID').AsInteger              := ID;
    QryExec.ParamByName('NR_PEDIDO').AsCurrency      := NrPedido;
    QryExec.ParamByName('CD_PRODUTO').AsInteger      := CdProduto;
    QryExec.ParamByName('QUANTIDADE').AsCurrency     := Quantidade;
    QryExec.ParamByName('VALOR_UNITARIO').AsCurrency := ValorUnitario;
    QryExec.ParamByName('VALOR_TOTAL').AsCurrency    := ValorTotal;

    QryExec.ExecSQL;

    RecalcularTotalPedidoVenda();

    FreeAndNil(QryExec);
  except on e: exception do
    raise exception.Create('Erro ao Atualizar PedidoVendaItens... ' + e.Message);
  end;
end;

procedure TControllerPedidoVendaItem.Inserir;
var QryExec : TFDQuery;
begin
  try
    QryExec := CriarQuery(vConexao);

    QryExec.SQL.Add('INSERT INTO PEDIDO_VENDA_ITENS');
    QryExec.SQL.Add('(NR_PEDIDO, CD_PRODUTO, QUANTIDADE, VALOR_UNITARIO, VALOR_TOTAL, DT_INCLUSAO)');
    QryExec.SQL.Add('VALUES');
    QryExec.SQL.Add('(:NR_PEDIDO, :CD_PRODUTO, :QUANTIDADE, :VALOR_UNITARIO, :VALOR_TOTAL, :DT_INCLUSAO)');
    QryExec.ParamByName('NR_PEDIDO').AsCurrency      := NrPedido;
    QryExec.ParamByName('CD_PRODUTO').AsInteger      := CdProduto;
    QryExec.ParamByName('QUANTIDADE').AsCurrency     := Quantidade;
    QryExec.ParamByName('VALOR_UNITARIO').AsCurrency := ValorUnitario;
    QryExec.ParamByName('VALOR_TOTAL').AsCurrency    := ValorTotal;
    QryExec.ParamByName('DT_INCLUSAO').AsDateTime    := Now;

    QryExec.ExecSQL;

    RecalcularTotalPedidoVenda();

    ID := vConexao.ExecSQLScalar('SELECT LAST_INSERT_ID()');

    FreeAndNil(QryExec);
  except on e: exception do
    raise exception.Create('Erro ao Cadastrar PedidoVendaItens... ' + e.Message);
  end;
end;

function TControllerPedidoVendaItem.RetornaQryConsulta: TFDquery;
var QryCons : TFDQuery;
begin
  try
    QryCons := CriarQuery(vConexao);

    QryCons.SQL.Add('SELECT * FROM PEDIDO_VENDA_ITENS AS PVI');
    QryCons.SQL.Add('INNER JOIN PRODUTOS AS P ON P.ID = PVI.CD_PRODUTO');
    QryCons.SQL.Add('WHERE NR_PEDIDO = :NR_PEDIDO');
    QryCons.ParamByName('NR_PEDIDO').AsInteger := NrPedido;
    QryCons.Open;

    Result := QryCons;

  except on e: exception do
    raise exception.Create('Erro ao Consultar PedidoVendaItens... ' + e.Message);
  end;
end;

procedure TControllerPedidoVendaItem.RecalcularTotalPedidoVenda;
var QryCons, QryExec : TFDQuery;
begin
  try
    QryCons := CriarQuery(vConexao);
    QryExec := CriarQuery(vConexao);

    QryCons.SQL.Add('SELECT SUM(VALOR_TOTAL) AS TOTAL FROM PEDIDO_VENDA_ITENS WHERE NR_PEDIDO = :NR_PEDIDO');
    QryCons.ParamByName('NR_PEDIDO').AsInteger := NrPedido;
    QryCons.Open;

    QryExec.SQL.Add('UPDATE PEDIDO_VENDA SET VALOR_TOTAL = :VALOR_TOTAL WHERE ID = :ID');
    QryExec.ParamByName('ID').AsInteger           := NrPedido;
    QryExec.ParamByName('VALOR_TOTAL').AsCurrency := QryCons.FieldByName('TOTAL').AsCurrency;
    QryExec.ExecSQL;

    FreeAndNil(QryCons);
    FreeAndNil(QryExec);

  except on e: exception do
    raise exception.Create('Erro ao Atualizar Total PedidoVenda... ' + e.Message);
  end;
end;

procedure TControllerPedidoVendaItem.Clear;
begin
  ID            := 0;
  NrPedido      := 0;
  CdProduto     := 0;
  Quantidade    := 0;
  ValorUnitario := 0;
  ValorTotal    := 0;
end;

constructor TControllerPedidoVendaItem.Create(AConn: TFDConnection);
begin
  vConexao := AConn;
end;

procedure TControllerPedidoVendaItem.Deletar;
var QryExec : TFDQuery;
begin
  if id = 0 then
    Exit;

  try
    QryExec := CriarQuery(vConexao);

    QryExec.SQL.Add('DELETE FROM PEDIDO_VENDA_ITENS WHERE ID = :ID');
    QryExec.ParamByName('ID').AsInteger := ID;

    QryExec.ExecSQL;

    FreeAndNil(QryExec);

    RecalcularTotalPedidoVenda();
  except on e: exception do
    raise exception.Create('Erro ao Deletar PedidoVendaItens... ' + e.Message);
  end;
end;

end.

