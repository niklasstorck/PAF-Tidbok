object dataform1: Tdataform1
  Left = 0
  Top = 0
  Caption = 'dataform1'
  ClientHeight = 645
  ClientWidth = 896
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
  object TidbokGrid: TDBGrid
    Left = 8
    Top = 8
    Width = 625
    Height = 481
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object MonthCalendar1: TMonthCalendar
    Left = 639
    Top = 8
    Width = 191
    Height = 160
    Date = 40673.427850752310000000
    TabOrder = 1
    OnClick = MonthCalendar1Click
  end
  object Edit1: TEdit
    Left = 8
    Top = 520
    Width = 713
    Height = 21
    TabOrder = 2
    Text = 'Edit1'
  end
  object Button1: TButton
    Left = 736
    Top = 568
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Query1: TADOQuery
    ConnectionString = 'Provider=MSDASQL.1;Persist Security Info=False;Data Source=PAF_3'
    Parameters = <>
    Left = 784
    Top = 320
  end
end
