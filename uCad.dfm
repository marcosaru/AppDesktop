object FrmCad: TFrmCad
  Left = 0
  Top = 0
  Caption = 'FrmCad'
  ClientHeight = 197
  ClientWidth = 576
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 432
    Height = 197
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitLeft = 8
    object Label1: TLabel
      Left = 27
      Top = 51
      Width = 31
      Height = 13
      Caption = 'Label1'
    end
    object Label2: TLabel
      Left = 27
      Top = 91
      Width = 31
      Height = 13
      Caption = 'Label1'
    end
    object Label3: TLabel
      Left = 27
      Top = 131
      Width = 31
      Height = 13
      Caption = 'Label1'
    end
    object Edt_Codigo: TEdit
      Left = 64
      Top = 48
      Width = 121
      Height = 21
      TabOrder = 0
      Text = 'Edt_Codigo'
    end
    object Edt_Nome: TEdit
      Left = 64
      Top = 88
      Width = 121
      Height = 21
      TabOrder = 1
      Text = 'Edit1'
    end
    object CbbEstados: TComboBox
      Left = 64
      Top = 128
      Width = 145
      Height = 21
      TabOrder = 2
      Text = 'CbbEstados'
    end
  end
  object Panel2: TPanel
    Left = 432
    Top = 0
    Width = 144
    Height = 197
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitLeft = 464
    ExplicitHeight = 272
    object btnConfirmar: TButton
      Left = 40
      Top = 46
      Width = 75
      Height = 25
      Caption = 'Confirmar'
      TabOrder = 0
    end
    object btnCancelar: TButton
      Left = 40
      Top = 86
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 1
    end
  end
end
