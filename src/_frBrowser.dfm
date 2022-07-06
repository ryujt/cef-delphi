object frBrowser: TfrBrowser
  Left = 0
  Top = 0
  Width = 800
  Height = 600
  TabOrder = 0
  object CEFWindowParent: TCEFWindowParent
    Left = 0
    Top = 0
    Width = 800
    Height = 600
    Align = alClient
    TabOrder = 0
    DoubleBuffered = True
    ParentDoubleBuffered = False
    ExplicitTop = -3
  end
  object Chromium: TChromium
    OnAfterCreated = ChromiumAfterCreated
    Left = 27
    Top = 17
  end
  object tmStart: TTimer
    Enabled = False
    Interval = 500
    OnTimer = tmStartTimer
    Left = 79
    Top = 18
  end
end
