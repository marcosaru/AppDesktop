unit uPesCategorias;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TFrmPesCategoria = class(TForm)
    pnlMain: TPanel;
    pnlBotoes: TPanel;
    btnCadastrar: TButton;
    Button1: TButton;
    Button3: TButton;
    Grid: TDBGrid;
    QryPesquisa: TFDQuery;
    QryPesquisaCAT_CODIGO: TIntegerField;
    QryPesquisaCAT_DESCRICAO: TStringField;
    btnCancelar: TButton;
    DTSPesquisa: TDataSource;
    procedure GridDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCadastrarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    procedure AbrirCadastro(ACodigo:Integer);
    procedure carregar;
  public
    { Public declarations }
  end;

var
  FrmPesCategoria: TFrmPesCategoria;

implementation

{$R *.dfm}

uses dmConexao, uCadCategoria;

procedure TFrmPesCategoria.AbrirCadastro(ACodigo: Integer);
begin
  Try
    FrmCadCategoria := TFrmCadCategoria.Create(Self,ACodigo);
    FrmCadCategoria.ShowModal;
  Finally
    if FrmCadCategoria.ModalResult = mrOk then
      carregar;
    FrmCadCategoria.Free;
  End;
end;

procedure TFrmPesCategoria.btnCadastrarClick(Sender: TObject);
begin
  AbrirCadastro(1);
end;

procedure TFrmPesCategoria.btnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmPesCategoria.Button1Click(Sender: TObject);
begin
  AbrirCadastro(2);
end;

procedure TFrmPesCategoria.carregar;
begin
  QryPesquisa.SQL.Clear;
  QryPesquisa.SQL.Add('select * from categoria');
  QryPesquisa.Open();
end;

procedure TFrmPesCategoria.FormShow(Sender: TObject);
begin
  Carregar;
end;

procedure TFrmPesCategoria.GridDblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

end.
