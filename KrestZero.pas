unit KrestZero;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Menus, jpeg, MPlayer;


 type
   PosVector = record

    x : integer;
    y : integer;
    z : integer;
   end;

   FieldType = (OneVertical,TwoVertical,ThreeVertical,OneHorizontal,TwoHorizontal,ThreeHorizontal,LeftDiagonal,RightDiagonal);
   GameType = (UserUser,UserComp,CompUser);

   RecGameType = record
     CompUser : bool;
     UserComp : bool;
     UserUser : bool;

   end;

  TForm1 = class(TForm)
    CanvaField: TImage;
    Timer1: TTimer;
    Label1: TLabel;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    sound: TMediaPlayer;
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CanvaFieldMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N10Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;




var
  Form1: TForm1;
  Player : array[0..2] of TBitmap;
  WhoMove : integer;    // 0 - пусто 1 - x 2 - o
  FieldGame : array[0..3,0..3] of integer;
  Field,Background : tbitmap;
  StrategyGame :  RecGameType;
  NumberCell : PosVector;


implementation

uses Unit2;

{$R *.dfm}

function TargetInCell(x : integer; y : integer):bool;
var xMin,xMax,yMin,yMax : integer;
begin

     if ((x > xMin) AND (x > xMax))
      then
       if ( (y > yMin) AND (y > yMax) )
        then Result := true
     else Result := false;

end;

function GetNumberCell(x : integer; y : integer):PosVector;
begin
       Result.x := x div (250 div 3);
       Result.y := y div (250 div 3);

end;
Procedure InitGame();
var i,j : integer;
    Blend: TBlendFunction;
begin

    //0: alpform := AC_LINE_OFFLINE;
   // 1: alpform := AC_SRC_ALPHA;
   // 2: alpform := AC_LINE_ONLINE;
   // 3: alpform := AC_SRC_OVER;



            Background.LoadFromFile('Data\\back.bmp');



         Field := Tbitmap.Create();
         Field.Transparent := true;


         Player[0] := Tbitmap.Create();
         Player[1] := Tbitmap.Create();

         Player[0].Transparent := true;
         Player[1].Transparent := true;

       Field.LoadFromFile('Data\\Field-2.bmp');

       Player[0].LoadFromFile('Data\\Krestik.bmp');
       Player[1].LoadFromFile('Data\\Nulik.bmp');

       Form1.CanvaField.Transparent := true;
      // Form1.CanvaField.Canvas.Draw(8,8,Field);

            //Blend.BlendOp := AC_SRC_OVER;
            Blend.BlendFlags := 0;
            Blend.SourceConstantAlpha := 250;
            Field.PixelFormat := pf32bit; // переводим оба в 32 бит
            Background.PixelFormat := pf32bit;
            Blend.AlphaFormat := AC_SRC_ALPHA;

     //if Windows.AlphaBlend(background.Canvas.Handle, 0, 0, background.Width, background.Height,
               //         Field.Canvas.Handle, 0, 0, Field.Width, Field.Height, Blend) then

                        Form1.CanvaField.Canvas.Draw(0,0,background);
                         Form1.CanvaField.Canvas.Draw(8, 55, Field);
       WhoMove := 1;

       for i:=0 to 3 do
       for j:=0 to 3 do
        FieldGame[i][j] := 0;


          form1.sound.FileName := 'Data\\back.mp3';
          form1.sound.Open;
          //form1.sound.Play;

end;

function GameOver():integer;
   var i,j,count:integer;
   begin


        // -1 - игра не окончена; 0 - ничья; 1 - победили крестики; 2 - победили нолики

        // Проверка на чью-нибудь победу
        for i:= 1 to 3 do
        begin
                // По горизонтали
            if( (FieldGame[0][0] = i) AND (FieldGame[1][0] = i) AND (FieldGame[2][0] = i) OR
                (FieldGame[0][1] = i) AND (FieldGame[1][1] = i) AND (FieldGame[2][1] = i) OR
                (FieldGame[0][2] = i) AND (FieldGame[1][2] = i) AND (FieldGame[2][2] = i) OR

                // По вертикали
                (FieldGame[0][0] = i) AND (FieldGame[0][1] = i) AND (FieldGame[0][2] = i) OR
                (FieldGame[1][0] = i) AND (FieldGame[1][1] = i) AND (FieldGame[1][2] = i) OR
                (FieldGame[2][0] = i) AND (FieldGame[2][1] = i) AND (FieldGame[2][2] = i) OR

                // По диагонали
                (FieldGame[0][0] = i) AND (FieldGame[1][1] = i) AND (FieldGame[2][2] = i) OR
                (FieldGame[2][0] = i) AND (FieldGame[1][1] = i) AND (FieldGame[0][2] = i) )

              then  Result := i;
            end;

        // Проверка на ничью
         count := 0;
        for i := 0 to 3 do
        for j := 0 to 3 do
            if(FieldGame[i][j] <> 0) then count := count + 1;

        // Заполнено все поле
        if(count = 9) then Result :=0;


      //  Result := -1;

   end;

Procedure ClearField();
var b : tbitmap;
begin
                     b:= tbitmap.Create();
                     Background := tbitmap.Create;
                     Background.Width := 600; Background.Height := 600;

      b.Width := form1.CanvaField.Width;
      b.Height := form1.CanvaField.Height;
      b.Canvas.Brush.Color := clbtnface;
      b.canvas.Pen.Color := clbtnface;
      b.Canvas.FillRect(b.Canvas.ClipRect);
      
      form1.CanvaField.Canvas.Brush.Color := clbtnface;
      form1.CanvaField.Canvas.Rectangle(0,0,390,360);
      form1.CanvaField.Canvas.Draw(0,0,b);
      form1.CanvaField.Refresh;

      b.Free;

end;

procedure CompMove();
type

Vector = record
 x : integer;
 y : integer;
 end;

var victoryMove : array[1..5] of Vector;
    variantStrategy : integer; i,j : integer;
begin

       victoryMove[1].x := 0; victoryMove[1].y := 0;
       victoryMove[2].x := 0; victoryMove[2].y := 2;
       victoryMove[3].x := 2; victoryMove[2].y := 0;
       victoryMove[4].x := 2; victoryMove[2].y := 2;
       victoryMove[5].x := 1; victoryMove[2].y := 1;

       variantStrategy := random(5);

                for i:=0 to 3 do
                 for j:=0 to 3 do
                  if (FieldGame[victoryMove[1].x][victoryMove[1].y] = 0) then
                     // комп делает ход
                     begin
                            form1.Label1.Caption := IntToStr(FieldGame[victoryMove[1].x][victoryMove[1].y]);
                            Form1.CanvaField.Canvas.Draw(victoryMove[1].x, victoryMove[1].y, Player[0]);
                            WhoMove := 0;
                      end;

end;

procedure UserMove();
  var x,y,NumCell,i,j,gm:integer;
begin


        x := Mouse.CursorPos.X div ( 250 div 3);
        y := Mouse.CursorPos.Y div ( 250 div 3);

               NumberCell := GetNumberCell(Mouse.CursorPos.X,Mouse.CursorPos.Y);
               form1.caption := 'x: ' + IntToStr(NumberCell.x)+' y: ' + IntToStr(NumberCell.y);

                   if ( gm <> 1) OR ( gm <> 2) then
                   if (FieldGame[x][y] = 0 )
                     then begin

                            FieldGame[x][y] := WhoMove;

                            if (WhoMove = 1) then WhoMove := 2 else WhoMove := 1;

                for i := 0 to 3 do
                for j := 0 to 3 do
                   // сдвинуть на width рисуемый спрайт или просто нарисовать по центру
                    if(FieldGame[i][j] <> 0) then Form1.CanvaField.Canvas.Draw(i * (300 div 3), j *(300 div 3)-1,Player[FieldGame[i][j]-1]);

         end;


         gm:=GameOver();
          if (gm=1) then   begin
                                  form2.ShowModal;
                                    ShowMessage('Х выиграл');
                                      //  sound.FileName := 'Data\\back.mp3';
                                      //  sound.Open;
                                     //  sound.Play;
                                     ClearField();
                                InitGame();
                           end;

          if (gm=2) then  begin    form2.ShowModal; ShowMessage('О выиграл');  ClearField(); InitGame(); end;

          if (gm=0) then begin  ShowMessage('Ничья');  ClearField(); InitGame(); end;

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
      Close();
end;

procedure TForm1.CanvaFieldMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
       if (StrategyGame.UserUser) then begin UserMove();  end;





          // if (WhoMove = 1) then CompMove()
      //else  UserMove();
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
       ClearField();
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
      ClearField();
      // проверить соответс пункт меню если стоит галочка то установить соотв флаг в записи


      // if ( (MainMenu1.Items.Items[2].Name = 'N6') AND (MainMenu1.Items.Items[2].Checked = true) ) then strategygame.UserUser := true;

      InitGame();
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
       Field.Free;
end;

procedure TForm1.N10Click(Sender: TObject);
begin
        StrategyGame.CompUser := true;

        // off
       StrategyGame.UserUser := false;
       StrategyGame.UserComp := false;
end;

procedure TForm1.N6Click(Sender: TObject);
begin
       StrategyGame.UserUser := true;

       // off
       StrategyGame.CompUser := false;
       StrategyGame.UserComp := false;
end;

procedure TForm1.N7Click(Sender: TObject);
begin
        StrategyGame.UserComp := false;

        // off
       StrategyGame.CompUser := false;
       StrategyGame.UserUser := false;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin

           //sound.Play;
     // CanvaField.Refresh;


end;

procedure TForm1.Button1Click(Sender: TObject);
begin
      InitGame();
end;

end.
