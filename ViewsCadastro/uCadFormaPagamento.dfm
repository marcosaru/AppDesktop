object FrmCadFormaPagamento: TFrmCadFormaPagamento
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Formas de Pagamento'
  ClientHeight = 119
  ClientWidth = 583
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlCadastro: TPanel
    Left = 0
    Top = 0
    Width = 439
    Height = 119
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 40
      Top = 27
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
    end
    object Label2: TLabel
      Left = 27
      Top = 57
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
    end
    object Edt_Codigo: TEdit
      Left = 79
      Top = 24
      Width = 41
      Height = 21
      Enabled = False
      TabOrder = 0
    end
    object Edt_Descricao: TEdit
      Left = 79
      Top = 51
      Width = 121
      Height = 21
      TabOrder = 1
    end
    object chkAvista: TCheckBox
      Left = 79
      Top = 78
      Width = 97
      Height = 17
      Caption = 'A Vista'
      TabOrder = 2
    end
  end
  object pnlBotoes: TPanel
    Left = 439
    Top = 0
    Width = 144
    Height = 119
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    object btnConfirmar: TButton
      Left = 40
      Top = 22
      Width = 75
      Height = 25
      Caption = 'Confirmar'
      TabOrder = 0
      OnClick = btnConfirmarClick
    end
    object btnCancelar: TButton
      Left = 40
      Top = 62
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 1
      OnClick = btnCancelarClick
    end
  end
end
