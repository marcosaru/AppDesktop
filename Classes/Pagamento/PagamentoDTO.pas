unit PagamentoDTO;

interface
  uses
    CondicoesDTO,FormaPagtoDTO;
  type
    TPagamentoDTO = class
      Private
        FCodigo: String;
        FDataVcto:TDate;
        FForma : TFormaPagtoDTO;
        FMovi:String;
        FValor:Double;
      public
        Property Codigo: String Read FCodigo Write FCodigo;
        Property DataVcto: TDate Read FDataVcto Write FDataVcto;
        Property FormaPagto: TFormaPagtoDTO read FForma Write FForma;
        Property Movimento: String Read FMovi Write FMovi;
        Property Valor: Double read Fvalor Write FValor;
        function Clone(PagamentoAClonar:TPagamentoDTO):TPagamentoDTO;
    end;


implementation

{ TPagamentoDTO }

function TPagamentoDTO.Clone(PagamentoAClonar: TPagamentoDTO): TPagamentoDTO;
begin
  Result := TPagamentoDTO.Create;
  Result.Codigo := PagamentoAClonar.Codigo;
  Result.DataVcto := PagamentoAClonar.DataVcto;
  Result.FormaPagto := PagamentoAClonar.FormaPagto;
  Result.Movimento := PagamentoAClonar.Movimento;
  Result.Valor := PagamentoAClonar.Valor;
end;

end.
