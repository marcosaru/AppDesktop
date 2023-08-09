unit uCadMunicipio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,MunicipioDAO,MunicipioDTO;

type
  TFrmCadMunicipio = class(TForm)
    pnlCadastro: TPanel;
    Panel2: TPanel;
    Edt_Codigo: TEdit;
    Edt_Nome: TEdit;
    btnConfirmar: TButton;
    btnCancelar: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    CbbEstados: TComboBox;
    procedure btnConfirmarClick(Sender: TObject);
    constructor create(AOwner:TComponent);override;
    constructor createWithCodigo(AOwner:TComponent;ACodigo:integer);overload;
    procedure Initialize;
    procedure FormShow(Sender: TObject);
    procedure limpar;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    fStatus:integer;
    MunicipioDAO: TMunicipioDAO;
    MunicipioDTO: TMunicipioDTO;
    procedure confirma;
    procedure controlarStatus;
    procedure carregar;
  public
    { Public declarations }
  end;

var
  FrmCadMunicipio: TFrmCadMunicipio;

implementation
uses uPesMunicipio;

{$R *.dfm}

procedure TFrmCadMunicipio.Initialize;
begin
  MunicipioDAO := TMunicipioDAO.create;
  MunicipioDTO := TMunicipioDTO.Create;
end;
procedure TFrmCadMunicipio.limpar;
begin
  Edt_Nome.Text := '';
end;

procedure TFrmCadMunicipio.btnConfirmarClick(Sender: TObject);
begin
  if Trim(Edt_Nome.Text) = '' then
  begin
    ShowMessage('Por favor insira o nome do Municipio.');
    exit;
  end;

  confirma;
  if FStatus <> 2 then
  begin
    if (MessageDlg('Deseja incluir mais um registro?',mtConfirmation,
    [mbYes,mbNo],0) = mrYes) then
    begin
      limpar;
      Edt_Codigo.Text := IntToStr((MunicipioDAO.EncontrarCodigoMaximo)+1);
    end;
  end;
    ModalResult := mrOk;
end;

procedure TFrmCadMunicipio.carregar;
begin
  MunicipioDTO.CleanupInstance;
  MunicipioDTO          := MunicipioDAO.Encontrar(FrmPesMunicipio.QryPesquisaMUN_CODIGO.AsString);
  Edt_Codigo.Text       := MunicipioDTO.Codigo;
  Edt_Nome.Text         := MunicipioDTO.Nome;
  CbbEstados.ItemIndex  := StrToInt(MunicipioDTO.Estado)-1;
end;

procedure TFrmCadMunicipio.confirma;
begin
  MunicipioDTO.CleanupInstance;
  MunicipioDTO.Codigo := Edt_Codigo.Text;
  MunicipioDTO.Nome   := Edt_Nome.Text;
  MunicipioDTO.Estado := CbbEstados.ItemIndex.ToString;
  if fStatus in [0,1] then
    MunicipioDAO.Salvar(MunicipioDTO)
  else 
  if fStatus = 2 then
    MunicipioDAO.Alterar(MunicipioDTO);
  
end;

procedure TFrmCadMunicipio.controlarStatus;
begin
  btnConfirmar.Enabled := fStatus in [0,1,2];
  pnlCadastro.Enabled  := fStatus in [0,1,2];
end;

constructor TFrmCadMunicipio.create(AOwner: TComponent);
begin
  inherited create(AOwner);
  Initialize;
end;

constructor TFrmCadMunicipio.createWithCodigo(AOwner: TComponent; ACodigo: integer);
begin
  inherited create(AOwner);
  Initialize;
  fStatus := Acodigo;
end;

procedure TFrmCadMunicipio.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    btnCancelar.Click();
end;

procedure TFrmCadMunicipio.FormShow(Sender: TObject);
begin
  if fStatus in [0,1] then
  begin
    limpar;
    Edt_Codigo.Text := IntToStr((MunicipioDAO.EncontrarCodigoMaximo)+1);
  end
  else
  if fStatus in [2,3] then
    Carregar;
  controlarStatus;
end;

end.
