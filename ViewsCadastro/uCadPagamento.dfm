object FrmCadRecebimento: TFrmCadRecebimento
  Left = 0
  Top = 0
  Caption = 'FrmCadRecebimento'
  ClientHeight = 199
  ClientWidth = 494
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 30
    Top = 49
    Width = 33
    Height = 13
    Caption = 'Codigo'
  end
  object Label2: TLabel
    Left = 39
    Top = 75
    Width = 24
    Height = 13
    Caption = 'Valor'
  end
  object Label3: TLabel
    Left = 40
    Top = 102
    Width = 23
    Height = 13
    Caption = 'Data'
  end
  object Label4: TLabel
    Left = 8
    Top = 129
    Width = 55
    Height = 13
    Caption = 'Vencimento'
  end
  object Label5: TLabel
    Left = 8
    Top = 156
    Width = 54
    Height = 13
    Caption = 'Pagamento'
  end
  object Label6: TLabel
    Left = 168
    Top = 49
    Width = 63
    Height = 13
    Caption = 'Observa'#231#245'es'
  end
  object Edt_Valor: TCurrencyEdit
    Left = 69
    Top = 72
    Width = 67
    Height = 21
    Alignment = taRightJustify
    Enabled = False
    TabOrder = 0
    Text = '0,00'
    FormatMask = '###,##0.00'
  end
  object Edt_Codigo: TEdit
    Left = 69
    Top = 46
    Width = 67
    Height = 21
    TabOrder = 1
  end
  object Edt_DataCompra: TMaskEdit
    Left = 69
    Top = 99
    Width = 67
    Height = 21
    Alignment = taRightJustify
    TabOrder = 2
    Text = ''
  end
  object Edt_Vcto: TMaskEdit
    Left = 69
    Top = 126
    Width = 67
    Height = 21
    Alignment = taRightJustify
    TabOrder = 3
    Text = ''
  end
  object Edt_Pagamento: TMaskEdit
    Left = 69
    Top = 153
    Width = 67
    Height = 21
    Alignment = taRightJustify
    TabOrder = 4
    Text = ''
  end
  object Edt_Obs: TMemo
    Left = 168
    Top = 72
    Width = 185
    Height = 89
    TabOrder = 5
  end
  object btnConfirmar: TButton
    Left = 392
    Top = 46
    Width = 75
    Height = 21
    Caption = 'Confirmar'
    TabOrder = 6
    OnClick = btnConfirmarClick
  end
  object BtnCancelar: TButton
    Left = 392
    Top = 72
    Width = 75
    Height = 21
    Caption = 'Cancelar'
    TabOrder = 7
    OnClick = BtnCancelarClick
  end
end
