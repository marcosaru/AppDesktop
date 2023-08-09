unit uPesCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, frxClass, frxDBSet;

type
  TFrmPesCliente = class(TForm)
    pnlMain: TPanel;
    pnlBotoes: TPanel;
    btnCadastrar: TButton;
    btnAlterar: TButton;
    btnApresentar: TButton;
    btnCancelar: TButton;
    DBGrid1: TDBGrid;
    DtsClientes: TDataSource;
    QryPesquisa: TFDQuery;
    QryPesquisaCLI_NOME: TStringField;
    QryPesquisaCLI_ENDERECO: TStringField;
    QryPesquisaCLI_CODIGO: TIntegerField;
    QryPesquisaCLI_CNPJCPF: TStringField;
    QryPesquisaCPF: TStringField;
    QryPesquisaBAI_NOME: TStringField;
    QryPesquisaMUN_NOME: TStringField;
    QryPesquisaCONTATOS: TMemoField;
    QryPesquisaConts: TStringField;
    relDSClientes: TfrxDBDataset;
    relClientes: TfrxReport;
    btnImprimir: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnCadastrarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure QryPesquisaCalcFields(DataSet: TDataSet);
    procedure btnApresentarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
  private
    { Private declarations }
    ordenacao : String;
    procedure carrega;
    procedure controlaStatus;
    procedure AbrirCadastro(AStatus:integer);
  public
    { Public declarations }
    FStatus : integer;
    constructor create(AOwner:TComponent;AStatus:integer);overload;
  end;

var
  FrmPesCliente: TFrmPesCliente;

implementation

{$R *.dfm}

uses dmConexao, uCadCliente;

procedure TFrmPesCliente.AbrirCadastro(AStatus: integer);
begin
  Try
    FrmCadCliente := TFrmCadCliente.Create(self,AStatus);
    FrmCadCliente.ShowModal;
  finally
    if FrmCadCliente.ModalResult = mrOk then
      carrega;

    controlaStatus;
    FrmCadCliente.Free;
  end;
end;

procedure TFrmPesCliente.btnApresentarClick(Sender: TObject);
begin
  AbrirCadastro(3);
end;

procedure TFrmPesCliente.btnCadastrarClick(Sender: TObject);
begin
  AbrirCadastro(1);
  carrega;
end;

procedure TFrmPesCliente.btnImprimirClick(Sender: TObject);
begin
  relDSClientes.Open;
  relClientes.ShowReport();
end;

procedure TFrmPesCliente.btnAlterarClick(Sender: TObject);
begin
  AbrirCadastro(2);
  carrega;
end;

procedure TFrmPesCliente.carrega;
begin

  QryPesquisa.SQL.Clear;
  QryPesquisa.SQL.Add('SELECT '+
                      '  c.cli_codigo, '+
                      '  c.cli_nome,   '+
                      '  c.cli_cnpjcpf, '+
                      '  LIST(CASE WHEN co.cto_valor IS NULL THEN '''' ELSE co.cto_valor END, '','') AS contatos, '+
                      '  b.bai_nome,   '+
                      '  m.mun_nome,   '+
                      '  c.cli_endereco '+
                      'FROM            '+
                      '  cliente c     '+
                      '  JOIN municipio m ON m.mun_codigo = c.cli_municipio '+
                      '  JOIN bairro b ON b.bai_codigo = c.cli_bairro       '+
                      '  LEFT JOIN contato co ON co.cto_cliente = c.cli_codigo AND co.cto_tipo IN (1, 3) '+
                      'GROUP BY        '+
                      '  c.cli_codigo,  '+
                      '  c.cli_nome,    '+
                      '  c.cli_cnpjcpf,   '+
                      '  b.bai_nome,      '+
                      '  m.mun_nome,      '+
                      '  c.cli_endereco');

  if ordenacao <> '' then
    QryPesquisa.SQL.Add(ordenacao);
  QryPesquisa.Open;

end;

procedure TFrmPesCliente.controlaStatus;
begin
  btnAlterar.Enabled := QryPesquisa.RecordCount > 0;
  btnApresentar.Enabled := QryPesquisa.RecordCount > 0;
end;

constructor TFrmPesCliente.create(AOwner: TComponent; AStatus: integer);
begin
  inherited create(AOwner);
  FStatus := AStatus;
end;

procedure TFrmPesCliente.DBGrid1DblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFrmPesCliente.DBGrid1TitleClick(Column: TColumn);
begin
  if Column.FieldName = 'CLI_NOME' then
    ordenacao := ' Order By CLI_NOME'
  else
    exit;
  carrega;
end;

procedure TFrmPesCliente.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    btnCancelar.Click();
end;

procedure TFrmPesCliente.FormShow(Sender: TObject);
begin
  carrega;
  controlaStatus;
end;

procedure TFrmPesCliente.QryPesquisaCalcFields(DataSet: TDataSet);
var
  MemoStream: TStringStream;
  ContatosText: string;
begin
 MemoStream := TStringStream.Create('');

  if Length(QryPesquisaCLI_CNPJCPF.AsString) = 11 then
  begin
    QryPesquisaCPF.AsString := copy(QryPesquisaCLI_CNPJCPF.AsString,1,3)+ '-'+
    copy(QryPesquisaCLI_CNPJCPF.AsString,4,3)+'-'+
    copy(QryPesquisaCLI_CNPJCPF.AsString,7,3)+'.'+
    copy(QryPesquisaCLI_CNPJCPF.AsString,10,2);
  end;

  try
    if not QryPesquisa.IsEmpty then
    begin
      TBlobField(QryPesquisa.FieldByName('contatos')).SaveToStream(MemoStream);
      MemoStream.Position := 0;
      ContatosText := MemoStream.ReadString(MemoStream.Size);
      QryPesquisaConts.AsString := ContatosText+ '  ';
    end;
  finally
    MemoStream.Free;
  end;

end;

end.
