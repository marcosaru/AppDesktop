unit ClienteDTO;

interface
uses System.DateUtils,System.Generics.Collections,BairroDTO,MunicipioDTO;
  type
    TContato = record
      FTipo: String;
      FValor: String;
  end;

  type
  TClienteDTO = class
  private
    FNome:string;
    FCodigo:string;
    FMunicipio:TMunicipioDTO;
    FBairro:TBairroDTO;
    FEndereco:String;
    FCPFOUCNPJ:String;
    FEstadoCivil:String;
    FNascimento:TDate;
    FEmpresa:String;
    FEmpresaEndereco:String;
    FSalario:Real;
    FFuncao:String;
    FEmpresaContato:String;
    FDataAdmissao:TDate;
    FContato: TContato;
    FContatos: TList<TContato>;
  public
    property Nome:String read FNome write FNome;
    property Codigo:String read FCodigo write FCodigo;
    property Municipio:TMunicipioDTO read FMunicipio write FMunicipio;
    property Bairro:TBairroDTO read FBairro write FBairro;
    property Endereco:String read FEndereco write FEndereco;
    property CpfOuCnpj:String read FCPFOUCNPJ write FCPFOUCNPJ;
    property EstadoCivil:String read FEstadoCivil write FEstadoCivil;
    property Nascimento:TDate read FNascimento write FNascimento;
    property DataAdmissao:TDate read FDataAdmissao write FDataAdmissao;
    property Empresa:String read FEmpresa write FEmpresa;
    property Contato: TContato read FContato write FContato;
    property EmpresaEndereco:String read FEmpresaEndereco write FEmpresaEndereco;
    property Salario:Real read FSalario write FSalario;
    property Funcao:String read FFuncao write FFuncao;
    property EmpresaContato:String read FEmpresaContato write FEmpresaContato;
    property Contatos: TList<TContato> read FContatos;
    constructor create;
  end;

implementation

{ TClienteDTO }

constructor TClienteDTO.create;
begin
  FContatos := TList<TContato>.Create;
end;

end.
