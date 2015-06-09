unit Dataform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,DBGrids,ADODB, DB, Grids, FMTBcd, SqlExpr, ComCtrls, StdCtrls,DBTables;

type
  Tdataform1 = class(TForm)
    TidbokGrid: TDBGrid;
    MonthCalendar1: TMonthCalendar;
    Edit1: TEdit;
    Button1: TButton;
    Query1: TADOQuery;
    procedure FormCreate(Sender: TObject);
    procedure UpdateDay(day:TdateTime; Sender: TObject);
    procedure MonthCalendar1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);

  private
    { Private declarations }
    //SQLstr: string;
  public
    { Public declarations }
  end;

var
  data: Tdataform1;

implementation

{$R *.dfm}
{
This example demostrates the use of ADO for database conectivity.
Example assumes that a TDBGrid is placed on the form.
}


procedure Tdataform1.Button1Click(Sender: TObject);
var DataSrc: TDataSource;
begin

  with Query1 do begin
    with SQL do begin
      Clear;
      //Add('SELECT *');
      //Add('FROM dbo_TB1 WHERE TidBas = ' + Edit1.Text);
      Add(Edit1.Text);
      //Add('Jour');
    end;
  //Active;
  //Open;
  end;


  { Set the query to Prepared - will improve performance }

  Query1.Prepared := true;

  try
    Query1.Active := True;
  except
    on e: EADOError do
    begin
      MessageDlg('Error while doing query', mtError,
                  [mbOK], 0);

      Exit;
    end;
  end;

  { Create the data source }
  DataSrc := TDataSource.Create(Self);
  DataSrc.DataSet := Query1;
  DataSrc.Enabled := true;

  { Finally initilalize the grid }
  TidbokGrid.DataSource := DataSrc;
  //DataSrc.Destroy

end;

procedure Tdataform1.FormCreate(Sender: TObject);
begin
  Query1.connectionstring:='Provider=MSDASQL.1;Persist Security Info=False;Data Source=PAF_3';
  Query1.active:=false;
  Query1.SQL.Clear;
  Updateday(now,sender);
end;


procedure Tdataform1.MonthCalendar1Click(Sender: TObject);
begin

Updateday(MonthCalendar1.Date, Sender)

end;

procedure Tdataform1.UpdateDay(day:TdateTime;Sender: TObject);
var DataSrc: TDataSource;
    S:String;
    R : Real;
begin

  with Query1 do begin
    with SQL do begin
      Clear;
      Add('SELECT *');

      Add('FROM dbo_TB1 WHERE (TidBas > ');
      R:=Day-3;
      Str( R:5:0,S);
      Add(S+') AND ( TidBas < ' );

      R:=Day-2;
      Str( R:5:0,S);
      Add(S+')');

      //Add('Jour');
    end;
  Active;
  Open;
  end;

  { Set the query to Prepared - will improve performance }

  Query1.Prepared := true;

  try
    Query1.Active := True;
  except
    on e: EADOError do
    begin
      MessageDlg('Fel vid databaskoppling: Modul: Dataform, Rad: 158', mtError,
                  [mbOK], 0);

      Exit;
    end;
  end;

  { Create the data source }
  DataSrc := TDataSource.Create(Self);
  DataSrc.DataSet := Query1;
  DataSrc.Enabled := true;

  { Finally initilalize the grid }
  TidbokGrid.DataSource := DataSrc;

  end;


{$R *.dfm}



end.