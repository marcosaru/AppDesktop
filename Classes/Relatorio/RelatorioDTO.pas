unit RelatorioDTO;

interface

uses
  ClienteDTO,
  FornecedorDTO,
  System.Generics.Collections,
  ProdutoDTO;

type
  TRelatorioDTO = class abstract
  protected
    FDataGeracao: TDateTime;
    FDataInicial: TDateTime;
    FDataFinal: TDateTime;
  public
    property DataGeracao: TDateTime read FDataGeracao write FDataGeracao;
    property DataInicio: TDateTime read FDataInicial write FDataInicial;
    property DataFim: TDateTime read FDataFinal write FDataFinal;
  end;

  TRelatorioClienteDTO = class(TRelatorioDTO)
  private
    FCliente: TClienteDTO;
    // Outras propriedades espec�ficas para o relat�rio de cliente
  public
    property Cliente: TClienteDTO read FCliente write FCliente;
    // Outras propriedades espec�ficas para o relat�rio de cliente
  end;

  TRelatorioFornecedorDTO = class(TRelatorioDTO)
  private
    FFornecedor: TFornecedorDTO;
    // Outras propriedades espec�ficas para o relat�rio de fornecedor
  public
    property Fornecedor: TFornecedorDTO read FFornecedor write FFornecedor;
    // Outras propriedades espec�ficas para o relat�rio de fornecedor
  end;

  TRelatorioProdutoDTO = class(TRelatorioDTO)
    private
    FProduto : TProdutoDTO;
    public
    Property Produto: TProdutoDTO read Fproduto write Fproduto;
  end;

implementation

end.

