program RandomPicker;

uses
  System.StartUpCopy,
  FMX.Forms,
  RandomPickerDisplay in 'RandomPickerDisplay.pas' {Form6},
  StyleBookDM in 'StyleBookDM.pas' {dmStyleBooks};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TPickerForm, PickerForm);
  Application.CreateForm(TdmStyleBooks, dmStyleBooks);
  Application.Run;
end.
