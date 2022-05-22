unit model.Cliente;

interface

type TModelCliente = class
  private
    FNomeCliente: string;
    FUF: string;
    FID: Integer;
    FCidade: string;
    procedure SetCidade(const Value: string);
    procedure SetID(const Value: Integer);
    procedure SetNomeCliente(const Value: string);
    procedure SetUF(const Value: string);
  public
    property ID          : Integer read FID          write SetID;
    property NomeCliente : string  read FNomeCliente write SetNomeCliente;
    property Cidade      : string  read FCidade      write SetCidade;
    property UF          : string  read FUF          write SetUF;
end;

implementation

{ TModelCliente }

procedure TModelCliente.SetCidade(const Value: string);
begin
  FCidade := Value;
end;

procedure TModelCliente.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TModelCliente.SetNomeCliente(const Value: string);
begin
  FNomeCliente := Value;
end;

procedure TModelCliente.SetUF(const Value: string);
begin
  FUF := Value;
end;

end.
