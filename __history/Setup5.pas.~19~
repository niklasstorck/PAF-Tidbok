unit Setup5;

{ $define localdebug }

interface

uses
  Sysutils,
  ActiveX, dbxmssql,
  System.IniFiles, StrUtils,
  Winapi.Windows, Winapi.Messages, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.FMTBcd,
  Vcl.StdCtrls, Vcl.CheckLst, Datasnap.DBClient, Datasnap.Provider, Data.DB,
  Data.SqlExpr, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, DBAdvGrid, W7Classes,
  W7Bars, CurvyControls, AdvGlowButton, AdvSmoothLabel, Vcl.Mask, AdvDropDown,
  AdvTimePickerDropDown, AdvSmoothTabPager, AdvSpin, AdvEdit, advlued,
  AdvListEditor, AdvLookupBar;

type
  TSetupForm = class(TForm)
    FYSPAF_setup: TSQLConnection;
    DTB_GetTidbokTyp: TSQLDataSet;
    DataSource1: TDataSource;
    DataSetProvider1: TDataSetProvider;
    ClientDataSet1: TClientDataSet;
    CurvyPanel1: TCurvyPanel;
    W7InformationBar1: TW7InformationBar;
    ButtonOk: TAdvGlowButton;
    ButtonCancel: TAdvGlowButton;
    Schema: TAdvSmoothTabPager;
    Rum: TAdvSmoothTabPage;
    TidbokKolumner: TCheckListBox;
    TidBokGrid: TDBAdvGrid;
    Schematider: TAdvSmoothTabPage;
    AdvSmoothLabel1: TAdvSmoothLabel;
    AdvSmoothLabel2: TAdvSmoothLabel;
    AdvSmoothLabel3: TAdvSmoothLabel;
    AdvSmoothLabel4: TAdvSmoothLabel;
    TimePicker_Start: TAdvTimePickerDropDown;
    TimePicker_Stop: TAdvTimePickerDropDown;
    TimePicker_Start_Lunch: TAdvTimePickerDropDown;
    TimePicker_Stop_Lunch: TAdvTimePickerDropDown;
    AdvSpinEdit1: TAdvSpinEdit;
    AdvLookupBar1: TAdvLookupBar;
    procedure FormCreate(Sender: TObject);
    procedure ButtonOkClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    // Procedure Get(
  private
    { Private declarations }
    function GetPsw2(Psw1: string): String;

  public
    { Public declarations }
    ParamString, DatabasName, ServerName, Provider, user, password: String;
    Changed, DatabaseOK, AllOk: Boolean;
    DaysShown : Integer;
    SchemaDisplayUnit: Integer;
    SchemaStart,
    SchemaStop,
    LunchStart,
    LunchStop : TTime;
    InsLeft,
    InsTop : Integer;
    procedure ReadFromIniFile;
    procedure WriteToInifile;
  end;

var
  SetupForm: TSetupForm;

implementation

{$R *.dfm}

procedure TSetupForm.FormCreate(Sender: TObject);
var
  I: Integer;
  S: String;
begin

  AllOk := False;
  DatabaseOK := False;
  TidBokGrid.Hide;
  ClientDataSet1.Active:=False;
{$IFDEF localdebug}
  TidBokGrid.Show;
{$ENDIF}
  CoInitialize(nil);
  ReadFromIniFile;
  Changed := False;

  FYSPAF_setup.Close;
  FYSPAF_setup.ConnectionName := ServerName;
  FYSPAF_setup.DriverName := 'MSSQL';
  FYSPAF_setup.Params.Values['HostName']   := ServerName;
  FYSPAF_setup.Params.Values['Database']   := DatabasName;
  FYSPAF_setup.Params.Values['User_name']  := user;
  FYSPAF_setup.Params.Values['Password']   := password;
  FYSPAF_setup.LoadParamsOnConnect := False;
  FYSPAF_setup.LoginPrompt := False;

  try
    ClientDataSet1.Active := true; // Öppnar databasen
    DatabaseOK := true;
  except
    DatabaseOK := False;
    Application.MessageBox(PChar('Databaskopplingen till  databasen, ['+ DatabasName +
        '] på servern ['+ Servername + '] kunde inte upprättas!'),
      'Databasfel', mb_OK);
    // Exit
  end;

  for I := 1 to TidBokGrid.RowCount - 1 do
  begin
    S := TidBokGrid.Cells[1, I];
    if TidbokKolumner.Items.IndexOf(S) < 0 then
      TidbokKolumner.Items.Add(S)
  end;

  FYSPAF_setup.Close;
  CoUninitialize;
end;

function TSetupForm.GetPsw2(Psw1: string): String;
var
  S: String;
  I: Integer;
begin
  S := '';
  I := 1;
  S := Psw1[12 + I] + Psw1[18 + I] + Psw1[2 + I] + Psw1[6 + I] + Psw1[11 + I] +
    Psw1[22 + I] + Psw1[8 + I] + Psw1[28 + I];
  Result := S;
end;

procedure TSetupForm.ButtonCancelClick(Sender: TObject);
begin
  Changed := False;
  Close
end;

procedure TSetupForm.ButtonOkClick(Sender: TObject);
begin
  WriteToInifile;
end;

procedure TSetupForm.ReadFromIniFile;
var
  SettingFile, SettingFilePAF: TIniFile;
  I, SPos: Integer;
  PswKrypt, S, ts, bs, kol: String;
  ws: Widestring;
  Ch: Boolean;

begin
  S := 'Fel';
  ParamString := '';
  SettingFile := TIniFile.Create(ChangeFileExt(Application.ExeName, '.INI'));
  AllOk := true;
  if paramcount > 0 then
    ParamString := ParamStr(1);

  if ParamString > '' then
  begin // Data från inifil i parameterlista, trol paf.ini
    if Sysutils.FileExists(ParamString) then
    begin
      SettingFilePAF := TIniFile.Create(ParamString);
      DatabasName := SettingFilePAF.ReadString('common', 'database', S);
      ServerName := SettingFilePAF.ReadString('common', 'server', S);
      Provider := SettingFilePAF.ReadString('common', 'provider', S);
      PswKrypt := SettingFilePAF.ReadString('common', 'sps', S);
      user := 'pa';
      //user := 'fyslabx'; //TEMP
      // password := 'purkebas';
      password := GetPsw2(PswKrypt);
      //password := 'krulle'; //TEMP

      SettingFilePAF.Free;
    end
    else
    begin
      ts := 'Inifilen: ' + ParamString + ' kunde inte läsas.';
      Application.MessageBox(PWidechar(ts), 'Fel!', mb_OK);
      AllOk := False;
    end
  end

  else

  begin // Ta databas från programmets inifil
    DatabasName := SettingFile.ReadString('DatabasInst', 'DataBase', S);
    ServerName := SettingFile.ReadString('DatabasInst', 'Server', S);
    Provider := SettingFile.ReadString('DatabasInst', 'provider', S);


    user := 'pa';
    password := 'purkebas'
  end;

  // nedanstående läses alltid från lokal inifil
  SchemaDisplayUnit := SettingFile.ReadInteger('Inst','SchemaDisplayUnit',15);
  SchemaStart  := SettingFile.ReadTime('Inst','SchemaStart',StrToTime('06:00:00'));
  SchemaStop   := Settingfile.ReadTime('Inst','SchemaStop',StrToTime('19:00:00'));
  LunchStart   := Settingfile.ReadTime('Inst','LunchStart',StrToTime('11:30:00'));
  LunchStop    := Settingfile.ReadTime('Inst','LunchStop',StrToTime('12:15:00'));
  DaysShown    := SettingFile.ReadInteger('Inst','Visadedagar',1);
  InsLeft      := SettingFile.ReadInteger('Inst','InsLeft',20);
  InsTop       := SettingFile.ReadInteger('Inst','Instop',7);
  TidbokKolumner.Items.Clear;
  try
    // for I := 1 to Clb_Tidbok.Items.Count - 1 do
    // begin
    I := 1;
    repeat
      S := '';
      ts := '';
      ts := SettingFile.ReadString('Valda kolumner', 'Kolumn' + IntToStr(I), S);
      if ts = '' then
      begin
        Break;
      end;

      SPos := PosEx(';', ts);
      S := Copy(ts, 0, SPos - 1);
      bs := Copy(ts, SPos + 1, Length(ts) - SPos + 1);
      try
        Ch := StrToBool(bs);
      except
        Ch := False;
      end;
      TidbokKolumner.Items.Add(S);
      TidbokKolumner.Checked[I - 1] := Ch;
      inc(I);
    until ts = '';

    // end
  finally
    SettingFile.Free;
  end;
  Changed := true;
end;

procedure TSetupForm.WriteToInifile;
var
  SettingFile: TIniFile;
  I: Integer;
begin
  // Spara till fil eller registry
  SettingFile := TIniFile.Create(ChangeFileExt(Application.ExeName, '.INI'));
  try
    for I := 0 to TidbokKolumner.Items.Count - 1 do
    begin
      SettingFile.WriteString('Valda kolumner', 'Kolumn' + IntToStr(I),
        TidbokKolumner.Items[I] + ';' + BoolToStr(TidbokKolumner.Checked[I]));
    end;
      SettingFile.WriteInteger('Inst','SchemaDisplayUnit',SchemaDisplayUnit);
      SettingFile.WriteInteger('Inst','Visadedagar',DaysShown);
      Settingfile.WriteTime('Inst','SchemaStart',SchemaStart);
      Settingfile.WriteTime('Inst','SchemaStop',SchemaStop);
      Settingfile.WriteTime('Inst','LunchStart',LunchStart);
      Settingfile.WriteTime('Inst','LunchStop',LunchStop);
      SettingFile.WriteInteger('Inst','InsLeft',InsLeft);
      SettingFile.WriteInteger('Inst','InsTop',InsTop);

  finally
    SettingFile.Free;
  end;
  Changed := true;;
  Close;
end;

end.

