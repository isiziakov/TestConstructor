unit MainFormUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Menus, Buttons, ComCtrls, structure, UnitFormAbout;

type

  { TForm1 }

  TForm1 = class(TForm)
    edAnswer_N3: TEdit;
    edAnswer_N4: TEdit;
    MenuItem1: TMenuItem;
    mnAbout: TMenuItem;
    NextBtn: TBitBtn;
    PrevBtn: TBitBtn;
    DeletBtn: TBitBtn;
    AddBtn: TBitBtn;
    edAnswer_N1: TEdit;
    edAnswer_N2: TEdit;
    GroupBox1: TGroupBox;
    edQuestion: TMemo;
    MainMenu: TMainMenu;
    mnExit: TMenuItem;
    mnSave: TMenuItem;
    mnOpen: TMenuItem;
    mnNew: TMenuItem;
    dlgOpen: TOpenDialog;
    dlgSave: TSaveDialog;
    rb_Answer_N3: TRadioButton;
    rb_Answer_N4: TRadioButton;
    Tests: TMenuItem;
    rb_Answer_N1: TRadioButton;
    rb_Answer_N2: TRadioButton;
    procedure edQuestionChange(Sender: TObject);
    procedure mnAboutClick(Sender: TObject);
    procedure NextBtnClick(Sender: TObject);
    procedure PrevBtnClick(Sender: TObject);
    procedure DeletBtnClick(Sender: TObject);
    procedure AddBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mnExitClick(Sender: TObject);
    procedure mnNewClick(Sender: TObject);
    procedure mnOpenClick(Sender: TObject);
    procedure mnSaveClick(Sender: TObject);
    procedure rb_Answer_N1Change(Sender: TObject);
    procedure rb_Answer_N2Change(Sender: TObject);
    procedure rb_Answer_N3Change(Sender: TObject);
    procedure rb_Answer_N4Change(Sender: TObject);
  private
    Current_Question: Question_Of_Test;
    Questions: TQuestions;
  public
    procedure Show();
    procedure Save();
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

procedure TForm1.mnNewClick(Sender: TObject);
begin
  Questions.Clear;
  Current_Question := Questions.EmptyQuestion;
  Show();
  GroupBox1.Caption := 'Вопрос 1 из 1';
end;

procedure TForm1.mnExitClick(Sender: TObject);
begin
  Close();
end;

procedure TForm1.NextBtnClick(Sender: TObject);
begin
  Save();
  Questions.EditQuestion(Current_Question);
  Current_Question := Questions.Next;
  Show();
end;

procedure TForm1.mnAboutClick(Sender: TObject);
begin
  frmAbout := TfrmAbout.Create(Form1);
  frmAbout.ShowModal;
end;

procedure TForm1.edQuestionChange(Sender: TObject);
begin

end;

procedure TForm1.PrevBtnClick(Sender: TObject);
begin
  Save();
  Questions.EditQuestion(Current_Question);
  Current_Question := Questions.Prev;
  Show();
end;

procedure TForm1.DeletBtnClick(Sender: TObject);
begin
  Questions.DeleteQuestion();
  Current_Question := Questions.Current;
  Show();
end;

procedure TForm1.AddBtnClick(Sender: TObject);
begin
   Save();
   Questions.EditQuestion(Current_Question);
   Questions.AddQuestion();
   Current_Question := Questions.Current;
   Show();
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Questions := TQuestions.Create();
  Current_Question := Questions.EmptyQuestion;
  Show();
  GroupBox1.Caption := 'Вопрос 1 из 1';
  dlgOpen.InitialDir:=ExtractFilePath(Application.ExeName);
  dlgSave.InitialDir:=ExtractFilePath(Application.ExeName);
end;

procedure TForm1.mnOpenClick(Sender: TObject);
begin
  if dlgOpen.Execute then
  begin
    Questions.Load(dlgOpen.FileName);
    Current_Question := Questions.Current;
    Show();
  end;
end;

procedure TForm1.mnSaveClick(Sender: TObject);
begin
  Save();
  Questions.EditQuestion(Current_Question);
  if dlgSave.Execute then
  begin
    Questions.Save(dlgSave.FileName);
  end;
end;

procedure TForm1.rb_Answer_N1Change(Sender: TObject);
begin
  if rb_Answer_N1.Checked then Current_Question.Index_Of_Correct_Answer := 1;
end;

procedure TForm1.rb_Answer_N2Change(Sender: TObject);
begin
  if rb_Answer_N2.Checked then Current_Question.Index_Of_Correct_Answer := 2;
end;

procedure TForm1.rb_Answer_N3Change(Sender: TObject);
begin
  if rb_Answer_N3.Checked then Current_Question.Index_Of_Correct_Answer := 3;
end;

procedure TForm1.rb_Answer_N4Change(Sender: TObject);
begin
  if rb_Answer_N4.Checked then Current_Question.Index_Of_Correct_Answer := 4;
end;



    procedure TForm1.Show();
    begin
      GroupBox1.Caption := 'Вопрос ' + IntToStr(Questions.CurrentIndex + 1) + ' из ' + IntToStr(Questions.Count + 1);
      edAnswer_N1.Text:=Current_Question.Answer1;
      edAnswer_N2.Text:=Current_Question.Answer2;
      edAnswer_N3.Text:=Current_Question.Answer3;
      edAnswer_N4.Text:=Current_Question.Answer4;
      rb_Answer_N1.Checked := Current_Question.Index_Of_Correct_Answer = 1;
      rb_Answer_N2.Checked := Current_Question.Index_Of_Correct_Answer = 2;
      rb_Answer_N3.Checked := Current_Question.Index_Of_Correct_Answer = 3;
      rb_Answer_N4.Checked := Current_Question.Index_Of_Correct_Answer = 4;
      edQuestion.Clear;
      edQuestion.Text:=Current_Question.Question;
    end;

    procedure TForm1.Save();
    begin
      Current_Question.Question:=edQuestion.Text;
      Current_Question.Answer1:=edAnswer_N1.Text;
      Current_Question.Answer2:=edAnswer_N2.Text;
      Current_Question.Answer3:=edAnswer_N3.Text;
      Current_Question.Answer4:=edAnswer_N4.Text;
    end;


end.

