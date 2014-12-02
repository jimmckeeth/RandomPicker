unit StyleBookDM;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls,
  System.Generics.Collections;

type
  TdmStyleBooks = class(TDataModule)
    sbAmakrits: TStyleBook;
    sbAir: TStyleBook;
    sbBlend: TStyleBook;
    sbLight: TStyleBook;
    sbAquaGraphite: TStyleBook;
    sbGoldenGraphite: TStyleBook;
    sbDark: TStyleBook;
    sbRubyGraphite: TStyleBook;
    sbTransparent: TStyleBook;
    procedure DataModuleCreate(Sender: TObject);
  private
    sbList: TObjectList<TStyleBook>;
    idx: Integer;
    function GetNextSB: TStyleBook;
    { Private declarations }
  public
    { Public declarations }
    property NextStyleBook: TStyleBook read GetNextSB;
  end;

var
  dmStyleBooks: TdmStyleBooks;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TdmStyleBooks.DataModuleCreate(Sender: TObject);
var
  x: Integer;
begin
  sbList := TObjectList<TStyleBook>.Create;
  for x := 0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[x] is TStyleBook then
      sbList.Add(Self.Components[x] as TStyleBook);
  end;
  idx := 0;
end;

function TdmStyleBooks.GetNextSB: TStyleBook;
begin
  inc(idx);
  if idx >= sbList.Count then
    idx := 0;
  Result := sbList[idx];
end;

end.
