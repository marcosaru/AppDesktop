unit BairroDTO;

interface
uses MunicipioDTO;
  type
  TBairroDTO = class
  private
    FCodigo: string;
    Fnome : string;
    FEstado : string;
    FMunicipio: TMunicipioDTO;
  public
    property Codigo: string read FCodigo write FCodigo;
    property Nome: string read FNome write FNome;
    property Estado: string read FEstado write FEstado;
    property Municipio: TMunicipioDTO read FMunicipio write FMunicipio;

  end;

implementation

end.
