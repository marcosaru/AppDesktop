object FrmPesCategoria: TFrmPesCategoria
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Categorias'
  ClientHeight = 505
  ClientWidth = 354
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
    Width = 354
    Height = 464
    Align = alClient
    TabOrder = 0
    object Grid: TDBGrid
      Left = 1
      Top = 1
      Width = 352
      Height = 462
      Align = alClient
      DataSource = DTSPesquisa
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
          FieldName = 'CAT_CODIGO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Title.Caption = 'C'#243'digo'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CAT_DESCRICAO'
          Title.Caption = 'Descri'#231#227'o'
          Width = 248
          Visible = True
        end>
    end
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 464
    Width = 354
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btnCadastrar: TButton
      Left = 16
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Ca&dastrar'
      TabOrder = 0
      OnClick = btnCadastrarClick
    end
    object Button1: TButton
      Left = 104
      Top = 6
      Width = 75
      Height = 25
      Caption = '&Alterar'
      TabOrder = 1
      OnClick = Button1Click
    end
    object Button3: TButton
      Left = 16
      Top = 117
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 2
    end
    object btnCancelar: TButton
      Left = 264
      Top = 5
      Width = 75
      Height = 25
      Caption = '&Cancelar'
      TabOrder = 3
      OnClick = btnCancelarClick
    end
  end
  object QryPesquisa: TFDQuery
    Connection = fdmConexao.BANCO
    SQL.Strings = (
      'select * from categoria')
    Left = 592
    Top = 320
    object QryPesquisaCAT_CODIGO: TIntegerField
      FieldName = 'CAT_CODIGO'
      Origin = 'CAT_CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryPesquisaCAT_DESCRICAO: TStringField
      FieldName = 'CAT_DESCRICAO'
      Origin = 'CAT_DESCRICAO'
      Size = 40
    end
  end
  object DTSPesquisa: TDataSource
    DataSet = QryPesquisa
    Left = 216
    Top = 464
  end
end
