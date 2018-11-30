object frmATM: TfrmATM
  Left = 0
  Top = 0
  Caption = 'ATM'
  ClientHeight = 294
  ClientWidth = 534
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object lbCPFCliente: TLabel
    Left = 24
    Top = 13
    Width = 63
    Height = 13
    Caption = 'CPF CLIENTE'
  end
  object lbSaldo: TLabel
    Left = 24
    Top = 32
    Width = 30
    Height = 13
    Caption = 'Saldo:'
  end
  object pnExtrato: TPanel
    Left = 159
    Top = 64
    Width = 361
    Height = 214
    TabOrder = 8
    Visible = False
    object Label7: TLabel
      Left = 35
      Top = 20
      Width = 57
      Height = 13
      Caption = 'Data Inicial:'
    end
    object Label8: TLabel
      Left = 199
      Top = 20
      Width = 57
      Height = 13
      Caption = 'Data Limite:'
    end
    object btReaExtrato: TButton
      Left = 108
      Top = 165
      Width = 117
      Height = 25
      Caption = 'Realizar Extrato'
      TabOrder = 0
    end
    object lstExtrato: TListBox
      Left = 108
      Top = 66
      Width = 121
      Height = 97
      ItemHeight = 13
      TabOrder = 1
    end
    object medDatLim: TMaskEdit
      Left = 199
      Top = 35
      Width = 121
      Height = 21
      TabOrder = 2
      Text = ''
    end
    object medDatIni: TMaskEdit
      Left = 35
      Top = 35
      Width = 121
      Height = 21
      TabOrder = 3
      Text = ''
    end
  end
  object pnDeposito: TPanel
    Left = 159
    Top = 64
    Width = 361
    Height = 214
    TabOrder = 6
    Visible = False
    object Label2: TLabel
      Left = 35
      Top = 42
      Width = 28
      Height = 13
      Caption = 'Valor:'
    end
    object medDeposito: TMaskEdit
      Left = 69
      Top = 39
      Width = 52
      Height = 21
      EditMask = '99999\,99;1;_'
      MaxLength = 8
      TabOrder = 0
      Text = '     ,  '
    end
    object btDepositar: TButton
      Left = 35
      Top = 134
      Width = 75
      Height = 25
      Caption = 'Depositar'
      TabOrder = 1
      OnClick = btDepositarClick
    end
  end
  object pnSaque: TPanel
    Left = 159
    Top = 64
    Width = 361
    Height = 214
    TabOrder = 4
    Visible = False
    object Label1: TLabel
      Left = 27
      Top = 58
      Width = 28
      Height = 13
      Caption = 'Valor:'
    end
    object medSaque: TMaskEdit
      Left = 61
      Top = 55
      Width = 58
      Height = 21
      EditMask = '99999\,99;1;_'
      MaxLength = 8
      TabOrder = 0
      Text = '     ,  '
    end
    object btSacar: TButton
      Left = 27
      Top = 150
      Width = 75
      Height = 25
      Caption = 'Sacar'
      TabOrder = 1
      OnClick = btSacarClick
    end
  end
  object pnTrans: TPanel
    Left = 159
    Top = 64
    Width = 361
    Height = 214
    TabOrder = 7
    Visible = False
    object lbTrans: TLabel
      Left = 35
      Top = 124
      Width = 76
      Height = 13
      Caption = 'Transferir para:'
      Visible = False
    end
    object lbValorTrans: TLabel
      Left = 35
      Top = 66
      Width = 28
      Height = 13
      Caption = 'Valor:'
      Visible = False
    end
    object Button1: TButton
      Left = 35
      Top = 18
      Width = 121
      Height = 34
      Caption = 'Para esta conta'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 199
      Top = 18
      Width = 130
      Height = 34
      Caption = 'Para outra conta'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = Button2Click
    end
    object medCPFTrans: TMaskEdit
      Left = 35
      Top = 143
      Width = 102
      Height = 21
      EditMask = '999\.999\.999\-00;0;_'
      MaxLength = 14
      TabOrder = 2
      Text = ''
      Visible = False
    end
    object rgTransConta: TRadioGroup
      Left = 235
      Top = 66
      Width = 94
      Height = 95
      Caption = 'Transferir para:'
      Items.Strings = (
        'CC'
        'CP')
      TabOrder = 3
      Visible = False
    end
    object medValorTrans: TMaskEdit
      Left = 35
      Top = 85
      Width = 67
      Height = 21
      EditMask = '99999\,99;1;_'
      MaxLength = 8
      TabOrder = 4
      Text = '     ,  '
      Visible = False
    end
    object btTrans: TButton
      Left = 35
      Top = 177
      Width = 294
      Height = 25
      Caption = 'Transferir'
      TabOrder = 5
      OnClick = btTransClick
    end
  end
  object btSaque: TButton
    Left = 24
    Top = 64
    Width = 129
    Height = 49
    Caption = 'Saque'
    Enabled = False
    TabOrder = 0
    OnClick = btSaqueClick
  end
  object btTransferencia: TButton
    Left = 24
    Top = 119
    Width = 129
    Height = 49
    Caption = 'Transfer'#234'ncia'
    Enabled = False
    TabOrder = 1
    OnClick = btTransferenciaClick
  end
  object btDeposito: TButton
    Left = 24
    Top = 174
    Width = 129
    Height = 49
    Caption = 'Dep'#243'sito'
    Enabled = False
    TabOrder = 2
    OnClick = btDepositoClick
  end
  object btExtrato: TButton
    Left = 24
    Top = 229
    Width = 129
    Height = 49
    Caption = 'Extrato'
    Enabled = False
    TabOrder = 3
    OnClick = btExtratoClick
  end
  object rgConta: TRadioGroup
    Left = 159
    Top = 8
    Width = 361
    Height = 50
    Caption = 'Selecione a conta:'
    Columns = 3
    Items.Strings = (
      'Corrente'
      'Sal'#225'rio'
      'Poupan'#231'a')
    TabOrder = 5
    OnClick = rgContaClick
  end
end
