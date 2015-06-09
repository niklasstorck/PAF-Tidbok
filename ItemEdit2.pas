{$define PROFILE}
unit ItemEdit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,Planner,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, CurvyControls, W7Classes, W7Bars,
  PAFPlanner, AdvGlassButton, AdvSmoothPanel;

type
  TPafEditForm = class(TCustomItemeditor)
    W7InformationBar1: TW7InformationBar;
    CurvyPanel1: TCurvyPanel;
    CeNamn: TCurvyEdit;
    CurvyCombo1: TCurvyCombo;
    CePnr: TCurvyEdit;
    ButtonOK: TAdvGlassButton;
    CeTdbUsr: TCurvyEdit;
    CeUndLak: TCurvyEdit;
    CmAnamnes: TCurvyMemo;
    CeProdkod: TCurvyEdit;
    CeProdtext: TCurvyEdit;
    CEFragetext: TCurvyEdit;
    procedure FormCreate(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
  private
    { Private declarations }
    FItem: TMyPAFItem;
  public
    { Public declarations }
    procedure CreateEditor(AOwner: TComponent); override;
    function Execute: Integer; override;
    property Item: TMyPAFItem read FItem write FItem;
    procedure PlannerItemToEdit(APlannerItem: TMyPAFItem);
    procedure EditToPlannerItem(APlannerItem: TPlannerItem); override;

  end;

//var  ItemEditForm: TPafEditForm;


procedure Register;

implementation

{$R *.dfm}

procedure Register;
begin
  RegisterComponents('PAF-TMS', [TPafEditForm]);

end;

procedure TPafEditForm.ButtonOKClick(Sender: TObject);
begin
  // FItem.Notes:= CmNotes.Lines.Text;
  //FItem.TdbUsr := CeTdbUsr.Text;
  //Close;
end;

procedure TPafEditForm.CreateEditor(AOwner: TComponent);
begin
  inherited;
  FormCreate(AOwner);
end;

procedure TPafEditForm.EditToPlannerItem(APlannerItem: TPlannerItem);
begin
  inherited;
  // Skriv �ter det som kan editeras till planner

end;

function TPafEditForm.Execute: Integer;
begin
  {
  CmAnamnes.Lines.Clear;
  CePnr.Text := LocalItem.Pafdata.pid;
  CeNamn.Text := LocalItem.PafData.PatNamn; // OBS namnet m�ste fixas !!
  CeProdkod.Text := LocalItem.PafData.Prodkod;
  CeProdtext.Text := LocalItem.PafData.Prodtext;
  //CEFragetext.Text := FItem.FrageText;
  CmAnamnes.Lines.Add(LocalItem.PafData.Anamnes);
  CeTdbUsr.Text := LocalItem.PafData.TdbUsr;
  CeUndLak.Text := LocalItem.PafData.UndLak;
  ItemEditForm.ShowModal;     }
  Result:=0;
end;

procedure TPafEditForm.FormCreate(Sender: TObject);
begin
  // FItem:=
  //CmAnamnes.Lines.Clear;

end;

procedure TPafEditForm.PlannerItemToEdit(APlannerItem: TMyPAFItem);
begin
  //inherited;
  CmAnamnes.Lines.Clear;
  CePnr.Text := APlannerItem.pid;
  CeNamn.Text := APlannerItem.PatNamn; // OBS namnet m�ste fixas !!
  CeProdkod.Text := APlannerItem.Prodkod;
  CeProdtext.Text := APlannerItem.Prodtext;
  //CEFragetext.Text := FItem.FrageText;
  CmAnamnes.Lines.Add(APlannerItem.PafData.Anamnes);
  CeTdbUsr.Text := APlannerItem.PafData.TdbUsr;
  CeUndLak.Text := APlannerItem.PafData.UndLak;

end;

end.