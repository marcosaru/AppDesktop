unit uPesVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, frxClass, frxDBSet, Vcl.StdCtrls, Vcl.Mask;

type
  TFrmPesVenda = class(TForm)
    pnlBotoes: TPanel;
    pnlPesVenda: TPanel;
    GridVendas: TDBGrid;
    QryPesquisa: TFDQuery;
    DTSVenda: TDataSource;
    QryPesquisaMOV_CODIGO: TIntegerField;
    QryPesquisaCLI_NOME: TStringField;
    QryPesquisaMOV_DATA: TSQLTimeStampField;
    QryPesquisaMOV_TIPO: TIntegerField;
    QryPesquisaMOV_TOTALPRODUTOS: TFloatField;
    QryPesquisaMOV_TOTALSERVICOS: TFloatField;
    QryPesquisaMOV_ACRESCIMO: TFloatField;
    QryPesquisaMOV_DESCONTO: TFloatField;
    QryPesquisaMOV_FRETE: TFloatField;
    QryPesquisaMOV_QTDEITENS: TSingleField;
    QryPesquisaMOV_VALORFINAL: TFloatField;
    RelVenda: TfrxReport;
    RelDTSVenda: TfrxDBDataset;
    btnCadastrar: TButton;
    btnAlterar: TButton;
    btnApresentar: TButton;
    pnlBuscar: TPanel;
    Edt_Codigo: TEdit;
    Edt_Nome: TEdit;
    Edt_DataInicio: TMaskEdit;
    Edt_DataFim: TMaskEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btnBuscar: TButton;
    btnImprimir: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Edt_CodigoKeyPress(Sender: TObject; var Key: Char);
    procedure Zerar(Sender: TObject);
    procedure Edt_NomeKeyPress(Sender: TObject; var Key: Char);
    procedure Edt_DataInicioKeyPress(Sender: TObject; var Key: Char);
    procedure Edt_DataFimKeyPress(Sender: TObject; var Key: Char);
    procedure pnlBuscarExit(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnCadastrarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnApresentarClick(Sender: TObject);
    procedure GridVendasTitleClick(Column: TColumn);
    procedure btnImprimirClick(Sender: TObject);
  private
    { Private declarations }
    ordenacao : String;
    procedure AbrirVenda(AStatus:integer);
    procedure ControlarStatus;
  public
    { Public declarations }
    procedure carrega(ACodigo: Integer = 0);
  end;

var
  FrmPesVenda: TFrmPesVenda;

implementation

{$R *.dfm}

uses dmConexao, uCadMovimento;

{ TFrmPesVenda }

procedure TFrmPesVenda.AbrirVenda(AStatus: integer);
begin
  Try
    FrmCadMovimento := TFrmCadMovimento.create(Self,AStatus,QryPesquisaMOV_CODIGO.AsString);
    FrmCadMovimento.ShowModal;
  Finally
    if FrmCadMovimento.ModalResult = mrOk then
      Carrega;

    FrmCadMovimento.Free;
  End;
end;

procedure TFrmPesVenda.btnAlterarClick(Sender: TObject);
begin
  AbrirVenda(4);
end;

procedure TFrmPesVenda.btnApresentarClick(Sender: TObject);
begin
    AbrirVenda(5);
end;

procedure TFrmPesVenda.btnBuscarClick(Sender: TObject);
begin
  pnlBuscar.Visible := true;
end;

procedure TFrmPesVenda.btnCadastrarClick(Sender: TObject);
begin
    AbrirVenda(1);
end;

procedure TFrmPesVenda.btnImprimirClick(Sender: TObject);
begin
  try
    FrmCadMovimento := TFrmCadMovimento.create(Self,4,QryPesquisaMOV_CODIGO.AsString);
    FrmCadMovimento.carrega(QryPesquisaMOV_CODIGO.AsString);
    FrmCadMovimento.imprimir;
  finally
    FrmCadMovimento.Free;
  end;
end;

procedure TFrmPesVenda.carrega(ACodigo: Integer = 0);
begin
  QryPesquisa.SQL.Clear;
  QryPesquisa.SQL.Add('select mov_codigo,cli_nome,mov_data,mov_tipo,mov_totalProdutos, '+
                      'mov_totalservicos,mov_acrescimo,mov_desconto,          '+
                      'mov_frete,mov_qtdeitens,mov_valorfinal from movimento '+
                      'join cliente on cli_codigo = mov_cliente where 1=1 ');

  if ACodigo > 0 then
  begin
    QryPesquisa.SQL.Add('and mov_codigo = '+ACodigo.ToString);
  end;

  if Ordenacao <> '' then
    QryPesquisa.SQL.Add(ordenacao);

  QryPesquisa.Open();

  ControlarStatus;
end;

procedure TFrmPesVenda.ControlarStatus;
begin
  btnApresentar.Enabled := QryPesquisa.RecordCount > 0;
  btnAlterar.Enabled    := QryPesquisa.RecordCount > 0;
  btnImprimir.Enabled   := QryPesquisa.RecordCount > 0;
  btnBuscar.Enabled     := QryPesquisa.RecordCount > 0;
end;

procedure TFrmPesVenda.Edt_CodigoKeyPress(Sender: TObject; var Key: Char);
begin
  if (key = #13) and (Edt_Codigo.Text <> '') then
  begin
    QryPesquisa.Locate('MOV_CODIGO',Edt_Codigo.Text);
  end;
end;

procedure TFrmPesVenda.Edt_DataFimKeyPress(Sender: TObject; var Key: Char);
var
  DataInicio, hora, DataFim: String;
  dataI, DataF: TDate;
  function DuasDatas(Edt: TMaskEdit): boolean;
  begin
    if Length(Trim(Edt.Text)) < 8 then
      result := false
    else
      result := true;
  end;

begin
  if key = #13 then
  begin
    DataInicio := Edt_DataInicio.Text;
    DataFim := Edt_DataFim.Text;

    if Length(Trim(Edt_DataInicio.Text)) > 8 then
      dataI := StrToDate(DataInicio);

    if Length(Trim(Edt_DataFim.Text)) > 8 then
      dataF := StrToDate(DataFim);

    if (key = #13) and not (DuasDatas(Edt_DataInicio)) then
    begin
      QryPesquisa.Filtered := false;
      QryPesquisa.Filter := 'Mov_data < '+ QuotedStr(DateToStr(dataF))+' ' ;
      QryPesquisa.Filtered := true;
    end
    else
    if (key = #13) and (DuasDatas(Edt_DataInicio)) then
    begin
      QryPesquisa.Filtered := false;
      QryPesquisa.Filter := 'Mov_data between '+QuotedStr(DateToStr(dataI))+ ' AND '+QuotedStr(DateToStr(dataF));
      QryPesquisa.Filtered := true;
    end;
  end;
end;


procedure TFrmPesVenda.Edt_DataInicioKeyPress(Sender: TObject; var Key: Char);
var
  DataInicio,hora,DataFim: String;
  dataI,DataF:TDate;
  function DuasDatas(Edt:TMaskEdit):boolean;
  begin
    if Length(Trim(Edt.Text)) < 8 then
      result := false
    else
      result := true;
  end;

begin
  if key = #13 then
  begin
    DataFim := Edt_DataFim.Text;
    DataInicio := Edt_DataInicio.Text;

    if Length(Trim(Edt_DataInicio.Text)) > 8 then
      dataI := StrToDate(DataInicio);

    if Length(Trim(Edt_DataFim.Text)) > 8 then
      dataF := StrToDate(DataFim);



    if (key = #13) and not (DuasDatas(Edt_DataFim)) then
    begin
      QryPesquisa.Filtered := false;
      QryPesquisa.Filter := 'Mov_data > '+ QuotedStr(DateToStr(dataI))+' ' ;
      QryPesquisa.Filtered := true;
    end
    else
    if (key = #13) and (DuasDatas(Edt_DataFim)) then
    begin
      QryPesquisa.Filtered := false;
      QryPesquisa.Filter := 'Mov_data between '+QuotedStr(DateToStr(dataI))+ ' AND '+QuotedStr(DateToStr(dataF));
      QryPesquisa.Filtered := true;
    end;
  end;

end;

procedure TFrmPesVenda.Edt_NomeKeyPress(Sender: TObject; var Key: Char);
begin
  if (Edt_nome.Text <> '') then
  begin
    QryPesquisa.Filtered := false;
    QryPesquisa.Filter := 'UPPER(CLI_NOME) LIKE ' + QuotedStr('%' + UpperCase(Edt_Nome.Text) + '%');
    QryPesquisa.Filtered := true;
  end;
end;

procedure TFrmPesVenda.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #27 then
    ModalResult := mrCancel;

end;

procedure TFrmPesVenda.FormShow(Sender: TObject);
begin
  carrega;
end;

procedure TFrmPesVenda.GridVendasTitleClick(Column: TColumn);
begin
  if Column.FieldName = 'CLI_NOME' then
    Ordenacao := ' Cli_Nome '
  else if Column.FieldName = 'MOV_DATA' then
    ordenacao := ' MOV_DATA '
  else if Column.FieldName = 'MOV_VALORFINAL' then
    ordenacao := ' MOV_VALORFINAL DESC ';

  ordenacao := ' Order by ' + ordenacao;
  carrega;
  QryPesquisa.First;

end;

procedure TFrmPesVenda.pnlBuscarExit(Sender: TObject);
begin
  pnlBuscar.Visible := false;
end;

procedure TFrmPesVenda.Zerar(Sender: TObject);
begin
  if not Edt_DataFim.Focused then
    Edt_DataInicio.Text := '';
  if not Edt_DataInicio.Focused then
    Edt_DataFim.Text    := '';

  Edt_Codigo.Text     := '';
  Edt_Nome.Text       := '';

end;

end.
