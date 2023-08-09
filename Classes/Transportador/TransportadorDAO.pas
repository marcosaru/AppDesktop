unit TransportadorDAO;

interface

uses
  TransportadorDTO, MunicipioDTO, MunicipioDAO, FireDAC.Comp.Client, FireDAC.Stan.Param, SysUtils;

type
  TTransportadorDAO = class
  private
    QryCadastro: TFDQuery;
    QryPesquisa: TFDQuery;
    TransportadorEncontrado: TTransportadorDTO;
    MunicipioDAO: TMunicipioDAO;
    MunicipioDTO: TMunicipioDTO;
    mStatus: integer;
  public
    function salvar(Transportador: TTransportadorDTO): boolean;
    function alterar(Transportador: TTransportadorDTO): boolean;
    function inativar(Transportador: TTransportadorDTO): boolean;
    function Encontrar(ACodigo: String): TTransportadorDTO;
    function encontrarCodigoMaximo: String;
    constructor create; overload;
    destructor destroy; overload;
  end;

implementation

uses dmConexao;

{ TTransportadorDAO }

function TTransportadorDAO.alterar(Transportador: TTransportadorDTO): Boolean;
begin
  mStatus := 2;
  salvar(Transportador);
  result:= true;
end;

constructor TTransportadorDAO.create;
begin
  QryCadastro := TFDQuery.Create(nil);
  QryPesquisa := TFDQuery.Create(nil);
  QryCadastro.Connection := fdmConexao.BANCO;
  QryPesquisa.Connection := fdmConexao.BANCO;

  TransportadorEncontrado := TTransportadorDTO.Create;
  MunicipioDAO := TMunicipioDAO.Create;
end;

destructor TTransportadorDAO.destroy;
begin
  QryCadastro.Free;
  QryPesquisa.Free;
  TransportadorEncontrado.Free;
  MunicipioDAO.Free;

  inherited;
end;

function TTransportadorDAO.Encontrar(ACodigo: String): TTransportadorDTO;
begin
  QryCadastro.SQL.Clear;
  QryCadastro.SQL.Add('SELECT * FROM TRANSPORTADOR where TRANS_CODIGO = '+ACodigo);
  QryCadastro.Open;
  if QryCadastro.RecordCount > 0 then
  begin
    with QryCadastro do
    begin
      MunicipioDTO := MunicipioDAO.Encontrar(FieldByName('TRANS_MUNICIPIO').AsString);
      TransportadorEncontrado.Codigo    := FieldByName('TRANS_CODIGO').AsString;
      TransportadorEncontrado.Nome      := FieldByName('TRANS_NOME').AsString;
      TransportadorEncontrado.Endereco  := FieldByName('TRANS_ENDERECO').AsString;
      TransportadorEncontrado.Telefone  := FieldByName('TRANS_TELEFONE').AsString;
      TransportadorEncontrado.Municipio := MunicipioDTO;
    end;
    result := TransportadorEncontrado;
  end
  else
    result := nil;
end;

function TTransportadorDAO.encontrarCodigoMaximo: String;
begin
  QryPesquisa.sql.clear;
  QryPesquisa.sql.add('SELECT MAX(TRANS_CODIGO) as Codigo FROM TRANSPORTADOR');
  QryPesquisa.Open;
  result := IntToStr(QryPesquisa.FieldByName('codigo').AsInteger + 1);
end;

function TTransportadorDAO.inativar(Transportador: TTransportadorDTO): Boolean;
begin
  // Implemente este método se necessário
end;

function TTransportadorDAO.salvar(Transportador: TTransportadorDTO): boolean;
begin
  try
    if fdmConexao.BANCO.InTransaction then
      fdmConexao.BANCO.Rollback;

    fdmConexao.BANCO.StartTransaction;

    QryCadastro.SQL.Clear;

    if mStatus in [0,1] then
      QryCadastro.SQL.Add('INSERT INTO TRANSPORTADOR'+
                          '(TRANS_CODIGO, TRANS_NOME, TRANS_TELEFONE, TRANS_ENDERECO, TRANS_MUNICIPIO) '+
                          'VALUES '+
                          '(:TRANS_CODIGO, :TRANS_NOME, :TRANS_TELEFONE, :TRANS_ENDERECO, :TRANS_MUNICIPIO)')
    else
    if mStatus = 2 then
      QryCadastro.SQL.Add('UPDATE TRANSPORTADOR SET '+
                          'TRANS_CODIGO = :TRANS_CODIGO, TRANS_NOME = :TRANS_NOME, '+
                          'TRANS_TELEFONE = :TRANS_TELEFONE, TRANS_ENDERECO = :TRANS_ENDERECO, TRANS_MUNICIPIO = :TRANS_MUNICIPIO'+
                          ' where TRANS_CODIGO = '+Transportador.Codigo);


    QryCadastro.Params[0].AsString := Transportador.Codigo;
    QryCadastro.Params[1].AsString := Transportador.Nome;
    QryCadastro.Params[2].AsString := Transportador.Telefone;
    QryCadastro.Params[3].AsString := Transportador.Endereco;
    QryCadastro.Params[4].AsString := Transportador.Municipio.Codigo;

    QryCadastro.ExecSQL;
    fdmConexao.BANCO.Commit;
    result := true;
  except
    result := false;
  end;
end;

end.

