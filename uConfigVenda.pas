unit uConfigVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFrmConfigVenda = class(TForm)
    Edt_ObservacoesVenda: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Edt_ObservacoesPreV: TMemo;
    Label3: TLabel;
    Edt_ObservacoesOrcamento: TMemo;
    btnConfirmar: TButton;
    btnCancelar: TButton;
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    QryCadastro : TFDQuery;
    QryPesquisa : TFDQuery;
    FStatus : integer;
    EmpresaCodigo: String;
    procedure carregar;
  public
    { Public declarations }
    constructor create(AOwner:TComponent;ACodigo:string);
    destructor destroy;
  end;

var
  FrmConfigVenda: TFrmConfigVenda;

implementation

{$R *.dfm}

uses dmConexao;

procedure TFrmConfigVenda.btnConfirmarClick(Sender: TObject);
begin
  try
    QryCadastro := TFDQuery.Create(nil);
    QryCadastro.Connection := fdmConexao.BANCO;

    if fdmConexao.BANCO.InTransaction then
      fdmConexao.BANCO.Rollback;

    fdmConexao.BANCO.StartTransaction;

    QryCadastro.SQL.Clear;
    if FStatus = 0 then
    QryCadastro.SQL.Add('insert into configuracoes ( '+
                        'conf_mov_observacoes_venda,conf_mov_observacoes_prev, '+
                        'conf_mov_observacoes_orcamento,conf_codigo)values ( ' +
                        ':conf_mov_observacoes_venda,:conf_mov_observacoes_prev, '+
                        ':conf_mov_observacoes_orcamento,:conf_codigo)')
    else
    if FStatus = 2 then
      QryCadastro.SQL.Add('update configuracoes set conf_mov_observacoes_venda= '+
                          ':conf_mov_observacoes_venda, conf_mov_observacoes_prev= '+
                          ':conf_mov_observacoes_prev,conf_mov_observacoes_orcamento= '+
                        ':conf_mov_observacoes_orcamento where conf_codigo = '+EmpresaCodigo);

    QryCadastro.Params[0].AsString := Edt_ObservacoesVenda.Text;
    QryCadastro.Params[1].AsString := Edt_ObservacoesPreV.Text;
    QryCadastro.Params[2].AsString := Edt_Observacoesorcamento.Text;
    if FStatus <> 2 then
      QryCadastro.Params[3].AsString := fdmConexao.retornaCodigoMaximo('conf_codigo','configuracoes');

    QryCadastro.ExecSQL;
    fdmConexao.BANCO.Commit;
    ModalResult := mrOk;
  finally
    QryCadastro.Free;
  end;
end;

procedure TFrmConfigVenda.carregar;
begin
  QryPesquisa.sql.Clear;
  QryPesquisa.sql.Add('select * from configuracoes');
  QryPesquisa.open;
end;

constructor TFrmConfigVenda.create(AOwner: TComponent; ACodigo: string);
begin
  inherited create(AOwner);
  QryPesquisa := TFDQuery.Create(nil);
  QryPesquisa.Connection := fdmConexao.BANCO;
  EmpresaCodigo := ACodigo;
end;

destructor TFrmConfigVenda.destroy;
begin
  QryPesquisa.Free;
  inherited;
end;

procedure TFrmConfigVenda.FormShow(Sender: TObject);
begin
    carregar;

    if QryPesquisa.RecordCount > 0 then
    begin
      btnConfirmar.Caption := 'Alterar';
      FStatus := 2;
      Edt_ObservacoesVenda.Text := QryPesquisa.FieldByName('conf_mov_observacoes_venda').AsString;
      Edt_ObservacoesPreV.Text  := QryPesquisa.FieldByName('conf_mov_observacoes_prev').AsString;
      Edt_ObservacoesOrcamento.Text := QryPesquisa.FieldByName('conf_mov_observacoes_orcamento').AsString;
    end;

end;

end.
