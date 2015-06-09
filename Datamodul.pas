unit Datamodul;

interface

uses
  System.SysUtils, System.Classes, Data.DBXMSSQL, Data.FMTBcd, Data.DB,
  Data.SqlExpr, Datasnap.DBClient, Datasnap.Provider;

type
  TData = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Data: TData;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

end.
