program ProjetoVendas;

uses
  Vcl.Forms,
  dmConexao in 'DAO\dmConexao.pas' {dm: TDataModule},
  form.Vendas in 'View\Vendas\form.Vendas.pas',
  model.Cliente in 'Model\Clientes\model.Cliente.pas',
  model.Produto in 'Model\Produtos\model.Produto.pas',
  model.PedidoVenda in 'Model\PedidoVenda\model.PedidoVenda.pas',
  controller.Cliente in 'Controller\Cliente\controller.Cliente.pas',
  Ufuncoes in 'Controller\Funcoes\Ufuncoes.pas',
  controller.Produto in 'Controller\Produto\controller.Produto.pas',
  controller.PedidoVenda in 'Controller\PedidoVenda\controller.PedidoVenda.pas',
  controller.PedidoVendaItem in 'Controller\PedidoVendaItens\controller.PedidoVendaItem.pas',
  model.PedidoVendaItem in 'Model\PedidoVendaItens\model.PedidoVendaItem.pas',
  form.Pesquisa in 'View\Pesquisa\form.Pesquisa.pas' {frmPesquisa};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrmVendas, frmVendas);
  Application.Run;
end.
