object Login: TLogin
  Left = 0
  Top = 0
  Caption = 'Login'
  ClientHeight = 241
  ClientWidth = 563
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnGerente: TPanel
    Left = 8
    Top = 8
    Width = 177
    Height = 225
    TabOrder = 0
    Visible = False
    object LbSenhaGer: TLabel
      Left = 21
      Top = 106
      Width = 30
      Height = 13
      Caption = 'Senha'
    end
    object lbLoginGer: TLabel
      Left = 21
      Top = 58
      Width = 19
      Height = 13
      Caption = 'CPF'
    end
    object Label1: TLabel
      Left = 21
      Top = 9
      Width = 74
      Height = 25
      Caption = 'Gerente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object btGerenteLogin: TButton
      Left = 21
      Top = 160
      Width = 75
      Height = 25
      Caption = 'Logar'
      TabOrder = 2
      OnClick = btGerenteLoginClick
    end
    object edGerenteSenha: TEdit
      Left = 21
      Top = 125
      Width = 121
      Height = 21
      TabOrder = 1
    end
    object btVoltarG: TButton
      Left = 128
      Top = 192
      Width = 41
      Height = 25
      Caption = 'Voltar'
      TabOrder = 3
      OnClick = btVoltarCClick
    end
    object medGerenteCPF: TMaskEdit
      Left = 21
      Top = 77
      Width = 120
      Height = 21
      EditMask = '999\.999\.999\-00;0;_'
      MaxLength = 14
      TabOrder = 0
      Text = ''
    end
  end
  object pnCliente: TPanel
    Left = 191
    Top = 8
    Width = 177
    Height = 225
    TabOrder = 2
    Visible = False
    object LbLoginCli: TLabel
      Left = 21
      Top = 58
      Width = 19
      Height = 13
      Caption = 'CPF'
    end
    object LbSenhaCli: TLabel
      Left = 21
      Top = 106
      Width = 30
      Height = 13
      Caption = 'Senha'
    end
    object Label2: TLabel
      Left = 21
      Top = 9
      Width = 64
      Height = 25
      Caption = 'Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edClienteSenha: TEdit
      Left = 21
      Top = 125
      Width = 121
      Height = 21
      TabOrder = 0
      Text = '1234'
    end
    object btClienteLogin: TButton
      Left = 20
      Top = 160
      Width = 75
      Height = 25
      Caption = 'Logar'
      TabOrder = 1
      OnClick = btClienteLoginClick
    end
    object btVoltarC: TButton
      Left = 128
      Top = 192
      Width = 41
      Height = 25
      Caption = 'Voltar'
      TabOrder = 2
      OnClick = btVoltarCClick
    end
    object medClienteCPF: TMaskEdit
      Left = 21
      Top = 79
      Width = 119
      Height = 21
      EditMask = '999\.999\.999\-00;0;_'
      MaxLength = 14
      TabOrder = 3
      Text = '00000000000'
    end
  end
  object pnPrincipal: TPanel
    Left = 374
    Top = 8
    Width = 177
    Height = 225
    TabOrder = 1
    object btATM: TButton
      Left = 24
      Top = 34
      Width = 121
      Height = 63
      Caption = 'ATM'
      TabOrder = 0
      OnClick = btATMClick
    end
    object btGerente: TButton
      Left = 24
      Top = 122
      Width = 121
      Height = 63
      Caption = 'Gerente'
      TabOrder = 1
      OnClick = btGerenteClick
    end
  end
end
