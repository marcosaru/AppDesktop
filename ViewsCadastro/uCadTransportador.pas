unit uCadTransportador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, TransportadorDAO,TransportadorDTO,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  BairroDTO,BairroDAO,MunicipioDAO,MunicipioDTO;

type
  TFrmCadTransportador = class(TForm)
    pnlCadastro: TPanel;
    PnlBotoes: TPanel;
    Edt_Codigo: TEdit;
    Edt_Municipio: TEdit;
    btnConfirmar: TButton;
    btnCancelar: TButton;
    Label2: TLabel;
    Label1: TLabel;
    Edt_CodigoMunicipio: TEdit;
    btnProcurarMunicipio: TButton;
    Label3: TLabel;
    Edt_Nome: TEdit;
    Edt_Telefone: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Edt_Endereco: TEdit;
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnProcurarMunicipioClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edt_CodigoMunicipioKeyPress(Sender: TObject; var Key: Char);

  private
    FStatus : integer;
    MunicipioDAO : TMunicipioDAO;
    Municipio : TMunicipioDTO;
    Transportador : TTransportadorDTO;
    TransportadorDAO: TTransportadorDAO;
    procedure confirma;
    procedure carregar;
    procedure limpar;
    procedure mudaStatus;
    Procedure Instanciar;
  public
    constructor Create(AOwned:TComponent;FCodigo:Integer); overload;
    constructor Create(AOwned:TComponent);overload;
    destructor destroy;overload;

  end;

var
  FrmCadTransportador: TFrmCadTransportador;

implementation

{$R *.dfm}
uses uPesBairro, dmConexao, uPesMunicipio, uPesTransportador;

procedure TFrmCadTransportador.btnConfirmarClick(Sender: TObject);
begin
  if Edt_Nome.Text = '' then
  begin
    ShowMessage('� Obrigat�rio informar um nome');
    exit;
  end;
  if Trim(Edt_CodigoMunicipio.Text) = '' then
   begin
    ShowMessage('� Obrigat�rio informar um Municipio');
    exit;
  end;

  confirma;
  if FStatus <> 2 then
  if MessageDlg('Deseja incluir mais um registro?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    limpar;

  end
  else
    ModalResult := mrOk
  else
    ModalResult := mrOk;

end;

procedure TFrmCadTransportador.btnProcurarMunicipioClick(Sender: TObject);
begin
  try
    FrmPesMunicipio := TFrmPesMunicipio.Create(self);
    FrmPesMunicipio.ShowModal;
  finally
    if FrmPesMunicipio.ModalResult = mrOk then
    begin
      Edt_Municipio.Text       := FrmPesMunicipio.QryPesquisaMUN_NOME.AsString;
      Edt_CodigoMunicipio.Text := FrmPesMunicipio.QryPesquisaMUN_CODIGO.AsString;
    end;
  end;
end;

procedure TFrmCadTransportador.carregar;
begin
  Try
    Transportador := TransportadorDAO.Encontrar(FrmPesTransportador.QryPesquisaTRANS_CODIGO.AsString);
    if Assigned(Transportador) then
    begin
      Edt_Codigo.Text := Transportador.Codigo;
      Edt_Nome.Text   := Transportador.Nome;
      Edt_Telefone.Text:= Transportador.Telefone;
      Edt_Endereco.Text := Transportador.Endereco;
      Edt_Municipio.Text := Transportador.Municipio.Nome;
      Edt_CodigoMunicipio.Text := Transportador.Municipio.Codigo;
    end;
  Finally

  End;
end;

procedure TFrmCadTransportador.confirma;
begin
  try
    Transportador := TTransportadorDTO.Create;
    TransportadorDAO := TTransportadorDAO.create;

    Transportador.Municipio := MunicipioDAO.Encontrar(Edt_CodigoMunicipio.Text);
    Transportador.Nome      := Edt_Nome.Text;
    Transportador.Telefone  := Edt_Telefone.Text;
    Transportador.Endereco  := Edt_Endereco.Text;
    Transportador.Codigo    := Edt_Codigo.Text;

    if FStatus in [0,1] then
      TransportadorDAO.salvar(Transportador)
    else
    if FStatus = 2 then
      TransportadorDAO.alterar(Transportador);
  finally
    Transportador.Free;
    TransportadorDAO.Free;
  end;
end;

procedure TFrmCadTransportador.Instanciar;
begin
  MunicipioDAO := TMunicipioDAO.Create;
  Municipio := TMunicipioDTO.Create;
  TransportadorDAO := TTransportadorDAO.create;
  Transportador := TTransportadorDTO.Create;
end;

constructor TFrmCadTransportador.Create(AOwned: TComponent);
begin
  inherited create(AOwned);
  Instanciar;
end;

constructor TFrmCadTransportador.Create(AOwned: TComponent; FCodigo: Integer);
begin
  inherited create(AOwned);
  FStatus := FCodigo;
  Instanciar;
end;

destructor TFrmCadTransportador.destroy;
begin
  MunicipioDAO.Free;
  Municipio.Free;
  FreeAndNil(TransportadorDAO);
  FreeAndNil(Transportador);
  inherited;
end;

procedure TFrmCadTransportador.Edt_CodigoMunicipioKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then
  begin
    Municipio := MunicipioDAO.Encontrar(Edt_CodigoMunicipio.Text);

    if Assigned(Municipio) then
    begin
      Edt_Municipio.Text := Municipio.Nome;
    end
    else
      ShowMessage('N�o foi encontrado Municipio com este c�digo, Use a busca ou altere o c�digo.');
  end;
end;

procedure TFrmCadTransportador.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    btnCancelar.Click();
end;

procedure TFrmCadTransportador.FormShow(Sender: TObject);
begin
  if FStatus = 1 then
  begin
    limpar;
    Edt_Codigo.Text := fdmConexao.retornaCodigoMaximo('TRANS_Codigo','transportador');
  end
  else
  if FStatus in [2,3] then
    carregar;

  mudaStatus;

end;



procedure TFrmCadTransportador.limpar;
begin
  Edt_Municipio.Text := '';
  Edt_CodigoMunicipio.Text := '';
  Edt_Nome.Text := '';
  Edt_Telefone.Text := '';
  Edt_Codigo.Text := '';
  Edt_Endereco.Text := '';
end;

procedure TFrmCadTransportador.mudaStatus;
begin
  pnlCadastro.Enabled  := FStatus <> 3;
  btnConfirmar.Enabled := FStatus <> 3;
end;

end.
