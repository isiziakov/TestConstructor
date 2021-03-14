unit UnitFormAbout;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfrmAbout }

  TfrmAbout = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label2Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

{$R *.lfm}

{ TfrmAbout }

procedure TfrmAbout.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  if Key = 27 then Close;
end;

procedure TfrmAbout.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Close();
end;

procedure TfrmAbout.Label2Click(Sender: TObject);
begin

end;

end.

