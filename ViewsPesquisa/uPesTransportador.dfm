object FrmPesTransportador: TFrmPesTransportador
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Transportadoras'
  ClientHeight = 482
  ClientWidth = 744
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
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 640
    Height = 482
    Align = alClient
    TabOrder = 0
    object Grid: TDBGrid
      Left = 1
      Top = 1
      Width = 638
      Height = 480
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
          FieldName = 'TRANS_CODIGO'
          Title.Caption = 'C'#243'digo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TRANS_NOME'
          Title.Caption = 'Nome'
          Width = 220
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TRANS_TELEFONE'
          Title.Caption = 'Telefone'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TRANS_ENDERECO'
          Title.Caption = 'Endere'#231'o'
          Width = 175
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MUN_NOME'
          Title.Caption = 'Municipio'
          Width = 100
          Visible = True
        end>
    end
  end
  object pnlBotoes: TPanel
    Left = 640
    Top = 0
    Width = 104
    Height = 482
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
    Connection = fdmConexao.BANCO
    SQL.Strings = (
      'select t.*, mun_nome from transportador as t '
      'join municipio on mun_codigo = trans_municipio')
    Left = 592
    Top = 320
    object QryPesquisaTRANS_CODIGO: TIntegerField
      FieldName = 'TRANS_CODIGO'
      Origin = 'TRANS_CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryPesquisaTRANS_TELEFONE: TStringField
      FieldName = 'TRANS_TELEFONE'
      Origin = 'TRANS_TELEFONE'
      Size = 50
    end
    object QryPesquisaTRANS_NOME: TStringField
      FieldName = 'TRANS_NOME'
      Origin = 'TRANS_NOME'
      Size = 100
    end
    object QryPesquisaTRANS_ENDERECO: TStringField
      FieldName = 'TRANS_ENDERECO'
      Origin = 'TRANS_ENDERECO'
      Size = 100
    end
    object QryPesquisaTRANS_MUNICIPIO: TIntegerField
      FieldName = 'TRANS_MUNICIPIO'
      Origin = 'TRANS_MUNICIPIO'
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
