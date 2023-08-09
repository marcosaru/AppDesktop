unit uPesFornecedores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TFrmPesFornecedor = class(TForm)
    pnlMain: TPanel;
    pnlBotoes: TPanel;
    btnCadastrar: TButton;
    btnAlterar: TButton;
    btnApresentar: TButton;
    btnCancelar: TButton;
    DBGrid1: TDBGrid;
    DT: TDataSource;
    QryPesquisa: TFDQuery;
    QryPesquisaFOR_CODIGO: TIntegerField;
    QryPesquisaFOR_NOME: TStringField;
    QryPesquisaMUN_NOME: TStringField;
    procedure FormShow(Sender: TObject);
    procedure CARREGA;
    procedure controlaStatus;
    procedure btnCadastrarClick(Sender: TObject);
    procedure btnApresentarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelarClick(Sender: TObject);
    procedure AbrirCadastro(AStatus:integer);
    procedure btnAlterarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPesFornecedor: TFrmPesFornecedor;

implementation

{$R *.dfm}

uses dmConexao, uCadFornecedor;

procedure TFrmPesFornecedor.AbrirCadastro(AStatus: integer);
begin
  try
    FrmCadFornecedor := TFrmCadFornecedor.create(Self,AStatus);
    FrmCadFornecedor.ShowModal;
  finally
    if FrmCadFornecedor.ModalResult = mrOk then
      carrega;
    FrmCadFornecedor.free;
  end;
end;

procedure TFrmPesFornecedor.btnAlterarClick(Sender: TObject);
begin
  AbrirCadastro(2);
end;

procedure TFrmPesFornecedor.btnApresentarClick(Sender: TObject);
begin
  AbrirCadastro(3);
end;

procedure TFrmPesFornecedor.btnCadastrarClick(Sender: TObject);
begin
  AbrirCadastro(1);
end;

procedure TFrmPesFornecedor.btnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmPesFornecedor.CARREGA;
begin
  QryPesquisa.sql.Clear;
  QryPesquisa.SQl.Add('select for_codigo,for_nome,mun_nome from fornecedor '+
                      'join municipio on mun_codigo = for_municipio');
  QryPesquisa.Open;
end;

procedure TFrmPesFornecedor.controlaStatus;
begin
  btnAlterar.Enabled    := QryPesquisa.RecordCount >0;
  btnApresentar.Enabled := QryPesquisa.RecordCount >0;
end;

procedure TFrmPesFornecedor.DBGrid1DblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFrmPesFornecedor.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = VK_ESCAPE then
    btnCancelar.Click();
end;

procedure TFrmPesFornecedor.FormShow(Sender: TObject);
begin
  CARREGA;
  controlaStatus;
end;

end.
