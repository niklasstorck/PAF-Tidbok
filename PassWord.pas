unit PASSWORD;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons;

type
  TPasswordDlg = class(TForm)
    Label1: TLabel;
    Password: TEdit;
    OKBtn: TButton;
    CancelBtn: TButton;
    Namn: TEdit;
    Label2: TLabel;
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    OK: Boolean;
  end;

var
  PasswordDlg: TPasswordDlg;

implementation

{$R *.dfm}

procedure TPasswordDlg.CancelBtnClick(Sender: TObject);
begin
  OK:=False;
end;

procedure TPasswordDlg.OKBtnClick(Sender: TObject);
begin
  if (Namn.Text='ns') and (Password.Text = 'klister') then
    OK:= true
  else
    OK:=false;
  Hide;
end;

end.
 
