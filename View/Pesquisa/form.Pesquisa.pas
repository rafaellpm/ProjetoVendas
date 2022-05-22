unit form.Pesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.Buttons, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  controller.Cliente, controller.Produto, controller.PedidoVenda, dmConexao;

type TtpPesquisa = (tpCliente, tpProduto, tpPedidoVenda);

type
  TfrmPesquisa = class(TForm)
    GroupBox1: TGroupBox;
    grid: TDBGrid;
    edtConsulta: TEdit;
    btnPesquisar: TBitBtn;
    memPesquisa: TFDMemTable;
    dsPesquisa: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure gridDblClick(Sender: TObject);
    procedure gridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    procedure ConsultaClientes;
    procedure ConsultaPedidoVenda;
    procedure ConsultaProdutos;
    procedure RetornaDados;
    { Private declarations }
  public
    { Public declarations }
    TipoPesquisa : TtpPesquisa;
    ResultPesquisa : Integer;
  end;

var
  frmPesquisa: TfrmPesquisa;

implementation

{$R *.dfm}

procedure TfrmPesquisa.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
     Perform(Wm_NextDlgCtl,0,0);
end;

procedure TfrmPesquisa.FormShow(Sender: TObject);
begin
  case TipoPesquisa of
    tpCliente     : ConsultaClientes();
    tpProduto     : ConsultaProdutos();
    tpPedidoVenda : ConsultaPedidoVenda();
  end;
end;

procedure TfrmPesquisa.gridDblClick(Sender: TObject);
begin
  RetornaDados();
end;

procedure TfrmPesquisa.gridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    RetornaDados();
end;

procedure TfrmPesquisa.RetornaDados;
begin
  case TipoPesquisa of
    tpCliente     : ResultPesquisa := memPesquisa.FieldByName('ID').AsInteger;
    tpProduto     : ResultPesquisa := memPesquisa.FieldByName('ID').AsInteger;
    tpPedidoVenda : ResultPesquisa := memPesquisa.FieldByName('ID').AsInteger;
  end;

  Close;
end;

procedure TfrmPesquisa.btnPesquisarClick(Sender: TObject);
begin
  case TipoPesquisa of
    tpCliente     : ConsultaClientes();
    tpProduto     : ConsultaProdutos();
    tpPedidoVenda : ConsultaPedidoVenda();
  end;
  grid.SetFocus;
end;

procedure TfrmPesquisa.ConsultaClientes;
var Cliente : TControllerCliente;
begin
  Cliente := TControllerCliente.Create(dm.fdConn);  
  try
    Cliente.NomeCliente := edtConsulta.Text;  

    grid.Columns.Items[0].Title.Caption := 'Codigo';
    grid.Columns.Items[0].FieldName := 'ID';
    grid.Columns.Items[0].Width := 50;

    grid.Columns.Items[1].Title.Caption := 'Nome Cliente';
    grid.Columns.Items[1].FieldName := 'NOME_CLIENTE';
    grid.Columns.Items[1].Width := 400;

    grid.Columns.Items[2].Title.Caption := 'Cidade';
    grid.Columns.Items[2].FieldName := 'CIDADE';
    grid.Columns.Items[2].Width := 100;

    grid.Columns.Items[3].Title.Caption := 'UF';
    grid.Columns.Items[3].FieldName := 'UF';
    grid.Columns.Items[3].Width := 60;

    memPesquisa.CloneCursor(Cliente.RetornaQryConsulta());
    
  finally
    FreeAndNil(Cliente);
  end;
end;

procedure TfrmPesquisa.ConsultaProdutos;
var Produtos : TControllerProduto;
begin
  Produtos := TControllerProduto.Create(dm.fdConn);  
  try
    Produtos.Descricao := edtConsulta.Text;

    grid.Columns.Items[0].Title.Caption := 'Codigo';
    grid.Columns.Items[0].FieldName := 'ID';
    grid.Columns.Items[0].Width := 50;

    grid.Columns.Items[1].Title.Caption := 'Descrição';
    grid.Columns.Items[1].FieldName := 'DESCRICAO';
    grid.Columns.Items[1].Width := 400;

    grid.Columns.Items[2].Title.Caption := 'R$ Unitário';
    grid.Columns.Items[2].FieldName := 'PRECO_VENDA';
    grid.Columns.Items[2].Width := 100;

    grid.Columns.Items[3].Visible := False;

    memPesquisa.CloneCursor(Produtos.RetornaQryConsulta());

    memPesquisa.FieldDefs.Items[2].DataType := ftCurrency;
  finally
    FreeAndNil(Produtos);
  end; 
end;

procedure TfrmPesquisa.ConsultaPedidoVenda;
var PedidoVenda : TControllerPedidoVenda;
begin
  PedidoVenda := TControllerPedidoVenda.Create(dm.fdConn);  
  try
    PedidoVenda.Cliente.NomeCliente := edtConsulta.Text;

    grid.Columns.Items[0].Title.Caption := 'Nr Pedido';
    grid.Columns.Items[0].FieldName := 'ID';
    grid.Columns.Items[0].Width := 50;

    grid.Columns.Items[1].Title.Caption := 'Nome Cliente';
    grid.Columns.Items[1].FieldName := 'NOME_CLIENTE';
    grid.Columns.Items[1].Width := 300;

    grid.Columns.Items[2].Title.Caption := 'Data';
    grid.Columns.Items[2].FieldName := 'DT_EMISSAO';
    grid.Columns.Items[2].Width := 90;

    grid.Columns.Items[3].Title.Caption := 'R$ Total';
    grid.Columns.Items[3].FieldName := 'VALOR_TOTAL';
    grid.Columns.Items[3].Width := 60;

    memPesquisa.CloneCursor(PedidoVenda.RetornaQryConsulta());

    memPesquisa.FieldDefs.Items[3].DataType := ftCurrency;

  finally
    FreeAndNil(PedidoVenda);
  end;
end;

end.
