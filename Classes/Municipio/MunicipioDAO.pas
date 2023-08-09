unit MunicipioDAO;

interface
uses MunicipioDTO,FireDAC.Stan.Intf, FireDAC.Stan.Option,
    FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
    FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
    FireDAC.Comp.DataSet, FireDAC.Comp.Client,Vcl.Dialogs,System.SysUtils;
  type
    TMunicipioDAO = class
      public
        function salvar(Municipio: TMunicipioDTO): boolean;
        function alterar(Municipio: TMunicipioDTO):Boolean;
        function inativar(Municipio:TMunicipioDTO):Boolean;
        function Encontrar(ACodigo:String): TMunicipioDTO;
        function EncontrarCodigoMaximo: integer;
        constructor Create;
        constructor createWithCodigo(ACodigo:integer);overload;
        destructor destroy; overload;
      private
        mStatus:integer;
        QryCadastro : TFDQuery;
        QryPesquisa  : TFDQuery;
        procedure Initialize;
    end;

implementation

{ TMunicipioDAO }

uses dmConexao;

function TMunicipioDAO.alterar(Municipio: TMunicipioDTO): Boolean;
begin
  mStatus := 2;
  salvar(Municipio);
  result:= true;
end;

constructor TMunicipioDAO.create;
begin
  initialize;
end;

constructor TMunicipioDAO.createWithCodigo(ACodigo: integer);
begin
  inherited create;
  Initialize;
  mStatus := ACodigo;
end;

destructor TMunicipioDAO.destroy;
begin
QryCadastro.Free;
  QryPesquisa.Free;
  QryCadastro := nil;
  QryPesquisa := nil;
  inherited;
end;

function TMunicipioDAO.Encontrar(ACodigo: String): TMunicipioDTO;
var
  MunicipioEncontrado : TMunicipioDTO;
begin
  QryCadastro.SQL.Clear;
  QryCadastro.SQL.ADD('SELECT * FROM Municipio where mun_codigo = '+ACodigo);
  QryCadastro.Open;
  if QryCadastro.RecordCount > 0 then
  begin
    MunicipioEncontrado := TMunicipioDTO.Create;
    with QryCadastro do
    begin
      MunicipioEncontrado.Codigo := FieldByName('Mun_CODIGO').AsString;
      MunicipioEncontrado.Nome := FieldByName('Mun_NOME').AsString;
      MunicipioEncontrado.Estado := FieldByName('Mun_Estado').AsString;
      result := MunicipioEncontrado;
    end;
  end
  else
    result := nil;
end;

function TMunicipioDAO.EncontrarCodigoMaximo: integer;
begin
  QryPesquisa.sql.Clear;
  QryPesquisa.sql.add('select max(mun_codigo) as codigo from municipio');
  QryPesquisa.Open;
  result := QryPesquisa.FieldByName('codigo').AsInteger;
end;

function TMunicipioDAO.inativar(Municipio: TMunicipioDTO): Boolean;
begin
    //
end;

procedure TMunicipioDAO.Initialize;
begin
  QryCadastro := TFDQuery.Create(nil);
  QryPesquisa := TFDQuery.Create(nil);

  QryCadastro.Connection := fdmConexao.BANCO;
  QryPesquisa.Connection := fdmConexao.BANCO;
end;

function TMunicipioDAO.salvar(Municipio: TMunicipioDTO): boolean;
begin
  try
    QryCadastro.SQL.Clear;
    if fdmConexao.BANCO.InTransaction then
      fdmConexao.BANCO.Rollback;

    fdmConexao.BANCO.StartTransaction;

    if mStatus in [0,1] then
      QryCadastro.SQL.Add('INSERT INTO Municipio'+
                          '(mun_nome,mun_estado,mun_codigo) '+
                          'VALUES '+
                          '( :mun_nome , :mun_Estado , :Codigo)')
    else
    if mStatus = 2 then
      QryCadastro.SQL.Add('UPDATE Municipio SET '+
                          ' mun_nome= :mun_nome,mun_estado= :mun_Estado,mun_codigo= :mun_codigo where mun_codigo = '+Municipio.Codigo);

    QryCadastro.Params[0].AsString := Municipio.Nome;
    QryCadastro.Params[1].AsString := IntToStr(StrToInt(Municipio.Estado)+1);
    QryCadastro.Params[2].AsString := Municipio.Codigo;


    QryCadastro.ExecSQL;

    fdmConexao.BANCO.Commit;
    result := true
  Except
    result := false;
  end;
end;
end.
