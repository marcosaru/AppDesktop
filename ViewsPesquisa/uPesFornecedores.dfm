object FrmPesFornecedor: TFrmPesFornecedor
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Fornecedores'
  ClientHeight = 449
  ClientWidth = 658
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = -8
    Top = 0
    Width = 553
    Height = 441
    TabOrder = 0
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 551
      Height = 439
      Align = alClient
      DataSource = DT
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDblClick = DBGrid1DblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'FOR_CODIGO'
          Title.Caption = 'C'#211'DIGO'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FOR_NOME'
          Title.Caption = 'NOME'
          Width = 160
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MUN_NOME'
          Title.Caption = 'MUNICIPIO'
          Width = 150
          Visible = True
        end>
    end
  end
  object pnlBotoes: TPanel
    Left = 554
    Top = 0
    Width = 104
    Height = 449
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    object btnCadastrar: TButton
      Left = 16
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Cadastrar'
      TabOrder = 0
      OnClick = btnCadastrarClick
    end
    object btnAlterar: TButton
      Left = 16
      Top = 55
      Width = 75
      Height = 25
      Caption = 'Alterar'
      TabOrder = 1
      OnClick = btnAlterarClick
    end
    object btnApresentar: TButton
      Left = 16
      Top = 86
      Width = 75
      Height = 25
      Caption = 'Apresentar'
      TabOrder = 2
      OnClick = btnApresentarClick
    end
    object btnCancelar: TButton
      Left = 16
      Top = 117
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 3
      OnClick = btnCancelarClick
    end
  end
  object DT: TDataSource
    DataSet = QryPesquisa
    Left = 592
    Top = 376
  end
  object QryPesquisa: TFDQuery
    Connection = fdmConexao.BANCO
    SQL.Strings = (
      'select for_codigo,for_nome,mun_nome from fornecedor'
      'join municipio on mun_codigo = for_municipio')
    Left = 592
    Top = 320
    object QryPesquisaFOR_CODIGO: TIntegerField
      FieldName = 'FOR_CODIGO'
      Origin = 'FOR_CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryPesquisaFOR_NOME: TStringField
      FieldName = 'FOR_NOME'
      Origin = 'FOR_NOME'
      Size = 100
    end
    object QryPesquisaMUN_NOME: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'MUN_NOME'
      Origin = 'MUN_NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
  end
end
