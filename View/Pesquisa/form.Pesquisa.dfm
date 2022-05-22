object frmPesquisa: TfrmPesquisa
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Pesquisa'
  ClientHeight = 405
  ClientWidth = 739
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
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 723
    Height = 59
    Caption = 'Pesquisa'
    TabOrder = 0
    object edtConsulta: TEdit
      Left = 7
      Top = 24
      Width = 627
      Height = 21
      TabOrder = 0
    end
    object btnPesquisar: TBitBtn
      Left = 640
      Top = 22
      Width = 75
      Height = 25
      Caption = 'Pesquisar'
      TabOrder = 1
      OnClick = btnPesquisarClick
    end
  end
  object grid: TDBGrid
    Left = 8
    Top = 73
    Width = 723
    Height = 324
    DataSource = dsPesquisa
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgCancelOnExit, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = gridDblClick
    OnKeyDown = gridKeyDown
    Columns = <
      item
        Expanded = False
        Title.Alignment = taCenter
        Visible = True
      end
      item
        Expanded = False
        Title.Alignment = taCenter
        Visible = True
      end
      item
        Expanded = False
        Title.Alignment = taCenter
        Visible = True
      end
      item
        Expanded = False
        Title.Alignment = taCenter
        Visible = True
      end>
  end
  object memPesquisa: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 464
    Top = 144
  end
  object dsPesquisa: TDataSource
    DataSet = memPesquisa
    Left = 576
    Top = 136
  end
end
