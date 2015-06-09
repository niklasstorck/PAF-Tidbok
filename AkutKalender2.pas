//****************************************************************************
//****************************************************************************
//                 Akutkalender
//
// �r startformen f�r PAFDTB, den dynamiska tidboken f�r paf.
// Anv�nder formen Setup4 samt tv� arvtagare till TMSplanner
// Finns att k�pa p� www.tmssoftware.com
// Modulerna med �rvda och modifierade delar fr�n TMSplanner finns i
// PAFEdit3.pas samt PAFPlanner.pas
//
// Programmet �r beroende av f�ljande stored procedures i fyspaf:
//
// DTB_DeleteRemFromTB, DTB_GetRemisser, DTB_GetTidbok, DTB_GetTidbokTyp,
// DTB_InsertTb, DTB_UpdateTb_ExamTime, DTB_UpdateTb_Status,
// samt DTBMoveRemInTb.
//
// ***************************************************************************

// Revision ******************************************************************

// 2013-10-22


unit AkutKalender2;

{ $define ns_debug}
{ $define demo }

interface

uses
  Password,
  ActiveX,
  PafPlanner, System.IniFiles, StrUtils,
  Windows, Messages, ComCtrls, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, Menus,
  AdvPolyList, CurvyControls,
  AdvSmoothLabel, ExtCtrls, AdvSplitter,
  StdCtrls, AdvSmoothEdit, AdvSmoothEditButton, AdvSmoothDatePicker,
  Ribbon,
  // AdvmSQLS,
  PlannerDatePicker,
  SqlExpr,
  AdvDropDown,
  Grids,
  BaseGrid, AdvGrid,
  AdvDateTimePicker,
  DateUtils,
  // Setup3,
  AdvMenus, AdvEdit, AdvEdBtn,
  AdvObj,
  Setup5,
  DBAdvGrid,
  AdvOfficeButtons, Planner, PlannerWaitList,
  PAFEdit3, ExeInfo,
  Data.DB,
  Data.DBXMSSQL,
  // Data.FMTBcd,
  Datasnap.DBClient,
  Datasnap.Provider,
  Vcl.Mask, AdvSmoothListBox, AdvSmoothComboBox, clisted,
  AeroButtons, Data.FMTBcd, AdvSpin, PictureContainer, AdvSmoothSplashScreen,
  Vcl.Samples.Spin, paramchklist, Vcl.DBCtrls, AdvCombo, AdvSmoothPanel,
  AdvSmoothExpanderPanel, AdvPanel;

//Const
  // *************************************
  // kalenderna uppdelning
  // Skall vara i ngn slags setup sen
  // *************************************
  //CDisplayUnit = 15; // Uppdelningen av kalendern i 15 minutersintervall
  //CDisplayStart = 6; // Klockan 6
  //CDisplayEnd = 20; // Klockan 20
  //CActiveStart = 7; // Klockan 7
  //CActiveEnd = 19; // Klockan 19

type

  //ShortString = String[15];
  //Longstring = String[50];

  TMainForm = class(TForm)
    AdvSmoothLabel1: TAdvSmoothLabel;
    ItemPopupMenu1: TAdvPopupMenu;
    Visaalladata1: TMenuItem;
    Annanavdelning1: TMenuItem;
    Sng1: TMenuItem;
    TimerKlocka: TTimer;
    TimerPlanner: TTimer;
    AdvMainMenu1: TAdvMainMenu;
    File1: TMenuItem;
    AdvSplitter2: TAdvSplitter;
    Instllningar1: TMenuItem;
    Lokalainstllningar1: TMenuItem;
    ExeInfo1: TExeInfo;
    PafItemEditor1: TPafItemEditor;
    DataSourceTB: TDataSource;
    DataSourceRemiss: TDataSource;
    TimerRemiss: TTimer;
    CurvyPanel1: TCurvyPanel;
    AdvSplitter1: TAdvSplitter;
    MYPAFWaitList1: TMYPAFWaitList;
    PAFPlanner: TMyPAFPlanner;
    ClientDataSetTB: TClientDataSet;
    DataSetProviderTB: TDataSetProvider;
    DTB_GetTB: TSQLDataSet;
    FYSPAF: TSQLConnection;
    DTB_GetRemisser: TSQLDataSet;
    DataSetProviderremiss: TDataSetProvider;
    ClientDataSetRemiss: TClientDataSet;
    SQLMonitor1: TSQLMonitor;
    SQLQuery1: TSQLQuery;
    GridSQLError: TDBAdvGrid;
    DspSQLError: TDataSetProvider;
    CdsSQLError: TClientDataSet;
    DSSQLerror: TDataSource;
    ItemPopupMenu2: TAdvPopupMenu;
    Orsak1: TMenuItem;
    Stngavprogrammet1: TMenuItem;
    PictureContainer1: TPictureContainer;
    LbNrRemisser: TLabel;
    ExpanderPanelInst: TAdvSmoothExpanderPanel;
    DatePicker1: TAdvSmoothDatePicker;
    SpinEditAntDagar: TSpinEdit;
    Label4: TLabel;
    Button2: TButton;
    ChekboxHelaDagen: TAdvOfficeCheckBox;
    CurvyPanel3: TCurvyPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    CheckListExtPrio: TCheckListEdit;
    AdvSpinEditTurklass: TAdvSpinEdit;
    ParamCheckListRemissgrupp: TParamCheckList;
    DayGrid: TDBAdvGrid;
    RemissGrid: TDBAdvGrid;
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

    procedure ChekboxHelaDagenClick(Sender: TObject);
    procedure abortmarkering1Click(Sender: TObject);

    // ******************************************
    // Edit
    procedure MyPAFPlanner1Items0EditModal(Sender: TObject);
    // procedure MYPAFWaitList1ItemDblClick(Sender: TObject; Item: TPlannerItem);
    // ******************************************
    // Inst�llningar
    procedure FormActivate(Sender: TObject);
    procedure Lokalainstllningar1Click(Sender: TObject);
    procedure MyPAFPlanner1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure PAFWaitList1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure PAFWaitList1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure PAFPlannerPlannerRightClick(Sender: TObject;
      Position, FromSel, FromSelPrecise, ToSel, ToSelPrecise: Integer);
    procedure PAFPlannerDragDropCell(Sender, Source: TObject; X, Y: Integer);
    procedure DefaultItemEditor1BeforeEditShow(Sender: TObject;
      APlannerItem: TPlannerItem);

    procedure PAFPlannerDragDropItem(Sender, Source: TObject; X, Y: Integer;
      PlannerItem: TPlannerItem);
    procedure PAFPlannerItemSize(Sender: TObject; Item: TPlannerItem;
      Position, FromBegin, FromEnd, ToBegin, ToEnd: Integer);
    procedure PAFPlannerItemMove(Sender: TObject; Item: TPlannerItem;
      FromBegin, FromEnd, FromPos, ToBegin, ToEnd, ToPos: Integer);
    procedure TimerRemissTimer(Sender: TObject);
    procedure CheckListExtPrioChange(Sender: TObject);
    //procedure CheckListTurKlassChange(Sender: TObject);
    procedure PAFPlannerDragOverItem(Sender, Source: TObject; X, Y: Integer;
      APlannerItem: TPlannerItem; State: TDragState; var Accept: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure AdvSpinEditTurklassChange(Sender: TObject);
    procedure Stngavprogrammet1Click(Sender: TObject);
    procedure MYPAFWaitList1ItemDblClick(Sender: TObject; Item: TPlannerItem);
    procedure Button2Click(Sender: TObject);
    procedure SpinEditAntDagarChange(Sender: TObject);
    procedure DBComboBox1Change(Sender: TObject);
    procedure ExpanderPanelInstEndDrag(Sender, Target: TObject; X, Y: Integer);

  private
    { Private declarations }

    imorgon: Boolean;
    RemissLatestRead,
    CurrDay: TDateTime;
    ColumnsPerDay{,
    DaysShown}: Integer; //Antal dagar som visas i tidboken
    // TidbokCols   : TCols;

    TurKlassVald: Integer;
    ExtPrioVald, UserId, PCNamn: String;
    // FItem: TMyPAFItem;
    // DisplayMinutes: Integer;

    // **********************************************************************
    // Hitta ett f�lt i en grid med hj�lp av f�ltnamnet.
    // Ger kolumnens nummer som resultat
    // function FieldByName(const DBGrid: TDBAdvGrid; NameS: String): Integer;

    // **********************************************************************
    // Procedurer som l�ser in tidbok och v�ntelista ************************
    // **********************************************************************
    procedure ReadDayFromPAF(FirstDay: TDateTime; NoDays : Integer);
    procedure ReadRemissFromPaf;
    procedure HeaderSetup(Date: TDatetime; NoDays: Integer);
    (*
    function TBHeaderAndDateToCol(StartTid: TDateTime; NoColsPerDay:Integer; ColHeader: String): Integer;
    function TBColToHeader(P: Integer): String;
    function TBColToDate(StartTid: TdateTime; NoColsPerDay, Column: Integer): TDateTime;
    *)
    procedure AddLunch(starttime, endtime: TDateTime);
    procedure SaveUstoPAF(RemissId, Tidbas, Tidbok, UserId, PCNamn: String;
      ALnr, UndTid: Integer);
    //procedure DisplayUpdateNew(DUnit: Integer; DStart, DEnd, AStart, AEnd: TTime);
    procedure DisplayUpdate(DUnit, DStart, DEnd, AStart, AEnd: Integer);
    procedure SQLFel(Rad, AlNr: Integer; Modul, RemissId, Tidbas, UserId, PCnamn, Tidbok, S: string);
    //procedure ItemToDayGrid(Item: TMyPafItem);
    //function GetDateTimeFromTidbok(X,Y: Integer):TDateTime;
  public
    { Public declarations }

  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}


procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin


  // FreeAndNil(Fitem);
  // MyPafPlanner1.Free
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  SQLMonitor1.Active := false;
  SQLMonitor1.FileName := 'sqlerror.txt';


  // Remissortering.
  // Till lokalt sparat val i xml fil eller registry senare 2013-04-04 / ns

  TurKlassVald := 1;
  ExtPrioVald := '';
  SQLQuery1.Active := false;
  SQLQuery1.SQL.Clear;
  FYSPAF.Connected := false;
  CurrDay := now;

  imorgon := false;
  PCNamn := ExeInfo1.ComputerName;
  UserId := 'Niklas'; // Ers�tts med inlogg n�r detta �r klart
  //RadioB_Dygn_1.Checked := false;

  PAFPlanner.DateTimeList.Add(CurrDay);
  PAFPlanner.DefaultItem.Editor := PafItemEditor1;
  MYPAFWaitList1.DefaultItem.Editor := PafItemEditor1;

  TimerKlocka.Interval := 1000;
  TimerPlanner.Interval := 60000;
  TimerRemiss.Interval := 50000;

end;

procedure TMainForm.FormShow(Sender: TObject);
begin

  (*
  PasswordDlg.ShowModal;
  if not PasswordDlg.ok then
  begin
    //MainForm.Close;
    exit
  end;
  *)
  SpinEditAntDagar.Value:=SetupForm.DaysShown;
  ExpanderPanelInst.Expanded:=False;
  FYSPAF.ConnectionName             := Setupform.ServerName;
  FYSPAF.DriverName                 := 'MSSQL';
  FYSPAF.Params.Values['HostName']  := Setupform.ServerName;

  FYSPAF.Params.Values['Database']  := Setupform.DatabasName;
  FYSPAF.Params.Values['User_name'] := Setupform.user;
  FYSPAF.Params.Values['Password']  := Setupform.password;
  FYSPAF.Params.Values['Provider']  := Setupform.Provider;
  FYSPAF.LoadParamsOnConnect        := false;
  FYSPAF.LoginPrompt                := false;

  DisplayUpdate(15, 6, 20, 7, 19);
  (*
  DisplayUpdateNew( SetupForm.SchemaDisplayUnit,
                 SetupForm.SchemaStart,
                 SetupForm.SchemaStop,
                 SetupForm.SchemaStart - SetupForm.SchemaDisplayUnit div 1440,
                 SetupForm.SchemaStop + SetupForm.SchemaDisplayUnit div 1440); // Skall kunna konfigureras av anv�ndare.
  *)
  // FYSPAF.Params.Add('provider = ' + SetupForm.Provider);

  //CoUninitialize;

  if not SetupForm.DatabaseOK then
  begin
    Caption:='Ingen Databaskoppling! Ta kontakt med din support.';
    Color:=clRed;
  end else
  begin
    ReadRemissFromPaf;
    TimerRemiss.Enabled      := true;
    TimerRemiss.Interval     := 300000; //Fem minuter
    DatePicker1.Date         := CurrDay; // L�ser ocks� in data
    HeaderSetup(CurrDay,SetupForm.DaysShown);
    Caption                  := 'Kopplad till databasen: '+ SetupForm.DatabasName
  end;


  // SetupForm3.Get(TidBokCols);
{$IFDEF ns_debug}
  DayGrid.show;
  RemissGrid.show;
  GridSQLError.show;
  GridSQLError.Columns[2].Width := 485;
  Caption := FYSPAF.ConnectionName;
{$ENDIF}

end;


procedure TMainForm.FormActivate(Sender: TObject);
begin
  DayGrid.Hide;
  RemissGrid.Hide;
  GridSQLError.Hide;
end;

procedure TMainForm.HeaderSetup(Date: TDatetime; NoDays: Integer);
var
  D, I, NumOfCols: Integer;
  S: String;
  Datum: TDateTime;
begin

  // MyPAFPlanner1.Positions := 7;
  NumOfCols := 0;
  for I := 0 to Setupform.TidbokKolumner.items.Count - 1 do
    if Setupform.TidbokKolumner.Checked[I] then
      Inc(NumOfCols);
  ColumnsPerday:= NumOfCols;
  PAFPlanner.Positions := NumOfCols*Nodays;

  PAFPlanner.PositionGroup := NumOfCols;

  PAFPlanner.Mode.PlannerType := plDay;
  PAFPlanner.Mode.Date := CurrDay;
  PAFPlanner.Mode.TimeLineStart := CurrDay;

  with PAFPlanner.Header do
  begin
    Captions.Clear;
    GroupCaptions.Clear;
    Captions.Add('');

    for D:= 0 to NoDays - 1 do
    begin

      for I := 0 to Setupform.TidbokKolumner.items.Count - 1 do
      begin
        if Setupform.TidbokKolumner.Checked[I] then
        begin
          S := Setupform.TidbokKolumner.items[I];
          Captions.Add(S);
        end;
      end;
      Datum:=Date+D;
      GroupCaptions.Add(FormatDateTime('dd mmmm yyyy', Datum));
    end;

  end;
  ReadremissFrompaf;
end;

procedure TMainForm.Lokalainstllningar1Click(Sender: TObject);
begin
  // Justera inst�llningar
  // Fn. bara f�r rum.
  Setupform.show;
  HeaderSetup(CurrDay,SetupForm.DaysShown);
end;

procedure TMainForm.PAFPlannerItemMove(Sender: TObject; Item: TPlannerItem;
  FromBegin, FromEnd, FromPos, ToBegin, ToEnd, ToPos: Integer);

var
  T1: TDateTime;
  S: String;
  Col: Integer;

begin
{$IFDEF ns_debug}
  SQLMonitor1.Active := true;
{$ENDIF}

  CdsSQLError.Active := false;
  SQLQuery1.SQL.Clear;
  T1 :=  PAFPlanner.PafCellToDateTime(columnsperday, ToPos, ToBegin);
  TMyPafItem(Item).PafStartTime  := T1;
  TMyPafItem(Item).ItemStartTime := TMyPafItem(Item).PafStartTime;

  Col := PafPlanner.HeaderAndDateToCol(TMyPafItem(Item).PafStartTime,CurrDay,
         columnsperday, PafPlanner.ColToHeader(ToPos));
  TMyPafItem(Item).ItemPos := Col;

  S := 'exec DTBMoveRemInTb ' + QuotedStr(TMyPAFItem(Item).rid) + ',' +
       IntToStr(TMyPAFItem(Item).ALnr) + ',' + IntToStr(0) + ',' +
       QuotedStr(DateTimeToStr(TMyPAFItem(Item).PafStartTime)) + ','+
       QuotedStr(PAFPlanner.ColToHeader(ToPos)) + ','+
       QuotedStr(UserId) + ',' + QuotedStr(PCNamn);

  SQLQuery1.SQL.Add(S);
  SQLQuery1.Prepared := true;
  CdsSQLError.Active := true;

  if (GridSQLError.Cells[1, 1] <> '0') then
  begin
   SQLFel(  435,
            TMyPAFItem(Item).ALnr,
            'Akutkalender2',
            TMyPAFItem(Item).Rid ,
            DateTimeToStr(TMyPAFItem(Item).PafStartTime),
            UserId, PCNamn,
            IntToStr(ToPos),S);
  end;
  ReadDayFromPAF(CurrDay,SetupForm.DaysShown);

{$IFDEF ns_debug}
  GridSQLError.Columns[2].Width := 485;
  MainForm.Caption := FYSPAF.ConnectionName + '  ' + S;
  SQLMonitor1.Active := false;
{$ENDIF}
end;

procedure TMainForm.MyPAFPlanner1Items0EditModal(Sender: TObject);
begin
  // MyPafeditor1.Edit(MyPAFPlanner1,MyPafPlanner1.Items.Selected);
end;

procedure TMainForm.PAFPlannerItemSize(Sender: TObject; Item: TPlannerItem;
  Position, FromBegin, FromEnd, ToBegin, ToEnd: Integer);

var
  S: String;
  TempTime: Integer;

begin
{$IFDEF ns_debug}
  SQLMonitor1.Active := true;
{$ENDIF}
  // Os�ker ber�kning fn. / NS
  //PAFPlannerItemMove(Sender,Item,FromBegin,FromEnd,Item.ItemPos,ToBegin,ToEnd,Item.ItemPos);
  CdsSQLError.Active := false;
  SQLQuery1.SQL.Clear;
  TempTime := (ToEnd - ToBegin) * SetupForm.SchemaDisplayUnit;
  S := 'exec DTB_UpdateTb_ExamTime ' + IntToStr(TMyPAFItem(Item).ALnr) + ','
  // + IntToStr(-7) + ','

    + IntToStr(TempTime) + ','
  // Hur uppdaterar jag utid?
    + QuotedStr(UserId) + ',' + QuotedStr(PCNamn);

  SQLQuery1.SQL.Add(S);
  SQLQuery1.Prepared := true;
  CdsSQLError.Active := true;
  //TMyPAFItem(Item).ItemStartTime:=ToBegin;
  (*
  TMyPAFItem(Item).PafStartTime:=ToBegin;
  TMyPAFItem(Item).PafEndTime:=TMyPAFItem(Item).PafStartTime + TempTime;
  TMyPAFItem(Item).ItemStartTime:=ToBegin;
  *)

{$IFDEF ns_debug}
  GridSQLError.Columns[2].Width := 485;
  MainForm.Caption := FYSPAF.ConnectionName + '  ' + S;
  SQLMonitor1.Active := false;
{$ENDIF}
end;

procedure TMainForm.PAFPlannerPlannerRightClick(Sender: TObject;
  Position, FromSel, FromSelPrecise, ToSel, ToSelPrecise: Integer);
begin
  with PAFPlanner.CreateItemAtSelection do
  begin
    Text.Text := 'Orsak?';
    Captiontype := ctTime;
    BackGround := false;
    Layer := 1;
    FixedPos := false;
    Captiontext := 'Blockerad tid';
    Color := RGB(127, 127, 100);
    // PopUpMenu := ItemPopupMenu2;
    Editor := nil;
    Shape := psRounded;
    Update;
  end;

end;

procedure TMainForm.MYPAFWaitList1ItemDblClick(Sender: TObject;
  Item: TPlannerItem);
begin
  // Edit item
  PafItemEditor1.Edit(PAFPlanner,TMyPAFItem(Item));
end;

procedure TMainForm.abortmarkering1Click(Sender: TObject);
begin
  Beep
end;

procedure TMainForm.AddLunch(starttime, endtime: TDateTime);
var
  I: Integer;
begin
  for I := 0 to PAFPlanner.Positions - 1 do
  begin
    with TMyPAFItem(PAFPlanner.CreateItem) do
    begin
      ItemStartTime := CurrDay + starttime;
      ItemEndTime := CurrDay + endtime;
      BackGround := true;
      AllowOverlap := true;
      Alignment := taCenter;
      Color := RGB(150, 200, 150);
      Text.Text := 'Lunch';
      ItemPos := I
    end;
  end;

end;

procedure TMainForm.AdvSpinEditTurklassChange(Sender: TObject);
begin
  //
  TurKlassVald := AdvSpinEditTurklass.Value
end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
  ReadRemissFromPaf;
end;

procedure TMainForm.Button2Click(Sender: TObject);
begin
  ReadDayFromPaf(CurrDay,SetupForm.DaysShown)
end;

procedure TMainForm.CheckBoxHelgerClick(Sender: TObject);
begin
(*
  if CheckBoxHelger.Checked = true then
  begin
    // Tv� dagar
    // Om helgdagar skall visas s� �r de tv� dagarna t.x fr + l�, annars fr + m�
    //
    MyPAFPlanner1.DateTimeList.Add(CurrDay);
  end
  else
*)
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
    PAFPlanner.Display.ScaleToFit := true;
    DisplayUpdate(30, 6, 20, 7, 19);
  end
  else
  begin
    PAFPlanner.Display.ScaleToFit := false;
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

    PAFPlanner.DateTimeList.Clear;
    PAFPlanner.DateTimeList.Add(D);

    HeaderSetup(CurrDay,SetupForm.DaysShown);
    ReadDayFromPAF(D, SetupForm.DaysShown);
  end;

end;

procedure TMainForm.DBComboBox1Change(Sender: TObject);
begin
 // �ndra urval
end;

procedure TMainForm.DefaultItemEditor1BeforeEditShow(Sender: TObject;
  APlannerItem: TPlannerItem);
begin
end;


// **********************************************************************
// **********************************************************************
// ******* procedurer f�r drag and drop mellan waitlist och planner *****
// **********************************************************************

// **********************************************************************
// procedure MyPAFPlanner1DragOver
// Endast klipp fr�n waitlist
// **********************************************************************
procedure TMainForm.MyPAFPlanner1DragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := (Source is TMYPAFWaitList) and (X > -1) and (Y > -1);
{$ifdef ns_debug}
    Caption:='X= '+InttoStr(X)+' Y= '+IntToStr(y)+' Datum = '+DateTimeToStr(PafPlanner.ColToDate(currday, ColumnsPerDay, x))+
    ' ColHeader = ' + PafPlanner.ColToHeader(X);
    //' PafCellTodatetime = '+ DateTimeToStr(PafPlanner.PafCellToDateTime(ColumnsPerDay,X,Y))
{$endif}
end;

procedure TMainForm.PAFPlannerDragDropCell(Sender, Source: TObject;
  X, Y: Integer);
var
  TmpTime: TDateTime;
begin
  if PAFPlanner.CellToItemNum(X, Y) = 0 then
  begin
    with TMyPAFItem(PAFPlanner.CreateItem) do
    begin
      Assign(TMyPAFItem(MYPAFWaitList1.items[MYPAFWaitList1.ItemIndex]));

      TmpTime        := PAFPlanner.PafCellToDateTime(columnsperday, X, Y);
      PafStartTime   := TmpTime; //PafPlanner.ColToDate(TmpTime,ColumnsPerDay,X);

      TmpTime        := PafStartTime + EncodeTime(Utid div 60, Utid mod 60, 0, 0);
      PafEndTime     := TmpTime;
      Usrum          := PafPlanner.ColToHeader(X);

      Color          := clSilver;
      //Caption.color:=rgb(100,0,0);
      //Captiontype:=ctTime;
      Caption        := DateTimeToStr(PafStartTime);
      Statusflg      := 1;


      ItemStartTime := PafStartTime;
      ItemEndTime   := PafEndtime;
      ItemPos       := PAFPlanner.HeaderAndDateToCol(PafStartTime, Currday,
                       ColumnsPerDay, UsRum);
      SaveUstoPAF(  rid, DateTimeToStr(PAFStartTime), PafPlanner.ColToHeader(ItemPos),
	                  UserId, ExeInfo1.ComputerName, { ALnr+1 } 0, Utid);
    end;

    //ItemToDayGrid(TMyPAFItem(MYPAFWaitList1.Items.Items[MYPAFWaitList1.ItemIndex]));
    MYPAFWaitList1.items.Delete(MYPAFWaitList1.ItemIndex);
    Update;
  end;

end;

(*
procedure TMainForm.ItemToDayGrid(Item: TMyPafItem);
var lines : Integer;
begin
  // L�gger till ett Item to Daygrid i v�ntan p� uppdatering fr�n databasen.
  // OBS Ej kontrollerad!!!!
  Daygrid.AddRow;
  lines:=DayGrid.Row;
  DayGrid.Cells[1,lines]  := DateTimeToStr(Item.PafStartTime); //	varchar(16) 	Tid f�r raden						2012-02-27 07:45
  DayGrid.Cells[2,lines]  := InttoStr(Item.ALNr); //	int 		Unikt id tilldelas varje rad					598876
  DayGrid.Cells[3,lines]  := InttoStr(Item.ALlnr); //	smallint		Uppdateringsflagga ALlnr=ALlnr+1 vid varje �ndring  	1
 	DayGrid.Cells[4,lines]  := InttoStr(Item.MallFlg); // tinyint 		1=Normal tid  0=Special/Reserverad tid			1
  DayGrid.Cells[5,lines]  := InttoStr(Item.StatusFlg); //	smallint 		0=Ej bok. 1=Bok. 2=Anl�nt 3=P�g. 4=Avsl. 5=Prel.		2
  DayGrid.Cells[6,lines]  := InttoStr(Item.TextFlg);   //		smallint		0=Normal  1=Textrad som visas i alla tidb�cker		0					Global tid Ex: Lunch 12:30
  DayGrid.Cells[7,lines]  := InttoStr(Item.BlockFlg); //     		smallint		0=Normal  1= Tiden blockerad kan ej bokas		0
  DayGrid.Cells[8,lines]  := Item.TdbTyp1; //        		char(15) 	Selektering i tidbok def. Unders�kn Ex. EKO
  DayGrid.Cells[9,lines]  := Item.TdbTyp2; // 		char(15) 	Selektering i tidbok def L�ksign  Ex. JML
  DayGrid.Cells[10,lines] := Item.TdbTyp3; //   		char(15) 	Selektering i tidbok def Bes�kstyp Ex. A=Akut
  DayGrid.Cells[11,lines] := Item.TdbTyp4; //   		char(15) 	Selektering i tidbok def Leverant�r Ex. ISOTOP
  DayGrid.Cells[12,lines] := Item.TdbTyp5; //        		char(15) 	Kommentar till tid Ex. FORSKN.
  DayGrid.Cells[13,lines] := Item.Pid; //         		char(15) 	Patient Id						19121212-1212
  DayGrid.Cells[14,lines] := Item.Rid; //         		char(15) 	Remiss identitet						10-123
  DayGrid.Cells[15,lines] := Item.PatNamn; //			varchar(50)	Sammanslagning av Efternamn + F�rnamn			Tolvansson Tolvan
  DayGrid.Cells[16,lines] := Item.ProdKod; //     		varchar(15) 	Unders�kningskod 					300
  DayGrid.Cells[17,lines] := Item.ProdText; //         		varchar(50) 	Fri text unders�kning					Arbetsprov
  DayGrid.Cells[18,lines] := Item.BestId; //      		varchar(15) 	Best�llarens v�rdadress					10013 102 31
  DayGrid.Cells[19,lines] := Item.BestTxt; //       		varchar(50) 	Namn p� best�llare					Avd 31 S�S
  DayGrid.Cells[20,lines] := DateTimeToStr(Item.PafBestDatum); //     		smalldatetime 	Best�llningsdatum remiss					2012-03-12
  DayGrid.Cells[21,lines] := Item.LevtId; //             		varchar(15) 	Leverant�rens identitet					10013 831 L01
  DayGrid.Cells[22,lines] := Item.Levttxt; //        		varchar(50) 	Leverant�rens namn					Fyslab S�S
  DayGrid.Cells[23,lines] := InttoStr(Item.Prioritet); //       		tinyint 		Prioritet numeriskt v�rde
  DayGrid.Cells[24,lines] := InttoStr(Item.Utid); //			smallint		F�rv�ntad unders�kningstid i minuter			20
  DayGrid.Cells[25,lines] := Item.PatKomm; //		varchar(255)	Remisskommentar
  DayGrid.Cells[26,lines] := Item.Fragetext; //		varchar(255)       Fr�gest�llning
  DayGrid.Cells[27,lines] := Item.Anamnes; //		varchar(8000)      Anamnes
  DayGrid.Cells[28,lines] := Item.Ordination; //		varchar		H�mtas fr�n ett antal tabeller bl.a Ordinationstab. Inneh�ller det man skrivit i ordination p� remissen

end; *)

// **********************************************************************
// *** Procedurer f�r drag drop p� en befintlig tid *********************
// **********************************************************************


// **********************************************************************
// procedure MyPAFPlanner1DragOverItem
// Kontrollerar att det �r ok att sl�ppa ett item p� ett annat
// Endast klipp fr�n planner eller waitlist samt att det skall vara
// en tom tid, vilket motsvarar StatusFlg = 0
// **********************************************************************

procedure TMainForm.PAFPlannerDragOverItem(Sender, Source: TObject;
  X, Y: Integer; APlannerItem: TPlannerItem; State: TDragState;
  var Accept: Boolean);
begin
  // Accepteras om k�llan �r ok och statusflag = 0 dvs en tom tid.
  Accept := ((Source is TMyPAFPlanner) or (Source is TMYPAFWaitList)) and
    (TMyPAFItem(APlannerItem).StatusFlg = 0);
end;
// **********************************************************************
// Flytta fr�n v�ntelista till en f�rdig tid i tidboken.
// **********************************************************************
procedure TMainForm.PAFPlannerDragDropItem(Sender, Source: TObject;
  X, Y: Integer; PlannerItem: TPlannerItem);
begin
  //CdsSQLError.Active := false;
  with TMyPAFItem(PlannerItem) do
  begin

    // AlNr := TMyPafItem(Source).ALNr;
    BackGround := false;
    Focus := true;
    Captiontype := ctText;
    Captiontext := Trim(Prodkod + ' ' + PatNamn);
    Editor := PafItemEditor1;
    Color := clGreen;

    if Source is TMYPAFWaitList then
      begin
        CopyRemissdataOnly
          (TMyPAFItem(MYPAFWaitList1.items[MYPAFWaitList1.ItemIndex]));
        SaveUstoPAF(rid, '', '', UserId, PCNamn, ALnr, Utid);
        MYPAFWaitList1.items.Delete(MYPAFWaitList1.ItemIndex);
      end
    else
      begin
        CopyRemissdataOnly(PAFPlanner.items.Selected);

        PAFPlannerItemMove(
        Sender, PlannerItem,
        PAFPlanner.items.Selected.ItemBegin,
        PAFPlanner.items.Selected.ItemEnd ,
        PAFPlanner.items.Selected.ItemPos,
        ItemBegin,
        ItemEnd,
        ItemPos);
      end;
  end;

  if Source is TMYPAFWaitList then
    MYPAFWaitList1.items.Delete(MYPAFWaitList1.ItemIndex)

end;

// **********************************************************************
// Flytta �ter fr�n Tidbok till v�ntelistan
// **********************************************************************

procedure TMainForm.PAFWaitList1DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  // Accepterar bara objekt fr�n PafPlanner.
  Accept := (Source is TMyPAFPlanner);
end;

procedure TMainForm.PAFWaitList1DragDrop(Sender, Source: TObject;
  X, Y: Integer);
var
  S: String;
begin
  if Assigned(PAFPlanner.items.Selected) then
  begin
    //
    SQLQuery1.SQL.Clear;

    S := 'exec DTB_DeleteRemFromTB ' +
      QuotedStr(TMyPAFItem(PAFPlanner.items.Selected).rid) + ',' +
      QuotedStr(UserId) + ',' + QuotedStr(PCNamn);

    SQLQuery1.SQL.Add(S);

    SQLQuery1.Prepared := true;
    try
    CdsSQLError.Active := true;
    except
      on  E: TSQLQuery do
      begin
        Messagedlg('SQL fel rad 837 PAFWaitlistDragDrop. '+E.Classname, mtError,[mbOK],0);
      end;
    end;
{$IFDEF ns_debug}
    MainForm.Caption := S;
    GridSQLError.Columns[2].Width := 485;
{$ENDIF}
    MYPAFWaitList1.items.Add.Assign(PAFPlanner.items.Selected);
    PAFPlanner.FreeItem(PAFPlanner.items.Selected);
    //ReadDayFromPAF(CurrDay);
  end;
end;
// **********************************************************************
// ******* Slut p� drag and drop ***************************************
// **********************************************************************


// **********************************************************************
// ***** Skriver bokade eller �ndrade remisser till PAF databasen *******
// **********************************************************************
// Namn: SaveUstoPAF
// Parameter:
// @P_RemissId	varchar(15),		/* RemissId*/
// @Alnr		int = Null,
// @P_Tidbas	varchar(25)='',		/*�nskad tid (om det �r en ny tid)*/
// @P_TidBok	varchar(25)='',		/*�nskad tidbok (om det �r en ny tid)*/
// @P_UndTid	smallint=0,		    /*F�rv�ntad unders�kningstid i minuter*/
// @P_UserId	varchar(15),		  /* Anv�ndarID*/
// @P_PCnamn	varchar(15)		    /* PCnamn*/
// Resultat: Skriver en f�r�ndrad unders�kning till PAF
// Kallar:  DTB_InsertTb
// **********************************************************************

procedure TMainForm.SaveUstoPAF(RemissId, Tidbas, Tidbok, UserId,
  PCNamn: String; ALnr, UndTid: Integer);

var
  S: String;
  SQLError:Boolean;
begin
  SQLError:=false;
  Coinitialize(nil);
  CdsSQLError.Active := false;
  SQLQuery1.SQL.Clear;

  S := 'exec DTB_InsertTb ' + #39 + Trim(RemissId) + #39 + ',' +
    IntToStr(ALnr) + ','
  // + IntToStr(0)               + ','
    + QuotedStr(Tidbas) + ',' + QuotedStr(Tidbok) + ',' + IntToStr(UndTid) + ','
    + QuotedStr(UserId) + ',' + QuotedStr(PCNamn);

  SQLQuery1.SQL.Add(S);

{$IFDEF ns_debug}
  MainForm.Caption := FYSPAF.ConnectionName + '  ' + S;

{$ENDIF}
  SQLQuery1.Prepared := true;

  try
    CdsSQLError.Active := true;
  except

    SQLError:=true;
  end;

  if (GridSQLError.Cells[1, 1] <> '0') or (SQLError = true) then
  SQLFel( 906, AlNr, 'Akutkalender2', RemissId, Tidbas, UserId, PCnamn, Tidbok, S);
  // SQLQuery1.Open;

end;


procedure TMainForm.SpinEditAntDagarChange(Sender: TObject);
begin
  SetupForm.DaysShown:=SpinEditAntDagar.Value;
  SetupForm.WriteToInifile;

end;

procedure TMainForm.Stngavprogrammet1Click(Sender: TObject);
begin
  Close;
end;

// ***************************************************************************
// ****************** Drag dropp end *****************************************
// ***************************************************************************
// ***************************************************************************

procedure TMainForm.RadioB_2DygnClick(Sender: TObject);
begin
  imorgon := true;
end;

procedure TMainForm.RadioB_Dygn_1Click(Sender: TObject);
begin
  imorgon := false;
end;


// **********************************************************************
// ***** L�ser in en dags unders�kningar fr�n PAF databasen *************
// **********************************************************************
// Namn: ReadDayFromPAF
// Parameter: dt: �nskat datum
// Resultat: L�ser in alla unders�kningar f�r datumet i fr�ga
// Kallar: NewItemToTidbok en g�ng f�r varje post
// **********************************************************************

procedure TMainForm.ReadDayFromPAF(FirstDay: TDateTime; NoDays : Integer);

var
  I, Column: Integer;
  //LoeInDatePart: Double;
  LengthOfExam: String;
  tmp_Rum: String;
  // LocalItem: TMyPafItem;
begin
{$IFDEF ns_debug}
  SQLMonitor1.Active          := false;
{$ENDIF}
  Cursor                      := crHourGlass;
  DayGrid.Clear;
  Caption                     := 'V�nta! L�ser in dagens unders�kningar';
  //Coinitialize(nil);

  // **********************************************************************
  // �ppna en stored procedure och l�s till Tabellen Daygrid
  // **********************************************************************

  // Fyspaf.Connected:=true;
  ClientDataSetTB.Active      := false;

  DTB_GetTB.Active            := false;
  DTB_GetTB.ParamByName('@FranDatum').AsString := DateTimeToStr(FirstDay);
  DTB_GetTB.ParamByName('@AntDagar').AsInteger := NoDays - 1;
  DTB_GetTB.Prepared          := true;

  // DTB_GetTidbok.Active:=TRUE;
  ClientDataSetTB.Open;
  // ClientDataSetTB.LogChanges:=False;

  PAFPlanner.items.ClearAll;
  PAFPlanner.items.BeginUpdate;

  // **********************************************************************
  // Loopen l�ser rad f�r rad i Daygrid och g�r nya entrys i Tidboken
  // **********************************************************************

  if DayGrid.RowCount > 1 then
  begin
    for I := 1 to DayGrid.RowCount - 1 do
    begin
      DayGrid.Row := I;
      tmp_Rum := Trim(DayGrid.Cells[8, I]);

      if PafPlanner.HeaderAndDateToCol(currday,currday,ColumnsPerDay, tmp_Rum) > -1 then // Om det finns ett rum som passar
      begin
        with TMyPAFItem(PAFPlanner.CreateItem) do
        begin
          // ****************************************************
          // L�s fr�n dold grid, Daygrid till tidboken
          // En post per loop.
          // Bygger p� att daygrid har en fast ordning p� f�lten.
          // �ndras ordningen i stored procedure DTB_GetTidBok
          // s� m�ste denna �ndras.
          // Alternativt f�r proceduren g�ras om s� man s�ker
          // efter namn p� f�lten ist�llet. (Det tar f�rmodligen l�ngre tid.)
          //
          // Niklas 2013-04-13
          //
          // ****************************************************

          Prodkod           := DayGrid.Cells[16, I];
          LengthOfExam      := DayGrid.Cells[25, I];
          Utid := StrToInt(LengthOfExam);
          if Utid < 15  then Utid:= 15; // Minsta tidsuppl�sning = 15 min

          BesKomm           := DayGrid.Cells[21, I];
          PatKomm           := DayGrid.Cells[26, I];

          (*
          LoeInDatePart := StrToInt(LengthOfExam) / 1440;
          // Del av dygn ex. 30 minuter dividerat med 1440 minuter (ett dygn)
          ItemEndTime := ItemStartTime + LoeInDatePart;
          PafEndTime := ItemStartTime + LoeInDatePart;
          *)
          Prodtext          := DayGrid.Cells[17, I];
          UsRum             := Trim(DayGrid.Cells[8, I]);
          pid               := DayGrid.Cells[13, I];
          PatNamn           := DayGrid.Cells[15, I];
          RemUsr            := DayGrid.Cells[19, I];
          TdbUsr            := DayGrid.Cells[9, I];
          FrageText         := DayGrid.Cells[27, I];
          Anamnes           := DayGrid.Cells[28, I];
          rid               := Trim(DayGrid.Cells[14, I]);
          ALnr              := StrToInt(DayGrid.Cells[2, I]);
          ALlnr             := StrToInt(DayGrid.Cells[3, I]);
          StatusFlg         := StrToInt(DayGrid.Cells[5, I]);

          // Inst�llningar f�r presentation av PAFItem
          CaptionBkg        := clSilver;
          Color             := clSilver;
          Captiontype       := ctText;
          Captiontext       := Trim(Prodkod + ' ' + PatNamn);
          Editor            := PafItemEditor1;

          CaptionBkgTo      := clLime;
          CaptionBkg        := clLime;
          CaptionFont.Color := clBlack;

          case StatusFlg of
            0:
              begin // = Ej Bokad
                CaptionBkgTo       := clSilver;
                CaptionBkg         := clSilver;
                CaptionFont.Color  := clBlack;
{$IFDEF ns_debug}
                BackGround         := false;
                // Jag vill ha posten editerbar under debug.
{$ELSE}
                BackGround         := true;
                // Men annars ska en fast tid inte vara det f�rst�s.
{$ENDIF}
                CaptionBkg         := clSilver;
                CaptionBkgTo       := clSilver;
                Captiontype        := ctText;
                Captiontext        := 'Ledig tid';
              end;
            1:
              begin // Tiden �r bokad men inget annat har h�nt
                CaptionBkgTo       := clSilver;
                CaptionBkg         := clWhite;
                CaptionFont.Color  := clBlack;
              end;
            2:
              begin // Patienten har anl�nt
                CaptionBkgTo       := clRed;
                CaptionBkg         := clRed;
                CaptionFont.Color  := clWhite;
              end;
            3:
              begin // Unders�kningen p�g�r
                CaptionBkgTo       := clBlue;
                CaptionBkg         := clBlue;
                CaptionFont.Color  := clWhite;
              end;
            4:
              begin // Unders�kningen �r avslutad men inget svar �r skrivet
                CaptionBkgTo       := clGray;
                CaptionBkg         := clGray;
                CaptionFont.Color  := clWhite;
                Color              := clGray
              end;
            5:
              begin // Prelimin�rbokad
                CaptionBkgTo       := clLime;
                CaptionBkg         := clLime;
                CaptionFont.Color  := clWhite;
                Color              := clGray
              end;
            6:
              begin // Prelimin�rbokad
                CaptionBkgTo       := clFuchsia;
                CaptionBkg         := clFuchsia;
                CaptionFont.Color  := clWhite;
                Color              := clGray
              end
          end;

          PAFStartTime  := StrTodateTime(DayGrid.Cells[1, I]);
          PafEndTime    := PafStartTime + EncodeTime(Utid div 60, Utid mod 60, 0, 0);
          ItemStartTime := PafStartTime;
          ItemEndTime   := PafEndtime;
          Column        := PAFPlanner.HeaderAndDateToCol(PafStartTime,Currday, ColumnsPerDay, UsRum);
          ItemPos       := Column;

          Text.Text     := Trim(pid + #13 + FrageText + #13 + Anamnes);
{$IFDEF ns_debug}
          Captiontext   := DateTimetoStr(PafStartTime)+', '+UsRum;
{$ENDIF}
          Hint          := Text.Text;
          PopupMenu     := ItemPopupMenu1;
          ShowHint      := true;

        end
      end;
    end; // For I:= ...
  end; // if Tempgrid ...
  Update;
  AddLunch(SetupForm.LunchStart, setupform.LunchStop);
  PAFPlanner.items.EndUpdate;
  Caption:='Klart.';
{$IFDEF ns_debug}
  SQLMonitor1.Active := true;
  GridSQLError.Columns[2].Width := 485;
{$ENDIF}
  //CoUninitialize;
  Cursor:=crDefault;
end;

// ***************************************************************************
// ***************************************************************************
// ***************************************************************************
// L�ser in remisser fr�n PAF till v�ntelistan
// S� sm�ningom skall man klientm�ssigt kunna v�lja akuta etc.
// f�r n�rvarande l�ser proceduren endast in akuta "h�rdkodat"
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
  Cursor:=crHourGlass;
  //Coinitialize(nil);

  DTB_GetRemisser.ParamByName('@ExtPrio').AsWideString := ExtPrioVald;
  DTB_GetRemisser.ParamByName('@Turklass').AsInteger := TurKlassVald;
  //DTB_GetRemisser.Prepared := true;;

  if not Setupform.DatabaseOK then exit;
  if not Setupform.AllOk then exit;

  Caption:='V�nta! L�ser in remisser';
  ClientDataSetRemiss.Open;
  MYPAFWaitList1.items.ClearAll;
  MYPAFWaitList1.items.BeginUpdate;

  for I := 1 to RemissGrid.RowCount - 1 do
  begin
    // RemissGrid.Row := I;
    if (RemissGrid.Cells[1, I] > '') and (true) then
    begin
      with TMyPAFItem(MYPAFWaitList1.items.Add) do
      begin
        S       := Trim(RemissGrid.Cells[35, I]);
        akut    := false;
        Color   := RGB(128, 200, 128);

        if S = 'A' then
          begin
            akut         := true;
            CaptionBkg   := RGB(200, 100, 100);
            CaptionBkgTo := RGB(200, 100, 100);
            Color        := RGB(200, 0, 0)
          end;
        if S = 'I' then
          begin
            akut         := false;
            CaptionBkg   := RGB(200, 200, 100);
            CaptionBkgTo := RGB(200, 200, 100);
            Color        := RGB(200, 128, 0)
          end;
        if S = 'AI' then
          begin
            akut         := true;
            CaptionBkg   := RGB(200, 100, 200);
            CaptionBkgTo := RGB(200, 100, 200);
            Color        := RGB(200, 0, 100)
          end;


        Editor           := PafItemEditor1;
        pid              := RemissGrid.Cells[1, I];
        PatNamn          := RemissGrid.Cells[3, I] + ' ' + RemissGrid.Cells[2, I];;
        rid              := Trim(RemissGrid.Cells[7, I]);
        RDatum           := StrTodateTime(RemissGrid.Cells[6, I]);
        RemUsr           := RemissGrid.Cells[21, I];
        FrageText        := RemissGrid.Cells[44, I];
        Anamnes          := RemissGrid.Cells[45, I];

        LengthOfExam     := DayGrid.Cells[25, I];
        if LengthOfExam < '05' then  // Kan v�l inte vara mindre �n 5 minuter?
          LengthOfExam := '30';

        Utid             := StrToInt(LengthOfExam);
        PafBestDatum     := StrTodateTime(RemissGrid.Cells[6, I]);

        BestId           := RemissGrid.Cells[8, I];
        BestLak          := RemissGrid.Cells[14, I];
        Prodkod          := RemissGrid.Cells[15, I];

        // ALlnr och ALnr kan vara tomma fr�n databasen
        // -> s�tts d� till 0.  Ger annars rte.
        try
          ALlnr          := StrToInt(RemissGrid.Cells[5, I]);
        except
          ALlnr          := 0;
        end;

        try
          ALnr           := StrToInt(RemissGrid.Cells[4, I]);
        except
          ALnr           := 0;
        end;

        Captiontype      := ctText;
        Captiontext      := Trim('['+Prodkod+']' + ' ' + PatNamn);
        Text.Text        := Trim(pid + #13 + FrageText + #13 + Anamnes);
        Hint             := Text.Text;
        ShowHint         := true;

      end
    end;
    RemissLatestRead     := Now;
  end;
  Update;
  LbNrRemisser.Caption := IntToStr(RemissGrid.RowCount);
  LbNrRemisser.Color := clRed;

  MYPAFWaitList1.items.EndUpdate;
  ClientDataSetRemiss.Close;
{$IFDEF ns_debug}
  SQLMonitor1.Active     := true;
  GridSQLError.Columns[2].Width := 485;
{$ENDIF}
  CoUninitialize;
  Cursor                 := crDefault;
  Caption                := '';
end;

procedure TMainForm.DisplayUpdate(DUnit, DStart, DEnd, AStart, AEnd: Integer);
var
  RowsPerHour: Integer;
begin
  with PAFPlanner.Display do
  begin
    DisplayUnit   := DUnit;
    RowsPerHour   := 60 div DisplayUnit;
    DisplayStart  := DStart * RowsPerHour;
    DisplayEnd    := DEnd * RowsPerHour;
    ActiveStart   := (Astart - Dstart) * RowsPerHour;
    ActiveEnd     := Aend * RowsPerHour - DisplayStart;

  end;
  AddLunch(SetupForm.LunchStart, setupform.LunchStop);
end;

(*
procedure TMainForm.DisplayUpdateNew(DUnit: Integer; DStart, DEnd, AStart, AEnd: TTime);
var
  s,ms, // Dummys
  RowsPerHour,
  AktStartH,
  AktEndH,
  DispStartH,
  DispEndH,
  AktStartM,
  AktEndM,
  DispStartM,
  DispEndM: Word;
begin
  DecodeTime(Dstart,DispStartH,DispStartM,s,ms);
  DecodeTime(DEnd,DispEndH,DispEndM,s,ms);
  DecodeTime(AStart,AktStartH,AktStartM,s,ms);
  DecodeTime(AEnd,AktEndH,AktEndM,s,ms);

  with PAFPlanner.Display do
  begin
    DisplayUnit   := DUnit; // Indelning av schemat i minuter
    RowsPerHour   := 60 div DisplayUnit;
    DisplayStart  := DispStartH * RowsPerHour + DispStartM div DisplayUnit;
    DisplayEnd    := DispEndH * RowsPerHour + DispEndM div DisplayUnit;
    ActiveStart   := 1;
    ActiveEnd     := DisplayEnd + 1;
  end;
end; *)

procedure TMainForm.ExpanderPanelInstEndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  SetupForm.InsLeft:=X;
  SetupForm.InsTop:=Y;
  setupForm.WriteToInifile;
end;

procedure TMainForm.SQLFel(Rad, AlNr: Integer; Modul, RemissId, Tidbas, UserId, PCnamn, Tidbok, S: string);
var
  S1: string;
  F: Textfile;
begin
  begin

    Application.MessageBox('Oops, n�got gick fel. Felkoder finns i den lokala filen DTB-Error.txt.', 'Fel!', mb_OK);
    S1 := 'DTB-Error.txt';
    AssignFile(F, S1);
    if fileExists(S1) then
      Append(F)
    else
    begin
      Rewrite(F);
      Writeln(F, '----------------------------------------------------------------');
      Writeln(F, 'Det h�r �r en fil med felinformation fr�n PAFDTB.exe.');
      Writeln(F, 'Om felet upprepar sig, tag kontakt med PAF-leverant�ren eller');
      Writeln(F, 'direkt med konstrukt�ren Niklas Storck: niklas@storckholmen.se.');
      Writeln(F, 'E-posta g�rna en kopia av denna fil tilsammans med en beskrivning');
      Writeln(F, 'av n�r och hur felet uppstod.');
      Writeln(F, '----------------------------------------------------------------');
      Writeln(F, '');
    end;
    Writeln(F, 'Fel i DTB, Tid: ' + DateTimeToStr(now));
    Writeln(F, '-----------------------------------');
    Writeln(F, 'Modul: ' + Modul +', Programlinje: '+ IntToStr(Rad));
    Writeln(F, 'SQL fr�ga: ' + S);
    Writeln(F, 'Felkod: ' + GridSqlerror.Cells[1,1] + ', ' + GridSqlerror.Cells[2,1]);
    Writeln(F, 'Remissid: ' + RemissId + '. AlNr: ' + IntToStr(ALnr) + '. Tidbas: ' + Tidbas + '.');
    Writeln(F, 'Anv�ndare: ' + UserId + '. PCNamn: ' + PCNamn + '. Tidbok: ' + Tidbok + '.');
    Writeln(F, '');
    CloseFile(F);
    CoUninitialize;
    //ReadRemissFromPaf;
  end;
end;

procedure TMainForm.Table1AfterInsert(DataSet: TDataSet);
begin
  Update;
end;


procedure TMainForm.TimerKlockaTimer(Sender: TObject);
begin
  PAFPlanner.Caption.Title := '   ' + FormatDateTime('HH:mm:ss', now);
 (*
  if Setupform.Changed then
  begin
    HeaderSetup;
    if Setupform.DatabaseOK then
      ReadDayFromPAF(CurrDay);
    Setupform.Changed := false
  end;
  *)
end;

procedure TMainForm.TimerPlannerTimer(Sender: TObject);
begin
 if Setupform.DatabaseOK then  ReadDayFromPAF(CurrDay, SetupForm.DaysShown);
end;

procedure TMainForm.TimerRemissTimer(Sender: TObject);
begin
 if (RemissLatestRead - Now) > 0.05 then
    if Setupform.DatabaseOK then
       ReadRemissFromPaf;
end;

end.