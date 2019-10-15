program cef;

uses
  uCEFApplication,
  uCEFv8Handler,
  Vcl.Forms,
  _fmMain in '_fmMain.pas' {fmMainOfCEF},
  Core in 'Core\Core.pas',
  View in 'Core\View.pas',
  JavaScript in 'Core\JavaScript.pas',
  Globals in 'Globals.pas';

{$R *.res}

begin
  GlobalCEFApp := TCefApplication.Create;
  GlobalCEFApp.EnableGPU := true;
  GlobalCEFApp.UserAgent := GlobalCEFApp.UserAgent + 'AsomeCodeApp';
  GlobalCEFApp.DeleteCache := false;
  GlobalCEFApp.DeleteCookies := false;
  GlobalCEFApp.OnWebKitInitialized :=
    procedure ()
    begin
      TCefRTTIExtension.Register('App', TJSExtension);
    end;
  if not GlobalCEFApp.StartMainProcess then Exit;
  ///
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmMainOfCEF, fmMainOfCEF);
  Application.Run;
  //
  DestroyGlobalCEFApp;
end.

