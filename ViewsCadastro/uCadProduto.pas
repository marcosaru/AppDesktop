unit uCadProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,CategoriaDAO,
  ProdutoDAO,ProdutoDTO,FornecedorDTO,FornecedorDAO, uCurrencyEditVCL, Vcl.Mask;

type
  TFrmCadProduto = class(TForm)
    pnlCadastro: TPanel;
    Panel2: TPanel;
    Edt_Codigo: TEdit;
    Edt_Nome: TEdit;
    btnConfirmar: TButton;
    btnCancelar: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edt_Custo: TCurrencyEdit;
    Edt_Venda: TCurrencyEdit;
    Label4: TLabel;
    Label5: TLabel;
    Edt_Medidas: TEdit;
    Edt_Tecido: TEdit;
    Edt_Madeira: TEdit;
    Edt_Descricao: TMemo;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Edt_CodigoFornecedor: TEdit;
    Edt_Fornecedor: TEdit;
    btnProcurarFornecedor: TButton;
    Label10: TLabel;
    Edt_CodigoCategoria: TEdit;
    btnProcurarCategoria: TButton;
    Edt_Categoria: TEdit;
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnProcurarFornecedorClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure Edt_CodigoFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure btnProcurarCategoriaClick(Sender: TObject);
    procedure Edt_CodigoCategoriaKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
    FStatus       : integer;
    Produto       : TProdutoDTO;
    ProdutoDAO    : TProdutoDAO;
    Fornecedor    : TFornecedorDTO;
    FornecedorDAO : TFornecedorDAO;
    CategoriaDAO  : TCategoriaDAO;
    procedure confirma;
    procedure Limpar;
    procedure carregar;
    procedure ControlarStatus;
  public
    { Public declarations }
    constructor create(AOwner:TComponent;ACodigo:integer);
  end;

var
  FrmCadProduto: TFrmCadProduto;

implementation

{$R *.dfm}

uses dmConexao, uPesProduto, uPesFornecedores, uCadFornecedor, uPesCategorias,
     CategoriaDTO;

{ TFrmCadProduto }

procedure TFrmCadProduto.btnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmCadProduto.btnConfirmarClick(Sender: TObject);
begin
  if Trim(Edt_Nome.Text) = '' then
  begin
    ShowMessage('Por favor insira um nome ao produto');
    exit;
  end;
  if Trim(Edt_Venda.Text) = '' then
  begin
    ShowMessage('Por favor insira o valor de venda do produto');
    exit;
  end;
  if Trim(Edt_CodigoCategoria.Text) = '' then
  begin
    ShowMessage('� Obrigat�rio informar uma categoria.');
    Exit;
  end;
  if Trim(Edt_CodigoFornecedor.Text) = '' then
  begin
    ShowMessage('� Obrigat�rio informar um fornecedor.');
    Exit;
  end;

  confirma;
end;

procedure TFrmCadProduto.btnProcurarCategoriaClick(Sender: TObject);
begin
  Try
    FrmPesCategoria := TFrmPesCategoria.Create(Self);
    FrmPesCategoria.ShowModal;
  Finally
    if FrmPesCategoria.ModalResult = mrOk then
    begin
      Edt_CodigoCategoria.Text := FrmPesCategoria.QryPesquisaCAT_CODIGO.AsString;
      Edt_Categoria.Text       := FrmPesCategoria.QryPesquisaCAT_DESCRICAO.AsString;
    end;
    FrmPesCategoria.Free;
  End;
end;

procedure TFrmCadProduto.btnProcurarFornecedorClick(Sender: TObject);
begin
  try
    FrmPesFornecedor := TFrmPesFornecedor.Create(self);
    FrmPesFornecedor.ShowModal;
  finally
    if FrmPesFornecedor.ModalResult = mrOk then
    begin
      Edt_Fornecedor.text       := FrmPesFornecedor.QryPesquisaFOR_NOME.AsString;
      Edt_CodigoFornecedor.text := FrmPesFornecedor.QryPesquisaFOR_CODIGO.AsString;
    end;
    FrmPesFornecedor.free;
  end;
end;

procedure TFrmCadProduto.carregar;
begin
  try
    Produto := TProdutoDTO.Create;
    ProdutoDAO := TProdutoDAO.create(FStatus);

    Produto := ProdutoDAO.EncontrarProduto(FrmPesProduto.QryPesquisaPRO_CODIGO.AsString);

    Edt_codigo.Text           := Produto.Codigo;
    Edt_nome.Text             := Produto.Nome;
    Edt_Custo.Value           := Produto.Custo;
    Edt_Venda.Value           := Produto.ValorVenda;
    Edt_Medidas.Text          := Produto.Medidas;
    Edt_Tecido.Text           := Produto.Tecido;
    Edt_Madeira.Text          := Produto.Madeira;
    Edt_Fornecedor.Text       := Produto.Fornecedor.Nome;
    Edt_CodigoFornecedor.Text := Produto.Fornecedor.Codigo;
    Edt_Descricao.Text        := Produto.Descricao;
    Edt_CodigoCategoria.Text := Produto.Categoria.Codigo;
    Edt_Categoria.Text       := Produto.Categoria.Descricao;

  finally
    Produto.free;
    ProdutoDAO.free;
  end;
end;

procedure TFrmCadProduto.confirma;
begin
  try
    Produto := TProdutoDTO.Create;
    ProdutoDAO := TProdutoDAO.create(FStatus);
    FornecedorDAO := TFornecedorDAO.create;
    CategoriaDAO := TCategoriaDAO.create;

    produto.Codigo     := Edt_codigo.Text;
    produto.Nome       := Edt_nome.Text;
    produto.Custo      := Edt_Custo.Value;
    Produto.ValorVenda := Edt_Venda.Value;
    Produto.Medidas    := Edt_Medidas.Text;
    Produto.Tecido     := Edt_Tecido.Text;
    Produto.Madeira    := Edt_Madeira.Text;
    Produto.Fornecedor := FornecedorDAO.EncontrarFornecedor(Edt_CodigoFornecedor.Text);
    Produto.Descricao  := Edt_Descricao.Text;
    Produto.Categoria  := CategoriaDAO.Encontrar(Edt_CodigoCategoria.Text);

    if FStatus in [0,1] then
      ProdutoDAO.salvar(Produto)
    else
    if FStatus = 2 then
      ProdutoDAO.alterar(Produto);
  finally
    FornecedorDAO.free;
    Produto.free;
    ProdutoDAO.free;
    CategoriaDAO.Free;
  end;
  if FStatus <> 2 then
  begin
    if MessageDlg('Deseja incluir outro produto?',mtConfirmation,[mbYes,mbNo],0) = mryes then
    begin
      Limpar;
      Edt_Codigo.Text := fdmConexao.retornaCodigoMaximo('pro_codigo','produto');
    end
    else
      ModalResult := mrOk
  end
  else
    ModalResult := mrOk;
end;

procedure TFrmCadProduto.ControlarStatus;
begin
  btnConfirmar.Enabled := FStatus <> 3;
  pnlCadastro.Enabled  := FStatus <> 3;
end;

constructor TFrmCadProduto.create(AOwner: TComponent; ACodigo: integer);
begin
  inherited create(AOwner);
  FStatus := ACodigo;
end;

procedure TFrmCadProduto.Edt_CodigoCategoriaKeyPress(Sender: TObject;
  var Key: Char);
var
  CategoriaEncontrada : TCategoriaDTO;
begin
  if Trim(Edt_CodigoCategoria.Text) <> '' then
    if Key = #13 then
    begin
      Try
        CategoriaDAO := TCategoriaDAO.create;
        CategoriaEncontrada := CategoriaDAO.Encontrar(Edt_CodigoCategoria.Text);

         if Assigned(CategoriaEncontrada) then
           Edt_Categoria.Text := CategoriaEncontrada.Descricao
         else
          ShowMessage('N�o foi possivel localizar uma categoria com este c�digo, '+
                      'por favor coloque outro c�digo ou use a busca.');
      Finally
        CategoriaDAO.Free;
      End;
    end;
end;

procedure TFrmCadProduto.Edt_CodigoFornecedorKeyPress(Sender: TObject;
  var Key: Char);
begin

  if Trim(Edt_CodigoFornecedor.text) <> '' then
    if Key = #13 then
    begin
      try
        Fornecedor := TFornecedorDTO.Create;
        FornecedorDAO := TFornecedorDAO.create;

        Fornecedor := FornecedorDAO.EncontrarFornecedor(Edt_CodigoFornecedor.Text);

        if Assigned(Fornecedor) then
        begin
          Edt_Fornecedor.Text := Fornecedor.Nome;
        end
        else
          ShowMessage('N�o foi encontrado nenhum fornecedor com este c�digo.');
      finally
        Fornecedor.Free;
        FornecedorDAO.Free;
      end;
    end;
end;

procedure TFrmCadProduto.FormShow(Sender: TObject);
begin
  if FStatus in [0,1] then
  begin
    Limpar;
    Edt_Codigo.Text := fdmConexao.retornaCodigoMaximo('PRO_CODIGO','PRODUTO');
  end
  else
  if FStatus = 2 then
  begin
    Limpar;
    carregar;
  end
  else
  if FStatus = 3 then
  begin
    Limpar;
    Carregar;
  end;
    ControlarStatus;
end;

procedure TFrmCadProduto.Limpar;
var
  I: Integer;
begin
  for I := 0 to ComponentCount - 1 do
  begin
    if Components[I] is TEdit then
      TEdit(Components[I]).Text := ''
    else if Components[I] is TMaskEdit then
      TMaskEdit(Components[I]).Text := ''
    else if Components[I] is TCurrencyEdit then
      TCurrencyEdit(Components[I]).Value := 0;
  end;
end;

end.
