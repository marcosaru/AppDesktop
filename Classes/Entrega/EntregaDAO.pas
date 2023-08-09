unit EntregaDAO;

interface
  uses
    EntregaDTO,FireDAC.Stan.Intf, FireDAC.Stan.Option,
    FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
    FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
    FireDAC.Comp.DataSet, FireDAC.Comp.Client,MovimentoDTO,MovimentoDAO,
    ProdutoDTO,ProdutoVenda,sysUtils,TransportadorDTO,TransportadorDAO;
  type
    TEntregaDAO = class
      private
        FStatus : integer;
        Entrega : TEntregaDTO;
        Movimento : TMovimentoDTO;
        MovimentoDAO : TMovimentoDAO;
        QryCadastro : TFDQuery;
        QryPesquisa  : TFDQuery;
        Produto : TProdutoDTO;
        ProdutoVenda: TProdutoVenda;
        TransportadorDAO : TTransportadorDAO;

      public
        function encontrar(Acodigo:String):TEntregaDTO;
        function Salvar(Entrega:TEntregaDTO):boolean;
        function Alterar(Entrega:TEntregaDTO):boolean;
        constructor create(MovimentoSalvar : TMovimentoDTO);
        destructor destroy;

    end;


implementation

{ TEntregaDAO }

uses dmConexao;

function TEntregaDAO.Alterar(Entrega: TEntregaDTO): boolean;
begin
  FStatus := 2;
  Salvar(Entrega);
end;

constructor TEntregaDAO.create(MovimentoSalvar : TMovimentoDTO);
begin
  Entrega := TEntregaDTO.create;
  MovimentoDAO := TMovimentoDAO.create;
  Produto := TProdutoDTO.Create;
  TransportadorDAO := TTransportadorDAO.create;
  ProdutoVenda := TProdutoVenda.Create;
end;

destructor TEntregaDAO.destroy;
begin
  FreeAndNil(Entrega);
  FreeAndNil(MovimentoDAO);
  FreeAndNil(Produto);
  FreeAndNil(ProdutoVenda);
  FreeAndNil(TransportadorDAO);
  inherited;
end;

function TEntregaDAO.encontrar(Acodigo: String): TEntregaDTO;
begin
  QryPesquisa.SQL.Clear;
  QryPesquisa.SQL.Add('Select * from entrega where ent_codigo = '+Acodigo);
  QryPesquisa.Open;
  if QryPesquisa.RecordCount > 0 then
  begin
    with QryPesquisa do
    begin
      Entrega.Codigo := FieldByName('Ent_codigo').AsString;
      Entrega.Movimento := MovimentoDAO.encontrar(FieldByName('Ent_Movimento').AsString);
      Entrega.DataPrevista := FieldByName('Ent_dataPrevista').AsDateTime;
      Entrega.DataEntrega := FieldByName('Ent_dataEntrega').AsDateTime;
      Entrega.Transportadora := TransportadorDAO.Encontrar(FieldByName('Ent_transportador').AsString);
    end;
    result:= Entrega;
  end
  else
    result := nil;
end;

function TEntregaDAO.Salvar(Entrega: TEntregaDTO): boolean;
begin
  QryCadastro.SQL.Clear;
  if fdmConexao.BANCO.InTransaction then
    fdmConexao.BANCO.Rollback;

  fdmConexao.BANCO.StartTransaction;

  if FStatus <> 2 then
    QryCadastro.SQL.Add('Insert into entrega (ent_codigo,ent_movimento, '+
                      'ent_dataprevista,ent_dataentrega,ent_transportador)'+
                      ' values (:ent_codigo,:ent_movimento, '+
                      ':ent_dataprevista,:ent_dataentrega,:ent_transportador)')
  else
    QryCadastro.SQL.Add('UPDATE ENTREGA SET ent_movimento= :ent_movimento, '+
                      'ent_dataprevista= :ent_dataprevista, '+
                      'ent_dataentrega= :ent_dataentrega, ' +
                      'ent_transportador= :ent_transportador )' +
                      'WHERE ent_codigo= :ent_codigo');

  QryCadastro.ParamByName('ent_codigo').AsString := Entrega.Codigo;
  QryCadastro.ParamByName('ent_movimento').AsString := Entrega.Movimento.Codigo;
  QryCadastro.ParamByName('ent_dataprevista').AsDateTime := Entrega.DataPrevista;
  QryCadastro.ParamByName('ent_dataentrega').AsDateTime := Entrega.DataEntrega;
  if Assigned(Entrega.Transportadora) then
    QryCadastro.ParamByName('ent_transportador').AsString := Entrega.Transportadora.Codigo
  else
    QryCadastro.ParamByName('ent_transportador').AsString := '1';

  QryCadastro.ExecSQL;

  fdmConexao.BANCO.Commit;
end;

end.
