program RandomPicker;

uses
  System.StartUpCopy,
  FMX.Forms,
  RandomPickerDisplay in 'RandomPickerDisplay.pas' {Form6},
  StyleBookDM in 'StyleBookDM.pas' {dmStyleBooks: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TdmStyleBooks, dmStyleBooks);
  Application.Run;
end.
