unit MunicipioDTO;

interface
  type
  TMunicipioDTO = class
    FCodigo: string;
    Fnome : string;
    FEstado : string;
    property Codigo: string read FCodigo write FCodigo;
    property Nome: string read FNome write FNome;
    property Estado: string read FEstado write FEstado;

  end;

implementation

end.
