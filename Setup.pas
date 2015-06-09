unit Setup;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, AdvMetroForm, AdvSmoothExpanderGroup, AdvSmoothPanel, Vcl.ComCtrls,
  GDIPCustomItem, GDIPTextItem, GDIPImageTextItem, GDIPGraphicItem,
  GDIPCheckItem, CustomItemsContainer, AdvPolyList, AdvGlowButton;

type
  TTMSForm1 = class(TAdvMetroForm)
    StatusBar1: TStatusBar;
    AdvSmoothPanel1: TAdvSmoothPanel;
    ButtonOK: TDBAdvGlowButton;
    ButtonCancel: TDBAdvGlowButton;
    AdvPolyList1: TAdvPolyList;
    CheckItem1: TCheckItem;
    CheckItem2: TCheckItem;
    CheckItem3: TCheckItem;
    CheckItem4: TCheckItem;
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  end;

var
  TMSForm1: TTMSForm1;

implementation

{$R *.dfm}


end.
