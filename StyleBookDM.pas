unit StyleBookDM;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Generics.Collections, FMX.StdCtrls;

type
  TdmStyleBooks = class(TForm)
    sbAmakrits: TStyleBook;
    sbAir: TStyleBook;
    sbBlend: TStyleBook;
    sbLight: TStyleBook;
    sbAquaGraphite: TStyleBook;
    sbGoldenGraphite: TStyleBook;
    sbDark: TStyleBook;
    sbRubyGraphite: TStyleBook;
    sbTransparent: TStyleBook;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
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

{$R *.fmx}

procedure TdmStyleBooks.FormCreate(Sender: TObject);
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
