object fmMainOfCEF: TfmMainOfCEF
  Left = 0
  Top = 0
  Caption = 'CEF'
  ClientHeight = 729
  ClientWidth = 1008
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object tmBye: TTimer
    Enabled = False
    OnTimer = tmByeTimer
    Left = 560
    Top = 372
  end
end
