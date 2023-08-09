unit PagamentoAbstrato;

interface
  uses
    MovimentoDAO,MovimentoDTO,PagamentoDAO,PagamentoDTO;
  type
    FPagamento = class abstract (TPagamentoDAO);

  type
    FPagamentoDescricao = class(TPagamentoDAO);

  type
    FMovimentoDAO = class(TMovimentoDAO);
implementation

end.
