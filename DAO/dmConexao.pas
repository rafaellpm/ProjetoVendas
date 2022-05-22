unit dmConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL, Data.DB, FireDAC.Comp.Client,
  System.ImageList, Vcl.ImgList, Vcl.Controls, Vcl.Forms, System.IniFiles,
  Winapi.Messages, Winapi.Windows, Vcl.Dialogs;

type
  Tdm = class(TDataModule)
    fdConn: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    ImageList: TImageList;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure ConectarDB;
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  ConectarDB();
end;

procedure Tdm.ConectarDB;
var Caminho: string;
    ArqIni : TIniFile;
begin
  Caminho := ExtractFilePath(Application.exeName) + 'Config.ini';
  ArqIni := TInifile.Create(Caminho);


  if not FileExists(Caminho) then
  begin
    ArqIni.WriteString('CONFIGURACAO', 'Database', 'projetovendas');
    ArqIni.WriteString('CONFIGURACAO', 'User', '');
    ArqIni.WriteString('CONFIGURACAO', 'Pass', '');
    ArqIni.WriteString('CONFIGURACAO', 'Porta', '3390');
  end;

  var DataBase := ArqIni.ReadString('CONFIGURACAO', 'Database','');
  var Usuario := ArqIni.ReadString('CONFIGURACAO', 'User','');
  var Senha := ArqIni.ReadString('CONFIGURACAO', 'Pass','');
  var Porta := ArqIni.ReadString('CONFIGURACAO', 'Porta','');
  var Servidor := ArqIni.ReadString('CONFIGURACAO', 'Server','localhost');

  with fdConn do
  begin
    Params.Values['Database'] := DataBase;
    Params.Values['User_name']     := Usuario;
    Params.Values['Password']  := Senha;
    Params.Values['Port']     := Porta;
    Params.Values['Server']   := Servidor;

    try
      Connected := True;
    except
      ShowMessage('Não foi possivel conectar ao banco de dados. Sistema será finalizado!');
      Application.Terminate;
    end;
  end;
end;

end.
