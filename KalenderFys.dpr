program KalenderFys;

uses
  Forms,
  AkutKalender2 in 'AkutKalender2.pas' {MainForm},
  Vcl.Themes,
  Vcl.Styles,
  Setup4 in 'Setup4.pas' {SetupForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TSetupForm, SetupForm);
  //Application.CreateForm(TSetupForm3, SetupForm3);
  Application.Run;

end.