unit CategoriaDTO;

interface
  type
  TCategoriaDTO = Class
    private
      FCodigo: String;
      FDescricao: String;
    public
      property Codigo: String Read FCodigo Write FCodigo;
      property Descricao: String Read FDescricao Write FDescricao;

  End;

implementation

end.
