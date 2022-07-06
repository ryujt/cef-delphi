unit _fmMain;

interface

uses
  DebugTools, JsonData, Disk,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uCEFChromium,
  uCEFWinControl, uCEFWindowParent, Vcl.ExtCtrls, uCEFChromiumCore, _frBrowser;

type
  TfmMainOfCEF = class(TForm)
    tmBye: TTimer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tmByeTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FBrowser : TfrBrowser;
    procedure WMCopyData(var Msg:TWMCopyData); message WM_COPYDATA;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    procedure rp_Say(AParams:TJsonData);
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
  FBrowser.Free;
  TCore.Obj.Finalize;
  tmBye.Enabled := true;
end;

procedure TfmMainOfCEF.FormShow(Sender: TObject);
begin
  FBrowser := TfrBrowser.Create(Self);
  FBrowser.Parent := Self;
  FBrowser.Align := alClient;
  FBrowser.StartBrowser;
end;

procedure TfmMainOfCEF.rp_Say(AParams: TJsonData);
begin
  ShowMessage(AParams.Values['msg']);
end;

procedure TfmMainOfCEF.tmByeTimer(Sender: TObject);
begin
  tmBye.Enabled := false;
  Application.Terminate;
end;

procedure TfmMainOfCEF.WMCopyData(var Msg: TWMCopyData);
var
  text : ansistring;
begin
  text := PAnsiChar(Msg.CopyDataStruct.lpData);
  TCore.Obj.View.AsyncBroadcast(text);
end;

end.
