object FrmCadCondicoes: TFrmCadCondicoes
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Condi'#231#245'es de Pagamento'
  ClientHeight = 206
  ClientWidth = 605
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
    Width = 512
    Height = 206
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
    object pnlMeses: TPanel
      Left = 265
      Top = 139
      Width = 241
      Height = 57
      TabOrder = 2
      Visible = False
      object Label4: TLabel
        Left = 28
        Top = 23
        Width = 30
        Height = 13
        Caption = 'Meses'
      end
      object CbbMeses: TComboBox
        Left = 64
        Top = 20
        Width = 57
        Height = 22
        Style = csOwnerDrawFixed
        ItemIndex = 0
        TabOrder = 0
        Text = '01'
        Items.Strings = (
          '01'
          '02'
          '03'
          '04'
          '05'
          '06'
          '07'
          '08'
          '09'
          '10'
          '11'
          '12')
      end
    end
    object pnlDias: TPanel
      Left = 18
      Top = 139
      Width = 241
      Height = 57
      TabOrder = 3
      Visible = False
      object Label3: TLabel
        Left = 35
        Top = 23
        Width = 20
        Height = 13
        Caption = 'Dias'
      end
      object Edt_Parcelas: TMaskEdit
        Left = 61
        Top = 20
        Width = 137
        Height = 21
        EditMask = '!999/999/999/999/999/999;1;_'
        MaxLength = 23
        TabOrder = 0
        Text = '   /   /   /   /   /   '
      end
    end
  end
  object pnlBotoes: TPanel
    Left = 512
    Top = 0
    Width = 93
    Height = 206
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    object btnConfirmar: TButton
      Left = 6
      Top = 22
      Width = 75
      Height = 25
      Caption = 'Confirmar'
      TabOrder = 0
      OnClick = btnConfirmarClick
    end
    object btnCancelar: TButton
      Left = 6
      Top = 57
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 1
      OnClick = btnCancelarClick
    end
  end
  object chkParcelas: TCheckBox
    Left = 79
    Top = 81
    Width = 137
    Height = 17
    Caption = 'Representa parcelas'
    TabOrder = 2
    OnClick = chkParcelasClick
  end
  object pnlEscolha: TPanel
    Left = 18
    Top = 112
    Width = 488
    Height = 25
    TabOrder = 3
    Visible = False
    object ChkDias: TCheckBox
      Left = 61
      Top = 4
      Width = 92
      Height = 17
      Caption = 'Especificar Dias'
      TabOrder = 0
      OnClick = ChkDiasClick
    end
    object ChkMeses: TCheckBox
      Left = 275
      Top = 4
      Width = 118
      Height = 17
      Caption = 'Especificar Meses'
      TabOrder = 1
      OnClick = ChkMesesClick
    end
  end
end
