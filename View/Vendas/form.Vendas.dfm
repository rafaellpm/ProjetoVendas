object frmVendas: TfrmVendas
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Vendas'
  ClientHeight = 488
  ClientWidth = 867
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object s: TPanel
    Left = 0
    Top = 0
    Width = 867
    Height = 62
    Align = alTop
    TabOrder = 0
    object btnGravar: TBitBtn
      Left = 8
      Top = 3
      Width = 65
      Height = 54
      Caption = 'Gravar'
      TabOrder = 0
      TabStop = False
      OnClick = btnGravarClick
    end
    object btnCancelar: TBitBtn
      Left = 150
      Top = 3
      Width = 65
      Height = 54
      Caption = 'Cancelar'
      TabOrder = 2
      OnClick = btnCancelarClick
    end
    object btnPesquisar: TBitBtn
      Left = 79
      Top = 3
      Width = 65
      Height = 54
      Caption = 'Pesquisar'
      TabOrder = 1
      TabStop = False
      OnClick = btnPesquisarClick
    end
    object btnFechar: TBitBtn
      Left = 793
      Top = 3
      Width = 65
      Height = 54
      Caption = 'Fechar'
      TabOrder = 3
      TabStop = False
      OnClick = btnFecharClick
    end
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 68
    Width = 850
    Height = 69
    Caption = 'Dados Gerais'
    TabOrder = 1
    object Label6: TLabel
      Left = 9
      Top = 19
      Width = 59
      Height = 13
      Caption = 'Cod. Cliente'
    end
    object Label7: TLabel
      Left = 136
      Top = 19
      Width = 97
      Height = 13
      Caption = 'Nome / Raz'#227'o Social'
    end
    object Label8: TLabel
      Left = 680
      Top = 19
      Width = 62
      Height = 13
      Caption = 'Data Cria'#231#227'o'
    end
    object edtCodCliente: TEdit
      Left = 9
      Top = 33
      Width = 121
      Height = 21
      TabOrder = 0
      OnExit = edtCodClienteExit
      OnKeyDown = edtCodClienteKeyDown
    end
    object edtNomeCliente: TEdit
      Left = 133
      Top = 33
      Width = 541
      Height = 21
      TabStop = False
      Color = clGradientActiveCaption
      TabOrder = 1
    end
    object edtDataCriacao: TEdit
      Left = 680
      Top = 33
      Width = 163
      Height = 21
      TabStop = False
      Color = clGradientActiveCaption
      TabOrder = 2
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 145
    Width = 850
    Height = 336
    Caption = 'Produtos'
    TabOrder = 2
    object Label1: TLabel
      Left = 9
      Top = 16
      Width = 110
      Height = 13
      Caption = 'Cod. Interno / Cod Bar'
    end
    object Label2: TLabel
      Left = 133
      Top = 16
      Width = 102
      Height = 13
      Caption = 'Descri'#231#227'o do Produto'
    end
    object Label3: TLabel
      Left = 598
      Top = 16
      Width = 18
      Height = 13
      Caption = 'Qtd'
    end
    object Label4: TLabel
      Left = 667
      Top = 16
      Width = 52
      Height = 13
      Caption = 'Vl. Unit'#225'rio'
    end
    object Label5: TLabel
      Left = 736
      Top = 16
      Width = 39
      Height = 13
      Caption = 'Vl. Total'
    end
    object Label9: TLabel
      Left = 672
      Top = 302
      Width = 81
      Height = 13
      Caption = 'TOTAL PEDIDO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtCodProduto: TEdit
      Left = 9
      Top = 31
      Width = 121
      Height = 21
      TabOrder = 0
      OnExit = edtCodProdutoExit
      OnKeyDown = edtCodProdutoKeyDown
    end
    object edtDescricao: TEdit
      Left = 133
      Top = 31
      Width = 459
      Height = 21
      TabStop = False
      Color = clGradientActiveCaption
      ReadOnly = True
      TabOrder = 1
    end
    object edtQuantidade: TEdit
      Left = 598
      Top = 31
      Width = 66
      Height = 21
      TabOrder = 2
      Text = '1'
      OnExit = edtQuantidadeExit
    end
    object edtValorUnitario: TEdit
      Left = 667
      Top = 31
      Width = 66
      Height = 21
      Color = clWhite
      TabOrder = 3
      Text = '0,00'
    end
    object edtValorTotal: TEdit
      Left = 736
      Top = 31
      Width = 66
      Height = 21
      TabStop = False
      Color = clGradientActiveCaption
      ReadOnly = True
      TabOrder = 4
      Text = '0,00'
    end
    object btnInserirProduto: TBitBtn
      Left = 804
      Top = 29
      Width = 39
      Height = 25
      TabOrder = 5
      OnClick = btnInserirProdutoClick
    end
    object DBGrid1: TDBGrid
      Left = 9
      Top = 58
      Width = 834
      Height = 231
      TabStop = False
      DataSource = dsItens
      Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 6
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDblClick = DBGrid1DblClick
      OnKeyDown = DBGrid1KeyDown
      Columns = <
        item
          Expanded = False
          FieldName = 'CD_PRODUTO'
          Title.Alignment = taCenter
          Title.Caption = 'Codigo'
          Width = 73
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCRICAO'
          Title.Alignment = taCenter
          Title.Caption = 'Descri'#231#227'o Produto'
          Width = 487
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QUANTIDADE'
          Title.Alignment = taCenter
          Title.Caption = 'Quantidade'
          Width = 72
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALOR_UNITARIO'
          Title.Alignment = taCenter
          Title.Caption = 'R$ Unit'#225'rio'
          Width = 78
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALOR_TOTAL'
          Title.Alignment = taCenter
          Title.Caption = 'R$ Total'
          Width = 82
          Visible = True
        end>
    end
    object edtTotalPedido: TEdit
      Left = 759
      Top = 294
      Width = 84
      Height = 27
      TabStop = False
      Alignment = taRightJustify
      Color = clGradientActiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 7
      Text = '0,00'
    end
  end
  object memItens: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 752
    Top = 247
    object memItensID: TIntegerField
      FieldName = 'ID'
    end
    object memItensCD_PRODUTO: TIntegerField
      FieldName = 'CD_PRODUTO'
    end
    object memItensDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 255
    end
    object memItensQUANTIDADE: TCurrencyField
      FieldName = 'QUANTIDADE'
    end
    object memItensVALOR_UNITARIO: TCurrencyField
      FieldName = 'VALOR_UNITARIO'
    end
    object memItensVALOR_TOTAL: TCurrencyField
      FieldName = 'VALOR_TOTAL'
    end
    object memItensDT_INCLUSAO: TDateTimeField
      FieldName = 'DT_INCLUSAO'
    end
    object memItensNR_PEDIDO: TIntegerField
      FieldName = 'NR_PEDIDO'
    end
  end
  object dsItens: TDataSource
    DataSet = memItens
    Left = 804
    Top = 239
  end
end
