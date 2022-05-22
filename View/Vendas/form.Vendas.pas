unit form.Vendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, controller.PedidoVenda,
  controller.Produto, controller.PedidoVendaItem;

type
  TfrmVendas = class(TForm)
    s: TPanel;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    btnPesquisar: TBitBtn;
    btnFechar: TBitBtn;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    edtCodProduto: TEdit;
    edtDescricao: TEdit;
    edtQuantidade: TEdit;
    edtValorUnitario: TEdit;
    edtValorTotal: TEdit;
    btnInserirProduto: TBitBtn;
    edtCodCliente: TEdit;
    edtNomeCliente: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    DBGrid1: TDBGrid;
    memItens: TFDMemTable;
    dsItens: TDataSource;
    edtDataCriacao: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    memItensID: TIntegerField;
    memItensCD_PRODUTO: TIntegerField;
    memItensQUANTIDADE: TCurrencyField;
    memItensVALOR_UNITARIO: TCurrencyField;
    memItensVALOR_TOTAL: TCurrencyField;
    memItensDT_INCLUSAO: TDateTimeField;
    memItensDESCRICAO: TStringField;
    Label9: TLabel;
    edtTotalPedido: TEdit;
    memItensNR_PEDIDO: TIntegerField;
    procedure edtCodClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnFecharClick(Sender: TObject);
    procedure edtCodClienteExit(Sender: TObject);
    procedure edtCodProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodProdutoExit(Sender: TObject);
    procedure edtQuantidadeExit(Sender: TObject);
    procedure btnInserirProdutoClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
    PedidoVenda : TControllerPedidoVenda;
    PedidoVendaItem : TControllerPedidoVendaItem;
    Produto : TControllerProduto;
    procedure CarregarItens;
    procedure CarregarPedidoVenda;
    procedure CadastrarPedidoVenda;
    procedure AtualizaTotal;
    procedure EditarProduto;
    procedure LimpaTela;
  public
    { Public declarations }
  end;

var
  frmVendas: TfrmVendas;

implementation

uses
  form.Pesquisa, dmConexao, Ufuncoes;

{$R *.dfm}

procedure TfrmVendas.btnCancelarClick(Sender: TObject);
var NrPedido : string;
begin
  if InputQuery('', 'Digite o Numero do Pedido a Cancelar: ', NrPedido) then
  begin
    if eNumerico(NrPedido) then
    begin
      PedidoVenda.ID := StrToInt(NrPedido);
      PedidoVenda.Deletar;
      dm.fdConn.Commit();

      LimpaTela();
    end
    else
    begin
      ShowMessage('Valor Digitado não é Válido!');
    end;
  end;
end;

procedure TfrmVendas.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmVendas.btnGravarClick(Sender: TObject);
begin
  dm.fdConn.Commit();

  ShowMessage('Gravado com Sucesso!');

  LimpaTela();

  edtCodCliente.SetFocus;
end;

procedure TfrmVendas.btnInserirProdutoClick(Sender: TObject);
begin
  if edtCodProduto.Text <> '' then
  begin
    dm.fdConn.Commit();
    dm.fdConn.StartTransaction();

    PedidoVendaItem.NrPedido      := PedidoVenda.ID;
    PedidoVendaItem.CdProduto     := StrToInt(edtCodProduto.Text);
    PedidoVendaItem.Quantidade    := StrToCurr(edtQuantidade.Text);
    PedidoVendaItem.ValorUnitario := StrToCurr(edtValorUnitario.Text);
    PedidoVendaItem.ValorTotal    := StrToCurr(edtValorTotal.Text);

    if PedidoVendaItem.ID = 0 then
      PedidoVendaItem.Inserir()
    else
      PedidoVendaItem.Atualizar();

    edtCodProduto.Text    := '';
    edtDescricao.Text     := '';
    edtQuantidade.Text    := '1';
    edtValorUnitario.Text := '0,00';
    edtValorTotal.Text    := '0,00';

    CarregarItens();
    AtualizaTotal();

    PedidoVendaItem.Clear;
    edtCodProduto.SetFocus;
  end;
end;

procedure TfrmVendas.btnPesquisarClick(Sender: TObject);
begin
  if PedidoVenda.ID > 0 then
  begin
    ShowMessage('Pedido já em Andamento!');
    Exit;
  end;

  try
    if not Assigned(frmPesquisa) then
      Application.CreateForm(TfrmPesquisa, frmPesquisa);

    frmPesquisa.TipoPesquisa := tpPedidoVenda;
    frmPesquisa.ShowModal;

    if frmPesquisa.ResultPesquisa > 0 then
    begin
      PedidoVenda.ID := frmPesquisa.ResultPesquisa;
      CarregarPedidoVenda();
      btnCancelar.Visible := False;
    end;
  finally
    FreeAndNil(frmPesquisa);
  end;
end;

procedure TfrmVendas.CarregarPedidoVenda;
begin
  PedidoVenda.Carregar();
  edtCodCliente.Text  := IntToStr(PedidoVenda.Cliente.ID);
  edtNomeCliente.Text := PedidoVenda.Cliente.NomeCliente;
  edtDataCriacao.Text := FormatDateTime('dd/mm/yyyy hh:mm:ss', PedidoVenda.DtEmissao);

  CarregarItens();

  edtTotalPedido.Text := FormatFloat('0.00', PedidoVenda.ValorTotal);

end;

procedure TfrmVendas.CadastrarPedidoVenda;
begin
  dm.fdConn.StartTransaction();
  PedidoVenda.CdCliente := StrToInt(edtCodCliente.Text);
  PedidoVenda.Cadastrar();

  btnCancelar.Visible := False;
end;

procedure TfrmVendas.CarregarItens;
begin
  PedidoVendaItem.NrPedido := PedidoVenda.ID;
  memItens.Close;
  memItens.CopyDataSet(PedidoVendaItem.RetornaQryConsulta());
end;

procedure TfrmVendas.DBGrid1DblClick(Sender: TObject);
begin
  EditarProduto();
end;

procedure TfrmVendas.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_DELETE then
  begin
    if MessageDlg('Realmente Deseja Excluir o Item?' , mtConfirmation, mbYesNo, 0) = mrYes then
    begin
      dm.fdConn.Commit();
      PedidoVendaItem.ID := memItens.FieldByName('ID').AsInteger;
      PedidoVendaItem.NrPedido := memItens.FieldByName('NR_PEDIDO').AsInteger;
      PedidoVendaItem.Deletar();

      CarregarItens();
      AtualizaTotal();

      PedidoVendaItem.Clear;
    end;
  end
  else
  if Key = VK_RETURN then
  begin
    EditarProduto();
  end;
end;

procedure TfrmVendas.EditarProduto;
begin
  edtCodProduto.Text    := memItens.FieldByName('CD_PRODUTO').AsString;
  edtCodProdutoExit(nil);

  edtQuantidade.Text    := memItens.FieldByName('QUANTIDADE').AsString;
  edtValorUnitario.Text := memItens.FieldByName('VALOR_UNITARIO').AsString;
  edtValorTotal.Text    := memItens.FieldByName('VALOR_TOTAL').AsString;

  PedidoVendaItem.ID    := memItens.FieldByName('ID').AsInteger;

  edtQuantidade.SetFocus;
  edtQuantidade.SelectAll;
end;

procedure TfrmVendas.AtualizaTotal();
begin
  edtTotalPedido.Text := FormatFloat('0.00', PedidoVenda.RetornaTotalPedido);
end;

procedure TfrmVendas.edtCodClienteExit(Sender: TObject);
begin
  if edtCodCliente.Text <> '' then
  begin
    PedidoVenda.Cliente.ID := StrToIntDef(edtCodCliente.Text,0);
    PedidoVenda.Cliente.Carregar();

    edtNomeCliente.Text := PedidoVenda.Cliente.NomeCliente;
    btnCancelar.Visible := False;
  end;
end;

procedure TfrmVendas.edtCodClienteKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_RETURN then
  begin
    if edtCodCliente.Text = '' then
    begin
      try
        if not Assigned(frmPesquisa) then
          Application.CreateForm(TfrmPesquisa, frmPesquisa);

        frmPesquisa.TipoPesquisa := tpCliente;
        frmPesquisa.ShowModal;

        if frmPesquisa.ResultPesquisa > 0 then
        begin
          edtCodCliente.Text := IntToStr(frmPesquisa.ResultPesquisa);
          edtCodClienteExit(nil);
        end;
      finally
        FreeAndNil(frmPesquisa);
      end;
    end;
  end;
end;

procedure TfrmVendas.edtCodProdutoExit(Sender: TObject);
begin
  if edtCodProduto.Text <> '' then
  begin
    Produto.ID := StrToIntDef(edtCodProduto.Text,0);
    Produto.Carregar();

    edtDescricao.Text     := Produto.Descricao;
    edtValorUnitario.Text := FormatFloat('0.00', Produto.PrecoVenda);
    edtValorTotal.Text    := FormatFloat('0.00', (StrToCurrDef(edtQuantidade.Text,1) * StrToCurrDef(edtValorUnitario.Text,0)));
  end;
end;

procedure TfrmVendas.edtCodProdutoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_RETURN then
  begin
    if edtCodCliente.Text = '' then
    begin
      ShowMessage('Cliente não Informado');
      exit
    end;

    if PedidoVenda.ID = 0 then
    begin
      CadastrarPedidoVenda();
    end;

    if edtCodProduto.Text = '' then
    begin
      try
        if not Assigned(frmPesquisa) then
          Application.CreateForm(TfrmPesquisa, frmPesquisa);

        frmPesquisa.TipoPesquisa := tpProduto;
        frmPesquisa.ShowModal;

        if frmPesquisa.ResultPesquisa > 0 then
        begin
          edtCodProduto.Text := IntToStr(frmPesquisa.ResultPesquisa);
          edtCodProdutoExit(nil);
        end;
      finally
        FreeAndNil(frmPesquisa);
      end;
    end;
  end;
end;

procedure TfrmVendas.edtQuantidadeExit(Sender: TObject);
begin
  edtValorTotal.Text := CurrToStr(StrToCurrDef(edtQuantidade.Text,1) * StrToCurrDef(edtValorUnitario.Text,0));
end;

procedure TfrmVendas.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
     Perform(Wm_NextDlgCtl,0,0);
end;

procedure TfrmVendas.FormShow(Sender: TObject);
begin
  PedidoVenda         := TControllerPedidoVenda.Create(dm.fdConn);
  Produto             := TControllerProduto.Create(dm.fdConn);
  PedidoVendaItem     := TControllerPedidoVendaItem.Create(dm.fdConn);
  edtDataCriacao.Text := FormatDateTime('dd/mm/yyyy hh:mm:ss', Now);
end;

procedure TfrmVendas.LimpaTela;
begin
  PedidoVenda.Clear;
  btnCancelar.Visible := True;

  memItens.Close;

  edtCodCliente.Text    := '';
  edtNomeCliente.Text   := '';
  edtDataCriacao.Text   := FormatDateTime('dd/mm/yyyy hh:mm:ss', Now);
  edtCodProduto.Text    := '';
  edtDescricao.Text     := '';
  edtQuantidade.Text    := '1';
  edtValorUnitario.Text := '0,00';
  edtValorTotal.Text    := '0,00';
  edtTotalPedido.Text   := '0,00';
end;

end.
