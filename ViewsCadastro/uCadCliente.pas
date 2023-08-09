unit uCadCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,
  Vcl.ComCtrls,ClienteDAO,ClienteDTO, uCurrencyEditVCL, Vcl.CheckLst,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient,BairroDTO,BairroDAO,MidasLib;

type
  TFrmCadCliente = class(TForm)
    pnlBotoes: TPanel;
    Panel1: TPanel;
    btnConfirma: TButton;
    btnCancelar: TButton;
    PageControl1: TPageControl;
    Fisica: TTabSheet;
    Juridica: TTabSheet;
    Edt_Codigo: TEdit;
    Edt_Nome: TEdit;
    Edt_Bairro: TEdit;
    Edt_Municipio: TEdit;
    Edt_Endereco: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    CbbEstadoCivil: TComboBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Edt_DataNascimento: TMaskEdit;
    LabelOcupacao: TLabel;
    Label15: TLabel;
    Edt_CodigoBairro: TEdit;
    Edt_CodigoMunicipio: TEdit;
    btnProcurarBairro: TButton;
    btnProcurarMunicipio: TButton;
    Edt_Cpf: TMaskEdit;
    ChkFuncionarioPublico: TCheckBox;
    ChkPrivada: TCheckBox;
    ChkAutonomo: TCheckBox;
    ChkEstudante: TCheckBox;
    Edt_Contato: TEdit;
    Contato: TClientDataSet;
    GridContatos: TDBGrid;
    Inserir: TButton;
    DS: TDataSource;
    ContatoTipo: TStringField;
    Panel2: TPanel;
    btnTipoContato: TRadioGroup;
    Deletar: TButton;
    ContatoRegistro: TStringField;
    ContatoType: TIntegerField;
    pnlCadastro: TPanel;
    pnlEmprego: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Edt_NomeDaEmpresa: TEdit;
    Edt_LocalDoTrabalho: TEdit;
    Edt_DataAdmissao: TMaskEdit;
    Edt_Cargo: TEdit;
    Edt_Telefone: TEdit;
    Edt_Salario: TCurrencyEdit;
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnProcurarBairroClick(Sender: TObject);
    constructor create(AOwner:TComponent;AStatus:Integer);overload;
    destructor destroy;
    procedure FormShow(Sender: TObject);
    procedure btnProcurarMunicipioClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edt_CpfEnter(Sender: TObject);
    procedure ChkPrivadaClick(Sender: TObject);
    procedure InserirClick(Sender: TObject);
    procedure controlarStatusDosContatos;
    procedure DeletarClick(Sender: TObject);
    procedure Edt_CodigoBairroKeyPress(Sender: TObject; var Key: Char);
    procedure Edt_CodigoMunicipioKeyPress(Sender: TObject; var Key: Char);
    procedure Edt_DataNascimentoEnter(Sender: TObject);
  private
    { Private declarations }
    FStatus : integer;
    ClienteDAO: TClienteDAO;
    Cliente: TClienteDTO;
    BairroDTO: TBairroDTO;
    BairroDAO: TBairroDAO;
    procedure confirma;
    procedure limpar;
    procedure carregar;
    procedure controlarStatus;
    function PossuiVinculoTrabalhista:boolean;
  public
    { Public declarations }
  end;

var
  FrmCadCliente: TFrmCadCliente;

implementation

{$R *.dfm}

uses uPesBairro, uPesCliente, uPesMunicipio,MunicipioDTO,MunicipioDAO,
  dmConexao;

procedure TFrmCadCliente.btnProcurarBairroClick(Sender: TObject);
begin
  try
    FrmPesBairro := TFrmPesBairro.Create(Self);
    FrmPesBairro.ShowModal;
  finally
    if FrmPesBairro.ModalResult = mrOk then
    begin
      Edt_Bairro.Text          := FrmPesBairro.QryPesquisaBAI_NOME.AsString;
      Edt_CodigoBairro.Text    := FrmPesBairro.QryPesquisaBAI_CODIGO.AsString;
      Edt_CodigoMunicipio.Text := FrmPesBairro.QryPesquisaMUN_CODIGO.AsString;
      Edt_Municipio.Text       := FrmPesBairro.QryPesquisaMUN_Nome.AsString;
    end;
    FrmPesBairro.Free;
  end;
end;

procedure TFrmCadCliente.btnProcurarMunicipioClick(Sender: TObject);
begin
  try
    FrmPesMunicipio := TFrmPesMunicipio.Create(Self);
    FrmPesMunicipio.ShowModal;
  finally
    if FrmPesMunicipio.ModalResult = mrOk then
    begin
      Edt_CodigoMunicipio.Text := FrmPesMunicipio.QryPesquisaMUN_CODIGO.AsString;
      Edt_Municipio.Text       := FrmPesMunicipio.QryPesquisaMUN_NOME.AsString;
      Edt_Bairro.Text          := '';
      Edt_CodigoBairro.Text    := '';
    end;
    FrmPesMunicipio.Free;
  end;
end;

procedure TFrmCadCliente.btnConfirmaClick(Sender: TObject);
var
  cto:integer;
begin
  Contato.First;
  cto := 0;
  while not Contato.Eof do
  begin
    if ContatoType.AsInteger = 1 then
      inc(cto);
    Contato.Next;
  end;

  if cto = 0 then
  begin
    ShowMessage('� necessario informar o celular para os relat�rios.');
    exit;
  end;
  confirma;
end;

procedure TFrmCadCliente.btnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmCadCliente.carregar;
var
  ContatoCliente:TContato;
begin
  try
    Cliente := TClienteDTO.create;
    ClienteDAO := TClienteDAO.create;
    Cliente := ClienteDAO.encontrarCliente(FrmPesCliente.QryPesquisaCLI_CODIGO.AsString);

    Edt_Codigo.Text          := Cliente.Codigo;
    Edt_Nome.Text            := Cliente.Nome;
    Edt_Municipio.Text       := Cliente.Municipio.Nome;
    Edt_CodigoMunicipio.Text := Cliente.Municipio.Codigo;
    Edt_CodigoBairro.Text    := Cliente.Bairro.Codigo;
    Edt_Bairro.Text          := Cliente.Bairro.Nome;
    Edt_Endereco.Text        := Cliente.Endereco;
    Edt_Cpf.EditMask         := '';
    Edt_Cpf.Text             := copy(Cliente.CpfOuCnpj,1,3)+'.'+copy(Cliente.CpfOuCnpj,4,3)+'.'+copy(Cliente.CpfOuCnpj,7,3)+'-'+copy(Cliente.CpfOuCnpj,9,2);
    Edt_DataNascimento.Text  := DateToStr(Cliente.Nascimento);
    if PossuiVinculoTrabalhista then
    begin
      Edt_NomeDaEmpresa.Text   := Cliente.Empresa;
      Edt_LocalDoTrabalho.Text := Cliente.EmpresaEndereco;
      Edt_Salario.Value        := Cliente.Salario;
      Edt_DataAdmissao.Text    := DateToStr(Cliente.DataAdmissao);
    end;

    for ContatoCliente in Cliente.Contatos do
    begin
      contato.Append;
      if ContatoCliente.FTipo = '1' then
        ContatoTipo.AsString := 'Celular'
      else
      if ContatoCliente.FTipo = '2' then
        ContatoTipo.AsString := 'Email'
      else
        ContatoTipo.AsString := 'Telefone';

      ContatoType.AsString   := ContatoCliente.FTipo;
      ContatoRegistro.AsString := ContatoCliente.FValor;
      contato.post;
    end;
  finally
    Cliente.Free;
    ClienteDAO.Free;
  end;
end;

procedure TFrmCadCliente.ChkPrivadaClick(Sender: TObject);
begin
  PossuiVinculoTrabalhista;
end;

procedure TFrmCadCliente.confirma;
begin
  if Trim(Edt_Nome.Text) = '' then
  begin
    MessageDlg('Por favor digite um nome.',mtInformation,[mbOk],0);
    exit;
  end;


  try
    ClienteDAO := TClienteDAO.Create;
    Cliente := TClienteDTO.Create;
    BairroDTO := TBairroDTO.Create;
    BairroDAO := TBairroDAO.create;

    BairroDTO := BairroDAO.Encontrar(Edt_CodigoBairro.Text);

    Cliente.Nome            := Edt_Nome.Text;
    Cliente.Codigo          := Edt_Codigo.Text;
    Cliente.Municipio       := BairroDTO.Municipio;
    Cliente.Bairro          := BairroDTO;
    Cliente.Endereco        := Edt_Endereco.Text;
    Cliente.CpfOuCnpj       := Edt_Cpf.Text;
    Cliente.EstadoCivil     := CbbEstadoCivil.ItemIndex.ToString;
    Cliente.Nascimento      := StrToDate(Edt_DataNascimento.Text);


    if PossuiVinculoTrabalhista then
    begin
      Cliente.Empresa         := Edt_NomeDaEmpresa.Text;
      Cliente.EmpresaEndereco := Edt_LocalDoTrabalho.Text;
      Cliente.Salario         := Edt_Salario.value;
      Cliente.Funcao          := Edt_Cargo.Text;
      Cliente.EmpresaContato  := Edt_telefone.Text;
      Cliente.DataAdmissao    := StrToDate(Edt_DataAdmissao.Text);
    end
    else
    begin
      Cliente.Empresa         := '';
      Cliente.EmpresaEndereco := '';
      Cliente.Salario         := 00;
      Cliente.Funcao          := '';
      Cliente.EmpresaContato  := '';
      Cliente.DataAdmissao    := StrToDate('01/01/1000');
    end;

    Contato.First;
    while not Contato.EoF do
    begin
      var
        novoContato: TContato;
      novoContato.FTipo := Contato.FieldByName('Type').AsString;
      novoContato.FValor := Contato.FieldByName('Registro').AsString;
      Cliente.Contatos.Add(novoContato);
      Contato.Next;
    end;

    if FStatus = 1 then
      ClienteDAO.salvar(Cliente)
    else
      ClienteDAO.alterar(Cliente);

    ModalResult := mrOk;

  finally
    if Assigned(ClienteDAO) then
      ClienteDAO.Free;
    if Assigned(Cliente) then
      Cliente.Free;
    if Assigned(BairroDTO) then
      BairroDTO.Free;
    if Assigned(BairroDAO) then
      BairroDAO.Free;
  end;
end;

function TFrmCadCliente.PossuiVinculoTrabalhista:boolean;
begin
  if ChkPrivada.Checked or ChkAutonomo.Checked or ChkFuncionarioPublico.Checked then
  begin
    pnlEmprego.Visible := true;
    FrmCadCliente.Height := 440;
    result := true;
    if ChkPrivada.Checked then
    begin
      ChkAutonomo.Enabled := false;
      ChkFuncionarioPublico.Enabled := false;
    end
    else
    if ChkAutonomo.Checked then
    begin
       ChkFuncionarioPublico.Enabled := false;
       ChkPrivada.Enabled := false;
    end
    else
    if ChkFuncionarioPublico.Checked then
    begin
       ChkPrivada.Enabled := false;
       ChkAutonomo.Enabled := false;
    end;
  end
  else
  begin
    pnlEmprego.Visible := false;
    FrmCadCliente.Height := 260;
    result := false;
  end;
  if not ChkPrivada.Checked and not ChkAutonomo.Checked and not ChkFuncionarioPublico.Checked then
  begin
    ChkAutonomo.Enabled := true;
    ChkPrivada.Enabled := true;
    ChkFuncionarioPublico.Enabled := true;
  end;

end;

procedure TFrmCadCliente.controlarStatus;
begin
  btnConfirma.Enabled := FStatus in [1,2];
  Deletar.Enabled := Contato.RecordCount > 0;
  pnlCadastro.Enabled := FStatus <> 3;
end;

procedure TFrmCadCliente.controlarStatusDosContatos;
begin
  Deletar.Enabled := contato.RecordCount > 0;
end;

constructor TFrmCadCliente.create(AOwner: TComponent; AStatus: Integer);
begin
  inherited create(AOwner);
  FStatus    := AStatus;

  Contato.CreateDataSet;
end;

procedure TFrmCadCliente.DeletarClick(Sender: TObject);
begin
  if MessageDlg('Deseja excluir este contato?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    Contato.Delete;
  end;
  controlarStatusDosContatos;
end;

destructor TFrmCadCliente.destroy;
begin
   Cliente.free;
   ClienteDAO.Free;
   Contato.Close;
   inherited;
end;

procedure TFrmCadCliente.Edt_CodigoBairroKeyPress(Sender: TObject;
  var Key: Char);
var
  BairroDTO: TBairroDTO;
  BairroDAO: TBairroDAO;
begin
  if key = #13 then
  begin
    try
      BairroDTO := TBairroDTO.Create;
      BairroDAO := TBairroDAO.create;
      BairroDTO := BairroDAO.Encontrar(Edt_CodigoBairro.Text);
      if Assigned(BairroDTO) then
      begin
        Edt_Bairro.Text          := BairroDTO.Nome;
        Edt_CodigoMunicipio.Text := BairroDTO.Municipio.Codigo;
        Edt_Municipio.Text       := BairroDTO.Municipio.Nome;
      end
      else
       ShowMessage('N�o foi possivel encontrar o bairro com este c�digo, digite novamente.');
    finally
      BairroDTO.Free;
      BairroDAO.Free;
    end;
  end;

end;

procedure TFrmCadCliente.Edt_CodigoMunicipioKeyPress(Sender: TObject;
  var Key: Char);
var
  Municipio : TMunicipioDTO;
  MunicipioDAO : TMunicipioDAO;
begin
    if key = #13 then
  begin
    try
      Municipio := TMunicipioDTO.Create;
      MunicipioDAO := TMunicipioDAO.create;
      Municipio := MunicipioDAO.Encontrar(Edt_CodigoMunicipio.Text);
      if Assigned(Municipio) then
      begin
        Edt_Municipio.Text    := Municipio.Nome;
        Edt_CodigoBairro.Text := '';
        Edt_Bairro.Text       := '';
      end
      else
       ShowMessage('N�o foi possivel encontrar o municipio com este c�digo, digite novamente.');
    finally
      BairroDTO.Free;
      BairroDAO.Free;
    end;
  end;
end;

procedure TFrmCadCliente.Edt_CpfEnter(Sender: TObject);
begin
  KeyPreview := false;
end;

procedure TFrmCadCliente.Edt_DataNascimentoEnter(Sender: TObject);
begin
  Edt_DataNascimento.Text := '';
  Edt_DataNascimento.EditMask := '!99/99/0000;1;_';
end;

procedure TFrmCadCliente.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    btnCancelar.Click();
end;

procedure TFrmCadCliente.FormShow(Sender: TObject);
begin
  if FStatus = 1 then
  begin
    limpar;
    Edt_Codigo.Text := fdmConexao.retornaCodigoMaximo('CLI_CODIGO','CLIENTE');
    Edt_nome.SetFocus;
  end
  else
  if FStatus = 2 then
  begin
    carregar;
    Edt_Nome.SetFocus;
  end
  else
  if FStatus = 3 then
    Carregar;

  FrmCadCliente.Height := 260;

  controlarStatus;

end;
procedure TFrmCadCliente.InserirClick(Sender: TObject);
var
  tipo: string;
  function verificarTipo(AString:string):integer;
  begin
    if Trim(AString) = 'Celular' then
      result := 1
    else
    if Trim(AString) = 'Email' then
      result := 2
    else
      result := 3;
  end;
begin
  if btnTipoContato.ItemIndex = 0 then
    tipo := 'Celular'
  else if btnTipoContato.ItemIndex = 1 then
    tipo := 'Email'
  else
    tipo := 'Telefone';
  if Edt_Contato.Text <> '' then
  begin
    Contato.Append;

    ContatoTipo.AsString := tipo;
    ContatoRegistro.AsString := Edt_Contato.Text;
    ContatoType.AsInteger := verificarTipo(tipo);

    Contato.Post;
  end;

  Edt_Contato.Text := '';
  controlarStatusDosContatos;
end;

procedure TFrmCadCliente.limpar;
var
  i: Integer;
  Edit: TEdit;
begin
  for i := 0 to FrmCadCliente.ComponentCount - 1 do
  begin
    if FrmCadCliente.Components[i].ClassType = TEdit then
    begin
      Edit := TEdit(FrmCadCliente.Components[i]);
      Edit.Text := '';
    end;
  end;
end;

end.
