﻿object FrmCadFornecedor: TFrmCadFornecedor
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastrar Fornecedor'
  ClientHeight = 170
  ClientWidth = 586
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlCadastro: TPanel
    Left = 0
    Top = 0
    Width = 490
    Height = 170
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Código: TLabel
      Left = 21
      Top = 13
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
    end
    object Nome: TLabel
      Left = 27
      Top = 37
      Width = 27
      Height = 13
      Caption = 'Nome'
    end
    object Municipio: TLabel
      Left = 35
      Top = 95
      Width = 43
      Height = 13
      Caption = 'Municipio'
    end
    object Label1: TLabel
      Left = 7
      Top = 64
      Width = 72
      Height = 13
      Caption = 'Representante'
    end
    object Label2: TLabel
      Left = 10
      Top = 121
      Width = 69
      Height = 13
      Caption = 'Transportador'
    end
    object Edt_Codigo: TEdit
      Left = 85
      Top = 10
      Width = 33
      Height = 21
      Enabled = False
      TabOrder = 0
    end
    object Edt_Nome: TEdit
      Left = 85
      Top = 37
      Width = 158
      Height = 21
      TabOrder = 1
    end
    object Edt_CodigoMunicipio: TEdit
      Left = 85
      Top = 91
      Width = 33
      Height = 21
      NumbersOnly = True
      TabOrder = 3
      OnKeyPress = Edt_CodigoMunicipioKeyPress
    end
    object Edt_Municipio: TEdit
      Left = 123
      Top = 91
      Width = 121
      Height = 21
      Enabled = False
      TabOrder = 7
    end
    object btnProcurarMunicipio: TButton
      Left = 226
      Top = 91
      Width = 17
      Height = 21
      Caption = '...'
      TabOrder = 4
      OnClick = btnProcurarMunicipioClick
    end
    object Edt_representante: TEdit
      Left = 85
      Top = 64
      Width = 158
      Height = 21
      TabOrder = 2
    end
    object Edt_CodigoTransportador: TEdit
      Left = 85
      Top = 118
      Width = 33
      Height = 21
      NumbersOnly = True
      TabOrder = 5
      OnKeyPress = Edt_CodigoTransportadorKeyPress
    end
    object Edt_Transportador: TEdit
      Left = 123
      Top = 118
      Width = 121
      Height = 21
      Enabled = False
      TabOrder = 8
    end
    object btnProcurarTransportador: TButton
      Left = 225
      Top = 118
      Width = 17
      Height = 21
      Caption = '...'
      TabOrder = 6
      OnClick = btnProcurarTransportadorClick
    end
  end
  object Panel2: TPanel
    Left = 490
    Top = 0
    Width = 96
    Height = 170
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    object btnConfirmar: TButton
      Left = 12
      Top = 45
      Width = 75
      Height = 25
      Caption = 'Confirmar'
      TabOrder = 0
      OnClick = btnConfirmarClick
    end
    object btnCancelar: TButton
      Left = 12
      Top = 76
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 1
      OnClick = btnCancelarClick
    end
  end
end