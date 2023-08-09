unit uPesProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TFrmPesProduto = class(TForm)
    pnlMain: TPanel;
    pnlBotoes: TPanel;
    btnCadastrar: TButton;
    btnAlterar: TButton;
    btnApresentar: TButton;
    btnCancelar: TButton;
    DBGrid1: TDBGrid;
    DTS: TDataSource;
    QryPesquisa: TFDQuery;
    QryPesquisaPRO_CODIGO: TIntegerField;
    QryPesquisaPRO_NOME: TStringField;
    QryPesquisaFOR_NOME: TStringField;
    QryPesquisaPRO_CUSTO: TIntegerField;
    QryPesquisaPRO_VALORVENDA: TIntegerField;
    QryPesquisaPRO_DESCRICAO: TBlobField;
    QryPesquisaPRO_MEDIDAS: TStringField;
    QryPesquisaPRO_TECIDO: TStringField;
    QryPesquisaPRO_MADEIRA: TStringField;
    btnBuscar: TButton;
    pnlBuscar: TPanel;
    Edt_Nome: TEdit;
    Edt_Codigo: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    QryPesquisaCAT_DESCRICAO: TStringField;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnCadastrarClick(Sender: TObject);
    procedure AbrirCadastro(ACodigo:integer);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnApresentarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure Edt_CodigoKeyPress(Sender: TObject; var Key: Char);
    procedure Edt_NomeKeyPress(Sender: TObject; var Key: Char);
    procedure btnBuscarClick(Sender: TObject);
    procedure pnlBuscarExit(Sender: TObject);
    procedure Edt_NomeEnter(Sender: TObject);
    procedure Edt_CodigoEnter(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    ordenacao: String;
    ordem:Boolean;
    procedure carregar(FOrdenacao:String = '');
  public
    { Public declarations }
  end;

var
  FrmPesProduto: TFrmPesProduto;

implementation

{$R *.dfm}

uses dmConexao, uCadProduto;

procedure TFrmPesProduto.AbrirCadastro(ACodigo: integer);
begin
  try
    FrmCadProduto := TFrmCadProduto.Create(Self,ACodigo);
    FrmCadProduto.ShowModal;
  finally
    FrmCadProduto.free;
  end;
end;

procedure TFrmPesProduto.btnAlterarClick(Sender: TObject);
begin
  AbrirCadastro(2);
  Carregar;
end;

procedure TFrmPesProduto.btnApresentarClick(Sender: TObject);
begin
  AbrirCadastro(3);
end;

procedure TFrmPesProduto.btnBuscarClick(Sender: TObject);
begin
  pnlBuscar.Visible := true;
  Edt_Codigo.SetFocus;
  Edt_Nome.Text := '';
  Edt_Codigo.Text := '';
end;

procedure TFrmPesProduto.btnCadastrarClick(Sender: TObject);
begin
  AbrirCadastro(1);
  Carregar;
end;

procedure TFrmPesProduto.btnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmPesProduto.carregar(FOrdenacao:String = '');
begin
  QryPesquisa.SQL.Clear;
  QryPesquisa.Sql.add('select pro_codigo,pro_nome,for_nome,    '+
                      'pro_custo,pro_valorvenda,pro_descricao, '+
                      'pro_medidas,pro_tecido,pro_madeira,cat_descricao'+
                      ' from produto                           '+
                      'join fornecedor on for_codigo = pro_fornecedor '+
                      'join categoria on cat_codigo = pro_categoria ');
  if Trim(FOrdenacao) <> '' then
    QryPesquisa.SQL.Add(FOrdenacao);

  QryPesquisa.Open;
end;

procedure TFrmPesProduto.DBGrid1DblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFrmPesProduto.DBGrid1TitleClick(Column: TColumn);
begin
  if Column.FieldName = 'PRO_NOME' then
  begin
    ordenacao := 'PRO_NOME ';
    if ordem then
    begin
      ordenacao := ordenacao + 'DESC';
      ordem := false;
    end
    else
    begin
      ordenacao := ordenacao + 'ASC';
      ordem := true;
    end;
  end
  else
  if Column.FieldName = 'PRO_MADEIRA' then
  begin
    ordenacao := 'PRO_MADEIRA ';
    if ordem then
    begin
      ordenacao := ordenacao + 'DESC';
      ordem := false;
    end
    else
    begin
      ordenacao := ordenacao + 'ASC';
      ordem := true;
    end;
  end
  else
  if Column.FieldName = 'PRO_TECIDO' then
  begin
    ordenacao := 'PRO_TECIDO ';
    if ordem then
    begin
      ordenacao := ordenacao + 'DESC';
      ordem := false;
    end
    else
    begin
      ordenacao := ordenacao + 'ASC';
      ordem := true;
    end;
  end
  ELSE
  if Column.FieldName = 'PRO_MADEIRA' then
  begin
    ordenacao := 'PRO_MADEIRA ';
    if ordem then
    begin
      ordenacao := ordenacao + 'DESC';
      ordem := false;
    end
    else
    begin
      ordenacao := ordenacao + 'ASC';
      ordem := true;
    end;
  end
  else
  if Column.FieldName = 'PRO_VALORVENDA' then
  begin
    ordenacao := 'PRO_VALORVENDA ';
    if ordem then
    begin
      ordenacao := ordenacao + 'DESC';
      ordem := false;
    end
    else
    begin
      ordenacao := ordenacao + 'ASC';
      ordem := true;
    end;
  end
  else
  if Column.FieldName = 'CAT_DESCRICAO' then
  begin
    ordenacao := 'CAT_DESCRICAO ';
    if ordem then
    begin
      ordenacao := ordenacao + 'DESC';
      ordem := false;
    end
    else
    begin
      ordenacao := ordenacao + 'ASC';
      ordem := true;
    end;
  end
  else
    Exit;

  ordenacao := 'ORDER BY ' + ordenacao;

  carregar(ordenacao);
end;

procedure TFrmPesProduto.Edt_CodigoEnter(Sender: TObject);
begin
  Edt_Nome.Text := '';
  Edt_Codigo.Text := '';
end;

procedure TFrmPesProduto.Edt_CodigoKeyPress(Sender: TObject; var Key: Char);
begin
  if (key = #13) and (Edt_Codigo.Text <> '') then
    QryPesquisa.Locate('PRO_CODIGO',Edt_Codigo.Text,[loPartialKey,loCaseInsensitive]);
end;

procedure TFrmPesProduto.Edt_NomeEnter(Sender: TObject);
begin
  Edt_Nome.Text := '';
  Edt_Codigo.Text := '';
end;

procedure TFrmPesProduto.Edt_NomeKeyPress(Sender: TObject; var Key: Char);
begin
  if (key = #13) and (Edt_Nome.Text <> '') then
    QryPesquisa.Locate('PRO_Nome',Edt_Nome.Text,[loPartialKey,loCaseInsensitive]);
end;

procedure TFrmPesProduto.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #27 then
    ModalResult := mrCancel;

end;

procedure TFrmPesProduto.FormShow(Sender: TObject);
begin
  carregar;
  ordem := false;
end;

procedure TFrmPesProduto.pnlBuscarExit(Sender: TObject);
begin
  pnlBuscar.Visible := false;
end;

end.
