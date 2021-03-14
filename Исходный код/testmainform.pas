unit TestMainForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Menus, Buttons, structure, UnitFormAbout;

type

  { TForm1 }

  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    dlgOpen: TOpenDialog;
    edAnswer_N1: TEdit;
    edAnswer_N2: TEdit;
    edAnswer_N3: TEdit;
    edAnswer_N4: TEdit;
    edQuestion: TMemo;
    GroupBox1: TGroupBox;
    MainMenu: TMainMenu;
    MenuItem1: TMenuItem;
    mnAbout: TMenuItem;
    mnExit: TMenuItem;
    mnOpen: TMenuItem;
    rb_Answer_N1: TRadioButton;
    rb_Answer_N2: TRadioButton;
    rb_Answer_N3: TRadioButton;
    rb_Answer_N4: TRadioButton;
    Tests: TMenuItem;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mnAboutClick(Sender: TObject);
    procedure mnOpenClick(Sender: TObject);
    procedure rb_Answer_N1Change(Sender: TObject);
    procedure rb_Answer_N2Change(Sender: TObject);
    procedure rb_Answer_N3Change(Sender: TObject);
    procedure rb_Answer_N4Change(Sender: TObject);
  private
    Answer, Number_Of_Correct_Answer: integer;
    Current_Question: Question_Of_Test;
    Questions: TQuestions;
    procedure ShowResult;
  public
    procedure Show();
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.mnOpenClick(Sender: TObject);
begin
  if dlgOpen.Execute then
  begin
  	edQuestion.Font.Size:=9;
    edQuestion.Alignment:=taLeftJustify;
    Number_Of_Correct_Answer := 0;
    Questions.Load(dlgOpen.FileName);
    Questions.MixIndexes;
    Current_Question := Questions.Current;
    Show();
  end;
end;

procedure TForm1.ShowResult;
begin
  Current_Question := Questions.EmptyQuestion;
  Show();
  edQuestion.Font.Size:=24;
  edQuestion.Alignment:=taCenter;
  edQuestion.Text := ' Правильно ' + IntToStr(Number_Of_Correct_Answer) + ' из ' + IntToStr(Questions.Count + 1);
end;

procedure TForm1.rb_Answer_N1Change(Sender: TObject);
begin
  if rb_Answer_N1.Checked then Answer := 1;
end;

procedure TForm1.rb_Answer_N2Change(Sender: TObject);
begin
  if rb_Answer_N2.Checked then Answer := 2;
end;

procedure TForm1.rb_Answer_N3Change(Sender: TObject);
begin
  if rb_Answer_N3.Checked then Answer := 3;
end;

procedure TForm1.rb_Answer_N4Change(Sender: TObject);
begin
  if rb_Answer_N4.Checked then Answer := 4;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Questions := TQuestions.Create;
  Current_Question := Questions.EmptyQuestion;
  Show();
  GroupBox1.Caption := 'Вопрос 1 из 1';
  dlgOpen.InitialDir:=ExtractFilePath(Application.ExeName);
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  if Answer = Current_Question.Index_Of_Correct_Answer then Number_Of_Correct_Answer := Number_Of_Correct_Answer + 1;
  if Questions.CurrentIndex = Questions.Count then ShowResult
                                   else
                                   begin
                                   Current_Question := Questions.Next;
                                   Show();
                                   end;
end;

procedure TForm1.mnAboutClick(Sender: TObject);
begin
  frmAbout := TfrmAbout.Create(Form1);
  frmAbout.ShowModal;
end;

procedure TForm1.Show();
    begin
      GroupBox1.Caption := 'Вопрос ' + IntToStr(Questions.CurrentIndex + 1) + ' из ' + IntToStr(Questions.Count + 1);
      edAnswer_N1.Text:=Current_Question.Answer1;
      edAnswer_N2.Text:=Current_Question.Answer2;
      edAnswer_N3.Text:=Current_Question.Answer3;
      edAnswer_N4.Text:=Current_Question.Answer4;
      edQuestion.Clear;
      edQuestion.Text:=Current_Question.Question;
      rb_Answer_N1.Checked := false;
      rb_Answer_N2.Checked := false;
      rb_Answer_N3.Checked := false;
      rb_Answer_N4.Checked := false;
    end;

end.

