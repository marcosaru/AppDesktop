unit uPesCondicoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TFrmPesCondicoes = class(TForm)
    pnlMain: TPanel;
    pnlBotoes: TPanel;
    btnCadastrar: TButton;
    btnAlterar: TButton;
    btnApresentar: TButton;
    btnCancelar: TButton;
    Grid: TDBGrid;
    DTSCondicoes: TDataSource;
    QryPesquisa: TFDQuery;
    QryPesquisaCON_CODIGO: TIntegerField;
    QryPesquisaCON_DESCRICAO: TStringField;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCadastrarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnApresentarClick(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
  private
    { Private declarations }

    procedure AbrirCadastro(ACodigo:Integer);
    procedure Carregar;
    procedure ControlarStatus;
  public
    { Public declarations }
  end;

var
  FrmPesCondicoes: TFrmPesCondicoes;

implementation

{$R *.dfm}

uses dmConexao, uCadCondicoes;

procedure TFrmPesCondicoes.AbrirCadastro(ACodigo: Integer);
begin
  try
    FrmCadCondicoes := TFrmCadCondicoes.create(Self,ACodigo);
    FrmCadCondicoes.ShowModal;
  finally
    FrmCadCondicoes.Free;
  end;
end;

procedure TFrmPesCondicoes.btnAlterarClick(Sender: TObject);
begin
  AbrirCadastro(2);
  Carregar;
  ControlarStatus;
end;

procedure TFrmPesCondicoes.btnApresentarClick(Sender: TObject);
begin
  AbrirCadastro(3);
  Carregar;
end;

procedure TFrmPesCondicoes.btnCadastrarClick(Sender: TObject);
begin
  AbrirCadastro(1);
  Carregar;
  ControlarStatus;
end;

procedure TFrmPesCondicoes.btnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmPesCondicoes.Carregar;
begin
  QryPesquisa.SQL.Clear;
  QryPesquisa.SQL.Add('select * from condicoes');
  QryPesquisa.Open();
end;

procedure TFrmPesCondicoes.ControlarStatus;
begin
  btnAlterar.Enabled := QryPesquisa.RecordCount > 0;
  btnApresentar.Enabled := QryPesquisa.RecordCount > 0;
end;

procedure TFrmPesCondicoes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = Vk_Escape then
    btnCancelarClick(nil);
end;

procedure TFrmPesCondicoes.FormShow(Sender: TObject);
begin
  Carregar;
  ControlarStatus;
end;

procedure TFrmPesCondicoes.GridDblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

end.
