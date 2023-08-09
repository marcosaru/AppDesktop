unit PagamentosMovimentoDTO;

interface
uses
  SysUtils;

type

    TPagamentosMovimentoDTO = class
      private
        FCodigo: Integer;
        FDataVcto: TDate;
        FNumeroDaParcela: Integer;
        FDataVenda: TDate;
        FDataPagto: TDate;
        FValor :Double;
        FJuros: Double;
        FMulta: Double;
        FMovimento: String;
        FObservacoes: string;
     public
       property Codigo : Integer read FCodigo write FCodigo;
       property DataVcto : TDate read FDataVcto write FDataVcto;
       property NumeroDaParcela : Integer read FNumeroDaParcela write FNumeroDaParcela;
       property DataPagto : TDate read FDataPagto write FDataPagto;
       property DataVenda : TDate read FDataVenda write FDataVenda;
       property Juros : Double read FJuros write FJuros;
       property Multa : Double read FMulta write FMulta;
       property Valor : Double read FValor write FValor;
       property Observacoes : String read FObservacoes write FObservacoes;
       property Movimento : String Read FMovimento write FMovimento;
  end;

implementation

end.
