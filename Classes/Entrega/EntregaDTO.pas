unit EntregaDTO;

interface
uses
  MovimentoDTO,TransportadorDTO,ProdutoVenda,System.Generics.Collections,SysUtils;
  type
    TEntregaDTO = class
      private
        FCodigo: String;
        FMovimento: TMovimentoDTO;
        FDataPrev : TDate;
        FData : TDate;
        FEntregador: TTransportadorDTO;
      public
        property Codigo:String read fCodigo write Fcodigo;
        property Movimento:TMovimentoDTO read FMovimento write FMovimento;
        property DataPrevista:TDate read FDataPrev write FDataPrev;
        property DataEntrega:TDate read FData write FData;
        property Transportadora : TTransportadorDTO read FEntregador write FEntregador;
        constructor create;
        destructor destroy;
    end;


implementation

{ TEntregaDTO }

constructor TEntregaDTO.create;
begin

end;

destructor TEntregaDTO.destroy;
begin
  inherited;
end;

end.
