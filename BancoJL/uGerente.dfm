object frmGerente: TfrmGerente
  Left = 0
  Top = 0
  Caption = 'frmGerente'
  ClientHeight = 314
  ClientWidth = 481
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pcGerente: TPageControl
    Left = 0
    Top = 0
    Width = 481
    Height = 314
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 485
    object TabSheet1: TTabSheet
      Caption = 'TabSheet1'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label1: TLabel
        Left = 27
        Top = 19
        Width = 23
        Height = 13
        Caption = 'CPF:'
      end
      object medCPF: TMaskEdit
        Left = 56
        Top = 16
        Width = 85
        Height = 21
        EditMask = '999\.999\.999\-99;0;_'
        MaxLength = 14
        TabOrder = 0
        Text = ''
      end
      object ledNome: TLabeledEdit
        Left = 56
        Top = 56
        Width = 297
        Height = 21
        EditLabel.Width = 31
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome:'
        LabelPosition = lpLeft
        LabelSpacing = 5
        TabOrder = 1
      end
      object ledSenha: TLabeledEdit
        Left = 56
        Top = 96
        Width = 121
        Height = 21
        EditLabel.Width = 34
        EditLabel.Height = 13
        EditLabel.Caption = 'Senha:'
        LabelPosition = lpLeft
        LabelSpacing = 5
        TabOrder = 2
      end
      object btCadastro: TButton
        Left = 56
        Top = 234
        Width = 177
        Height = 41
        Caption = 'Cadastrar'
        TabOrder = 3
        OnClick = btCadastroClick
      end
      object cbCCorrente: TCheckBox
        Left = 56
        Top = 144
        Width = 97
        Height = 17
        Caption = 'Conta Corrente'
        TabOrder = 4
      end
      object cbCSalario: TCheckBox
        Left = 56
        Top = 167
        Width = 97
        Height = 17
        Caption = 'Conta Sal'#225'rio'
        TabOrder = 5
      end
      object cbCPoupanca: TCheckBox
        Left = 56
        Top = 190
        Width = 97
        Height = 17
        Caption = 'Conta Poupan'#231'a'
        TabOrder = 6
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'TabSheet2'
      ImageIndex = 2
      OnShow = TabSheet1Show
      ExplicitWidth = 477
      object sgClientes: TStringGrid
        Left = -4
        Top = 24
        Width = 466
        Height = 210
        ColCount = 7
        FixedCols = 0
        RowCount = 2
        TabOrder = 0
        OnClick = sgClientesClick
        ColWidths = (
          69
          63
          70
          64
          64
          54
          54)
      end
      object bbtRemover: TBitBtn
        Left = 3
        Top = 240
        Width = 230
        Height = 41
        Caption = 'Remover'
        Enabled = False
        TabOrder = 1
        OnClick = bbtRemoverClick
      end
      object bbtEditar: TBitBtn
        Left = 239
        Top = 240
        Width = 230
        Height = 41
        Caption = 'Editar'
        Enabled = False
        TabOrder = 2
        OnClick = bbtEditarClick
      end
    end
  end
end
