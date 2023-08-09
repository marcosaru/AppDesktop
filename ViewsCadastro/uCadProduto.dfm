object FrmCadProduto: TFrmCadProduto
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastrar Produto'
  ClientHeight = 249
  ClientWidth = 796
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
  object pnlCadastro: TPanel
    Left = 0
    Top = 0
    Width = 707
    Height = 249
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitHeight = 148
    object Label1: TLabel
      Left = 49
      Top = 19
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
    end
    object Label2: TLabel
      Left = 55
      Top = 47
      Width = 27
      Height = 13
      Caption = 'Nome'
    end
    object Label3: TLabel
      Left = 54
      Top = 74
      Width = 28
      Height = 13
      Caption = 'Custo'
    end
    object Label4: TLabel
      Left = 7
      Top = 101
      Width = 75
      Height = 13
      Caption = 'Pre'#231'o de Venda'
    end
    object Label5: TLabel
      Left = 239
      Top = 101
      Width = 55
      Height = 13
      Caption = 'Fornecedor'
    end
    object Label6: TLabel
      Left = 255
      Top = 19
      Width = 39
      Height = 13
      Caption = 'Medidas'
    end
    object Label7: TLabel
      Left = 263
      Top = 47
      Width = 31
      Height = 13
      Caption = 'Tecido'
    end
    object Label8: TLabel
      Left = 256
      Top = 74
      Width = 38
      Height = 13
      Caption = 'Madeira'
    end
    object Label9: TLabel
      Left = 248
      Top = 174
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
    end
    object Label10: TLabel
      Left = 247
      Top = 128
      Width = 47
      Height = 13
      Caption = 'Categoria'
    end
    object Edt_Codigo: TEdit
      Left = 96
      Top = 16
      Width = 41
      Height = 21
      Enabled = False
      TabOrder = 0
    end
    object Edt_Nome: TEdit
      Left = 96
      Top = 44
      Width = 120
      Height = 21
      TabOrder = 1
    end
    object Edt_Custo: TCurrencyEdit
      Left = 96
      Top = 71
      Width = 120
      Height = 21
      TabOrder = 2
      Text = '0,00'
      FormatMask = '###,##0.00'
    end
    object Edt_Venda: TCurrencyEdit
      Left = 96
      Top = 98
      Width = 120
      Height = 21
      TabOrder = 3
      Text = '0,00'
      FormatMask = '###,##0.00'
    end
    object Edt_Medidas: TEdit
      Left = 304
      Top = 16
      Width = 121
      Height = 21
      TabOrder = 4
    end
    object Edt_Tecido: TEdit
      Left = 304
      Top = 44
      Width = 121
      Height = 21
      TabOrder = 5
    end
    object Edt_Madeira: TEdit
      Left = 304
      Top = 71
      Width = 121
      Height = 21
      TabOrder = 6
    end
    object Edt_Descricao: TMemo
      Left = 305
      Top = 171
      Width = 208
      Height = 57
      TabOrder = 7
    end
    object Edt_CodigoFornecedor: TEdit
      Left = 304
      Top = 98
      Width = 33
      Height = 21
      TabOrder = 8
      OnKeyPress = Edt_CodigoFornecedorKeyPress
    end
    object Edt_Fornecedor: TEdit
      Left = 343
      Top = 98
      Width = 155
      Height = 21
      Enabled = False
      TabOrder = 9
    end
    object btnProcurarFornecedor: TButton
      Left = 488
      Top = 98
      Width = 25
      Height = 21
      Caption = '...'
      TabOrder = 10
      OnClick = btnProcurarFornecedorClick
    end
    object Edt_CodigoCategoria: TEdit
      Left = 304
      Top = 125
      Width = 33
      Height = 21
      TabOrder = 11
      OnKeyPress = Edt_CodigoCategoriaKeyPress
    end
    object Edt_Categoria: TEdit
      Left = 343
      Top = 125
      Width = 155
      Height = 21
      Enabled = False
      TabOrder = 13
    end
    object btnProcurarCategoria: TButton
      Left = 488
      Top = 125
      Width = 25
      Height = 21
      Caption = '...'
      TabOrder = 12
      OnClick = btnProcurarCategoriaClick
    end
  end
  object Panel2: TPanel
    Left = 707
    Top = 0
    Width = 89
    Height = 249
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitHeight = 148
    object btnConfirmar: TButton
      Left = 6
      Top = 43
      Width = 75
      Height = 25
      Caption = 'Confirmar'
      TabOrder = 0
      OnClick = btnConfirmarClick
    end
    object btnCancelar: TButton
      Left = 6
      Top = 74
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 1
      OnClick = btnCancelarClick
    end
  end
end
