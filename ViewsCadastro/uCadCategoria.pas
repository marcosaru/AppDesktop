unit uCadCategoria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,FireDAC.Stan.Intf, FireDAC.Stan.Option,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,CategoriaDAO,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFrmCadCategoria = class(TForm)
    Edt_Codigo: TEdit;
    Edt_Descricao: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    btnConfirma: TButton;
    btnCancelar: TButton;
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FStatus : integer;
    CategoriaDAO : TCategoriaDAO;
    QryPesquisa : TFDQuery;
    procedure Limpar;
    Procedure Carregar;
  public
    { Public declarations }
    Constructor Create(AOwner:TComponent;ACodigo:Integer);overload;
    Destructor Destroy;override;
  end;

var
  FrmCadCategoria: TFrmCadCategoria;

implementation

{$R *.dfm}

uses CategoriaDTO, dmConexao, uPesCategorias;

procedure TFrmCadCategoria.btnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmCadCategoria.btnConfirmaClick(Sender: TObject);
var
  Categoria : TCategoriaDTO;
begin
  try
    Categoria := TCategoriaDTO.Create;

    Categoria.Codigo := Edt_Codigo.Text;
    Categoria.Descricao := Edt_Descricao.Text;

    if FStatus <> 2 then
      CategoriaDAO.Salvar(Categoria)
    else
      CategoriaDAO.Alterar(Categoria);

    if MessageDlg('Deseja adicionar outro registro?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
    begin
      Limpar;
      Edt_Codigo.Text := fdmConexao.retornaCodigoMaximo('CAT_CODIGO','CATEGORIA');
    end
    else
      ModalResult := mrOk;
  finally
    Categoria.Free;
  end;
end;

procedure TFrmCadCategoria.Carregar;
var
  Categoria : TCategoriaDTO;
begin
    Categoria := CategoriaDAO.Encontrar(FrmPesCategoria.QryPesquisaCAT_CODIGO.AsString);

    Edt_Codigo.Text    := Categoria.Codigo;
    Edt_Descricao.Text := Categoria.Descricao;
end;

constructor TFrmCadCategoria.Create(AOwner: TComponent; ACodigo: Integer);
begin
  inherited create(AOwner);
  FStatus := ACodigo;
  CategoriaDAO := TCategoriaDAO.create;
  QryPesquisa := TFDQuery.Create(nil);
  QryPesquisa.Connection := fdmConexao.BANCO;
end;

destructor TFrmCadCategoria.Destroy;
begin
  if Assigned(CategoriaDAO) then
    FreeAndNil(CategoriaDAO);

  FreeAndNil(QryPesquisa);

  inherited;
end;

procedure TFrmCadCategoria.FormShow(Sender: TObject);
begin
  if FStatus = 1 then
  begin
    Limpar;
    Edt_Codigo.Text := fdmConexao.retornaCodigoMaximo('CAT_CODIGO','CATEGORIA');
  end
  else
  if FStatus = 2 then
  begin
    Carregar;
  end;
end;

procedure TFrmCadCategoria.Limpar;
begin
  Edt_Codigo.Text    := '';
  Edt_Descricao.Text := '';
end;

end.
