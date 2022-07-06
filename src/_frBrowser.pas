unit _frBrowser;

interface

uses
  FrameBase, JsonData, Disk,
  uCEFApplication, uCEFInterfaces, uCEFTypes, uCEFStringVisitor, uCEFCookieManager,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, uCEFWinControl, uCEFWindowParent, uCEFChromiumCore, uCEFChromium;

type
  TfrBrowser = class(TFrame)
    Chromium: TChromium;
    CEFWindowParent: TCEFWindowParent;
    tmStart: TTimer;
    procedure ChromiumAfterCreated(Sender: TObject; const browser: ICefBrowser);
    procedure tmStartTimer(Sender: TObject);
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure StartBrowser;
  end;

implementation

uses
  Core;

{$R *.dfm}

{ TfrBrowser }

procedure TfrBrowser.ChromiumAfterCreated(Sender: TObject;
  const browser: ICefBrowser);
begin
  tmStart.Enabled := true;
end;

constructor TfrBrowser.Create(AOwner: TComponent);
begin
  inherited;

  TCore.Obj.View.Add(Self);
end;

destructor TfrBrowser.Destroy;
begin
  TCore.Obj.View.Remove(Self);

  inherited;
end;

procedure TfrBrowser.StartBrowser;
begin
  Chromium.CreateBrowser(CEFWindowParent);
end;

procedure TfrBrowser.tmStartTimer(Sender: TObject);
begin
  tmStart.Enabled := false;
  Chromium.LoadURL(GetExecPath + 'index.html');
end;

end.