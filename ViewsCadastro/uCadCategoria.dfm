object FrmCadCategoria: TFrmCadCategoria
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastrar Categoria'
  ClientHeight = 155
  ClientWidth = 350
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 17
    Top = 35
    Width = 33
    Height = 13
    Caption = 'C'#243'digo'
  end
  object Label2: TLabel
    Left = 4
    Top = 75
    Width = 46
    Height = 13
    Caption = 'Descri'#231#227'o'
  end
  object Edt_Codigo: TEdit
    Left = 56
    Top = 32
    Width = 41
    Height = 21
    Enabled = False
    TabOrder = 0
  end
  object Edt_Descricao: TEdit
    Left = 56
    Top = 72
    Width = 153
    Height = 21
    TabOrder = 1
  end
  object btnConfirma: TButton
    Left = 265
    Top = 28
    Width = 75
    Height = 25
    Caption = 'Confirma'
    TabOrder = 2
    OnClick = btnConfirmaClick
  end
  object btnCancelar: TButton
    Left = 265
    Top = 68
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 3
    OnClick = btnCancelarClick
  end
end
