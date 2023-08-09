unit uPesFormPagto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TFrmPesFormaPagamento = class(TForm)
    pnlMain: TPanel;
    pnlBotoes: TPanel;
    btnCadastrar: TButton;
    btnAlterar: TButton;
    btnApresentar: TButton;
    btnCancelar: TButton;
    Grid: TDBGrid;
    DataSource1: TDataSource;
    QryPesquisa: TFDQuery;
    QryPesquisaFORPAGTO_CODIGO: TIntegerField;
    QryPesquisaFORPAGTO_DESCRICAO: TStringField;
    QryPesquisaFORPAGTO_AVISTA: TIntegerField;
    QryPesquisaAv: TStringField;
    procedure btnCadastrarClick(Sender: TObject);
    procedure btnApresentarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridDblClick(Sender: TObject);
    procedure QryPesquisaCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    procedure AbrirCadastro(ACodigo:integer);
    procedure Carregar;
    procedure ControlarStatus;
  public
    { Public declarations }
  end;

var
  FrmPesFormaPagamento: TFrmPesFormaPagamento;

implementation

{$R *.dfm}

uses dmConexao, uCadFormaPagamento;

procedure TFrmPesFormaPagamento.AbrirCadastro(ACodigo: integer);
begin
   try
    FrmCadFormaPagamento := TFrmCadFormaPagamento.create(Self,ACodigo);
    FrmCadFormaPagamento.ShowModal;
  finally
    FrmCadFormaPagamento.Free;
  end;
end;

procedure TFrmPesFormaPagamento.btnCadastrarClick(Sender: TObject);
begin
  AbrirCadastro(1);
  Carregar;
end;

procedure TFrmPesFormaPagamento.btnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmPesFormaPagamento.Carregar;
begin
  QryPesquisa.SQL.Clear;
  QryPesquisa.SQL.Add('SELECT * FROM FORMAPAGTO');
  QryPesquisa.Open;
end;

procedure TFrmPesFormaPagamento.ControlarStatus;
begin
  btnAlterar.Enabled := QryPesquisa.RecordCount > 0;
  btnApresentar.Enabled := QryPesquisa.RecordCount > 0;
end;

procedure TFrmPesFormaPagamento.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_Escape then
    btnCancelarClick(nil);
end;

procedure TFrmPesFormaPagamento.FormShow(Sender: TObject);
begin
  Carregar;
  ControlarStatus;
end;

procedure TFrmPesFormaPagamento.GridDblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFrmPesFormaPagamento.QryPesquisaCalcFields(DataSet: TDataSet);
begin
   if QryPesquisaFORPAGTO_AVISTA.AsInteger = 1 then
    QryPesquisaAv.AsString := 'SIM'
  else
    QryPesquisaAv.AsString := 'N�O';
end;

procedure TFrmPesFormaPagamento.btnAlterarClick(Sender: TObject);
begin
  AbrirCadastro(2);
  Carregar;
end;

procedure TFrmPesFormaPagamento.btnApresentarClick(Sender: TObject);
begin
  AbrirCadastro(3);
end;

end.
