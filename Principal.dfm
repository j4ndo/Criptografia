object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Criptografia'
  ClientHeight = 203
  ClientWidth = 345
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 4
    Width = 57
    Height = 13
    Caption = 'Texto Plano'
  end
  object Label2: TLabel
    Left = 8
    Top = 157
    Width = 98
    Height = 13
    Caption = 'Texto Criptografado'
  end
  object Label3: TLabel
    Left = 8
    Top = 46
    Width = 31
    Height = 13
    Caption = 'Chave'
  end
  object edtTextoPlano: TEdit
    Left = 8
    Top = 20
    Width = 329
    Height = 21
    TabOrder = 0
  end
  object edtTextoCriptografado: TEdit
    Left = 8
    Top = 174
    Width = 329
    Height = 21
    TabOrder = 4
  end
  object btnCriptografar: TBitBtn
    Left = 8
    Top = 98
    Width = 121
    Height = 38
    Caption = 'Criptografar'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 2
    OnClick = btnCriptografarClick
  end
  object btnDescriptografar: TBitBtn
    Left = 216
    Top = 98
    Width = 121
    Height = 38
    Caption = 'Descriptografar'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 3
    OnClick = btnDescriptografarClick
  end
  object edtChave: TEdit
    Left = 8
    Top = 63
    Width = 329
    Height = 21
    TabOrder = 1
  end
end
