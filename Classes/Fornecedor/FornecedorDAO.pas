unit FornecedorDAO;

interface
uses FireDAC.Stan.Intf, FireDAC.Stan.Option, Sysutils,
    FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
    FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,TransportadorDAO,
    FireDAC.Comp.DataSet,FornecedorDTO, FireDAC.Comp.Client,MunicipioDAO;
  type
    TFornecedorDAO = class
      private
        fStatus:integer;
        QryBuscar,QryAuxiliar,QryCadastrar:TFDQuery;
        MunicipioDAO : TMunicipioDAO;
        TransportadorDAO: TTransportadorDAO;
      public
        procedure salvar(Fornecedor:TFornecedorDTO);
        function EncontrarFornecedor(ACodigo:String):TFornecedorDTO;
        procedure Alterar(Fornecedor:TFornecedorDTO);
        constructor create;
        destructor destroy;
    end;

implementation

{ TFornecedorDAO }

uses dmConexao;

procedure TFornecedorDAO.Alterar(Fornecedor: TFornecedorDTO);
begin
  fStatus:= 2;
  salvar(Fornecedor);
end;

constructor TFornecedorDAO.create;
begin
  QryBuscar := TFDQuery.Create(nil);
  QryBuscar.Connection := fdmConexao.BANCO;

  QryAuxiliar := TFDQuery.Create(nil);
  QryAuxiliar.Connection := fdmConexao.BANCO;

  QryCadastrar := TFDQuery.Create(nil);
  QryCadastrar.Connection := fdmConexao.BANCO;

  MunicipioDAO := TMunicipioDAO.create;
  TransportadorDAO := TTransportadorDAO.create;
end;

destructor TFornecedorDAO.destroy;
begin
  FreeAndNil(MunicipioDAO);
  FreeAndNil(TransportadorDAO);
  inherited;
end;

function TFornecedorDAO.EncontrarFornecedor(ACodigo: String): TFornecedorDTO;
var
  FornecedorEncontrado : TFornecedorDTO;
begin
  QryBuscar.sql.Clear;
  QryBuscar.sql.Add('select * from fornecedor where for_codigo = '+ACodigo);
  QryBuscar.open;

  if QryBuscar.RecordCount > 0  then
  begin
    FornecedorEncontrado := TFornecedorDTO.Create;

    with QryBuscar do
    begin
      FornecedorEncontrado.Codigo := FieldByName('FOR_Codigo').AsString;
      FornecedorEncontrado.Nome := FieldByName('FOR_Nome').AsString;
      FornecedorEncontrado.Municipio := MunicipioDAO.Encontrar(FieldByName('FOR_Municipio').AsString);
      FornecedorEncontrado.Responsavel := FieldByName('FOR_REPRESENTANTE').AsString;
      FornecedorEncontrado.Transportador := TransportadorDAO.Encontrar(FieldByName('FOR_TRANSPORTADOR').AsString);
    end;
    result := FornecedorEncontrado;
  end
  else
    result := nil;

end;

procedure TFornecedorDAO.salvar(Fornecedor: TFornecedorDTO);
begin
  if fdmConexao.BANCO.InTransaction then
    fdmConexao.BANCO.rollback;

  fdmConexao.BANCO.StartTransaction;

  QryCadastrar.sql.clear;

  if fStatus in [0,1] then
    QryCadastrar.sql.add('INSERT INTO FORNECEDOR (FOR_CODIGO,FOR_NOME,FOR_MUNICIPIO,FOR_REPRESENTANTE,FOR_TRANSPORTADOR) '+
                         'VALUES '+
                         '(:FOR_CODIGO,:FOR_NOME,:FOR_MUNICIPIO,:FOR_REPRESENTANTE,:FOR_TRANSPORTADOR)')
  else
  if fStatus = 2 then
    QryCadastrar.sql.add('UPDATE FORNECEDOR SET FOR_NOME = :FOR_NOME, FOR_MUNICIPIO = :FOR_MUNICIPIO,'+
    ' FOR_REPRESENTANTE = :FOR_REPRESENTANTE, FOR_TRANSPORTADOR = :FOR_TRANSPORTADOR' +
    ' WHERE FOR_CODIGO = :FOR_CODIGO');

  QryCadastrar.ParamByName('FOR_CODIGO').AsString := Fornecedor.Codigo;
  QryCadastrar.ParamByName('FOR_NOME').AsString := Fornecedor.Nome;
  QryCadastrar.ParamByName('FOR_MUNICIPIO').AsString := Fornecedor.Municipio.Codigo;
  QryCadastrar.ParamByName('FOR_REPRESENTANTE').AsString := Fornecedor.Responsavel;
  QryCadastrar.ParamByName('FOR_TRANSPORTADOR').AsString := Fornecedor.Transportador.Codigo;
  QryCadastrar.ExecSQL;

  fdmConexao.BANCO.Commit;
end;

end.
