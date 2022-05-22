unit model.Produto;

interface

type TModelProduto = class
  private
    FValorVenda: Currency;
    FDescricao: string;
    FID: Integer;
    procedure SetDescricao(const Value: string);
    procedure SetID(const Value: Integer);
    procedure SetValorVenda(const Value: Currency);

  public
    property ID         : Integer  read FID         write SetID;
    property Descricao  : string   read FDescricao  write SetDescricao;
    property PrecoVenda : Currency read FValorVenda write SetValorVenda;

end;

implementation

{ TModelProduto }

procedure TModelProduto.SetDescricao(const Value: string);
begin
  FDescricao := Value;
end;

procedure TModelProduto.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TModelProduto.SetValorVenda(const Value: Currency);
begin
  FValorVenda := Value;
end;

end.
