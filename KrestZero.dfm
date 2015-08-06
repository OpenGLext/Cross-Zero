object Form1: TForm1
  Left = 592
  Top = 150
  BorderIcons = [biSystemMenu]
  Caption = 'Cross-Zero v0.1'
  ClientHeight = 429
  ClientWidth = 281
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object CanvaField: TImage
    Left = 0
    Top = 0
    Width = 281
    Height = 429
    Align = alClient
    Proportional = True
    Transparent = True
    OnMouseDown = CanvaFieldMouseDown
    ExplicitLeft = 8
    ExplicitTop = 8
    ExplicitWidth = 250
    ExplicitHeight = 250
  end
  object Label1: TLabel
    Left = 32
    Top = 272
    Width = 3
    Height = 13
  end
  object sound: TMediaPlayer
    Left = 8
    Top = 320
    Width = 253
    Height = 30
    AutoEnable = False
    Visible = False
    TabOrder = 0
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 80
    Top = 104
  end
  object MainMenu1: TMainMenu
    Left = 120
    Top = 208
    object N1: TMenuItem
      Caption = #1048#1075#1088#1072
      object N2: TMenuItem
        Caption = #1057#1090#1072#1088#1090
        OnClick = Button1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object N4: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        OnClick = Button3Click
      end
    end
    object N5: TMenuItem
      Caption = #1042#1072#1088#1080#1072#1085#1090' '#1080#1075#1088#1099
      object N10: TMenuItem
        Caption = #1050#1086#1084#1087#1100#1102#1090#1077#1088'-'#1048#1075#1088#1086#1082
        OnClick = N10Click
      end
      object N7: TMenuItem
        Caption = #1048#1075#1088#1086#1082'-'#1050#1086#1084#1087#1100#1102#1090#1077#1088
        OnClick = N7Click
      end
      object N6: TMenuItem
        Caption = #1048#1075#1088#1086#1082'-'#1048#1075#1088#1086#1082
        Checked = True
        OnClick = N6Click
      end
    end
    object N8: TMenuItem
      Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      object N9: TMenuItem
        Caption = #1040#1074#1090#1086#1088
      end
    end
  end
end
