unit uCad;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrmCad = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Edt_Codigo: TEdit;
    Edt_Nome: TEdit;
    btnConfirmar: TButton;
    btnCancelar: TButton;
    CbbEstados: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCad: TFrmCad;

implementation

{$R *.dfm}

end.
