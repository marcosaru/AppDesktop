unit uCadEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  Vcl.ExtDlgs,EmpresaDTO, EmpresaDAO,BairroDTO,BairroDAO;

type
  TFrmCadEmpresa = class(TForm)
    pnlBottom: TPanel;
    pnlHeader: TPanel;
    pnlConteudo: TPanel;
    Edt_Nome: TEdit;
    Edt_CNPJ: TMaskEdit;
    Edt_Endereco: TEdit;
    Edt_Inscricao: TEdit;
    Edt_CodigoMunicipio: TEdit;
    Edt_CodigoBairro: TEdit;
    Edt_Municipio: TEdit;
    Edt_Bairro: TEdit;
    Edt_ProcurarBairro: TButton;
    btnCancelar: TButton;
    BtnConfirmar: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edt_Fantasia: TEdit;
    Label8: TLabel;
    Edt_Data: TMaskEdit;
    Label9: TLabel;
    PictureDialog: TOpenPictureDialog;
    Label10: TLabel;
    Label11: TLabel;
    pnlLogo: TPanel;
    ImgLogo: TImage;
    Label12: TLabel;
    Label7: TLabel;
    Edt_email: TEdit;
    Label13: TLabel;
    procedure ImgLogoClick(Sender: TObject);
    procedure BtnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Edt_CodigoBairroKeyPress(Sender: TObject; var Key: Char);
    procedure Edt_ProcurarBairroClick(Sender: TObject);
  private
    { Private declarations }
    FStatus : integer;
    Empresa: TEmpresaDTO;
    EmpresaDAO: TEmpresaDAO;
    Bairro : TBairroDTO;
    BairroDAO: TBairroDAO;
    LogoStream: TMemoryStream;
    LogoData: TBytes;
    procedure confirmar;
    procedure carregar;
  public
    { Public declarations }
  end;

var
  FrmCadEmpresa: TFrmCadEmpresa;

implementation

{$R *.dfm}
uses uPesBairro;

procedure TFrmCadEmpresa.btnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmCadEmpresa.BtnConfirmarClick(Sender: TObject);
begin
  if Trim(Edt_CodigoMunicipio.Text) <> '' then
    confirmar;
end;

procedure TFrmCadEmpresa.carregar;
begin
  Edt_Nome.Text := Empresa.Nome;
  Edt_CNPJ.EditMask := '';
  Edt_CNPJ.Text := copy(Empresa.CNPJ,1,2)+ '.'+copy(Empresa.CNPJ,3,3)+ '.'+copy(Empresa.CNPJ,6,3)+ '/'+copy(Empresa.CNPJ,9,4)+ '-'+copy(Empresa.CNPJ,13,2);
  Edt_Endereco.Text := Empresa.Endereco;
  Edt_Inscricao.Text := Empresa.Inscricao;
  Edt_CodigoBairro.Text:= Empresa.Bairro.Codigo;
  Edt_Bairro.Text := Empresa.Bairro.Nome;
  Edt_CodigoMunicipio.Text := Empresa.Bairro.Municipio.Codigo;
  Edt_Municipio.Text := Empresa.Bairro.Municipio.Nome;
  Edt_Fantasia.Text := Empresa.Fantasia;
  Edt_Data.Text     := DateToStr(Empresa.Fundacao);
  Edt_Email.Text    := Empresa.Email;
  Label12.Caption := '';
  Empresa.LogoStream.Position := 0;
  ImgLogo.Picture.LoadFromStream(Empresa.LogoStream);

end;

procedure TFrmCadEmpresa.confirmar;
var cnpj,data : String;
begin
  try
    LogoStream := TMemoryStream.Create;

    BairroDAO := TBairroDAO.create;
    Bairro := BairroDAO.Encontrar(Edt_CodigoBairro.Text);

    EmpresaDAO := TEmpresaDAO.create;
    Empresa    := TEmpresaDTO.Create;

    Empresa.Nome := Edt_Nome.Text;
    cnpj := Edt_CNPJ.Text;
    Empresa.CNPJ := cnpj.Replace('.','').Replace('-','').Replace('/','');
    Empresa.Bairro := Bairro;
    Empresa.Municipio := Bairro.Municipio;
    Empresa.Endereco := Edt_Endereco.Text;
    Empresa.Inscricao:= Edt_Inscricao.Text;
    Empresa.Fantasia := Edt_Fantasia.Text;
    Empresa.Fundacao := StrToDate(Edt_Data.Text);
    Empresa.Email    := Edt_email.Text;

    ImgLogo.Picture.SaveToStream(LogoStream);

    LogoStream.Position := 0;
    SetLength(LogoData, LogoStream.Size);
    LogoStream.ReadBuffer(LogoData[0], LogoStream.Size);

    Empresa.Logo := LogoData;
    if FStatus = 0 then
      EmpresaDAO.salvar(Empresa)
    else
      EmpresaDAO.alterar(Empresa);
  finally
    Empresa.Free;
    Bairro.Free;
    EmpresaDAO.Free;
    LogoStream.Free;
  end;

end;

procedure TFrmCadEmpresa.Edt_CodigoBairroKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (key=#13) and (Trim(Edt_CodigoBairro.Text)<> '') then
  begin

     BairroDAO := TBairroDAO.create;
      Bairro := BairroDAO.Encontrar(Edt_CodigoBairro.Text);
      if Assigned(Bairro) then
      begin
        Edt_Bairro.Text:= Bairro.Nome;
        Edt_CodigoMunicipio.Text := Bairro.Municipio.Codigo;
        Edt_Municipio.Text := Bairro.Municipio.Nome;
      end
      else
        ShowMessage('Bairro N�o encontrado, digite outro c�digo ou use a busca.');

  end;

end;

procedure TFrmCadEmpresa.Edt_ProcurarBairroClick(Sender: TObject);
begin
  try
    FrmPesBairro := TFrmPesBairro.Create(self);
    FrmPesBairro.ShowModal;
  finally
    if FrmPesBairro.ModalResult = mrOk then
    begin
      BairroDAO := TBairroDAO.create;
      Bairro := BairroDAO.Encontrar(FrmPesBairro.QryPesquisaBAI_CODIGO.AsString);
      Edt_CodigoMunicipio.Text := Bairro.Municipio.Codigo;
      Edt_Municipio.Text       := Bairro.Municipio.Nome;
      Edt_Bairro.Text          := Bairro.Nome;
      Edt_CodigoBairro.Text    := Bairro.Codigo;
    end;
    FrmPesBairro.Free;
  end;
end;

procedure TFrmCadEmpresa.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #20 then
    btnCancelarClick(self);
end;

procedure TFrmCadEmpresa.FormShow(Sender: TObject);
begin
  try
    EmpresaDAO := TEmpresaDAO.create;
    Empresa    := TEmpresaDTO.Create;

    Empresa := EmpresaDAO.Encontrar('1');
    if Trim(Empresa.Nome) <> '' then
    begin
      carregar;
      FStatus := 2;
    end;
    Edt_Nome.SetFocus;
  finally

  end;
end;

procedure TFrmCadEmpresa.ImgLogoClick(Sender: TObject);
begin
  PictureDialog.Title := 'Selecionar a Imagem PNG';
  PictureDialog.Filter := 'Arquivos de Imagem|*.png';
  Label12.Visible := false;

  if PictureDialog.Execute then
  begin
    ImgLogo.Picture.LoadFromFile(PictureDialog.FileName);
    ImgLogo.Stretch := true;
  end;

end;

end.
