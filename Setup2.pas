unit Setup2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, GDIPCustomItem, GDIPTextItem,
  GDIPImageTextItem, GDIPGraphicItem, GDIPCheckItem, CustomItemsContainer,
  AdvPolyList, CurvyControls, AdvPolyPager, GDIPSectionItem,
  GDIPImageSectionItem, GDIPHeaderItem, AdvSmoothButton, Vcl.Grids, AdvObj,
  BaseGrid, AdvGrid, DBAdvGrid, Vcl.StdCtrls, Vcl.CheckLst, Vcl.ComCtrls;

type
  TRum = record
    Nr: Integer;
    Rum: String;
    Show: Boolean
  end;

  TCols = array [0..25] of TRum;

  TSetupForm = class(TForm)
    CurvyPanel1: TCurvyPanel;
    CurvyPanel2: TCurvyPanel;
    ButtOk: TAdvSmoothButton;
    ButtCancel: TAdvSmoothButton;
    TabControl1: TTabControl;
    CheckListBoxKolumner: TCheckListBox;
    procedure FormCreate(Sender: TObject);
    //function Setup(var col: TCols ):Integer;
    procedure ButtOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Columns: TCols;
    procedure BeforeEdit(col :TCols);
  end;

var
  SetupForm: TSetupForm;

implementation

{$R *.dfm}
procedure TSetupForm.FormCreate(Sender: TObject);
var i: Integer;
begin
  
  for i := 0 to high(Columns) do begin
    //Columns[i].create;
    Columns[i].Nr:=0;
    Columns[i].Rum:=''
  end;

end;

procedure TSetupForm.BeforeEdit(col: TCols);
var i: Integer; S: String;
begin
  CheckListBoxKolumner.Items.Clear;
  for I := 0 to High(col)-1 do
  begin
     S:=col[i].Rum;
     CheckListBoxKolumner.Items.Add(S);
     if col[i].Show then
       CheckListBoxKolumner.Checked[i]:=true
  end;
end;

procedure TSetupForm.ButtOkClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 1 to 2 do
  begin

  end;

  Close;
end;



end.
