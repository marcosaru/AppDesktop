object FrmPesProduto: TFrmPesProduto
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Produtos'
  ClientHeight = 608
  ClientWidth = 1086
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 1086
    Height = 544
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 675
    ExplicitHeight = 498
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 1084
      Height = 542
      Align = alClient
      DataSource = DTS
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDblClick = DBGrid1DblClick
      OnTitleClick = DBGrid1TitleClick
      Columns = <
        item
          Expanded = False
          FieldName = 'PRO_CODIGO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Title.Caption = 'CODIGO'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 52
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRO_NOME'
          Title.Caption = 'NOME'
          Width = 187
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FOR_NOME'
          Title.Caption = 'FORNECEDOR'
          Width = 103
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRO_VALORVENDA'
          Title.Caption = 'VALOR DE VENDA'
          Width = 96
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRO_MEDIDAS'
          Title.Caption = 'MEDIDAS'
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRO_TECIDO'
          Title.Caption = 'TECIDO'
          Width = 125
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRO_MADEIRA'
          Title.Caption = 'MADEIRA'
          Width = 123
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CAT_DESCRICAO'
          Title.Caption = 'Categoria'
          Width = 133
          Visible = True
        end>
    end
    object pnlBuscar: TPanel
      Left = 1
      Top = 376
      Width = 297
      Height = 105
      TabOrder = 1
      Visible = False
      OnExit = pnlBuscarExit
      object Label1: TLabel
        Left = 14
        Top = 27
        Width = 33
        Height = 13
        Caption = 'C'#243'digo'
      end
      object Label2: TLabel
        Left = 20
        Top = 54
        Width = 27
        Height = 13
        Caption = 'Nome'
      end
      object Edt_Nome: TEdit
        Left = 56
        Top = 51
        Width = 121
        Height = 21
        TabOrder = 0
        OnEnter = Edt_NomeEnter
        OnKeyPress = Edt_NomeKeyPress
      end
      object Edt_Codigo: TEdit
        Left = 56
        Top = 24
        Width = 121
        Height = 21
        NumbersOnly = True
        TabOrder = 1
        OnEnter = Edt_CodigoEnter
        OnKeyPress = Edt_CodigoKeyPress
      end
    end
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 544
    Width = 1086
    Height = 64
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 924
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
      Left = 97
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Alterar'
      TabOrder = 1
      OnClick = btnAlterarClick
    end
    object btnApresentar: TButton
      Left = 178
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Apresentar'
      TabOrder = 2
      OnClick = btnApresentarClick
    end
    object btnCancelar: TButton
      Left = 340
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 3
      OnClick = btnCancelarClick
    end
    object btnBuscar: TButton
      Left = 259
      Top = 24
      Width = 75
      Height = 25
      Caption = '&Buscar'
      TabOrder = 4
      OnClick = btnBuscarClick
    end
  end
  object DTS: TDataSource
    DataSet = QryPesquisa
    Left = 680
    Top = 312
  end
  object QryPesquisa: TFDQuery
    Connection = fdmConexao.BANCO
    SQL.Strings = (
      'select pro_codigo,pro_nome,for_nome,'
      'pro_custo,pro_valorvenda,pro_descricao,'
      'pro_medidas,pro_tecido,pro_madeira,cat_descricao'
      ' from produto'
      'join fornecedor on for_codigo = pro_fornecedor'
      'join categoria on cat_codigo = pro_categoria')
    Left = 680
    Top = 264
    object QryPesquisaPRO_CODIGO: TIntegerField
      FieldName = 'PRO_CODIGO'
      Origin = 'PRO_CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryPesquisaPRO_NOME: TStringField
      FieldName = 'PRO_NOME'
      Origin = 'PRO_NOME'
      Size = 100
    end
    object QryPesquisaFOR_NOME: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'FOR_NOME'
      Origin = 'FOR_NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
    object QryPesquisaPRO_CUSTO: TIntegerField
      FieldName = 'PRO_CUSTO'
      Origin = 'PRO_CUSTO'
    end
    object QryPesquisaPRO_VALORVENDA: TIntegerField
      FieldName = 'PRO_VALORVENDA'
      Origin = 'PRO_VALORVENDA'
    end
    object QryPesquisaPRO_DESCRICAO: TBlobField
      FieldName = 'PRO_DESCRICAO'
      Origin = 'PRO_DESCRICAO'
    end
    object QryPesquisaPRO_MEDIDAS: TStringField
      FieldName = 'PRO_MEDIDAS'
      Origin = 'PRO_MEDIDAS'
      Size = 100
    end
    object QryPesquisaPRO_TECIDO: TStringField
      FieldName = 'PRO_TECIDO'
      Origin = 'PRO_TECIDO'
      Size = 100
    end
    object QryPesquisaPRO_MADEIRA: TStringField
      FieldName = 'PRO_MADEIRA'
      Origin = 'PRO_MADEIRA'
      Size = 100
    end
    object QryPesquisaCAT_DESCRICAO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CAT_DESCRICAO'
      Origin = 'CAT_DESCRICAO'
      ProviderFlags = []
      ReadOnly = True
      Size = 40
    end
  end
end
