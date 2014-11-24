program RandomPicker;

uses
  System.StartUpCopy,
  FMX.Forms,
  RandomPickerDisplay in 'RandomPickerDisplay.pas' {Form6};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm6, Form6);
  Application.Run;
end.
