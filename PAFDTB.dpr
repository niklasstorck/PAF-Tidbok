program PAFDTB;

{$R *.dres}

uses
  Forms,
  Vcl.Themes,
  Vcl.Styles,
  AkutKalender2 in 'AkutKalender2.pas' {MainForm},
  PassWord in 'PassWord.pas' {PasswordDlg},
  Setup5 in 'Setup5.pas' {SetupForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TPasswordDlg, PasswordDlg);
  Application.CreateForm(TSetupForm, SetupForm);
  Application.Run;

end.
