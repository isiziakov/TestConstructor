unit structure;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  Question_Of_Test = record
    Question: string;
    Answer1: string;
    Answer2: string;
    Answer3: string;
    Answer4: string;
    Index_Of_Correct_Answer: integer;
  end;

  TQuestions = class
  private
    Questions : array of Question_Of_Test;
    Indexes: array of integer;
    index: integer;

    procedure NewQuestion;
  public
    constructor Create();

    procedure Clear;
    procedure Save(FileName:string);
    procedure Load(FileName:string);
    procedure AddQuestion();
    procedure EditQuestion(Question:Question_Of_Test);
    procedure DeleteQuestion();

    function Next: Question_Of_Test;
    function Prev: Question_Of_Test;
    function Current: Question_Of_Test;

    function Count: integer;
    function CurrentIndex: integer;
    function EmptyQuestion: Question_Of_Test;

    procedure CreateIndexes;
    procedure MixIndexes;
  end;


implementation

constructor TQuestions.Create();
begin
end;

procedure TQuestions.Clear;
begin
  SetLength(Questions, 0);
  SetLength(Indexes, 0);
  index := 0;
end;

procedure TQuestions.Save(FileName:string);
var file_with_test : text;
    i: integer;
    q:string;
begin
  AssignFile(file_with_test, FileName);
  rewrite(file_with_test);
  for i:=0 to High(Questions) do
   begin
    q:= StringReplace(Questions[i].Question, chr(13) + chr(10), chr(255), [rfReplaceAll]);
    writeln(file_with_test, q);
    writeln(file_with_test, Questions[i].Answer1);
    writeln(file_with_test, Questions[i].Answer2);
    writeln(file_with_test, Questions[i].Answer3);
    writeln(file_with_test, Questions[i].Answer4);
    writeln(file_with_test, chr(Questions[i].Index_Of_Correct_Answer + 129));
   end;
  closefile(file_with_test);
end;

procedure TQuestions.Load(FileName:string);
var file_with_test : text;
    Question:Question_Of_Test;
    number: char;
    q: string;
begin
  Clear;
  AssignFile(file_with_test, FileName);
  reset(file_with_test);
  while not eof(file_with_test) do
    begin
     Question := EmptyQuestion;
      readln(file_with_test, q);
      Question.Question := StringReplace(q, chr(255), chr(13) + chr(10),[rfReplaceAll]);
      readln(file_with_test, Question.Answer1);
      readln(file_with_test, Question.Answer2);
      readln(file_with_test, Question.Answer3);
      readln(file_with_test, Question.Answer4);
      readln(file_with_test, number);
      Question.Index_Of_Correct_Answer := Ord(number) - 129;
      AddQuestion();
      EditQuestion(Question);
    end;
 closefile(file_with_test);
 index := 0;
 SetLength(Indexes, Length(Questions));
 CreateIndexes;
end;

procedure TQuestions.NewQuestion();
var l: integer;
begin
  if (Questions = nil) then l := 0
  else l := Length(Questions);
  SetLength(Questions, l + 1);
  SetLength(Indexes, l + 1);
  Indexes[High(Indexes)] := High(Indexes);
end;

procedure TQuestions.AddQuestion();
begin
  NewQuestion();
  index := High(Questions);
  Questions[index]:= EmptyQuestion;
end;

procedure TQuestions.EditQuestion(Question:Question_Of_Test);
begin
  if (Questions = nil) then NewQuestion();
  Questions[index]:= Question;
end;

procedure TQuestions.DeleteQuestion();
var i:integer;
begin
 if (index > 0) then
  begin
   for i := index to High(Questions) - 1 do
    Questions[i] := Questions[i + 1];
   SetLength(Questions, High(Questions));
  if index > Count then index := count;
  end
  else;
  begin
    Questions[0]:= EmptyQuestion;
  end;
end;

function TQuestions.Next: Question_Of_Test;
begin
  if (index < Count) then index := index +1;
  result := Current;
end;

function TQuestions.Prev: Question_Of_Test;
begin
  if (index > 0) then index := index - 1;
  result := Current;
end;

function TQuestions.Current: Question_Of_Test;
begin
 result := Questions[Indexes[index]];
end;

function TQuestions.Count: integer;
begin
  result := High(Questions);
end;

function TQuestions.CurrentIndex: integer;
begin
	result := index;
end;

function TQuestions.EmptyQuestion: Question_Of_Test;
begin
	Result.Question := '';
	Result.Answer1 := '';
    Result.Answer2 := '';
    Result.Answer3 := '';
    Result.Answer4 := '';
    Result.Index_Of_Correct_Answer := -1;
end;

procedure TQuestions.CreateIndexes;
var i: integer;
begin
  for i := 0 to High(Indexes) do Indexes[i] := i;
end;

procedure TQuestions.MixIndexes;
var i, i1, i2, c, t: integer;
begin
  Randomize;
  c := Count + 1;
  for i := 0 to 100 do
   begin
     i1 := Random(c);
     i2 := Random(c);
     if (i1 <> i2) then
      begin
         t := Indexes[i1];
         Indexes[i1] := Indexes[i2];
         Indexes[i2] := t;
      end;
   end;
end;

end.

