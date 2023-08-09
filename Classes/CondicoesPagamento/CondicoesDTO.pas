unit CondicoesDTO;

interface
  type
    TCondicoesDTO = class
      private
        FCodigo: string;
        FDescricao: string;
      public
       property Codigo : String read FCodigo write FCodigo;
        property Descricao : String read FDescricao write FDescricao;
        function Clone(ObjAClonar:TCondicoesDTO):TCondicoesDTO;
       destructor destroy;override;
    end;

implementation

{ TCondicoesDTO }

function TCondicoesDTO.Clone(ObjAClonar: TCondicoesDTO): TCondicoesDTO;
begin
  result := TCondicoesDTO.Create;
  Result.Codigo := ObjAClonar.Codigo;
  Result.Descricao := ObjAClonar.Descricao;
end;

destructor TCondicoesDTO.destroy;
begin

  inherited;
end;

end.
