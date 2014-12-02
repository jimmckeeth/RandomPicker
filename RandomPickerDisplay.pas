unit RandomPickerDisplay;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Ani, FMX.Objects, FMX.Edit, FMX.Layouts, FMX.ListBox,
  FMX.Controls.Presentation, FMX.EditBox, FMX.SpinBox, FMX.Gestures;

type
  TForm6 = class(TForm)
    Panel1: TPanel;
    lblNum3: TLabel;
    lblNum2: TLabel;
    lblNum1: TLabel;
    FloatAnimation1: TFloatAnimation;
    FloatAnimation2: TFloatAnimation;
    FloatAnimation3: TFloatAnimation;
    lblNum4: TLabel;
    FloatAnimation4: TFloatAnimation;
    lblNum5: TLabel;
    FloatAnimation5: TFloatAnimation;
    lblNum6: TLabel;
    FloatAnimation6: TFloatAnimation;
    LineLeft: TLine;
    LineRight: TLine;
    LineTop: TLine;
    LineBottom: TLine;
    LineFirst: TLine;
    LineSecond: TLine;
    Button1: TButton;
    Timer1: TTimer;
    ToolBar1: TToolBar;
    Label2: TLabel;
    lbHistory: TListBox;
    Layout1: TLayout;
    Label1: TLabel;
    maxValue: TSpinBox;
    Layout2: TLayout;
    SpeedButton1: TSpeedButton;
    Label3: TLabel;
    GestureManager1: TGestureManager;
    Layout3: TLayout;
    procedure Button1Click(Sender: TObject);
    procedure FloatAnimation1Finish(Sender: TObject);
    procedure FloatAnimation1Process(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);
  private
    { Private declarations }
    spinning: Boolean;
    MagicNumber: String;
    locked1, locked2, locked3: TFloatAnimation;
    function FindCompliment(Animation: TFloatAnimation): TFloatAnimation;
    procedure LockNumber(var Animation, Compliment: TFloatAnimation);
    function FindLabel(idx: Integer): TLabel;
    procedure JustSpin;
    procedure FullSpin;
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

{$R *.fmx}

uses StyleBookDM;

const
{$IFdef NEXTGEN}
  cPos1 = 0;
  cPos2 = 1;
  cPos3 = 2;
{$ELSE}
  cPos1 = 1;
  cPos2 = 2;
  cPos3 = 3;
{$ENDIF}

procedure TForm6.Button1Click(Sender: TObject);
begin
  FullSpin;
end;

procedure TForm6.FloatAnimation1Finish(Sender: TObject);
var
  Animation: TFloatAnimation;
  Compliment: TFloatAnimation;
  lblNum: TLabel;
  lblComp: TLabel;
  val: Integer;
begin
  Animation := Sender as TFloatAnimation;
  Compliment := FindCompliment(Animation);

  Animation.StartValue := -90;
  Animation.Delay := 0;
  Animation.Duration := 0.5;

  if (Animation.Interpolation = TInterpolationType.Linear) and (Compliment.Interpolation = TInterpolationType.Linear) then
  begin
    lblNum := FindLabel(Animation.Tag);
    lblComp := FindLabel(Compliment.Tag);
    val := StrToInt(lblComp.Text) + 1;
    if val > 9 then
      val := 0;
    lblNum.Text := IntToStr(val);
  end
  else
    Compliment.Stop;
end;

procedure TForm6.FloatAnimation1Process(Sender: TObject);
var
  Animation: TFloatAnimation;
  Compliment: TFloatAnimation;
  lblNum: TLabel;
begin
  Animation := Sender as TFloatAnimation;
  Compliment := FindCompliment(Animation);

  if not Timer1.Enabled then
  begin
    lblNum := FindLabel(Compliment.Tag);

    if Locked1 = nil then
    begin
      if (Compliment.Tag in [1, 4]) and (lblNum.Text = MagicNumber[cPos1]) then
      begin
        Locked1 := Compliment;
        LockNumber(Animation, Compliment);
      end;
    end
    else
    begin
      if Locked2 = nil then
      begin
        if (Compliment.Tag in [2, 5]) and (lblNum.Text = MagicNumber[cPos2]) then
        begin
          Locked2 := Compliment;
          LockNumber(Animation, Compliment);
        end;
      end
      else
      begin
        if Locked3 = nil then
        begin
          if (Compliment.Tag in [3, 6]) and (lblNum.Text = MagicNumber[cPos3]) then
          begin
            Locked3 := Compliment;
            LockNumber(Animation, Compliment);
        end;
        end;
      end;
    end;
  end;

  if (Animation.CurrentTime >= Animation.Duration / 2) then
  begin
    if not Compliment.Running and (Compliment <> Locked1) and (Compliment <> Locked2) and (Compliment <> Locked3) then
    begin
      //Compliment.Duration := Animation.Duration; // * 1.1;
      Compliment.Start;
    end;
  end;

end;

procedure TForm6.FormCreate(Sender: TObject);
begin
  Randomize;
  Locked1 := FloatAnimation1;
  Locked2 := FloatAnimation2;
  Locked3 := FloatAnimation3;
end;

procedure TForm6.FormGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  FullSpin;
end;

procedure TForm6.FormShow(Sender: TObject);
begin
  JustSpin;
  MagicNumber := '000';
end;

procedure TForm6.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  if (Locked3 <> nil) then
  begin
    spinning := False;
    Button1.Visible := True;
    if (MagicNumber <> '000')  then
      lbHistory.Items.Add(MagicNumber);
  end;
end;

function TForm6.FindCompliment(Animation: TFloatAnimation): TFloatAnimation;
begin
  case Animation.Tag of
    1: Result := FloatAnimation4;
    2: Result := FloatAnimation5;
    3: Result := FloatAnimation6;
    4: Result := FloatAnimation1;
    5: Result := FloatAnimation2;
    6: Result := FloatAnimation3;
  end;
end;

function TForm6.FindLabel(idx: Integer): TLabel;
begin
  case idx of
    1 : Result := lblNum1;
    2 : Result := lblNum2;
    3 : Result := lblNum3;
    4 : Result := lblNum4;
    5 : Result := lblNum5;
    6 : Result := lblNum6;
  end;

end;

procedure TForm6.SpeedButton1Click(Sender: TObject);
begin
  lbHistory.Clear;
end;

procedure TForm6.JustSpin;
begin
  if spinning then exit;
  spinning := True;
  Button1.Visible := False;
  Timer1.Enabled := True;
  FloatAnimation1.Delay := 0;
  FloatAnimation2.Delay := 0.05;
  FloatAnimation3.Delay := 0.1;
  FloatAnimation4.Delay := 0;
  FloatAnimation5.Delay := 0.05;
  FloatAnimation6.Delay := 0.1;
  FloatAnimation1.Interpolation := TInterpolationType.Linear;
  FloatAnimation2.Interpolation := TInterpolationType.Linear;
  FloatAnimation3.Interpolation := TInterpolationType.Linear;
  FloatAnimation4.Interpolation := TInterpolationType.Linear;
  FloatAnimation5.Interpolation := TInterpolationType.Linear;
  FloatAnimation6.Interpolation := TInterpolationType.Linear;
  FloatAnimation1.StopValue := 57;
  FloatAnimation2.StopValue := 57;
  FloatAnimation3.StopValue := 57;
  FloatAnimation4.StopValue := 57;
  FloatAnimation5.StopValue := 57;
  FloatAnimation6.StopValue := 57;
  Locked1.Duration := 0.25;
  Locked2.Duration := 0.25;
  Locked3.Duration := 0.25;
  Locked1 := nil;
  Locked2 := nil;
  Locked3 := nil;
  FloatAnimation1.Start;
  FloatAnimation2.Start;
  FloatAnimation3.Start;
  FloatAnimation4.Start;
  FloatAnimation5.Start;
  FloatAnimation6.Start;
end;

procedure TForm6.FullSpin;
begin
  MagicNumber := '';
  JustSpin;
  repeat
    MagicNumber := Format('%.3d', [Random(Round(maxValue.Value)) + 1]);
  until (lbHistory.Items.Count >= maxValue.Value) or (lbHistory.Items.IndexOf(MagicNumber) = -1);
end;

procedure TForm6.LockNumber(var Animation, Compliment: TFloatAnimation);
begin
  //Animation.Stop;
  //Compliment.Duration := Compliment.Duration / 2;
  Compliment.StopValue := -15;
  Compliment.Interpolation := TInterpolationType.Quadratic;
  Compliment.Start;
  Timer1.Enabled := True;
end;

end.
