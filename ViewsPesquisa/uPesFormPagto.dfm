object FrmPesFormaPagamento: TFrmPesFormaPagamento
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Formas de Pagamentos'
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
    Left = 0
    Top = 0
    Width = 554
    Height = 449
    Align = alClient
    TabOrder = 0
    object Grid: TDBGrid
      Left = 1
      Top = 1
      Width = 552
      Height = 447
      Align = alClient
      DataSource = DataSource1
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDblClick = GridDblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'FORPAGTO_CODIGO'
          Title.Caption = 'C'#243'digo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FORPAGTO_DESCRICAO'
          Title.Caption = 'Descri'#231#227'o'
          Width = 300
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Av'
          Title.Caption = 'AVista'
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
  object DataSource1: TDataSource
    DataSet = QryPesquisa
    Left = 592
    Top = 376
  end
  object QryPesquisa: TFDQuery
    OnCalcFields = QryPesquisaCalcFields
    Connection = fdmConexao.BANCO
    SQL.Strings = (
      'select * from FormaPagto')
    Left = 592
    Top = 320
    object QryPesquisaFORPAGTO_CODIGO: TIntegerField
      FieldName = 'FORPAGTO_CODIGO'
      Origin = 'FORPAGTO_CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryPesquisaFORPAGTO_DESCRICAO: TStringField
      FieldName = 'FORPAGTO_DESCRICAO'
      Origin = 'FORPAGTO_DESCRICAO'
      Size = 100
    end
    object QryPesquisaFORPAGTO_AVISTA: TIntegerField
      FieldName = 'FORPAGTO_AVISTA'
      Origin = 'FORPAGTO_AVISTA'
    end
    object QryPesquisaAv: TStringField
      FieldKind = fkCalculated
      FieldName = 'Av'
      Size = 3
      Calculated = True
    end
  end
end
