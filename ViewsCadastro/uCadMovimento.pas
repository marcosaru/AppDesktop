﻿unit uCadMovimento;

interface

uses
  Winapi.Windows,FormaPagtoDTO,FormaPagtoDAO, Winapi.Messages, System.SysUtils,
  System.Variants, System.Classes, Vcl.Graphics,MovimentoDTO, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Vcl.StdCtrls, frxClass, frxDBSet,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Datasnap.DBClient,
  uCurrencyEditVCL, Vcl.Buttons, Vcl.Controls, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls,MovimentoDAO, Vcl.Forms, Vcl.Dialogs,
   Vcl.Imaging.pngimage,MidasLib,EmpresaDTO,EmpresaDAO,
  ProdutoDTO,ProdutoDAO,CondicoesDTO,CondicoesDAO,
  ClienteDTO,ClienteDAO, Vcl.Menus, Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnPopup,PagamentoDTO,PagamentoDAO, Vcl.Mask;

type
  TFrmCadMovimento = class(TForm)
    pnlItens: TPanel;
    Panel2: TPanel;
    GridProdutos: TDBGrid;
    pnlBotoes: TPanel;
    Panel3: TPanel;
    pnlInformacoes: TPanel;
    btnIncluir: TButton;
    btnRemover: TButton;
    btnAlterar: TButton;
    btnLimpar: TButton;
    LblForm: TLabel;
    Edt_CodigoCliente: TEdit;
    Edt_Cliente: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    btnConfirmar: TButton;
    btnCancelar: TButton;
    pnlProduto: TPanel;
    Edt_Produto: TEdit;
    Edt_CodigoProduto: TEdit;
    Label11: TLabel;
    Qtde: TLabel;
    btnInserirProduto: TSpeedButton;
    TblProdutos: TClientDataSet;
    DTS: TDataSource;
    btnOcultarPainel: TSpeedButton;
    Label12: TLabel;
    btnProcurarProduto: TButton;
    TblProdutosCodigo: TIntegerField;
    TblProdutosNome: TStringField;
    TblProdutosQtd: TFloatField;
    TblProdutosValor: TFloatField;
    TblProdutosTotal: TFloatField;
    Label13: TLabel;
    Label1: TLabel;
    Edt_Codigo: TEdit;
    btnProcurarCliente: TButton;
    Edt_TotalProdutos: TCurrencyEdit;
    Edt_TotalServicos: TCurrencyEdit;
    Edt_Acrescimo: TCurrencyEdit;
    Edt_Desconto: TCurrencyEdit;
    Edt_Frete: TCurrencyEdit;
    Edt_QtdeItens: TCurrencyEdit;
    Edt_TotalAPagar: TCurrencyEdit;
    Edt_PorcentagemAcrescimo: TCurrencyEdit;
    Edt_PorcentagemDesconto: TCurrencyEdit;
    Edt_Valor: TCurrencyEdit;
    Edt_Qtdade: TEdit;
    QryItens: TFDQuery;
    QryItensMITENS_MOVIMENTO: TIntegerField;
    QryItensMITENS_PRODUTO: TIntegerField;
    QryItensPRO_NOME: TStringField;
    QryVenda: TFDQuery;
    QryVendaMOV_CODIGO: TIntegerField;
    QryVendaCLI_NOME: TStringField;
    QryVendaMOV_DATA: TSQLTimeStampField;
    QryVendaMOV_TIPO: TIntegerField;
    QryVendaMOV_TOTALPRODUTOS: TFloatField;
    QryVendaMOV_TOTALSERVICOS: TFloatField;
    QryVendaMOV_ACRESCIMO: TFloatField;
    QryVendaMOV_DESCONTO: TFloatField;
    QryVendaMOV_FRETE: TFloatField;
    QryVendaMOV_QTDEITENS: TSingleField;
    QryVendaMOV_VALORFINAL: TFloatField;
    QryItensMITENS_QUANTIDADE: TSingleField;
    QryEmpresa: TFDQuery;
    QryEmpresaEMP_NOME: TStringField;
    QryEmpresaEMP_CODIGO: TIntegerField;
    QryEmpresaEMP_CNPJ: TStringField;
    QryEmpresaEMP_BAIRRO: TIntegerField;
    QryEmpresaEMP_MUNICIPIO: TIntegerField;
    QryEmpresaEMP_ENDERECO: TStringField;
    QryEmpresaEMP_INSCRICAO: TIntegerField;
    QryEmpresaEMP_FANTASIA: TStringField;
    QryEmpresaEMP_FUNDACAO: TDateField;
    QryEmpresaEMP_LOGO: TBlobField;
    QryEmpresaBAI_NOME: TStringField;
    QryEmpresaMUN_NOME: TStringField;
    QryVendaBAI_NOME: TStringField;
    QryVendaMUN_NOME: TStringField;
    QryVendaCLI_ENDERECO: TStringField;
    QryVendaCTO_VALOR: TStringField;
    RelDtsVenda: TfrxDBDataset;
    RelDtsItens: TfrxDBDataset;
    RelDtsEmpresa: TfrxDBDataset;
    RelVenda: TfrxReport;
    Edt_Empresa: TEdit;
    Edt_CodigoEmpresa: TEdit;
    Label15: TLabel;
    Edt_ObservacoesVenda: TLabel;
    Edt_Observacoes: TMemo;
    Label14: TLabel;
    Edt_Telefone: TEdit;
    QryVendaMOV_OBSERVACOES: TBlobField;
    Edt_FormaDePagamento: TEdit;
    Edt_CodigoFormaDePagamento: TEdit;
    Label16: TLabel;
    Edt_CondicaoPagamento: TEdit;
    Edt_CodigoCondicaoPagamento: TEdit;
    Label17: TLabel;
    btnProcurarCondicao: TButton;
    btnProcurarForma: TButton;
    QryVendaCON_DESCRICAO: TStringField;
    QryVendaFORPAGTO_DESCRICAO: TStringField;
    ChkMudarEntrega: TCheckBox;
    QryVendaMOV_ENTREGA: TBlobField;
    QryEmpresaCONF_MOV_OBSERVACOES_VENDA: TBlobField;
    QryEmpresaCONF_MOV_OBSERVACOES_PREV: TBlobField;
    QryEmpresaCONF_MOV_OBSERVACOES_ORCAMENTO: TBlobField;
    QryEntrega: TFDQuery;
    RelDtsEntrega: TfrxDBDataset;
    QryEntregaENT_CODIGO: TIntegerField;
    QryEntregaENT_MOVIMENTO: TIntegerField;
    QryEntregaENT_DATAPREVISTA: TDateField;
    QryEntregaENT_DATAENTREGA: TDateField;
    QryEntregaENT_TRANSPORTADOR: TIntegerField;
    GridFormasPagamento: TDBGrid;
    pnlEntrega: TPanel;
    Label18: TLabel;
    Edt_ObsEntrega: TMemo;
    DTSFormasPagamento: TDataSource;
    TblFormasPagamento: TClientDataSet;
    TblFormasPagamentoIndice: TIntegerField;
    TblFormasPagamentoFormaPagamento: TStringField;
    TblFormasPagamentoCodigoFormaPagto: TIntegerField;
    TblFormasPagamentoDataVcto: TDateField;
    TblFormasPagamentoValor: TFloatField;
    TblFormasPagamentoGerarParcela: TBooleanField;
    btnImprimir: TButton;
    RelDtsPagamento: TfrxDBDataset;
    QryPagamento: TFDQuery;
    QryPagamentoPAG_CODIGO: TIntegerField;
    QryPagamentoPAG_MOVIMENTO: TIntegerField;
    QryPagamentoPAG_FORMAPAGTO: TIntegerField;
    QryPagamentoPAG_DATAVCTO: TDateField;
    QryPagamentoPAG_VALOR: TSingleField;
    QryPagamentoFORPAGTO_DESCRICAO: TStringField;
    QryItensPRO_TECIDO: TStringField;
    QryItensPRO_MEDIDAS: TStringField;
    QryEmpresaEMP_EMAIL: TStringField;
    Label19: TLabel;
    Edt_PrevisaoEntrega: TMaskEdit;
    ChkObsPagamento: TCheckBox;
    Edt_ObsPagamento: TMemo;
    QryVendaMOV_OBSPAGAMENTO: TStringField;
    QryItensMITENS_PRECO: TSingleField;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnOcultarPainelClick(Sender: TObject);
    procedure btnInserirProdutoClick(Sender: TObject);
    procedure btnProcurarProdutoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pnlProdutoExit(Sender: TObject);
    procedure btnRemoverClick(Sender: TObject);
    procedure pnlBotoesClick(Sender: TObject);
    procedure Panel3Click(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
    procedure pnlInformacoesClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnConsultarVendasClick(Sender: TObject);
    procedure Edt_CodigoClienteKeyPress(Sender: TObject; var Key: Char);
    procedure btnProcurarClienteClick(Sender: TObject);
    procedure Edt_FreteKeyPress(Sender: TObject; var Key: Char);
    procedure Edt_QtdadeKeyPress(Sender: TObject; var Key: Char);
    procedure Edt_CodigoProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure Edt_PorcentagemDescontoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edt_PorcentagemAcrescimoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnProcurarFormaClick(Sender: TObject);
    procedure btnProcurarCondicaoClick(Sender: TObject);
    procedure Edt_CodigoFormaDePagamentoKeyPress(Sender: TObject;
      var Key: Char);
    procedure Edt_CodigoCondicaoPagamentoKeyPress(Sender: TObject;
      var Key: Char);
    procedure ChkMudarEntregaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure GridFormasPagamentoCellClick(Column: TColumn);
    procedure Edt_DescontoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edt_AcrescimoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnImprimirClick(Sender: TObject);
    procedure GridFormasPagamentoKeyPress(Sender: TObject; var Key: Char);
    procedure ChkObsPagamentoClick(Sender: TObject);
  private
    { Private declarations }

    FStatusTabela:integer;
    FMovimento:String;
    Produto : TProdutoDTO;
    Movimento :TMovimentoDTO;
    MovimentoDAO : TMovimentoDAO;
    ProdutoDAO: TProdutoDAO;
    Condicao : TCondicoesDTO;
    CondicaoDAO:TCondicoesDAO;
    FormaPagto: TFormaPagtoDTO;
    FormaPagtoDAO: TFormaPagtoDAO;
    Pagamento : TPagamentoDTO;
    PagamentoDAO : TPagamentoDAO;
    Cliente   : TClienteDTO;
    ClienteDAO: TClienteDAO;
    QryConfig : TFDQuery;
    Empresa: TEmpresaDTO;
    EmpresaDAO: TEmpresaDAO;

    procedure controlaStatus;
    procedure AtualizarValores;
    procedure confirma;

    procedure carregarEmpresa(ACodigo:String);
    procedure carregarVenda(ACodigo:String);
    procedure carregarItens(ACodigo:String);
    procedure CarregarTelefone(ACodigo:String);
    procedure carregarPagamentos(ACodigo:String);
    Procedure CriarParcelas(Movimento:TMovimentoDTO;valor:Double;NumeroParcela:Integer;Vcto:TDate);
    procedure AdicionarPagamentosTabelaTemp;
    procedure CalcularValoresParaTabela;
  public
    { Public declarations }
    FStatus:integer;
    procedure imprimir;
     procedure carrega(ACodigo:String);
    constructor create(AOwner:TComponent;AStatus:Integer;Movi:String = '');
    destructor destroy;override;
  end;

var
  FrmCadMovimento: TFrmCadMovimento;

implementation

{$R *.dfm}

uses uPesProduto, uPesVenda, dmConexao, uPesCliente,ProdutoVenda,PagamentosMovimentoDAO,
  uPesFormPagto, uPesCondicoes, PagamentosMovimentoDTO, DateUtils;

procedure TFrmCadMovimento.AdicionarPagamentosTabelaTemp;
var
  qtdadeParcelas,i:Integer;
  QtdDeBarras:String;
  DataAtual:TDate;
  Dias,n:Word;
begin
  QtdDeBarras := Edt_CondicaoPagamento.Text;


  DataAtual := Date;

  qtdadeParcelas := QtdDeBarras.CountChar('/') + 1;
  n := 1;
  TblFormasPagamento.Close;
  TblFormasPagamento.CreateDataSet;

  for I := 1 to qtdadeParcelas do
  begin
    TblFormasPagamento.Append;

    Dias := StrToIntDef(Copy(Edt_CondicaoPagamento.Text,n,3),0);
    FormaPagtoDAO := TFormaPagtoDAO.create;
    FormaPagto := FormaPagtoDAO.Encontrar(Edt_CodigoFormaDePagamento.Text);

    TblFormasPagamentoIndice.AsInteger := i;
    TblFormasPagamentoCodigoFormaPagto.AsString := Edt_CodigoFormaDePagamento.Text;
    TblFormasPagamentoGerarParcela.AsBoolean := FormaPagto.Avista <> 1;
    TblFormasPagamentoFormaPagamento.AsString := Edt_FormaDePagamento.Text;
    TblFormasPagamentoValor.AsFloat := (Edt_TotalAPagar.Value / qtdadeParcelas);
    TblFormasPagamentoDataVcto.AsDateTime := IncDay(DataAtual,Dias);

    TblFormasPagamento.Post;
    FormaPagtoDAO.Free;
    n := n + 4;
  end;

end;

procedure TFrmCadMovimento.AtualizarValores;
var
  TotalApagar: Real;

  procedure AtualizarPorcentagemAcrescimo;
  begin
    if Edt_PorcentagemAcrescimo.value > 0 then
    begin
      Edt_Acrescimo.Value := Edt_TotalProdutos.value * (Edt_PorcentagemAcrescimo.Value / 100);
      Edt_Acrescimo.Enabled := false;
    end
    else if Edt_Acrescimo.Value > 0 then
    begin
      Edt_PorcentagemAcrescimo.Value := (Edt_Acrescimo.Value * 100) / Edt_TotalProdutos.value;
      Edt_PorcentagemAcrescimo.Enabled := false;
    end;
  end;

  procedure AtualizarPorcentagemDesconto;
  begin
    if Edt_PorcentagemDesconto.value > 0 then
    begin
      Edt_Desconto.Value := Edt_TotalProdutos.value * (Edt_PorcentagemDesconto.Value / 100);
      Edt_Desconto.Enabled := false;
    end
    else if Edt_Desconto.Value > 0 then
    begin
      Edt_PorcentagemDesconto.Value := (Edt_Desconto.Value * 100) / Edt_TotalProdutos.value;
      Edt_PorcentagemDesconto.Enabled := false;
    end;
  end;

  procedure CalcularTotal;
  begin
    Edt_TotalAPagar.Value := TotalApagar + Edt_Acrescimo.Value - Edt_Desconto.Value + Edt_Frete.Value;
  end;

begin
  TblProdutos.First;
  Edt_TotalProdutos.value := 0;
  Edt_QtdeItens.Value     := 0;

  while not TblProdutos.EoF do
  begin
    Edt_TotalProdutos.value := Edt_TotalProdutos.value + (TblProdutosValor.AsFloat * TblProdutosQtd.AsFloat);
    Edt_QtdeItens.Value := Edt_QtdeItens.Value + TblProdutosQtd.AsFloat;
    TblProdutos.Next;
  end;

  TotalApagar := Edt_TotalProdutos.value;

  AtualizarPorcentagemAcrescimo;
  AtualizarPorcentagemDesconto;
  CalcularTotal;
  if TblFormasPagamento.RecordCount > 0 then
    CalcularValoresParaTabela;
end;

procedure TFrmCadMovimento.btnAlterarClick(Sender: TObject);
begin
  pnlProduto.Visible := true;
  Edt_CodigoProduto.Text := TblProdutosCodigo.AsString;
  Edt_Produto.Text       := TblProdutosNome.AsString;
  Edt_Qtdade.Text        := TblProdutosQtd.AsString;
  Edt_Valor.Value        := TblProdutosValor.AsFloat;
  FStatusTabela := 2;
end;

procedure TFrmCadMovimento.btnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmCadMovimento.btnConfirmarClick(Sender: TObject);
var
  Somatorio:Double;
begin
  Somatorio := 0;
  if Trim(Edt_Cliente.Text) = '' then
  begin
    ShowMessage('Por favor, preencha o campo Cliente.');
    Edt_Cliente.SetFocus;
    Exit;
  end;

  if Trim(Edt_Codigo.Text) = '' then
  begin
    ShowMessage('Por favor, preencha o campo Código.');
    Edt_Codigo.SetFocus;
    Exit;
  end;

  if Trim(Edt_Empresa.Text) = '' then
  begin
    ShowMessage('Por favor, preencha o campo Empresa.');
    Edt_Empresa.SetFocus;
    Exit;
  end;

  if Trim(Edt_CodigoEmpresa.Text) = '' then
  begin
    ShowMessage('Por favor, preencha o campo Código da Empresa.');
    Edt_CodigoEmpresa.SetFocus;
    Exit;
  end;

  if Trim(Edt_FormaDePagamento.Text) = '' then
  begin
    ShowMessage('Por favor, preencha o campo Forma de Pagamento.');
    Edt_FormaDePagamento.SetFocus;
    Exit;
  end;

  if Trim(Edt_CodigoFormaDePagamento.Text) = '' then
  begin
    ShowMessage('Por favor, preencha o campo Código da Forma de Pagamento.');
    Edt_CodigoFormaDePagamento.SetFocus;
    Exit;
  end;

  if Trim(Edt_CondicaoPagamento.Text) = '' then
  begin
    ShowMessage('Por favor, preencha o campo Condição de Pagamento.');
    Edt_CondicaoPagamento.SetFocus;
    Exit;
  end;

  if Trim(Edt_CodigoCondicaoPagamento.Text) = '' then
  begin
    ShowMessage('Por favor, preencha o campo Código da Condição de Pagamento.');
    Edt_CodigoCondicaoPagamento.SetFocus;
    Exit;
  end;

  TblFormasPagamento.First;
  while not TblFormasPagamento.Eof do
  begin
    Somatorio := Somatorio + TblFormasPagamentoValor.AsFloat;
    TblFormasPagamento.Next;
  end;

  if (Somatorio <> Edt_TotalAPagar.Value) then
  begin
    ShowMessage('Confira os valores das formas de pagamento, foram encontrado divergencias com o valor total.');
    Exit;
  end;


  confirma;
end;

procedure TFrmCadMovimento.btnConsultarVendasClick(Sender: TObject);
begin
  try
    FrmPesVenda := TFrmPesVenda.Create(Self);
    FrmPesVenda.ShowModal;
  finally
    FrmPesVenda.Free;
  end;
end;

procedure TFrmCadMovimento.btnImprimirClick(Sender: TObject);
begin
  imprimir;
end;

procedure TFrmCadMovimento.btnIncluirClick(Sender: TObject);
begin
  pnlProduto.Visible := true;
  FStatusTabela := 1;
  Edt_CodigoProduto.SetFocus;
end;

procedure TFrmCadMovimento.btnProcurarClienteClick(Sender: TObject);
begin
  try
    FrmPesCliente := TFrmPesCliente.Create(Self);
    FrmPesCliente.ShowModal;
  finally
    if FrmPesCliente.ModalResult = mrOk then
    begin
      ClienteDAO := TClienteDAO.Create;
      Cliente := ClienteDAO.encontrarCliente(FrmPesCliente.QryPesquisaCLI_CODIGO.AsString);
      Edt_CodigoCliente.Text := Cliente.Codigo;
      Edt_Cliente.Text := Cliente.Nome;
      CarregarTelefone(Cliente.Codigo);
    end;
    FrmPesCliente.Free;
    ClienteDAO.Free;
  end;
end;

procedure TFrmCadMovimento.btnProcurarCondicaoClick(Sender: TObject);
begin
  try
    FrmPesCondicoes := TFrmPesCondicoes.Create(Self);
    FrmPesCondicoes.ShowModal;
  finally
    if FrmPesCondicoes.ModalResult = MrOk then
    begin
      Edt_CondicaoPagamento.Text := FrmPesCondicoes.QryPesquisaCON_DESCRICAO.AsString;
      Edt_CodigoCondicaoPagamento.Text := FrmPesCondicoes.QryPesquisaCON_CODIGO.AsString;
      AdicionarPagamentosTabelaTemp;
    end;
    FrmPesCondicoes.Free;
  end;
end;

procedure TFrmCadMovimento.btnProcurarFormaClick(Sender: TObject);
begin
  try
    FrmPesFormaPagamento := TFrmPesFormaPagamento.Create(Self);
    FrmPesFormaPagamento.ShowModal;
  finally
    if FrmPesFormaPagamento.ModalResult = mrOk then
    begin
      FormaPagtoDAO :=  TFormaPagtoDAO.create;

      FormaPagto := FormaPagtoDAO.Encontrar(FrmPesFormaPagamento.QryPesquisaFORPAGTO_CODIGO.AsString);
      Edt_FormaDePagamento.Text := FormaPagto.Descricao;
      Edt_CodigoFormaDePagamento.Text := FormaPagto.Codigo;

      FormaPagto.Free;
      FormaPagtoDAO.Free;
    end;
    FrmPesFormaPagamento.Free;
  end;
end;

procedure TFrmCadMovimento.btnProcurarProdutoClick(Sender: TObject);
begin
  try
    FrmPesProduto := TFrmPesProduto.Create(self);
    FrmPesProduto.ShowModal;
  finally
    if FrmPesProduto.ModalResult = mrOk then
    begin
      Edt_CodigoProduto.Text := FrmPesProduto.QryPesquisaPRO_CODIGO.AsString;
      Edt_Produto.Text       := FrmPesProduto.QryPesquisaPRO_NOME.AsString;
      Edt_Valor.Value        := FrmPesProduto.QryPesquisaPRO_VALORVENDA.AsFloat;
      Edt_Qtdade.text        := '';
      Edt_Qtdade.SetFocus;
    end;
    FrmPesProduto.Free;
  end;
end;

procedure TFrmCadMovimento.btnRemoverClick(Sender: TObject);
begin
  if MessageDlg('Deseja excluir o item: '+TblProdutosNome.AsString,mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    TblProdutos.Edit;
    TblProdutos.Delete;
    Edt_PorcentagemAcrescimo.Enabled := true;
    Edt_Acrescimo.Enabled := true;
    Edt_PorcentagemDesconto.Enabled := true;
    Edt_Desconto.Enabled := true;
  end;
  controlaStatus;
  AtualizarValores;
end;


procedure TFrmCadMovimento.CalcularValoresParaTabela;
var  i: integer;
begin
  TblFormasPagamento.First;
  while not TblFormasPagamento.EoF do
  begin
    TblFormasPagamento.Edit;

    TblFormasPagamentoValor.AsFloat := Edt_TotalAPagar.Value/TblFormasPagamento.RecordCount;

    TblFormasPagamento.Post;
    TblFormasPagamento.Next;
  end;
end;

procedure TFrmCadMovimento.carrega(ACodigo: String);
var
  Produtos : TProdutoVenda;
  i:integer;
  PagamentoDescricao : TPagamentoDTO;
  PagamentoDAO : TPagamentoDAO;
begin

    MovimentoDAO := TMovimentoDAO.create;
    PagamentoDAO := TPagamentoDAO.Create;

    ProdutoDAO := TProdutoDAO.create(1);

    Movimento := MovimentoDAO.encontrar(ACodigo);

    Movimento.Descricao := PagamentoDAO.EncontrarLista(Movimento);
    Movimento.Produtos := ProdutoDAO.EncontrarLista(Movimento);

    i := 1;
    for Produtos in Movimento.Produtos do
    begin
      TblProdutos.Append;
      TblProdutosCodigo.AsString := Produtos.Produto.Codigo;
      TblProdutosNome.AsString   := Produtos.Produto.Nome;
      TblProdutosQtd.AsFloat     := Produtos.Quantidade;
      TblProdutosValor.AsFloat   := Produtos.Preco;
      TblProdutosTotal.AsFloat   := Produtos.Quantidade * Produtos.Preco;
      TblProdutos.Post;
    end;

    TblFormasPagamento.Close;
    TblFormasPagamento.CreateDataSet;

    for PagamentoDescricao in Movimento.Descricao do
    begin
      TblFormasPagamento.Append;
      TblFormasPagamentoIndice.AsInteger:= i;
      TblFormasPagamentoFormaPagamento.AsString := PagamentoDescricao.FormaPagto.Descricao;
      TblFormasPagamentoCodigoFormaPagto.AsString := PagamentoDescricao.FormaPagto.Codigo;
      TblFormasPagamentoDataVcto.AsDateTime := PagamentoDescricao.DataVcto;
      TblFormasPagamentoValor.AsFloat := PagamentoDescricao.Valor;
      TblFormasPagamentoGerarParcela.AsBoolean := PagamentoDescricao.FormaPagto.Avista <> 1;
      TblFormasPagamento.Post;
      inc(i);
    end;


    Edt_CodigoCliente.Text   := Movimento.Cliente.Codigo;
    Edt_Cliente.Text         := Movimento.Cliente.Nome;
    Edt_FormaDePagamento.Text     := Movimento.FormaPagto.Descricao;
    Edt_CodigoFormaDePagamento.Text:= Movimento.FormaPagto.Codigo;
    Edt_CondicaoPagamento.Text := Movimento.CondicaoPagto.Descricao;
    Edt_CodigoCondicaoPagamento.Text := Movimento.CondicaoPagto.Codigo;
    Edt_Observacoes.Text := Movimento.Observacoes;
    Edt_ObsEntrega.Text := Movimento.Entrega;
    if Trim(Edt_ObsEntrega.Text) <> '' then
      pnlEntrega.Visible := true;
    Edt_Acrescimo.value := Movimento.Acrescimo;
    Edt_Desconto.Value  := Movimento.Desconto;
    Edt_Frete.Value     := Movimento.Frete;

    if Movimento.ObsPagamento <> '' then
      ChkObsPagamento.Checked := true;

    Edt_ObsPagamento.Text := Movimento.ObsPagamento;



    AtualizarValores;

end;

procedure TFrmCadMovimento.carregarEmpresa(ACodigo:String);
begin
  QryEmpresa.Connection:= fdmConexao.BANCO;
  QryEmpresa.SQL.Clear;
  QryEmpresa.SQL.Add('select e.*,b.bai_nome,m.mun_nome, '+
                     'conf_mov_observacoes_venda,conf_mov_observacoes_prev,  '+
                     'conf_mov_observacoes_orcamento                         '+
                     ' from empresa as e                                     '+
                     'join municipio m on e.emp_municipio = m.mun_codigo     '+
                     'join bairro b on b.bai_codigo = e.emp_bairro           '+
                     'join configuracoes on conf_codigo = 1 WHERE EMP_CODIGO = 1');

  QryEmpresa.Open;
end;

procedure TFrmCadMovimento.carregarItens(ACodigo:String);
begin
  QryItens.SQL.Clear;
  QryItens.Connection := fdmConexao.BANCO;
  QryItens.SQL.Add('select mitens_movimento,mitens_produto, '+
                         'pro_nome,mitens_preco,mitens_quantidade,PRO_TECIDO,PRO_MEDIDAS '+
                         'from movimentoitens                     '+
                         'Join produto on pro_codigo = mitens_produto ' +
                         'where mitens_movimento = '+ACodigo);
  QryItens.Open;
end;

procedure TFrmCadMovimento.carregarPagamentos(ACodigo: String);
begin
  QryPagamento.SQL.Clear;
  QryPagamento.SQL.Add('select p.*,forpagto_descricao from pagamento as p '+
                       'join formapagto on forpagto_codigo = p.pag_formapagto '+
                       'where pag_movimento = :pag_movimento');
  QryPagamento.ParamByName('pag_movimento').AsString := ACodigo;
  QryPagamento.Open();
end;

procedure TFrmCadMovimento.CriarParcelas(Movimento:TMovimentoDTO;valor:Double;NumeroParcela:Integer;Vcto:TDate);
var
  parcela: TPagamentosMovimentoDTO;
  i: Integer;
begin
   parcela := TPagamentosMovimentoDTO.Create;
   try
     parcela.DataVcto := Vcto;
     parcela.NumeroDaParcela := NumeroParcela;
     parcela.Movimento := Edt_Codigo.Text;
     Parcela.Valor := valor;
     parcela.Juros := 0;
     parcela.Multa := 0;
     parcela.Observacoes := '';

     Movimento.PagamentosMovimento.Add(parcela);
   except
     parcela.Free;
     raise;
   end;
end;

destructor TFrmCadMovimento.destroy;
begin
  if Assigned(Produto) then
    FreeAndNil(Produto);

  if Assigned(Movimento) then
    FreeAndNil(Movimento);

  if Assigned(MovimentoDAO) then
    FreeAndNil(MovimentoDAO);

  if Assigned(ProdutoDAO) then
    FreeAndNil(ProdutoDAO);

  if Assigned(Condicao) then
    FreeAndNil(Condicao);

  if Assigned(CondicaoDAO) then
    FreeAndNil(CondicaoDAO);

  if Assigned(FormaPagto) then
    FreeAndNil(FormaPagto);

  if Assigned(FormaPagtoDAO) then
    FreeAndNil(FormaPagtoDAO);

  if Assigned(PagamentoDAO) then
    FreeAndNil(PagamentoDAO);

 // if Assigned(Pagamento) then
   // FreeAndNil(Pagamento);

  if Assigned(Cliente) then
    FreeAndNil(Cliente);

  if Assigned(ClienteDAO) then
    FreeAndNil(ClienteDAO);

  if Assigned(QryConfig) then
    FreeAndNil(QryConfig);

  if Assigned(Empresa) then
    FreeAndNil(Empresa);

  if Assigned(EmpresaDAO) then
    FreeAndNil(EmpresaDAO);


  if Assigned(RelDtsVenda) then
    FreeAndNil(RelDtsVenda);

  if Assigned(RelDtsItens) then
    FreeAndNil(RelDtsItens);

  if Assigned(RelDtsEmpresa) then
    FreeAndNil(RelDtsEmpresa);

  if Assigned(RelVenda) then
    FreeAndNil(RelVenda);

  if Assigned(RelDtsPagamento) then
    FreeAndNil(RelVenda);

  if Assigned(QryPagamento) then
    FreeAndNil(QryPagamento);


  inherited;
end;

procedure TFrmCadMovimento.carregarVenda(ACodigo:String);
begin
  QryVenda.Connection := fdmConexao.BANCO;
  QryVenda.SQL.Clear;
  QryVenda.SQL.Add('select mov_codigo,cli_nome,mov_data,mov_tipo,mov_totalProdutos, '+
                   'bai_nome,mun_nome,Cli_endereco, '+
                   'mov_totalservicos,cto_valor,mov_acrescimo,mov_desconto, '+
                   'mov_frete,mov_qtdeitens,mov_valorfinal,mov_observacoes,mov_entrega, '+
                   'con_descricao,forpagto_descricao,mov_obspagamento from movimento '+
                   'join cliente on cli_codigo = mov_cliente '+
                   'join bairro on bai_codigo = cli_bairro   '+
                   'join municipio on mun_codigo = cli_municipio '+
                   'join formapagto on forpagto_codigo = mov_forpagto '+
                   'join condicoes on con_codigo = mov_condicoes '+
                   'join contato on cto_cliente = cli_codigo where cto_tipo = 1 and mov_codigo = '+ACodigo);

  QryVenda.Open;
end;

procedure TFrmCadMovimento.ChkMudarEntregaClick(Sender: TObject);
begin
  if ChkMudarEntrega.Checked then
    pnlEntrega.Visible := true
  else
    pnlEntrega.Visible := false;

end;

procedure TFrmCadMovimento.ChkObsPagamentoClick(Sender: TObject);
begin
  if ChkObsPagamento.Checked then
    Edt_ObsPagamento.Visible := true
  else
    Edt_ObsPagamento.Visible := false;
end;

procedure TFrmCadMovimento.confirma;
var
  Cobrancas:TPagamentosMovimentoDAO;

  procedure AdicionarProdutosNaVenda;
  var i:integer;
  ProdutoVenda :TProdutoVenda;
  begin
    TblProdutos.First;

    ProdutoDAO := TProdutoDAO.create(1);

    while not TblProdutos.EoF do
    begin
      ProdutoVenda := TProdutoVenda.Create;
      Produto := ProdutoDAO.EncontrarProduto(TblProdutosCodigo.AsString);
      Produto.ValorVenda := TblProdutosValor.AsFloat;

      ProdutoVenda.Produto := Produto.Clone(Produto);
      ProdutoVenda.Quantidade := TblProdutosQtd.AsFloat;
      ProdutoVenda.Preco := TblProdutosValor.AsFloat;

      Movimento.Produtos.Add(ProdutoVenda.Clone(ProdutoVenda));
      TblProdutos.Next;
    end;
  end;

  procedure AdicionarDescricaoDosPagamentos;
  var
    PagNovo : TPagamentoDTO;
    FormaPagamento : TFormaPagtoDTO;
  begin
    TblFormasPagamento.First;

    if Assigned(Pagamento) then
      Pagamento.Free;

    FormaPagamento := TFormaPagtoDTO.Create;

    while not TblFormasPagamento.Eof do
    begin
      Pagamento := TPagamentoDTO.Create;
      FormaPagamento := FormaPagtoDAO.Encontrar(TblFormasPagamentoCodigoFormaPagto.AsString);
      Pagamento.Codigo     := (StrToInt(fdmConexao.retornaCodigoMaximo('pag_codigo','pagamento'))+
      TblFormasPagamentoIndice.AsInteger).ToString;
      Pagamento.DataVcto   := TblFormasPagamentoDataVcto.AsDateTime;
      Pagamento.Movimento  := Movimento.Codigo;
      Pagamento.FormaPagto := FormaPagamento.Clone(FormaPagamento);
      Pagamento.Valor      := TblFormasPagamentoValor.AsFloat;
      PagNovo :=  Pagamento.Clone(Pagamento);

     // Writeln();
      Movimento.Descricao.Add(PagNovo);
      Pagamento.Free;
      TblFormasPagamento.Next;
    end;
  end;

  procedure GerarParcelas;
  var
    i : integer;
  begin
    TblFormasPagamento.First;
    i := 1;

    while not TblFormasPagamento.Eof do
    begin
      if TblFormasPagamentoGerarParcela.AsBoolean then
      begin
        CriarParcelas(Movimento,TblFormasPagamentoValor.AsFloat,i,TblFormasPagamentoDataVcto.AsDateTime);
        inc(i);
      end;
      TblFormasPagamento.Next;
    end;

  end;

begin

    Movimento    := TMovimentoDTO.Create;
    MovimentoDAO := TMovimentoDAO.Create;
    ClienteDAO   := TClienteDAO.Create;
    EmpresaDAO   := TEmpresaDAO.create;
    PagamentoDAO := TPagamentoDAO.create;
    Cobrancas    := TPagamentosMovimentoDAO.Create;

    Empresa := EmpresaDAO.Encontrar('1');

    CondicaoDAO := TCondicoesDAO.create;
    Condicao := CondicaoDAO.Encontrar(Edt_CodigoCondicaoPagamento.Text);

    FormaPagtoDAO := TFormaPagtoDAO.create;
    FormaPagto := FormaPagtoDAO.Encontrar(Edt_CodigoFormaDePagamento.Text);

    Movimento.Codigo        := Edt_Codigo.Text;
    Movimento.Cliente       := ClienteDAO.encontrarCliente(Edt_CodigoCliente.Text);
    Movimento.Data          := Date;
    Movimento.Tipo          := FStatus.ToString;
    Movimento.TotalProdutos := Edt_TotalProdutos.value;
    Movimento.TotalServicos := Edt_TotalServicos.Value;
    Movimento.Acrescimo     := Edt_Acrescimo.Value;
    Movimento.Desconto      := Edt_Desconto.Value;
    Movimento.Frete         := Edt_Frete.Value;
    Movimento.QtdadeItens   := Edt_QtdeItens.value;
    Movimento.ValorTotal    := Edt_TotalAPagar.Value;
    Movimento.Observacoes   := Edt_Observacoes.Text;
    Movimento.Entrega       := Edt_ObsEntrega.Text;
    Movimento.CondicaoPagto := Condicao;
    Movimento.FormaPagto    := FormaPagto;
    Movimento.ObsPagamento  := Edt_ObsPagamento.Text;

    AdicionarProdutosNaVenda;
    AdicionarDescricaoDosPagamentos;

    GerarParcelas;

    MovimentoDAO.salvar(Movimento);
    ProdutoDAO.SalvarLista(Movimento);
    PagamentoDAO.SalvarLista(Movimento);
    Cobrancas.SalvarLista(Movimento);

    if MessageDlg('Deseja imprimir?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
      imprimir;


   Cobrancas.Free;


end;

procedure TFrmCadMovimento.controlaStatus;
begin
  btnRemover.Enabled   := (TblProdutos.RecordCount > 0) and ((Fstatus <> 4) and (Fstatus <> 5 ));
  btnAlterar.Enabled   := (TblProdutos.RecordCount > 0) and ((Fstatus <> 4) and (Fstatus <> 5 ));
  btnLimpar.Enabled    := (TblProdutos.RecordCount > 0) and ((Fstatus <> 4) and (Fstatus <> 5 ));
  btnConfirmar.Enabled := (TblProdutos.RecordCount > 0) and ((Fstatus <> 4) and (Fstatus <> 5 ));
  btnProcurarCliente.Enabled := ((Fstatus <> 4) and (Fstatus <> 5 ));
  btnProcurarForma.Enabled := (TblProdutos.RecordCount > 0) and ((Fstatus <> 4) and (Fstatus <> 5 ));
  Edt_CodigoFormaDePagamento.Enabled := (TblProdutos.RecordCount > 0) and ((Fstatus <> 4) and (Fstatus <> 5 ));
  btnProcurarCondicao.Enabled := (TblProdutos.RecordCount > 0) and ((Fstatus <> 4) and (Fstatus <> 5 ));
  Edt_CodigoCondicaoPagamento.Enabled := (TblProdutos.RecordCount > 0) and ((Fstatus <> 4) and (Fstatus <> 5 ));
  btnIncluir.Enabled := ((Fstatus <> 4) and (Fstatus <> 5 ));
  ChkMudarEntrega.Enabled := ((Fstatus <> 4) and (Fstatus <> 5 ));
  btnImprimir.Visible := (Fstatus in [4,5]);
end;

constructor TFrmCadMovimento.create(AOwner: TComponent; AStatus: Integer;Movi:string = '');
begin
  inherited create(AOwner);
  FStatus:=AStatus;

  if Movi <> '' then
    FMovimento := Movi;

  TblFormasPagamento.CreateDataSet;
  TblProdutos.CreateDataSet;
end;



procedure TFrmCadMovimento.CarregarTelefone(ACodigo:String);
var
  QryBuscarTel : TFDQuery;
begin
  try
    QryBuscarTel := TFDQuery.Create(nil);
    QryBuscarTel.Connection := fdmConexao.BANCO;
    QryBuscarTel.SQL.Clear;
    QryBuscarTel.SQL.Add('select cto_cliente,cto_tipo,cto_valor from contato '+
                         'where cto_tipo = 1 and cto_cliente = '+ACodigo);
    QryBuscarTel.Open;
    if QryBuscarTel.RecordCount > 0 then
      Edt_Telefone.Text := QryBuscarTel.FieldByName('cto_valor').AsString;
  finally
    QryBuscarTel.Free;
  end;
end;

procedure TFrmCadMovimento.Edt_AcrescimoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = 13) then
  begin
    AtualizarValores;
  end;
  if (key = 13) and (Edt_Acrescimo.Value <= 0) then
  begin
    Edt_PorcentagemAcrescimo.value := 0;
    Edt_PorcentagemAcrescimo.Enabled := true;
  end;
end;

procedure TFrmCadMovimento.Edt_CodigoClienteKeyPress(Sender: TObject;
  var Key: Char);
var
  Cliente : TClienteDTO;
  ClienteDAO : TClienteDAO;

begin
  if key = #13 then
  begin
    Edt_Cliente.Text  := '';
    Edt_Telefone.Text := '';

    try
      Cliente := TClienteDTO.create;
      ClienteDAO := TClienteDAO.create;

      Cliente := ClienteDAO.encontrarCliente(Edt_CodigoCliente.Text);
      if Assigned(Cliente) then
      begin
        Edt_Cliente.Text := Cliente.Nome;
        CarregarTelefone(Cliente.Codigo);
      end
      else
        ShowMessage('Cliente Não encontrado. Insira outro código ou utilize a busca.');
    finally
      Cliente.Free;
      ClienteDAO.Free;
    end;
  end;
end;

procedure TFrmCadMovimento.Edt_CodigoCondicaoPagamentoKeyPress(Sender: TObject;
  var Key: Char);
begin

  if key = #13 then
  begin
    Edt_CondicaoPagamento.Text  := '';
    try
      CondicaoDAO := TCondicoesDAO.create;
      Condicao := CondicaoDAO.Encontrar(Edt_CodigoCondicaoPagamento.Text);

      if Assigned(Condicao) then
      begin
        Edt_CondicaoPagamento.Text := Condicao.Descricao;
        AdicionarPagamentosTabelaTemp;
      end
      else
        ShowMessage('Condição de Pagamento não encontrada. Insira outro código ou utilize a busca.');
    finally
      FreeAndNil(Condicao);
      FreeAndNil(CondicaoDAO);
    end;
  end;
end;

procedure TFrmCadMovimento.Edt_CodigoFormaDePagamentoKeyPress(Sender: TObject;
  var Key: Char);
begin

  if key = #13 then
  begin
    Edt_FormaDePagamento.Text  := '';
    try
      FormaPagtoDAO := TFormaPagtoDAO.create;
      FormaPagto := FormaPagtoDAO.Encontrar(Edt_CodigoFormaDePagamento.Text);

      if Assigned(FormaPagto) then
      begin
        Edt_FormaDePagamento.Text := FormaPagto.Descricao;
      end
      else
        ShowMessage('Forma de Pagamento não encontrada. Insira outro código ou utilize a busca.');
    finally
      FreeAndNil(FormaPagto);
      FreeAndNil(FormaPagtoDAO);
    end;
  end;
end;

procedure TFrmCadMovimento.Edt_CodigoProdutoKeyPress(Sender: TObject;
  var Key: Char);
var
  Produto: TProdutoDTO;
  ProdutoDAO: TProdutoDAO;
begin

  if (Key = #13) and (Trim(Edt_CodigoProduto.Text) <> '') then
  begin
    try
      ProdutoDAO := TProdutoDAO.Create(1);
      Produto := ProdutoDAO.EncontrarProduto(Edt_CodigoProduto.Text);
      if Assigned(Produto) then
      begin
        Edt_Produto.Text := Produto.Nome;
        Edt_Valor.Value  := Produto.ValorVenda;
      end
      else
        ShowMessage('Produto não encontrado. Por favor, digite outro c�digo.');
      Edt_Qtdade.SetFocus;
    finally
      ProdutoDAO.Free;
    end;
  end;
end;

procedure TFrmCadMovimento.Edt_DescontoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key = 13) then
  begin
    AtualizarValores;
  end;
  if (key = 13) and (Edt_Desconto.Value <= 0) then
  begin
    Edt_PorcentagemDesconto.value := 0;
    Edt_PorcentagemDesconto.Enabled := true;
  end;
end;

procedure TFrmCadMovimento.Edt_FreteKeyPress(Sender: TObject; var Key: Char);
begin
 if key = #0 then
  AtualizarValores;
end;

procedure TFrmCadMovimento.Edt_PorcentagemAcrescimoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (key = VK_RETURN) then
    AtualizarValores;

  if (key = VK_RETURN) and (Edt_PorcentagemAcrescimo.Value <= 0) then
  begin
    Edt_Acrescimo.value := 0;
    Edt_Acrescimo.Enabled := true;
  end;
end;

procedure TFrmCadMovimento.Edt_PorcentagemDescontoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    AtualizarValores;
  if (Key = VK_RETURN) and (Edt_PorcentagemDesconto.Value <= 0) then
  begin
    Edt_Desconto.value := 0;
    Edt_Desconto.Enabled := true;
  end;
end;

procedure TFrmCadMovimento.Edt_QtdadeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    btnInserirProdutoClick(Self);
    Edt_Produto.Text := '';
    Edt_CodigoProduto.Text := '';
    Edt_Valor.Value    := 000;
    Edt_Qtdade.Text   := '';
    if FStatusTabela <> 2 then
      Edt_CodigoProduto.SetFocus;
  end;
end;

procedure TFrmCadMovimento.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
    btnCancelarClick(nil);
end;

procedure TFrmCadMovimento.FormShow(Sender: TObject);
  procedure VerificarLabel;
  begin
    if StrToInt(Movimento.Tipo) = 1 then
      LblForm.Caption := 'Venda'
    else
    if StrToInt(Movimento.Tipo) = 2 then
      LblForm.Caption := 'Pré-Venda'
    else
    if StrToInt(Movimento.Tipo) = 3 then
      LblForm.Caption := 'Orçamento';
  end;

begin

  if FStatus = 1 then
    LblForm.Caption := 'Venda'
  else
  if FStatus = 2 then
    LblForm.Caption := 'Pré-Venda'
  else
  if FStatus = 3 then
    LblForm.Caption := 'Orçamento'
  else
  if FStatus = 4 then
  begin
    Carrega(FMovimento);
    VerificarLabel;
    controlaStatus;
  end
  else if FStatus = 5 then
  begin
    carrega(FMovimento);
    VerificarLabel;
    controlaStatus;
  end;

  if FStatus in [0,1,2,3] then
    Edt_Codigo.Text := fdmConexao.retornaCodigoMaximo('Mov_codigo','MOVIMENTO');
  carregarEmpresa('1');
  Edt_CodigoEmpresa.Text := QryEmpresa.FieldByName('Emp_Codigo').AsString;
  Edt_Empresa.Text := QryEmpresa.FieldByName('Emp_nome').AsString;

  controlaStatus;
end;

procedure TFrmCadMovimento.GridFormasPagamentoCellClick(Column: TColumn);
var
  TotalApagar : Double;
  TotalConfirmado : Double;
  TotalRestante : Double;
  divisao : Double;
  ind,i: integer;
begin
  if Column.FieldName = 'FormaPagamento' then
  try
    FrmPesFormaPagamento := TFrmPesFormaPagamento.Create(Self);
    FrmPesFormaPagamento.ShowModal;
  finally
    if FrmPesFormaPagamento.ModalResult = mrOk then
    begin
      TblFormasPagamento.Edit;
      TblFormasPagamentoCodigoFormaPagto.AsString := FrmPesFormaPagamento.QryPesquisaFORPAGTO_CODIGO.AsString;
      TblFormasPagamentoFormaPagamento.AsString := FrmPesFormaPagamento.QryPesquisaFORPAGTO_DESCRICAO.AsString;
      TblFormasPagamentoGerarParcela.AsBoolean := FrmPesFormaPagamento.QryPesquisaFORPAGTO_AVISTA.AsInteger <> 1;
    end;
    FrmPesFormaPagamento.Free;
  end;

end;

procedure TFrmCadMovimento.GridFormasPagamentoKeyPress(Sender: TObject;
  var Key: Char);
  var
  TotalApagar,TotalConfirmado,TotalRestante,divisao :Double;
  ind,i:integer;
begin
  if (Key = Char(VK_RETURN)) and (TblFormasPagamento.State in [dsEdit, dsInsert]) then
  begin
    TblFormasPagamento.Post;

    if GridFormasPagamento.SelectedField.FieldName = 'Valor' then
    begin
      TotalApagar := 0;
      TotalConfirmado := 0;
      TotalRestante := 0;

      ind:= TblFormasPagamentoIndice.AsInteger;

      TotalAPagar := Edt_TotalAPagar.Value;

      TblFormasPagamento.First;

       while (not TblFormasPagamento.Eof) and (TblFormasPagamentoIndice.AsInteger <= ind) do
      begin
        TotalConfirmado := TotalConfirmado + TblFormasPagamentoValor.AsFloat;
        TblFormasPagamento.Next;
      end;

      TotalRestante := TotalAPagar - TotalConfirmado;

      if TotalRestante <= 0 then
        divisao := 0
      else
        if TblFormasPagamento.RecordCount > ind then
          divisao := TotalRestante / (TblFormasPagamento.RecordCount - ind)
        else
          divisao := 0;

      if TblFormasPagamento.Locate('indice', ind, []) then
      begin
        TblFormasPagamento.Next;
        while not TblFormasPagamento.Eof do
        begin
          TblFormasPagamento.Edit;
          TblFormasPagamentoValor.AsFloat := divisao;
          TblFormasPagamento.Post;
          TblFormasPagamento.Next;
        end;
      end;
    end;
  end;
end;

procedure TFrmCadMovimento.imprimir;
var
  img: TfrxPictureView;
  pngImage: TPngImage;
  Stream : TMemoryStream;
  imgRomaneio:TfrxPictureView;
begin
    EmpresaDAO:= TEmpresaDAO.create;
    Empresa := EmpresaDAO.Encontrar('1');

    carregarEmpresa(movimento.Codigo);
    carregarVenda(movimento.Codigo);
    carregarItens(movimento.Codigo);
    carregarPagamentos(Movimento.Codigo);

    RelDtsPagamento.Open;
    RelDtsVenda.Open;
    RelDtsItens.Open;
    RelDtsEmpresa.Open;

    pngImage := TPngImage.Create;
    stream := TMemoryStream.Create;

    if Length(Empresa.Logo) > 0 then
     begin
       stream.Write(Empresa.Logo[0], Length(Empresa.Logo)); // Carregar o array de bytes no stream
       stream.Position := 0;
       pngImage.LoadFromStream(stream); // Carregar imagem PNG a partir do stream
     end;

    img := TfrxPictureView(RelVenda.FindObject('Logo'));
    imgRomaneio := TfrxPictureView(RelVenda.FindObject('LogoRomaneio'));

    if Assigned(img) then
    begin
      img.Picture.Assign(pngImage);
      imgRomaneio.Picture.Assign(pngImage);
    end;
    RelVenda.ShowReport();


end;

procedure TFrmCadMovimento.Panel2Click(Sender: TObject);
begin
  pnlProduto.Visible := false;
end;

procedure TFrmCadMovimento.Panel3Click(Sender: TObject);
begin
  pnlProduto.Visible := false;
end;

procedure TFrmCadMovimento.pnlBotoesClick(Sender: TObject);
begin
  pnlProduto.Visible := false;
end;

procedure TFrmCadMovimento.pnlInformacoesClick(Sender: TObject);
begin
  pnlProduto.Visible := false;
end;

procedure TFrmCadMovimento.pnlProdutoExit(Sender: TObject);
begin
  pnlProduto.Visible := false;
end;


procedure TFrmCadMovimento.btnInserirProdutoClick(Sender: TObject);
begin
  if Trim(Edt_Produto.Text) = '' then
    exit;
  if Edt_valor.Value <= 0 then
    exit;
  if StrToInt(Edt_Qtdade.Text) <=0 then
    exit;

  if FStatusTabela = 1 then
    TblProdutos.Append
  else
    TblProdutos.Edit;

  TblProdutosCodigo.AsString := Edt_CodigoProduto.Text;
  TblProdutosNome.AsString   := Edt_Produto.Text;
  TblProdutosQtd.AsFloat     := StrToFloat(Edt_Qtdade.Text);
  TblProdutosValor.AsFloat   := Edt_Valor.Value;
  TblProdutosTotal.AsFloat   := TblProdutosValor.AsFloat * TblProdutosQtd.AsFloat;

  TblProdutos.Post;

  if FStatusTabela = 2 then
    pnlProduto.Visible := false;

  AtualizarValores;

  controlaStatus;
end;

procedure TFrmCadMovimento.btnLimparClick(Sender: TObject);
begin
  TblFormasPagamento.Close;
  TblFormasPagamento.CreateDataSet;
end;

procedure TFrmCadMovimento.btnOcultarPainelClick(Sender: TObject);
begin
  pnlProduto.Visible := false;
end;

end.
