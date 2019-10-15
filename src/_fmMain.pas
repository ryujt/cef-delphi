unit _fmMain;

interface

uses
  JsonData, Disk,
  uCEFApplication, uCEFInterfaces, uCEFTypes, uCEFStringVisitor, uCEFCookieManager,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uCEFChromium,
  uCEFWinControl, uCEFWindowParent, Vcl.ExtCtrls;

type
  TfmMainOfCEF = class(TForm)
    CEFWindowParent: TCEFWindowParent;
    Chromium: TChromium;
    tmStart: TTimer;
    tmBye: TTimer;
    procedure FormShow(Sender: TObject);
    procedure tmStartTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tmByeTimer(Sender: TObject);
  private
    procedure WMCopyData(var Msg:TWMCopyData); message WM_COPYDATA;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    procedure rp_GoHome(AJsonData:TJsonData);
  end;

var
  fmMainOfCEF: TfmMainOfCEF;

implementation

uses
  Core;

{$R *.dfm}

constructor TfmMainOfCEF.Create(AOwner: TComponent);
begin
  inherited;

  Chromium.Options.FileAccessFromFileUrls := STATE_ENABLED;
  Chromium.Options.WebSecurity := STATE_DISABLED;

  TCore.Obj.View.Add(Self);
end;

destructor TfmMainOfCEF.Destroy;
begin
  TCore.Obj.View.Remove(Self);

  inherited;
end;

procedure TfmMainOfCEF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caNone;
  Hide;
  tmBye.Enabled := true;
end;

procedure TfmMainOfCEF.FormShow(Sender: TObject);
begin
  Chromium.CreateBrowser(CEFWindowParent);
  tmStart.Enabled := true;
end;

procedure TfmMainOfCEF.rp_GoHome(AJsonData: TJsonData);
begin
  Chromium.LoadURL(GetExecPath + 'index.html');
end;

procedure TfmMainOfCEF.tmByeTimer(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfmMainOfCEF.tmStartTimer(Sender: TObject);
begin
  rp_GoHome(nil);
end;

procedure TfmMainOfCEF.WMCopyData(var Msg: TWMCopyData);
var
  text : ansistring;
begin
  text := PAnsiChar(Msg.CopyDataStruct.lpData);
  TCore.Obj.View.AsyncBroadcast(text);
end;

end.
