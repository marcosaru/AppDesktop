object FrmPesMunicipio: TFrmPesMunicipio
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Municipios'
  ClientHeight = 395
  ClientWidth = 582
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
      DataSource = DtsMunicipio
      Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
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
          FieldName = 'MUN_CODIGO'
          Title.Caption = 'C'#211'DIGO'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MUN_NOME'
          Title.Caption = 'NOME'
          Width = 300
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EST_NOME'
          Title.Caption = 'ESTADO'
          Visible = True
        end>
    end
  end
  object pnlBotoes: TPanel
    Left = 478
    Top = 0
    Width = 104
    Height = 395
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
    object Button1: TButton
      Left = 16
      Top = 55
      Width = 75
      Height = 25
      Caption = 'Alterar'
      TabOrder = 1
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 16
      Top = 86
      Width = 75
      Height = 25
      Caption = 'Apresentar'
      TabOrder = 2
      OnClick = Button2Click
    end
    object btnCancelar: TButton
      Left = 16
      Top = 117
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      ModalResult = 2
      TabOrder = 3
    end
  end
  object DtsMunicipio: TDataSource
    DataSet = QryPesquisa
    Left = 520
    Top = 328
  end
  object QryPesquisa: TFDQuery
    Connection = fdmConexao.BANCO
    SQL.Strings = (
      'select mun_Codigo,mun_nome,est_nome from municipio'
      'join estado on mun_estado = est_codigo')
    Left = 520
    Top = 264
    object QryPesquisaMUN_CODIGO: TIntegerField
      FieldName = 'MUN_CODIGO'
      Origin = 'MUN_CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryPesquisaMUN_NOME: TStringField
      FieldName = 'MUN_NOME'
      Origin = 'MUN_NOME'
      Size = 100
    end
    object QryPesquisaEST_NOME: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'EST_NOME'
      Origin = 'EST_NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 2
    end
  end
end
