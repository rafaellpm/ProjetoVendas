unit model.PedidoVendaItem;

interface

type TModelPedidoVendaItem = class
  private
    FDtInclusao: TDateTime;
    FNrPedido: Integer;
    FValorUnitario: Currency;
    FID: Integer;
    FValorTotal: Currency;
    FCdProduto: Integer;
    FQuantidade: Currency;
    procedure SetCdProduto(const Value: Integer);
    procedure SetDtInclusao(const Value: TDateTime);
    procedure SetID(const Value: Integer);
    procedure SetNrPedido(const Value: Integer);
    procedure SetQuantidade(const Value: Currency);
    procedure SetValorTotal(const Value: Currency);
    procedure SetValorUnitario(const Value: Currency);
  public
    property ID            : Integer   read FID            write SetID;
    property NrPedido      : Integer   read FNrPedido      write SetNrPedido;
    property CdProduto     : Integer   read FCdProduto     write SetCdProduto;
    property Quantidade    : Currency  read FQuantidade    write SetQuantidade;
    property ValorUnitario : Currency  read FValorUnitario write SetValorUnitario;
    property ValorTotal    : Currency  read FValorTotal    write SetValorTotal;
    property DtInclusao    : TDateTime read FDtInclusao    write SetDtInclusao;
end;

implementation

{ TModelPedidoVendaItem }

procedure TModelPedidoVendaItem.SetCdProduto(const Value: Integer);
begin
  FCdProduto := Value;
end;

procedure TModelPedidoVendaItem.SetDtInclusao(const Value: TDateTime);
begin
  FDtInclusao := Value;
end;

procedure TModelPedidoVendaItem.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TModelPedidoVendaItem.SetNrPedido(const Value: Integer);
begin
  FNrPedido := Value;
end;

procedure TModelPedidoVendaItem.SetQuantidade(const Value: Currency);
begin
  FQuantidade := Value;
end;

procedure TModelPedidoVendaItem.SetValorTotal(const Value: Currency);
begin
  FValorTotal := Value;
end;

procedure TModelPedidoVendaItem.SetValorUnitario(const Value: Currency);
begin
  FValorUnitario := Value;
end;

end.
