Program Lab1;

 {
    Create a program that calculates matrix expressions. Find
    the value of a given matrix expression using subprograms
    that do not use global parameters.
 }

//Determining the Console Program Type
{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

type
  TMatrix = array[1..3, 1..3] of Integer;

//Declaring the initial matrixes used in the expression
//
Var
  A , B:TMatrix;
  resultOf:Integer;
  Temp1, Temp2, Temp3, Temp4, Temp5, resultMx:TMatrix;
  I, J, K:Integer;

Begin



End.
