unit JavaScript;

interface

uses
  HandleComponent,
  Windows, Messages, SysUtils, Classes, Dialogs;

type
  TJSExtension = class
    class function version:string;
    class procedure postMessage(msg:string);
  end;

  TJavaScript = class (THandleComponent)
  private
    procedure WMCopyData(var Msg:TWMCopyData); message WM_COPYDATA;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    class function Obj:TJavaScript;

    procedure SendString(const AText:ansistring);
  end;

implementation

uses
  Globals;

{ TJSExtension }

class function TJSExtension.version: string;
begin
  Result := '1.0';
end;

class procedure TJSExtension.postMessage(msg:string);
begin
  TJavaScript.Obj.SendString(msg);
end;

{ TJavaScript }

var
  MyObject : TJavaScript = nil;

class function TJavaScript.Obj: TJavaScript;
begin
  if MyObject = nil then MyObject := TJavaScript.Create(nil);
  Result := MyObject;
end;

procedure TJavaScript.SendString(const AText: ansistring);
var
  receiverHandle : THandle;
  copyDataStruct : TCopyDataStruct;
begin
  receiverHandle := FindWindow('TfmMainOfCEF', nil);
  if receiverHandle = 0 then Exit;

  copyDataStruct.dwData := 0;
  copyDataStruct.cbData := 1 + Length(AText);
  copyDataStruct.lpData := PAnsiChar(AText);
  SendMessage(receiverHandle, WM_COPYDATA, integer(Handle), Integer(@copyDataStruct));
end;

procedure TJavaScript.WMCopyData(var Msg: TWMCopyData);
var
  text : ansistring;
begin
  text := PAnsiChar(Msg.CopyDataStruct.lpData);
end;

constructor TJavaScript.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TJavaScript.Destroy;
begin

  inherited;
end;

{ TJSExtension }

initialization
  MyObject := TJavaScript.Create(nil);
end.