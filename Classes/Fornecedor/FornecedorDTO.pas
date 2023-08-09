unit FornecedorDTO;

interface
uses MunicipioDTO,TransportadorDTO;
  type
    TFornecedorDTO = class
      private
        FCodigo:String;
        FNome:String;
        FMunicipio:TMunicipioDTO;
        FResponsavel:String;
        FTransportador : TTransportadorDTO;

      public
        property Codigo:String read FCodigo Write FCodigo;
        property Nome: String read FNome Write FNome;
        property Municipio: TMunicipioDTO read FMunicipio write FMunicipio;
        property Responsavel: String read FResponsavel Write FResponsavel;
        property Transportador : TTransportadorDTO read FTransportador write FTransportador;
  end;

implementation



end.
