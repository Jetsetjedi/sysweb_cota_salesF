object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Bootstrap Server'
  ClientHeight = 287
  ClientWidth = 498
  Color = clBtnFace
  Constraints.MinHeight = 240
  Constraints.MinWidth = 480
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object TopPanel: TPanel
    Left = 0
    Top = 0
    Width = 498
    Height = 73
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 28
      Top = 17
      Width = 63
      Height = 13
      Caption = 'Port number:'
    end
    object StartButton: TButton
      Left = 16
      Top = 41
      Width = 75
      Height = 25
      Action = StartServerAction
      TabOrder = 0
    end
    object StopButton: TButton
      Left = 104
      Top = 41
      Width = 75
      Height = 25
      Action = StopServerAction
      TabOrder = 1
    end
    object PortNumberEdit: TEdit
      Left = 97
      Top = 14
      Width = 82
      Height = 21
      TabOrder = 2
      OnChange = PortNumberEditChange
    end
  end
  object MainTreeView: TTreeView
    Left = 0
    Top = 73
    Width = 498
    Height = 128
    Indent = 19
    TabOrder = 1
  end
  object mlogserver: TMemo
    Left = 0
    Top = 202
    Width = 498
    Height = 84
    Lines.Strings = (
      '')
    TabOrder = 2
  end
  object MainActionList: TActionList
    Left = 416
    Top = 8
    object StartServerAction: TAction
      Caption = 'Start Server'
      OnExecute = StartServerActionExecute
      OnUpdate = StartServerActionUpdate
    end
    object StopServerAction: TAction
      Caption = 'Stop Server'
      OnExecute = StopServerActionExecute
      OnUpdate = StopServerActionUpdate
    end
  end
  object CDascext: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'caracter'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'ascord'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'DataSetProvider1'
    StoreDefs = True
    Left = 256
    Top = 16
    object CDascextcaracter: TStringField
      FieldName = 'caracter'
      ProviderFlags = []
      Size = 1
    end
    object CDascextascord: TIntegerField
      FieldName = 'ascord'
      ProviderFlags = []
    end
  end
end
