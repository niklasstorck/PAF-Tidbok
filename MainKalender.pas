unit MainKalender;

{$define ns_debug}
{ $define demo }

interface

uses

  // Datamodul,
  PafPlanner,  System.IniFiles, StrUtils,
  Windows, Messages, ComCtrls, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, Menus,
  AdvPolyList, CurvyControls,
  AdvSmoothLabel, ExtCtrls, AdvSplitter,
  StdCtrls, AdvSmoothEdit, AdvSmoothEditButton, AdvSmoothDatePicker,
  Ribbon, AdvmSQLS,
  PlannerDatePicker,
  SqlExpr,
  AdvDropDown,
  Grids,
  BaseGrid, AdvGrid,
  AdvDateTimePicker,
  DateUtils,
  //Setup3,
  AdvMenus, AdvEdit, AdvEdBtn,
  AdvObj,
  Setup4,
  DBAdvGrid,
  AdvOfficeButtons, Planner, PlannerWaitList,
  PAFEdit3, ExeInfo, Data.DB, Data.DBXMSSQL, Data.FMTBcd, Datasnap.DBClient,
  Datasnap.Provider, Vcl.Mask, AdvSmoothListBox, AdvSmoothComboBox, clisted;

Const
  // *************************************
  // kalenderna uppdelning
  // Skall vara i ngn slags setup sen
  // *************************************
  CDisplayUnit = 15; // Uppdelningen av kalendern i 15 minutersintervall
  CDisplayStart = 6; // Klockan 6
  CDisplayEnd = 20; // Klockan 20
  CActiveStart = 7; // Klockan 7
  CActiveEnd = 19; // Klockan 19

type

  ShortString = String[15];
  Longstring = String[50];

  TMainForm = class(TForm)
    AdvSmoothLabel1: TAdvSmoothLabel;
    CurvyPanel2: TCurvyPanel;
    AdvSmoothLabel2: TAdvSmoothLabel;
    PopupMenuItem: TAdvPopupMenu;
    Visaalladata1: TMenuItem;
    Annanavdelning1: TMenuItem;
    Sng1: TMenuItem;
    TimerKlocka: TTimer;
    RadioB_Dygn_1: TRadioButton;
    RadioB_2Dygn: TRadioButton;
    CheckBoxHelger: TAdvOfficeCheckBox;
    TimerPlanner: TTimer;
    RemissGrid: TDBAdvGrid;
    AdvMainMenu1: TAdvMainMenu;
    File1: TMenuItem;
    ChekboxHelaDagen: TAdvOfficeCheckBox;
    AdvSplitter2: TAdvSplitter;
    PopupMenuItemNew: TAdvPopupMenu;
    abortmarkering1: TMenuItem;
    AdvSplitter4: TAdvSplitter;
    DatePicker1: TPlannerDatePicker;
    Instllningar1: TMenuItem;
    Lokalainstllningar1: TMenuItem;
    ExeInfo1: TExeInfo;
    PafItemEditor1: TPafItemEditor;
    DayGrid: TDBAdvGrid;
    DataSourceTB: TDataSource;
    DataSourceRemiss: TDataSource;
    TimerRemiss: TTimer;
    CurvyPanel1: TCurvyPanel;
    AdvSplitter1: TAdvSplitter;
    MYPAFWaitList1: TMYPAFWaitList;
    MyPAFPlanner1: TMyPAFPlanner;
    ClientDataSetTB: TClientDataSet;
    DataSetProviderTB: TDataSetProvider;
    DTB_GetTB: TSQLDataSet;
    FYSPAF: TSQLConnection;
    DTB_GetRemisser: TSQLDataSet;
    DataSetProviderremiss: TDataSetProvider;
    ClientDataSetRemiss: TClientDataSet;
    SQLMonitor1: TSQLMonitor;
    SQLQuery1: TSQLQuery;
    CurvyPanel3: TCurvyPanel;
    Label1: TLabel;
    CheckListExtPrio: TCheckListEdit;
    CheckListTurKlass: TCheckListEdit;
    Label2: TLabel;
    Label3: TLabel;
    GridSQLError: TDBAdvGrid;
    DspSQLError: TDataSetProvider;
    CdsSQLError: TClientDataSet;
    DSSQLerror: TDataSource;
    Button1: TButton;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TimerKlockaTimer(Sender: TObject);
    procedure RadioB_2DygnClick(Sender: TObject);
    procedure RadioB_Dygn_1Click(Sender: TObject);
    procedure DatePicker1Change(Sender: TObject);

    // procedure DBActiveDaySource1InsertItem(Sender: TObject;
    // APlannerItem: TPlannerItem);
    procedure Table1AfterInsert(DataSet: TDataSet);
    procedure CheckBoxHelgerClick(Sender: TObject);
    procedure TimerPlannerTimer(Sender: TObject);
    procedure CalPanel1DateChange(Sender: TObject;
      origDate, newDate: TDateTime);

    procedure ChekboxHelaDagenClick(Sender: TObject);
    procedure abortmarkering1Click(Sender: TObject);

    // ******************************************
    // Edit
    procedure MyPAFPlanner1Items0EditModal(Sender: TObject);
    // procedure MYPAFWaitList1ItemDblClick(Sender: TObject; Item: TPlannerItem);
    // ******************************************
    // Inställningar
    procedure FormActivate(Sender: TObject);
    procedure Lokalainstllningar1Click(Sender: TObject);
    procedure MyPAFPlanner1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure PAFWaitList1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure PAFWaitList1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure MyPAFPlanner1PlannerRightClick(Sender: TObject;
      Position, FromSel, FromSelPrecise, ToSel, ToSelPrecise: Integer);
    procedure MyPAFPlanner1DragDropCell(Sender, Source: TObject; X, Y: Integer);
    procedure DefaultItemEditor1BeforeEditShow(Sender: TObject;
      APlannerItem: TPlannerItem);

    procedure MyPAFPlanner1DragDropItem(Sender, Source: TObject; X, Y: Integer;
      PlannerItem: TPlannerItem);
    procedure MyPAFPlanner1ItemSize(Sender: TObject; Item: TPlannerItem;
      Position, FromBegin, FromEnd, ToBegin, ToEnd: Integer);
    procedure MyPAFPlanner1ItemMove(Sender: TObject; Item: TPlannerItem;
      FromBegin, FromEnd, FromPos, ToBegin, ToEnd, ToPos: Integer);
    procedure TimerRemissTimer(Sender: TObject);
    procedure CheckListExtPrioChange(Sender: TObject);
    procedure CheckListTurKlassChange(Sender: TObject);
    procedure MyPAFPlanner1DragOverItem(Sender, Source: TObject; X, Y: Integer;
      APlannerItem: TPlannerItem; State: TDragState; var Accept: Boolean);
    procedure Button1Click(Sender: TObject);

  private
    { Private declarations }

    imorgon: Boolean;
    CurrDay: TDateTime;
    // TidbokCols   : TCols;

    TurKlassVald, ExtPrioVald, UserId, PCNamn: String;
    // FItem: TMyPAFItem;
    // DisplayMinutes: Integer;

    // **********************************************************************
    // Hitta ett fält i en grid med hjälp av fältnamnet.
    // Ger kolumnens nummer som resultat
    function FieldByName(const DBGrid: TDBAdvGrid; NameS: String): Integer;

    // **********************************************************************
    // Procedurer som läser in tidbok och väntelista ************************
    // **********************************************************************
    procedure ReadDayFromPAF(dt: TDateTime);
    procedure ReadRemissFromPaf;

    //
    procedure HeaderSetup;
    function TBRumToCol(H: String): Integer;
    function TBColToRum(P: Integer): String;
    function KodToMinuter(kod: String): Integer;
    procedure PlaceToDrop(X, Y: Integer; var aDT: TDateTime; aRoom: String);
    procedure AddLunch(starttime, endtime: TDateTime);
    procedure SaveUstoPAF(RemissId, Tidbas, Tidbok, UserId, PCNamn: String;
      ALnr, UndTid: Integer);
    procedure DisplayUpdate(DUnit, DStart, DEnd, AStart, AEnd: Integer);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

function TMainForm.FieldByName(const DBGrid: TDBAdvGrid; NameS: String)
  : Integer;
var
  col, idx: Integer;
begin
  col := 0;
  for idx := 0 to DBGrid.Columns.Count - 1 do
  begin
    if DBGrid.Columns[idx].FieldName = NameS then
    begin
      col := idx;
      Break;
    end;
  end;

  if col > 0 then
    Result := col
  else
    Result := 0;
end;





procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // FreeAndNil(Fitem);
  // MyPafPlanner1.Free
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  F: Textfile;
  S: String;
begin
  SQLMonitor1.Active := false;

  // Remissortering.
  // Till lokalt sparat val i xml fil eller registry senare 2013-04-04 / ns

  TurKlassVald := '0';
  ExtPrioVald := 'PAEI';
  SQLQuery1.Active := false;
  SQLQuery1.SQL.Clear;
  FYSPAF.Connected := false;
  CurrDay := now;
  imorgon := false;
  PCNamn := ExeInfo1.ComputerName;
  UserId := 'Niklas'; // Ersätts med inlogg när detta är klart
  RadioB_Dygn_1.Checked := false;

  MyPAFPlanner1.DateTimeList.Add(CurrDay);
  MyPAFPlanner1.DefaultItem.Editor := PafItemEditor1;
  MYPAFWaitList1.DefaultItem.Editor := PafItemEditor1;
  DisplayUpdate(15, 6, 20, 7, 19); // Skall kunna konfigureras av användare.
  if paramcount > 0  then
  SetupForm.ParamString:=ParamStr[1];
  // HeaderSetup;

end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  DayGrid.Hide;
  RemissGrid.Hide;
  GridSQLError.Hide;
  FysPaf.ConnectionName := SetupForm.ServerName;
  ReadRemissFromPaf;
  DatePicker1.Date := CurrDay; // Läser också in data
  HeaderSetup;

  // SetupForm3.Get(TidBokCols);
{$IFDEF ns_debug}
  DayGrid.show;
  RemissGrid.show;
  GridSQLError.show;
  GridSQLError.Columns[2].Width := 485;
  Caption:=FYSPAF.ConnectionName;
{$ENDIF}
end;

procedure TMainForm.FormActivate(Sender: TObject);
var
  TF: Textfile;
  S: String;
begin

  //FysPaf.
  (*
    AssignFile(TF,'c:\PAF\DBConnString.txt');
    Reset(TF);
    Read(TF,S);
    PAF_T.Connected          := False;
    PAF_T.ConnectionString   := S;
    PAF_T.Connected          := True;

    CloseFile(TF);
  *)
end;

procedure TMainForm.HeaderSetup;
var
  I, NumOfCols: Integer;
  S: String;
begin

  // MyPAFPlanner1.Positions := 7;
  NumOfCols := 0;
  for I := 0 to SetupForm.TidbokKolumner.items.Count - 1 do
    if SetupForm.TidbokKolumner.Checked[I] then
      Inc(NumOfCols);

  MyPAFPlanner1.Positions := NumOfCols;
  MyPAFPlanner1.PositionGroup := NumOfCols;

  MyPAFPlanner1.Mode.PlannerType := plDay;
  MyPAFPlanner1.Mode.Date := CurrDay;
  MyPAFPlanner1.Mode.TimeLineStart := CurrDay;

  with MyPAFPlanner1.Header do
  begin
    Captions.Clear;
    GroupCaptions.Clear;
    Captions.Add('');

    for I := 0 to SetupForm.TidbokKolumner.items.Count - 1 do
    begin
      if SetupForm.TidbokKolumner.Checked[I] then
      begin
        S := SetupForm.TidbokKolumner.items[I];
        Captions.Add(S);
      end;
    end;
    GroupCaptions.Add(FormatDateTime('dddd dd mmmm yyyy', CurrDay));
  end;

end;

function TMainForm.KodToMinuter(kod: String): Integer;
begin
  if Trim(kod) = '213' then
    Result := 59
  else
    Result := 45;
end;

procedure TMainForm.Lokalainstllningar1Click(Sender: TObject);
var
  I: Integer;
begin
  // Justera inställningar
  // Fn. bara för rum.
  SetupForm.show;
  HeaderSetup;
end;

procedure TMainForm.MyPAFPlanner1ItemMove(Sender: TObject; Item: TPlannerItem;
  FromBegin, FromEnd, FromPos, ToBegin, ToEnd, ToPos: Integer);

var
  S, ErrorText: String;
  TempTime, EInt: Integer;

begin
{$IFDEF ns_debug}
  SQLMonitor1.Active := true;
{$ENDIF}
  // TempTime:=
  CdsSQLError.Active := false;
  SQLQuery1.SQL.Clear;
  S := 'exec DTBMoveRemInTb ' + QuotedStr(TMyPAFItem(Item).rid) + ',' +
    IntToStr(TMyPAFItem(Item).ALnr) + ',' + IntToStr(0) + ',' +
    QuotedStr(DateTimeToStr(TMyPAFItem(Item).ItemStartTime - ToPos)) + ','

    + QuotedStr(TBColToRum(ToPos)) + ','

    + QuotedStr(UserId) + ',' + QuotedStr(PCNamn);

  SQLQuery1.SQL.Add(S);
  SQLQuery1.Prepared := true;
  CdsSQLError.Active := true;
  ReadDayFromPAF(CurrDay);
{$IFDEF ns_debug}
  GridSQLError.Columns[2].Width := 485;
  MainForm.Caption := FysPaf.ConnectionName+'  '+ S;
  SQLMonitor1.Active := false;
{$ENDIF}
end;

procedure TMainForm.MyPAFPlanner1Items0EditModal(Sender: TObject);
begin
  // MyPafeditor1.Edit(MyPAFPlanner1,MyPafPlanner1.Items.Selected);
end;

procedure TMainForm.MyPAFPlanner1ItemSize(Sender: TObject; Item: TPlannerItem;
  Position, FromBegin, FromEnd, ToBegin, ToEnd: Integer);

var
  S, ErrorText: String;
  TempTime, EInt: Integer;

begin
{$IFDEF ns_debug}
  SQLMonitor1.Active := true;
{$ENDIF}
  TempTime := (ToEnd - ToBegin) * CDisplayUnit; // Osäker beräkning fn. / NS
  CdsSQLError.Active := false;
  SQLQuery1.SQL.Clear;
  S := 'exec DTB_UpdateTb_ExamTime ' + IntToStr(TMyPAFItem(Item).ALnr) + ','
  // + IntToStr(-7) + ','

    + IntToStr(TempTime) + ','
  // Hur uppdaterar jag utid?
    + QuotedStr(UserId) + ',' + QuotedStr(PCNamn);

  SQLQuery1.SQL.Add(S);
  SQLQuery1.Prepared := true;
  CdsSQLError.Active := true;

{$IFDEF ns_debug}
  GridSQLError.Columns[2].Width := 485;
  MainForm.Caption := FysPaf.ConnectionName+'  '+ S;
  SQLMonitor1.Active := false;
{$ENDIF}
end;

procedure TMainForm.MyPAFPlanner1PlannerRightClick(Sender: TObject;
  Position, FromSel, FromSelPrecise, ToSel, ToSelPrecise: Integer);
begin
  with MyPAFPlanner1.CreateItemAtSelection do
  begin
    Text.Text := 'Orsak?';
    Captiontype := ctTime;
    BackGround := false;
    Layer := 1;
    FixedPos := false;
    Captiontext := 'Blockerad tid';
    Color := RGB(127, 127, 100);
    PopUpMenu := PopupMenuItemNew;
    Update;
  end;

end;

procedure TMainForm.abortmarkering1Click(Sender: TObject);
begin
  Beep
end;

procedure TMainForm.AddLunch(starttime, endtime: TDateTime);
var
  I: Integer;
begin
  for I := 0 to 6 do
  begin
    with TMyPAFItem(MyPAFPlanner1.CreateItem) do
    begin
      ItemStartTime := starttime;
      ItemEndTime := endtime;
      BackGround := true;
      AllowOverlap := true;
      Alignment := taCenter;
      Color := RGB(150, 200, 150);
      Text.Text := 'Lunch';
      ItemPos := I
    end;
  end;

end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
  ReadRemissFromPaf;
end;

procedure TMainForm.CalPanel1DateChange(Sender: TObject;
  origDate, newDate: TDateTime);
// var
// D: TDateTime;
begin
  (*
    D:=CalPanel1.Date;
    DayPlanner.DateTimeList.Clear;
    DayPlanner.DateTimeList.Add(D);
    CurrDay:=D;
    ReadDayFromPAF(D);
    HeaderSetup;
  *)
end;

procedure TMainForm.CheckBoxHelgerClick(Sender: TObject);
begin
  if CheckBoxHelger.Checked = true then
  begin
    // Två dagar
    // Om helgdagar skall visas så är de två dagarna t.x fr + lö, annars fr + må
    //
    MyPAFPlanner1.DateTimeList.Add(CurrDay);
  end
  else

end;

procedure TMainForm.CheckListTurKlassChange(Sender: TObject);
Var
  S: String;
begin
  // Sorteringa av remissgrupp. Måste så småningom läsas från databas

  S := CheckListTurKlass.Text;
  TurKlassVald := S;
  // ReadRemissFromPaf;

{$IFDEF ns_debug}
  MainForm.Caption := S;
{$ENDIF}
end;

procedure TMainForm.CheckListExtPrioChange(Sender: TObject);
var
  S: String;
begin
  // AEIP etc

  S := CheckListExtPrio.Text;
  ExtPrioVald := S;

  // ReadRemissFromPaf;
{$IFDEF ns_debug}
  MainForm.Caption := S;
{$ENDIF}
end;

procedure TMainForm.ChekboxHelaDagenClick(Sender: TObject);
begin
  if ChekboxHelaDagen.Checked = true then
  begin
    MyPAFPlanner1.Display.ScaleToFit := true;
    DisplayUpdate(30, 6, 20, 7, 19);
  end
  else
  begin
    MyPAFPlanner1.Display.ScaleToFit := false;
    DisplayUpdate(15, 6, 20, 7, 19);
  end;
  // DBDayPlanner.ItemSource:=DBActiveDaySource1;
end;

procedure TMainForm.DatePicker1Change(Sender: TObject);
var
  D: TDateTime;
begin

  D := DatePicker1.Date;
  if D <> CurrDay then
  begin
    CurrDay := D;

    MyPAFPlanner1.DateTimeList.Clear;
    MyPAFPlanner1.DateTimeList.Add(D);

    HeaderSetup;
    ReadDayFromPAF(D);
  end;

end;

procedure TMainForm.DefaultItemEditor1BeforeEditShow(Sender: TObject;
  APlannerItem: TPlannerItem);
begin
end;

// ***************************************************************************
// ***************************************************************************
// ******* procedurer för drag and drop mellan waitlist och planner **********
// ***************************************************************************

procedure TMainForm.MyPAFPlanner1DragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := (Source is TMYPAFWaitList);
end;

procedure TMainForm.MyPAFPlanner1DragDropCell(Sender, Source: TObject;
  X, Y: Integer);
var
  ErrorSave: Integer;
  ErrorText: String;
begin
  ErrorSave := 0;
  ErrorText := '';
  if MyPAFPlanner1.CellToItemNum(X, Y) = 0 then
  begin
    with TMyPAFItem(MyPAFPlanner1.CreateItem) do
    begin
      Assign(TMyPAFItem(MYPAFWaitList1.items[MYPAFWaitList1.ItemIndex]));
      ItemStartTime := MyPAFPlanner1.CellToTime(X, Y);

      ItemEndTime := ItemStartTime + EncodeTime(Utid div 60, Utid mod 60, 0, 0);
      // Temp
      Color := clSilver;

      SaveUstoPAF(rid, DateTimeToStr(ItemStartTime - X), TBColToRum(ItemPos),
        UserId, ExeInfo1.ComputerName, { ALnr+1 } 0, Utid);
    end;

    MYPAFWaitList1.items.Delete(MYPAFWaitList1.ItemIndex);
    Update;
  end;

end;

// **********************************************************************
// *** Procedurer för drag drop på en befintlig tid *********************
// **********************************************************************

// **********************************************************************
// procedure MyPAFPlanner1DragOverItem
// Kontrollerar att det är ok att släppa ett item på ett annat
// Endast klipp från planner eller waitlist samt att det skall vara
// en tom tid, vilket motsvarar StatusFlg = 0
//
procedure TMainForm.MyPAFPlanner1DragOverItem(Sender, Source: TObject;
  X, Y: Integer; APlannerItem: TPlannerItem; State: TDragState;
  var Accept: Boolean);
begin
  Accept := ((Source is TMyPAFPlanner) or (Source is TMYPAFWaitList)) and
    (TMyPAFItem(APlannerItem).StatusFlg = 0)
end;

procedure TMainForm.MyPAFPlanner1DragDropItem(Sender, Source: TObject;
  X, Y: Integer; PlannerItem: TPlannerItem);
begin
  CdsSQLError.Active := false;
  with TMyPAFItem(PlannerItem) do
  begin
    if Source is TMYPAFWaitList then
      CopyRemissdataOnly
        (TMyPAFItem(MYPAFWaitList1.items[MYPAFWaitList1.ItemIndex]))
    else
      CopyRemissdataOnly(MyPAFPlanner1.items.Selected);

    // AlNr := TMyPafItem(Source).ALNr;
    BackGround := false;
    Focus := true;
    Captiontype := ctText;
    Captiontext := Trim(Prodkod + ' ' + PatNamn);
    Editor := PafItemEditor1;
    Color := clGreen;
    SaveUstoPAF(rid, '', '', UserId, PCNamn, ALnr, Utid)
  end;
  if Source is TMYPAFWaitList then
    MYPAFWaitList1.items.Delete(MYPAFWaitList1.ItemIndex)

end;

procedure TMainForm.PAFWaitList1DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  // Accepterar bara objekt från PafPlanner.
  Accept := (Source is TMyPAFPlanner);
end;

procedure TMainForm.PAFWaitList1DragDrop(Sender, Source: TObject;
  X, Y: Integer);
var
  S, ErrorText: String;
  EInt: Integer;
begin
  if Assigned(MyPAFPlanner1.items.Selected) then
  begin
    //
    SQLQuery1.SQL.Clear;

    S := 'exec DTB_DeleteRemFromTB ' +
      QuotedStr(TMyPAFItem(MyPAFPlanner1.items.Selected).rid) + ',' +
      QuotedStr(UserId) + ',' + QuotedStr(PCNamn);

    SQLQuery1.SQL.Add(S);

    SQLQuery1.Prepared := true;
    CdsSQLError.Active := true;

{$IFDEF ns_debug}
    MainForm.Caption := S;
    GridSQLError.Columns[2].Width := 485;
{$ENDIF}
    MYPAFWaitList1.items.Add.Assign(MyPAFPlanner1.items.Selected);
    MyPAFPlanner1.FreeItem(MyPAFPlanner1.items.Selected);
    ReadDayFromPAF(CurrDay);
  end;
end;

// **********************************************************************
// ***** Skriver bokade eller ändrade remisser till PAF databasen *******
// **********************************************************************
// Namn: SaveUstoPAF
// Parameter:
// @P_RemissId	varchar(15),		/* RemissId*/
// @Alnr		int = Null,
// @P_Tidbas	varchar(25)='',		/*Önskad tid (om det är en ny tid)*/
// @P_TidBok	varchar(25)='',		/*Önskad tidbok (om det är en ny tid)*/
// @P_UndTid	smallint=0,		    /*Förväntad undersökningstid i minuter*/
// @P_UserId	varchar(15),		  /* AnvändarID*/
// @P_PCnamn	varchar(15)		    /* PCnamn*/
// Resultat: Skriver en förändrad undersökning till PAF
// Kallar:  DTB_InsertTb
// **********************************************************************

procedure TMainForm.SaveUstoPAF(RemissId, Tidbas, Tidbok, UserId,
  PCNamn: String; ALnr, UndTid: Integer);

var
  EInt: Integer;
  EText: String;
  S: String;
  F: Textfile;
begin
  CdsSQLError.Active := false;
  SQLQuery1.SQL.Clear;
  S := 'exec DTB_InsertTb ' + #39 + Trim(RemissId) + #39 + ',' +
    IntToStr(ALnr) + ','
  // + IntToStr(0)               + ','
    + QuotedStr(Tidbas) + ',' + QuotedStr(Tidbok) + ',' + IntToStr(UndTid) + ','
    + QuotedStr(UserId) + ',' + QuotedStr(PCNamn);
  SQLQuery1.SQL.Add(S);

{$IFDEF ns_debug}
  MainForm.Caption := FysPaf.ConnectionName+'  '+ S;

{$ENDIF}
  SQLQuery1.Prepared := true;
  CdsSQLError.Active := true;
  // SQLQuery1.Open;

end;


// ***************************************************************************
// ****************** Drag dropp end *****************************************
// ***************************************************************************
// ***************************************************************************

procedure TMainForm.PlaceToDrop(X, Y: Integer; var aDT: TDateTime;
  aRoom: String);
begin
  // aDT := StrTodateTime('2011-08-20 11:00');
  // aRoom := 'EKO-4';
end;

procedure TMainForm.RadioB_2DygnClick(Sender: TObject);
begin
  imorgon := true;
end;

procedure TMainForm.RadioB_Dygn_1Click(Sender: TObject);
begin
  imorgon := false;
end;


// **********************************************************************
// ***** Läser in en dags undersökningar från PAF databasen *************
// **********************************************************************
// Namn: ReadDayFromPAF
// Parameter: dt: Önskat datum
// Resultat: Läser in alla undersökningar för datumet i fråga
// Kallar: NewItemToTidbok en gång för varje post
// **********************************************************************

procedure TMainForm.ReadDayFromPAF(dt: TDateTime);

var
  I, TempI: Integer;
  LoeInDatePart: Double;
  LengthOfExam: String;
  tmp_Rum: String;
  // LocalItem: TMyPafItem;
begin
{$IFDEF ns_debug}
  SQLMonitor1.Active := false;
{$ENDIF}
  DayGrid.Clear;

  // **********************************************************************
  // Öppna en stored procedure och läs till Tabellen Daygrid
  // **********************************************************************

  // Fyspaf.Connected:=true;
  ClientDataSetTB.Active := false;

  DTB_GetTB.Active := false;
  DTB_GetTB.ParamByName('@FranDatum').AsString := DateTimeToStr(dt);
  DTB_GetTB.ParamByName('@AntDagar').AsInteger := 1;
  DTB_GetTB.Prepared := true;

  // DTB_GetTidbok.Active:=TRUE;
  ClientDataSetTB.Open;
  // ClientDataSetTB.LogChanges:=False;

  AddLunch(EncodeTime(11, 30, 0, 0), EncodeTime(12, 15, 0, 0));
  MyPAFPlanner1.items.ClearAll;
  MyPAFPlanner1.items.BeginUpdate;

  // **********************************************************************
  // Loopen läser rad för rad i Daygrid och gör nya entrys i Tidboken
  // **********************************************************************

  if DayGrid.RowCount > 1 then
  begin
    for I := 1 to DayGrid.RowCount - 1 do
    begin
      DayGrid.Row := I;
      tmp_Rum := Trim(DayGrid.Cells[8, I]);

      if TBRumToCol(tmp_Rum) > -1 then // Om det finns ett rum som passar
      begin
        with TMyPAFItem(MyPAFPlanner1.CreateItem) do
        begin
          // ****************************************************
          // Läs från dold grid, Daygrid till tidboken
          // En post per loop.
          // Bygger på att daygrid har en fast ordning på fälten.
          // Ändras ordningen i stored procedure DTB_GetTidBok
          // så måste denna ändras.
          // Alternativt får proceduern göras om så man söker
          // efter namn på fälten istället.
          //
          // Niklas 2013-04-13
          //
          // ****************************************************
          ItemStartTime := StrTodateTime(DayGrid.Cells[1, I]);
          Prodkod := DayGrid.Cells[16, I];
          LengthOfExam := DayGrid.Cells[25, I];

          if LengthOfExam < '00' then
            LengthOfExam := '30';

          Utid := StrToInt(LengthOfExam);
          BesKomm := DayGrid.Cells[21, I];
          PatKom := DayGrid.Cells[26, I];
          LoeInDatePart := StrToInt(LengthOfExam) / 1440;
          // Del av dygn ex. 30 minuter dividerat med 1440 minuter (ett dygn)
          ItemEndTime := ItemStartTime + LoeInDatePart;
          Prodtext := DayGrid.Cells[17, I];
          UsRum := Trim(DayGrid.Cells[8, I]);
          pid := DayGrid.Cells[13, I];
          PatNamn := DayGrid.Cells[15, I];
          RemUsr := DayGrid.Cells[19, I];
          TdbUsr := DayGrid.Cells[9, I];
          FrageText := DayGrid.Cells[27, I];
          Anamnes := DayGrid.Cells[28, I];
          rid := Trim(DayGrid.Cells[14, I]);
          ALnr := StrToInt(DayGrid.Cells[2, I]);
          ALlnr := StrToInt(DayGrid.Cells[3, I]);
          StatusFlg := StrToInt(DayGrid.Cells[5, I]);

          // Inställningar för presentation av PAFItem
          CaptionBkg := clSilver;
          Color := clSilver;
          Captiontype := ctText;
          Captiontext := Trim(Prodkod + ' ' + PatNamn);
          Editor := PafItemEditor1;

          CaptionBkgTo := clLime;
          CaptionBkg := clLime;
          CaptionFont.Color := clBlack;

          case StatusFlg of
            0:
              begin // = Ej Bokad
                CaptionBkgTo := clSilver;
                CaptionBkg := clSilver;
                CaptionFont.Color := clBlack;
{$IFDEF ns_debug}
                BackGround := false;
                // Jag vill ha posten editerbar under debug.
{$ELSE}
                BackGround := true;
                // Men annars ska en fast tid inte vara det förstås.
{$ENDIF}
                CaptionBkg := clSilver;
                CaptionBkgTo := clSilver;
                Captiontype := ctText;
                Captiontext := 'Ledig tid';
              end;
            1:
              begin // Tiden är bokad men inget annat har hänt
                CaptionBkgTo := clSilver;
                CaptionBkg := clWhite;
                CaptionFont.Color := clBlack;
              end;
            2:
              begin // Patienten har anlänt
                CaptionBkgTo := clRed;
                CaptionBkg := clRed;
                CaptionFont.Color := clWhite;
              end;
            3:
              begin // Undersökningen pågår
                CaptionBkgTo := clBlue;
                CaptionBkg := clBlue;
                CaptionFont.Color := clWhite;
              end;
            4:
              begin // Undersökningen är avslutad men inget svar är skrivet
                CaptionBkgTo := clGray;
                CaptionBkg := clGray;
                CaptionFont.Color := clWhite;
                Color := clGray
              end;
            5:
              begin // Preliminärbokad
                CaptionBkgTo := clLime;
                CaptionBkg := clLime;
                CaptionFont.Color := clWhite;
                Color := clGray
              end;
            6:
              begin // Preliminärbokad
                CaptionBkgTo := clFuchsia;
                CaptionBkg := clFuchsia;
                CaptionFont.Color := clWhite;
                Color := clGray
              end
          end;

          ItemPos := TBRumToCol(UsRum);
          Text.Text := Trim(pid + #13 + FrageText + #13 + Anamnes);
{$IFDEF ns_debug}
          Captiontext := rid;
{$ENDIF}
          Hint := Text.Text;
          ShowHint := true;
          Update
        end
      end;
    end; // For I:= ...
  end; // if Tempgrid ...
  MyPAFPlanner1.items.EndUpdate;
{$IFDEF ns_debug}
  SQLMonitor1.Active := true;
  GridSQLError.Columns[2].Width := 485;
{$ENDIF}
end;

// ***************************************************************************
// ***************************************************************************
// ***************************************************************************
// Läser in remisser från PAF till väntelistan
// Så småningom skall man klientmässigt kunna välja akuta etc.
// för närvarande läser proceduren endast in akuta "hårdkodat"
// ***************************************************************************
// ***************************************************************************

procedure TMainForm.ReadRemissFromPaf;
var
  I: Integer;
  S: String;
  // LocalItem: TMyPafItem;
  LengthOfExam: String;
begin
{$IFDEF ns_debug}
  SQLMonitor1.Active := false;
{$ENDIF}
  DTB_GetRemisser.ParamByName('@ExtPrio').AsWideString := ExtPrioVald;
  DTB_GetRemisser.ParamByName('@Turklass').AsString := '0';
  DTB_GetRemisser.Prepared := true;;

  ClientDataSetRemiss.Open;
  MYPAFWaitList1.items.ClearAll;
  MYPAFWaitList1.items.BeginUpdate;

  for I := 1 to RemissGrid.RowCount - 1 do
  begin
    RemissGrid.Row := I;
    if RemissGrid.Cells[1, I] > '' then
    begin
      with TMyPAFItem(MYPAFWaitList1.items.Add) do
      begin
        S := Trim(RemissGrid.Cells[35, I]);
        if S = 'A' then
        begin
          akut := true;
          CaptionBkg := RGB(200, 100, 100);
          CaptionBkgTo := RGB(200, 100, 100);
          Color := RGB(200, 128, 255)
        end
        else
        begin
          akut := false;
          Color := RGB(128, 200, 128)
        end;
        Editor := PafItemEditor1;
        pid := RemissGrid.Cells[1, I];
        PatNamn := RemissGrid.Cells[3, I] + ' ' + RemissGrid.Cells[2, I];;
        rid := Trim(RemissGrid.Cells[7, I]);
        RDatum := StrTodateTime(RemissGrid.Cells[6, I]);
        RemUsr := RemissGrid.Cells[21, I];
        FrageText := RemissGrid.Cells[44, I];
        Anamnes := RemissGrid.Cells[45, I];

        LengthOfExam := DayGrid.Cells[25, I];
        if LengthOfExam < '02' then
          LengthOfExam := '30';

        Utid := StrToInt(LengthOfExam);
        PafBestDatum := StrTodateTime(RemissGrid.Cells[6, I]);
        Editor := PafItemEditor1;
        BestId := RemissGrid.Cells[8, I];
        BestLak := RemissGrid.Cells[14, I];
        Prodkod := RemissGrid.Cells[15, I];
        try
          ALnr := StrToInt(RemissGrid.Cells[4, I]);
          ALlnr := StrToInt(RemissGrid.Cells[5, I]);
        except
          ALnr := 0;
          ALlnr := 0;
        end;
        Captiontype := ctText;
        Captiontext := Trim(Prodkod + ' ' + PatNamn);
        Text.Text := Trim(pid + #13 + FrageText + #13 + Anamnes);
        Hint := Text.Text;
        ShowHint := true;
        Update;
      end
    end;
  end;

  MYPAFWaitList1.items.EndUpdate;

{$IFDEF ns_debug}
  SQLMonitor1.Active := true;
  GridSQLError.Columns[2].Width := 485;
{$ENDIF}
end;

procedure TMainForm.DisplayUpdate(DUnit, DStart, DEnd, AStart, AEnd: Integer);
var
  RowsPerHour: Integer;
begin
  with MyPAFPlanner1.Display do
  begin
    DisplayUnit := DUnit;
    // 15; // Uppdelningen av kalendern i 15 minutersintervall
    RowsPerHour := 60 div DisplayUnit;
    // 60 div DisplayUnit;
    DisplayStart := CDisplayStart * RowsPerHour;
    // Klockan 6
    DisplayEnd := CDisplayEnd * RowsPerHour;
    // Klockan 20
    ActiveStart := (CActiveStart - DisplayStart) * RowsPerHour;
    // 30 minuter efter displaystart
    ActiveEnd := (CActiveEnd - CDisplayStart) * RowsPerHour;
  end;
end;

procedure TMainForm.Table1AfterInsert(DataSet: TDataSet);
begin
  Update;
end;

function TMainForm.TBColToRum(P: Integer): String;
var
  S: String;
begin
  Result := MyPAFPlanner1.Header.Captions.Strings[P + 1];
end;

function TMainForm.TBRumToCol(H: String): Integer;
var
  S: String;
  P: Integer;
begin
  S := Trim(H);
  if MyPAFPlanner1.Header.Captions.Find(S, P) then
    Result := P - 1
  else
    Result := -1;
end;

procedure TMainForm.TimerKlockaTimer(Sender: TObject);
begin
  MyPAFPlanner1.Caption.Title := '   ' + FormatDateTime('HH:mm:ss', now);
  if SetupForm.Changed then
  begin
    HeaderSetup;
    ReadDayFromPAF(CurrDay);
    SetupForm.Changed := false
  end;
end;

procedure TMainForm.TimerPlannerTimer(Sender: TObject);
begin
  ReadDayFromPAF(CurrDay);
end;

procedure TMainForm.TimerRemissTimer(Sender: TObject);
begin
  ReadRemissFromPaf;
end;

end.
