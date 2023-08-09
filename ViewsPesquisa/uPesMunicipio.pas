unit uPesMunicipio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TFrmPesMunicipio = class(TForm)
    pnlMain: TPanel;
    pnlBotoes: TPanel;
    btnCadastrar: TButton;
    Button1: TButton;
    Button2: TButton;
    btnCancelar: TButton;
    DBGrid1: TDBGrid;
    DtsMunicipio: TDataSource;
    QryPesquisa: TFDQuery;
    QryPesquisaMUN_CODIGO: TIntegerField;
    QryPesquisaMUN_NOME: TStringField;
    QryPesquisaEST_NOME: TStringField;
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCadastrarClick(Sender: TObject);
    procedure carrega;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    procedure AbrirCadastroMunicipio(AStatus:integer);
  public
    { Public declarations }
  end;

var
  FrmPesMunicipio: TFrmPesMunicipio;

implementation

{$R *.dfm}

uses dmConexao, uCadMunicipio;

procedure TFrmPesMunicipio.AbrirCadastroMunicipio(AStatus: integer);
begin
  try
    FrmCadMunicipio := TFrmCadMunicipio.createWithCodigo(self,AStatus);
    FrmCadMunicipio.ShowModal;
  finally
    if FrmCadMunicipio.ModalResult = mrOk then
      carrega;
    FrmCadMunicipio.Free;
  end;
end;

procedure TFrmPesMunicipio.btnCadastrarClick(Sender: TObject);
begin
   AbrirCadastroMunicipio(1);
end;

procedure TFrmPesMunicipio.Button1Click(Sender: TObject);
begin
  AbrirCadastroMunicipio(2);
end;

procedure TFrmPesMunicipio.Button2Click(Sender: TObject);
begin
  AbrirCadastroMunicipio(3);
end;

procedure TFrmPesMunicipio.carrega;
begin
  QryPesquisa.sql.Clear;
  QryPesquisa.Sql.Add('select mun_Codigo,mun_nome,est_nome from municipio '+
                      'join estado on mun_estado = est_codigo');
  QryPesquisa.Open;
end;

procedure TFrmPesMunicipio.DBGrid1DblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFrmPesMunicipio.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    btnCancelar.Click();

end;

procedure TFrmPesMunicipio.FormShow(Sender: TObject);
begin
  carrega;
end;

end.
