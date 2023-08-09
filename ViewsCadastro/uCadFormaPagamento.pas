unit uCadFormaPagamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, FormaPagtoDTO,FormaPagtoDAO,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrmCadFormaPagamento = class(TForm)
    pnlCadastro: TPanel;
    pnlBotoes: TPanel;
    Edt_Codigo: TEdit;
    Edt_Descricao: TEdit;
    btnConfirmar: TButton;
    btnCancelar: TButton;
    Label1: TLabel;
    Label2: TLabel;
    chkAvista: TCheckBox;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FStatus       : Integer;
    FormaPagto    : TFormaPagtoDTO;
    FormaPagtoDAO : TFormaPagtoDAO;
    procedure Limpar;
    procedure confirma;
    procedure controlaStatus;
    procedure Carregar;
  public
    { Public declarations }
    constructor create(AOwner:TComponent;AStatus:integer);overload;
  end;

var
  FrmCadFormaPagamento: TFrmCadFormaPagamento;

implementation

{$R *.dfm}

uses dmConexao, uPesFormPagto;

procedure TFrmCadFormaPagamento.btnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmCadFormaPagamento.btnConfirmarClick(Sender: TObject);
begin
  confirma;
end;

procedure TFrmCadFormaPagamento.Carregar;
begin
  try
    FormaPagtoDAO := TFormaPagtoDAO.create;
    FormaPagto    := FormaPagtoDAO.Encontrar(FrmPesFormaPagamento.QryPesquisaFORPAGTO_CODIGO.AsString);

    Edt_Codigo.Text    := FormaPagto.Codigo;
    Edt_Descricao.Text := FormaPagto.Descricao;
    chkAvista.Checked := FormaPagto.Avista = 1;
  finally
    FormaPagto.Free;
    FormaPagtoDAO.Free;
  end;
end;

procedure TFrmCadFormaPagamento.confirma;
begin
  try
    FormaPagtoDAO := TFormaPagtoDAO.create;
    FormaPagto := TFormaPagtoDTO.Create;

    FormaPagto.Codigo := Edt_Codigo.Text;
    FormaPagto.Descricao := Edt_Descricao.Text;

    if chkAvista.Checked then
      FormaPagto.Avista := 1
    else
      FormaPagto.Avista := 2;

    if FStatus in [0,1] then
      FormaPagtoDAO.salvar(FormaPagto)
    else
    begin
      FormaPagtoDAO.Alterar(FormaPagto);
      ModalResult := mrOk;
    end;
     if MessageDlg('Deseja adicionar outro registro?',mtConfirmation,[MbYes,MbNo],0) = MrYes then
     begin
       Limpar;
       Edt_Codigo.Text := fdmConexao.retornaCodigoMaximo('ForPagto_Codigo','FormaPagto');
     end
     else
     ModalResult := mrOk;
  finally
    FormaPagtoDAO.Free;
    FormaPagto.Free;
  end;
end;

procedure TFrmCadFormaPagamento.controlaStatus;
begin
  btnConfirmar.Enabled := FStatus <> 3;
end;

constructor TFrmCadFormaPagamento.create(AOwner: TComponent; AStatus: integer);
begin
  inherited create(AOwner);
  FStatus := AStatus;
end;

procedure TFrmCadFormaPagamento.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_Escape then
    btnCancelarClick(nil);
end;

procedure TFrmCadFormaPagamento.FormShow(Sender: TObject);
begin
  if FStatus = 1 then
  begin
    Limpar;
    Edt_Codigo.Text := fdmConexao.retornaCodigoMaximo('ForPagto_Codigo','FormaPagto');
  end
  else
  if FStatus = 2 then
    Carregar
  else
  if FStatus = 3 then
  begin
    Carregar;
    pnlCadastro.Enabled := false;
  end;

  controlaStatus;
end;

procedure TFrmCadFormaPagamento.Limpar;
begin
  Edt_Codigo.Text := '';
  Edt_Descricao.Text := '';
end;

end.
