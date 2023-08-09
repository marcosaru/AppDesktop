unit LicencaDTO;

interface

type
  TLicencaDTO = class
  private
    FId: Integer;
    FChave: string;
    FDataExpiracao: TDateTime;
  public
    property Id: Integer read FId write FId;
    property Chave: string read FChave write FChave;
    property DataExpiracao: TDateTime read FDataExpiracao write FDataExpiracao;
  end;

implementation

end.

