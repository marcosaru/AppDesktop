unit CategoriaDAO;

interface
  uses
    CategoriaDTO,FireDAC.Stan.Intf, FireDAC.Stan.Option,
    FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
    FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
    FireDAC.Comp.DataSet, FireDAC.Comp.Client,Vcl.Dialogs,System.SysUtils;
  Type
    TCategoriaDAO = Class
      Private
        FStatus:Integer;
        Categoria : TCategoriaDTO;
        QryPesquisa: TFDQuery;
        QryAux: TFDQuery;
        QryCadastrar: TFDQuery;

      Public
        Function Salvar(Categoria:TCategoriaDTO):Boolean;
        Function Alterar(Categoria:TCategoriaDTO):Boolean;
        Function Encontrar(ACodigo:String):TCategoriaDTO;
        constructor create;
        destructor destroy;

    End;

implementation

{ TCategoriaDAO }

uses dmConexao;

function TCategoriaDAO.Alterar(Categoria: TCategoriaDTO): Boolean;
begin
  FStatus := 2;
  Salvar(Categoria);
end;

constructor TCategoriaDAO.create;
begin
  QryPesquisa  := TFDQuery.Create(Nil);
  QryAux       := TFDQuery.Create(Nil);
  QryCadastrar := TFDQuery.Create(Nil);

  QryPesquisa.Connection := fdmConexao.BANCO;
  QryAux.Connection := fdmConexao.BANCO;
  QryCadastrar.Connection := fdmConexao.BANCO;

  Categoria := TCategoriaDTO.Create;
end;

destructor TCategoriaDAO.destroy;
begin
  FreeAndNil(QryPesquisa);
  FreeAndNil(QryAux);
  FreeAndNil(QryCadastrar);
  FreeAndNil(Categoria);
  inherited;
end;

function TCategoriaDAO.Encontrar(ACodigo: String): TCategoriaDTO;
begin
  QryPesquisa.SQL.Clear;
  QryPesquisa.SQL.Add('Select * from categoria where cat_codigo = :cat_codigo');
  QryPesquisa.ParamByName('cat_codigo').AsString := ACodigo;
  QryPesquisa.Open();

  if QryPesquisa.RecordCount > 0  then
  begin
    Categoria.Codigo := QryPesquisa.FieldByName('cat_codigo').AsString;
    Categoria.Descricao := QryPesquisa.FieldByName('cat_descricao').AsString;
    result := Categoria;
  end
  else
    result := nil;
end;

function TCategoriaDAO.Salvar(Categoria: TCategoriaDTO): Boolean;
begin
  try

  if fdmConexao.BANCO.InTransaction then
    fdmConexao.BANCO.Rollback;

  fdmConexao.BANCO.StartTransaction;

  QryCadastrar.SQL.Clear;
  if FStatus <> 2 then
    QryCadastrar.SQL.Add('INSERT INTO CATEGORIA (CAT_CODIGO,CAT_DESCRICAO) '+
                         ' VALUES (:CAT_CODIGO,:CAT_DESCRICAO)')
  else
    QryCadastrar.SQL.Add('UPDATE CATEGORIA SET CAT_DESCRICAO WHERE '+
                         'CAT_CODIGO= :CAT_CODIGO');

  QryCadastrar.ParamByName('CAT_CODIGO').AsString := Categoria.Codigo;
  QryCadastrar.ParamByName('CAT_DESCRICAO').AsString := Categoria.Descricao;

  QryCadastrar.ExecSQL;

  fdmConexao.BANCO.Commit;

  except
    result := false;
  end;
end;

end.
