unit ProdutoDTO;

interface
uses
  FornecedorDTO,CategoriaDTO;
  type
    TProdutoDTO = class
      private
        FCodigo     : string;
        FNome       : string;
        FCusto      : real;
        FFornecedor : TFornecedorDTO;
        FValorVenda : real;
        FDescricao  : string;
        FMedidas    : string;
        FTecido     : string;
        FMadeira    : string;
        FCategoria  : TCategoriaDTO;
      public
        property Codigo     : string         read FCodigo write FCodigo;
        property Nome       : string         read FNome write FNome;
        property Custo      : real           read FCusto write FCusto;
        property Fornecedor : TFornecedorDTO read FFornecedor write FFornecedor;
        property ValorVenda : real           read FValorVenda write FValorVenda;
        property Descricao  : string         read FDescricao write FDescricao;
        property Medidas    : string         read FMedidas write FMedidas;
        property Tecido     : string         read FTecido write FTecido;
        property Madeira    : string         read FMadeira write FMadeira;
        property Categoria  : TCategoriaDTO  read FCategoria write FCategoria;
        function Clone(ProdutoDTO:TProdutoDTO):TProdutoDTO;
    end;

implementation

{ TProdutoDTO }

function TProdutoDTO.Clone(ProdutoDTO: TProdutoDTO): TProdutoDTO;
begin
  result            := TProdutoDTO.Create;
  Result.Codigo     := Self.Codigo;
  Result.Nome       := Self.Nome;
  Result.Custo      := Self.Custo;
  Result.Fornecedor :=  Self.Fornecedor;
  Result.ValorVenda :=  Self.ValorVenda;
  Result.Descricao  :=  Self.Descricao;
  Result.Medidas    :=  Self.Medidas;
  Result.Tecido     :=  Self.Tecido;
  Result.Madeira    :=  Self.Madeira;
end;

end.
