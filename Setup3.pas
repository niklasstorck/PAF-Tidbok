unit Setup3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.FMTBcd, Data.DBXMSSQL, Data.DB,
  Data.SqlExpr, Datasnap.Provider, Datasnap.DBClient, Vcl.StdCtrls, Vcl.Grids,
  AdvObj, BaseGrid, AdvGrid, DBAdvGrid, Vcl.CheckLst, CurvyControls,
  Vcl.ComCtrls, Vcl.ExtCtrls;

type
  {TRum = record
    Nr: Integer;
    Rum: String;
    Show: Boolean
  end;}

  //TCols = array [0..25] of TRum;

  TSetupForm3 = class(TForm)
    Panel1: TPanel;
    ButtonCancel: TButton;
    ButtonOk: TButton;
    TabControl1: TTabControl;
    TidbokGrid: TDBAdvGrid;
    CurvyPanel1: TCurvyPanel;
    CDSTidboktyp: TClientDataSet;
    DSTidboktyp: TDataSource;
    DSPTidboktyp: TDataSetProvider;
    FysPAFInst: TSQLConnection;
    CLB_tidbok: TCheckListBox;
    procedure FormCreate(Sender: TObject);
    procedure ButtonOkClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);

  private
    { Private declarations }
        // Här sparas den lokala informationen om vilka kolumner som ska vara synliga
    //Columns: TCols;
    // *************************************

  public
    { Public declarations }

    //procedure Edit (var col: TCols);
    //procedure Get  (var col: TCols);
  end;

var
  SetupForm3: TSetupForm3;

implementation

{$R *.dfm}


procedure TSetupForm3.ButtonCancelClick(Sender: TObject);
begin
  Close
end;

procedure TSetupForm3.ButtonOkClick(Sender: TObject);
var i: Integer;
begin


  Close
end;

procedure TSetupForm3.FormCreate(Sender: TObject);
var i: Integer;
begin
  CDSTidboktyp.Active:=true;
  for i:= 0 to TidBokGrid.rowcount - 1 do begin
    CLB_tidbok.Items.Add(TidBokGrid.Cells[2,1]);
  end;
end;


end.
