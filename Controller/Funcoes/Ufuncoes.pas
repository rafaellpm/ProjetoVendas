unit Ufuncoes;

interface
uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.DApt, FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  Vcl.Forms, System.SysUtils, System.StrUtils;


  function CriarQuery(AConn: TFDConnection): TFDQuery;
  function eNumerico(AValor: string): Boolean;

implementation

function CriarQuery(AConn: TFDConnection): TFDQuery;
var Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  Query.Connection := AConn;
  Result := Query;
end;

function eNumerico(AValor: string): Boolean;
var Valor: Integer;
begin
  try
    Valor  := StrToInt(AValor);
    Result := True;
  except
    Result := False;
  end;
end;

end.
