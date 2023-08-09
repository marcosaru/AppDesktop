unit ClienteDAO;

interface
uses ClienteDTO,
     BairroDTO,BairroDAO,MunicipioDTO,MunicipioDAO;
  type
    TClienteDAO = class
      fStatus : integer;
      Cliente : TClienteDTO;
      ContatoCliente : TContato;
      BairroDTO : TBairroDTO;
      BairroDAO : TBairroDAO;
      function salvar(Cliente:TClienteDTO):boolean;
      procedure alterar(Cliente:TClienteDTO);
      function encontrarCliente(ACodigo: String):TClienteDTO;
      constructor create;
      destructor destroy;
    end;

implementation
{ TClienteDAO }

uses dmConexao,System.SysUtils,Vcl.Dialogs, System.DateUtils,System.Variants;

procedure TClienteDAO.alterar(Cliente: TClienteDTO);
begin
  fStatus := 2;
  salvar(Cliente);
end;


constructor TClienteDAO.create;
begin
  Cliente := TClienteDTO.create;
  BairroDAO := TBairroDAO.create;
end;

destructor TClienteDAO.destroy;
begin
  FreeAndNil(Cliente);
  FreeAndNil(BairroDAO);

  inherited;
end;

function TClienteDAO.encontrarCliente(ACodigo: String): TClienteDTO;
begin
  fdmConexao.QryBusca.SQL.Clear;
  fdmConexao.QryBusca.SQL.Add('SELECT * FROM CLIENTE WHERE CLI_CODIGO = '+ACodigo);
  fdmConexao.QryBusca.Open;

  if fdmConexao.QryBusca.RecordCount > 0 then
  begin
    with fdmConexao.QryBusca do
    begin
      BairroDTO := BairroDAO.Encontrar(FieldByName('CLI_BAIRRO').AsString);

      Cliente.Codigo          := FieldByName('CLI_CODIGO').AsString;
      Cliente.Nome            := FieldByName('CLI_NOME').AsString;
      Cliente.Municipio       := BairroDTO.Municipio;
      Cliente.Bairro          := BairroDTO;
      Cliente.Endereco        := FieldByName('CLI_ENDERECO').AsString;
      Cliente.CpfOuCnpj       := FieldByName('CLI_CNPJCPF').AsString;
      Cliente.EstadoCivil     := FieldByName('CLI_ESTADOCIVIL').AsString;
      Cliente.Nascimento      := FieldByName('CLI_NASCIMENTO').AsDateTime;
      Cliente.Empresa         := FieldByName('CLI_EMPRESA').AsString;
      Cliente.EmpresaEndereco := FieldByName('CLI_EMPRESAENDERECO').AsString;
      Cliente.Salario         := FieldByName('CLI_SALARIO').AsFloat;
      Cliente.Funcao          := FieldByName('CLI_FUNCAO').AsString;
      Cliente.EmpresaContato  := FieldByName('CLI_EMPRESACONTATO').AsString;
    end;

    fdmConexao.QryBusca.SQL.Clear;
    fdmConexao.QryBusca.SQL.Add('SELECT * FROM CONTATO WHERE CTO_CLIENTE = '+ACodigo);
    fdmConexao.QryBusca.Open;

    fdmConexao.QryBusca.fIRST;
    while not fdmConexao.QryBusca.EOF do
    begin
      with fdmConexao.QryBusca do
      begin
        ContatoCliente.FTipo := FieldByName('CTO_TIPO').AsString;
        ContatoCliente.FValor := FieldByName('CTO_VALOR').AsString;
        Cliente.Contatos.Add(ContatoCliente);
      end;
      fdmConexao.QryBusca.Next;
    end;

    result := Cliente;
  end
  else
    result := nil;
end;


function TClienteDAO.salvar(Cliente: TClienteDTO): boolean;
  procedure gravarContatos(Cliente:TClienteDTO);
  var
    NovoContato : TContato;
    NovoCodigo : String;
  begin
    fdmConexao.BANCO.StartTransaction;

    fdmConexao.QryAux.SQL.Clear;
    fdmConexao.QryAux.SQL.ADD('delete from contato where cto_cliente = '+Cliente.Codigo);
    fdmConexao.QryAux.ExecSQL;

    fdmConexao.BANCO.commit;

    fdmConexao.BANCO.StartTransaction;

    for NovoContato in Cliente.Contatos do
    begin
      NovoCodigo := fdmConexao.retornaCodigoMaximo('CTO_CODIGO','CONTATO');




      fdmConexao.QryAux.SQL.Clear;
      fdmConexao.QryAux.SQL.add('INSERT INTO CONTATO '+
                                '(CTO_CODIGO,CTO_TIPO,CTO_CLIENTE,CTO_VALOR) '+
                                'VALUES '+
                                '(:CTO_CODIGO,:CTO_TIPO,:CTO_CLIENTE,:CTO_VALOR)');
      fdmConexao.QryAux.Params[0].AsString := NovoCodigo;
      fdmConexao.QryAux.Params[1].AsString := NovoContato.FTipo;
      fdmConexao.QryAux.Params[2].AsString := Cliente.Codigo;
      fdmConexao.QryAux.Params[3].AsString := NovoContato.FValor;

      fdmConexao.QryAux.ExecSQL;


    end;
    fdmConexao.BANCO.commit;

  end;
begin
  if fdmConexao.BANCO.InTransaction then
    fdmConexao.BANCO.Rollback;

  fdmConexao.BANCO.StartTransaction;

  fdmConexao.QryCadastro.SQL.Clear;
  try
    if fStatus in [0,1] then
      fdmConexao.QryCadastro.SQL.Add('INSERT INTO CLIENTE '+
                                  '(CLI_NOME,CLI_MUNICIPIO,CLI_BAIRRO,CLI_ENDERECO,CLI_CNPJCPF,CLI_CODIGO,CLI_ESTADOCIVIL,'+
                                  'CLI_NASCIMENTO,CLI_EMPRESA,CLI_EMPRESAENDERECO,CLI_SALARIO,CLI_FUNCAO,'+
                                  'CLI_EMPRESACONTATO,CLI_DATAADMISSAO)'+
                                  'VALUES '+
                                  '(:CLI_NOME,:CLI_MUNICIPIO,:CLI_BAIRRO,:CLI_ENDERECO,:CLI_CNPJCPF,:CLI_CODIGO,:CLI_ESTADOCIVIL,'+
                                  ':CLI_NASCIMENTO,:CLI_EMPRESA,:CLI_EMPRESAENDERECO,:CLI_SALARIO,:CLI_FUNCAO,'+
                                  ':CLI_EMPRESACONTATO,:CLI_DATAADMISSAO)')
    else
    if fStatus = 2 then
      fdmConexao.QryCadastro.SQL.Add('UPDATE CLIENTE SET CLI_NOME=:CLI_NOME,CLI_MUNICIPIO=:CLI_MUNICIPIO, '+
                                  'CLI_BAIRRO=:CLI_BAIRRO,CLI_ENDERECO=:CLI_ENDERECO,CLI_CNPJCPF=:CLI_CNPJCPF, '+
                                  'CLI_CODIGO=:CLI_CODIGO,CLI_ESTADOCIVIL=:CLI_ESTADOCIVIL,'+
                                  'CLI_NASCIMENTO=:CLI_NASCIMENTO,CLI_EMPRESA=:CLI_EMPRESA, '+
                                  'CLI_EMPRESAENDERECO=:CLI_EMPRESAENDERECO,CLI_SALARIO=:CLI_SALARIO,CLI_FUNCAO=:CLI_FUNCAO,'+
                                  'CLI_EMPRESACONTATO=:CLI_EMPRESACONTATO,CLI_DATAADMISSAO=:CLI_DATAADMISSAO where cli_codigo = '+Cliente.Codigo);

    fdmConexao.QryCadastro.Params[0].AsString  := Cliente.Nome;
    fdmConexao.QryCadastro.Params[1].AsString  := Cliente.Municipio.Codigo;
    fdmConexao.QryCadastro.Params[2].AsString  := Cliente.Bairro.Codigo;
    fdmConexao.QryCadastro.Params[3].AsString  := Cliente.Endereco;
    fdmConexao.QryCadastro.Params[4].AsString  := Cliente.CpfOuCnpj.Replace('-','').Replace('.','');
    fdmConexao.QryCadastro.Params[5].AsString  := Cliente.Codigo;
    fdmConexao.QryCadastro.Params[6].AsString  := Cliente.EstadoCivil;
    fdmConexao.QryCadastro.Params[7].AsDate  := Cliente.Nascimento;
    fdmConexao.QryCadastro.Params[8].AsString  := Cliente.Empresa;
    fdmConexao.QryCadastro.Params[9].AsString := Cliente.EmpresaEndereco;
    fdmConexao.QryCadastro.Params[10].AsString  := FloatToStr(Cliente.Salario).Replace(',','.');
    fdmConexao.QryCadastro.Params[11].AsString := Cliente.Funcao;
    fdmConexao.QryCadastro.Params[12].AsString := Cliente.EmpresaContato;
    fdmConexao.QryCadastro.Params[13].AsDate  := Cliente.DataAdmissao;

    fdmConexao.QryCadastro.ExecSQL;
    fdmConexao.BANCO.Commit;

    gravarContatos(Cliente);

    result := true;
  except
    result := false;
  end;
end;

end.
