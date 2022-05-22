unit model.PedidoVenda;

interface

type TModelPedidoVenda = class
  private
    FCdCliente: Integer;
    FID: Integer;
    FValorTotal: Currency;
    FDtEmissao: TDateTime;
    procedure SetCdCliente(const Value: Integer);
    procedure SetDtEmissao(const Value: TDateTime);
    procedure SetID(const Value: Integer);
    procedure SetValorTotal(const Value: Currency);
  public
    property ID         : Integer   read FID         write SetID;
    property CdCliente  : Integer   read FCdCliente  write SetCdCliente;
    property ValorTotal : Currency  read FValorTotal write SetValorTotal;
    property DtEmissao  : TDateTime read FDtEmissao  write SetDtEmissao;
end;

implementation

{ TModelPedidoVenda }

procedure TModelPedidoVenda.SetCdCliente(const Value: Integer);
begin
  FCdCliente := Value;
end;

procedure TModelPedidoVenda.SetDtEmissao(const Value: TDateTime);
begin
  FDtEmissao := Value;
end;

procedure TModelPedidoVenda.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TModelPedidoVenda.SetValorTotal(const Value: Currency);
begin
  FValorTotal := Value;
end;

end.
