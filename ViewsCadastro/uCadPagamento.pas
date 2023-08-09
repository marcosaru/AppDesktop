unit uCadPagamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,PagamentosMovimentoDAO, PagamentosMovimentoDTO,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uCurrencyEditVCL, Vcl.Mask;

type
  TFrmCadRecebimento = class(TForm)
    Edt_Valor: TCurrencyEdit;
    Edt_Codigo: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edt_DataCompra: TMaskEdit;
    Edt_Vcto: TMaskEdit;
    Label4: TLabel;
    Edt_Pagamento: TMaskEdit;
    Label5: TLabel;
    Edt_Obs: TMemo;
    Label6: TLabel;
    btnConfirmar: TButton;
    BtnCancelar: TButton;
    procedure FormShow(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
  private
    { Private declarations }
    Pagamento : TPagamentosMovimentoDTO;
    PagamentoDAO : TPagamentosMovimentoDAO;
  public
    { Public declarations }
  end;

var
  FrmCadRecebimento: TFrmCadRecebimento;

implementation

{$R *.dfm}

uses uPesVencimentos;

procedure TFrmCadRecebimento.BtnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmCadRecebimento.btnConfirmarClick(Sender: TObject);
begin
  if MessageDlg('Confirma o recebimento do valor: '+Pagamento.Valor.ToString,mtConfirmation,[MbYes,MbNo],0) = mrYes then
  begin
    Pagamento.DataPagto := Date;
    PagamentoDAO.Alterar(Pagamento);
    ModalResult := mrOk;
  end
  else
    ModalResult := mrCancel;
end;

procedure TFrmCadRecebimento.FormShow(Sender: TObject);
begin
  Try
    PagamentoDAO := TPagamentosMovimentoDAO.Create;
    Pagamento := PagamentoDAO.Encontrar(FrmPesVencimentos.QryPesquisaCOB_CODIGO.AsInteger);

    if Assigned(Pagamento) then
    begin
      Edt_Codigo.Text := Pagamento.Codigo.ToString;
      Edt_DataCompra.Text  := DateToStr(Pagamento.DataVenda);
      Edt_Vcto.Text := DateToStr(Pagamento.DataVcto);
      Edt_Obs.Text := Pagamento.Observacoes;
      Edt_Valor.Value := Pagamento.Valor;
    end;

  Finally

  End;
end;

end.
