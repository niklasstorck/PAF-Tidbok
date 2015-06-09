unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.FMTBcd, Data.DBXMSSQL, Data.DB,
  Data.SqlExpr, Datasnap.Provider, Datasnap.DBClient, Vcl.StdCtrls, Vcl.Grids,
  AdvObj, BaseGrid, AdvGrid, DBAdvGrid, Vcl.CheckLst, CurvyControls,
  Vcl.ComCtrls, Vcl.ExtCtrls;

type
  TForm2 = class(TForm)
    Panel1: TPanel;
    TabControl1: TTabControl;
    CurvyPanel1: TCurvyPanel;
    CLB_tidbok: TCheckListBox;
    CheckListBoxRum: TCheckListBox;
    TidbokGrid: TDBAdvGrid;
    ButtonCancel: TButton;
    ButtonOk: TButton;
    DataSourceGetTdbTyp: TDataSource;
    DataSourceGetTidbok: TDataSource;
    DataSource1: TDataSource;
    DTB_GetTidbokTyp: TSQLDataSet;
    CDSTidboktyp: TClientDataSet;
    DSTidboktyp: TDataSource;
    DSPTidboktyp: TDataSetProvider;
    FysPAFInst: TSQLConnection;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

end.
