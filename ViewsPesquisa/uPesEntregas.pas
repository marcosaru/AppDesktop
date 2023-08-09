unit uPesEntregas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TFrmPesEntrega = class(TForm)
    pnlMain: TPanel;
    pnlBotoes: TPanel;
    btnCadastrar: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Grid: TDBGrid;
    DtsEntregas: TDataSource;
    QryPesquisa: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPesEntrega: TFrmPesEntrega;

implementation

{$R *.dfm}

uses dmConexao;

end.
