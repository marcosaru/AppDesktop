unit CondicoesDAO;

interface
  uses CondicoesDTO,FireDAC.Stan.Intf, FireDAC.Stan.Option,System.Sysutils,
    FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
    FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
    FireDAC.Comp.DataSet, FireDAC.Comp.Client;
    type
      TCondicoesDAO = class
      private
        QryPesquisa : TFDQuery;
        QryCadastro : TFDQuery;
        QryAux      : TFDQuery;
        Condicao  : TCondicoesDTO;
        FStatus     : integer;
      public
        constructor create;
        destructor destroy;
        function Encontrar(ACodigo:string):TCondicoesDTO;
        function salvar(Condicao:TCondicoesDTO):boolean;
        function Alterar(Condicao:TCondicoesDTO):Boolean;
      end;

implementation

{ TCondicoesDAO }

uses dmConexao;

function TCondicoesDAO.Alterar(Condicao: TCondicoesDTO): Boolean;
begin
  FStatus:= 2;
  salvar(Condicao);
end;

constructor TCondicoesDAO.create;
begin
  QryPesquisa := TFDQuery.Create(nil);
  QryCadastro := TFDQuery.Create(nil);
  QryAux      := TFDQuery.Create(nil);
  Condicao  := TCondicoesDTO.Create;

  QryPesquisa.Connection := fdmConexao.BANCO;
  QryCadastro.Connection := fdmConexao.BANCO;
  QryAux.Connection      := fdmConexao.BANCO;
end;

destructor TCondicoesDAO.destroy;
begin
  FreeAndNil(QryPesquisa);
  FreeAndNil(QryCadastro);
  FreeAndNil(QryAux);
  FreeAndNil(Condicao);

  inherited;
end;

function TCondicoesDAO.Encontrar(ACodigo: string): TCondicoesDTO;
begin
  QryPesquisa.SQL.Clear;
  QryPesquisa.SQL.Add('SELECT * FROM condicoes where con_codigo = '+ACodigo);
  QryPesquisa.Open;
  if QryPesquisa.RecordCount > 0 then
  begin
    Condicao.Codigo := QryPesquisa.FieldByName('con_codigo').AsString;
    Condicao.Descricao := QryPesquisa.FieldByName('con_descricao').AsString;
    result := Condicao.Clone(Condicao);
  end
  else result := nil;
end;

function TCondicoesDAO.salvar(Condicao: TCondicoesDTO): boolean;
begin
  if fdmConexao.BANCO.InTransaction then
    fdmConexao.BANCO.Rollback;

  fdmConexao.BANCO.StartTransaction;

  QryCadastro.SQL.Clear;
  if FStatus in [0,1] then
    QryCadastro.SQL.Add('insert into Condicoes (con_codigo, '+
                      'con_descricao) values (:con_codigo,'+
                      ':con_descricao )')
  else
  if FStatus = 2 then
    QryCadastro.SQL.Add('UPDATE Condicoes SET '+
                        'con_descricao=:con_descricao where con_codigo = :con_codigo');

  QryCadastro.ParamByName('con_codigo').AsString := Condicao.Codigo;
  QryCadastro.ParamByName('con_descricao').AsString := Condicao.Descricao;
  QryCadastro.ExecSQL;

  fdmConexao.BANCO.Commit;
end;

end.
