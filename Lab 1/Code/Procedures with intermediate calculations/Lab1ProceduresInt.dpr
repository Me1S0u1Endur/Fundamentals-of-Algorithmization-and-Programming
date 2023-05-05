Program Lab1ProceduresInt;

{
  Create a program that calculates matrix expressions. Find
  the value of a given matrix expression using subprograms
  that do not use global parameters.
}

// Determining the Console Program Type
{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

// Determining the type for matrixes
Type
  TMatrix = array[1..3, 1..3] of Integer;

// Declaring the initial matrixes used in the expression
// Tepm1, Temp2, Temp3, Temp4, Temp5 - intemideate results
// resultMatrix - result of expression
Var
  A, B:TMatrix;
  resultOf:Integer;
  Temp1, Temp2, Temp3, Temp4, resultMatrix:TMatrix;

// Subprogram for inputting matrixes
{
  Matrix inputMatrix is being entered by user. Inputted values are
  being checked. In case of the incorrect input it displays an error
  message
}
Procedure initArray(Var inputMatrix:TMatrix);

Var
  I, J:Integer;
  Check:String;
  Flags:Integer;

Begin

  For I := 1 to 3 do
  Begin

    For J := 1 to 3 do
    Begin

      Repeat

        Write('Enter the [' + intToStr(I) + ', ' + intToStr(J) + '] element]: ');
        Readln(Check);
        Val(Check, resultOf, Flags);
        If (Flags <> 0) then
          Writeln('Incorrect input')
        Else
          inputMatrix[I, J] := strToInt(Check);

      Until (Flags = 0) and (resultOf > -100);

    End;

  End;

End;

// Subprogram for calculating the sum or sub of matrixes
{
  Two matrixes (firstMatrix, secondMatrix) of the same size are given.
  The subprogram returns the matrix that is equal
  to the result of summation or subtraction of
  the given matrixes.
}
Procedure doSumOrSubOfMatrix(Const firstMatrix, secondMatrix:TMatrix; Const Flags:boolean; Var resultOf:TMatrix);

// Variable declaration section
Var
  I, J, M, N:Integer;

// I, J, M, N – counter variables

Begin

// Set matrix's length
  M := length(firstMatrix);
  N := length(secondMatrix);

  For I := 1 to M do
    For J := 1 to N do
    Begin

    If Flags then
      resultOf[I, J] := firstMatrix[I, J] + secondMatrix[I, J]
    Else
      resultOf[I, J] := firstMatrix[I, J] - secondMatrix[I, J];

    End;

End;

// Subprogram for multiplying the matrixes
{
  Two matrixes (firstMatrix1, secondMatrix1) of the same size are given.
  The subprogram returns the matrix that is equal
  to the result of the multiplication of the matrixes.
}
Procedure doMultiplyMatrix(Const firstMatrix1, secondMatrix1:TMatrix; Var resultOf:TMatrix);

// Declaring counter variables
Var
  I, J, L, S, lengthOfArray:Integer;

Begin

// Set a length of matrix's
  lengthOfArray := length(firstMatrix1);

  For I := 1 to lengthOfArray do
    For J := 1 to lengthOfArray do
    Begin

    S := 0;
      For L := 1 to lengthOfArray do
        S := S + firstMatrix1[I, L] * secondMatrix1[L, J];
    resultOf[I, J] := S;

    End;

End;

// Subprogram for multiplying the matrix by a number
{
  The firstMatrix1 matrix and the multiplier number are given. The
  subprogram returns the value of the matrix multiplied by a number.
}
Procedure doMultiplyNum(Const firstMatrix1:TMatrix; Const Number:Integer; Var resultOf:TMatrix);

// Declaring counter variables
Var
  I, J, L, lengthOfArray:Integer;

Begin

  // Set matrix's length
  lengthOfArray := length(firstMatrix1);

  For I := 1 to lengthOfArray do
    For J := 1 to lengthOfArray do
        resultOf[I, J] := firstMatrix1[I, J] * Number

End;

// Subprogram for outputting the matrix
{
  A matrix outputMatrix is given. The procedure outputs the
  formatted values of the matrix elements.
}
Procedure doPrintMatrix(Const outputMatrix:TMatrix);

// Declaring counter variables
Var
  I, J:Integer;

Begin
  For I := 1 to length(outputmatrix)  do
  Begin

    For J := 1 to length(outputMatrix)  do
      Write(outputMatrix[I, J]:6);

    Writeln;
  End;

  Writeln;
End;


Begin

  // Inputting matrixes
  Writeln('Enter the matrix A: ');
  initArray(A);
  Writeln('Enter the matrix B: ');
  initArray(B);

  // Outputting the initial matrixes
  Writeln('Matrix A: ');
  doPrintMatrix(A);

  Writeln('Matrix B: ');
  doPrintMatrix(B);

  // Calculating the value of the expression
  doSumOrSubOfMatrix(A, B, True, Temp1);
  Writeln('A + B: ');
  doPrintMatrix(Temp1);
  doMultiplyNum(Temp1, 3, Temp2);
  Writeln('3 * (A + B): ');
  doPrintMatrix(Temp2);
  doMultiplyMatrix(A, B, Temp1);
  Writeln('A * B: ');
  doPrintMatrix(Temp1);
  doMultiplyNum(A, 2, Temp3);
  Writeln('2 * A: ');
  doPrintMatrix(Temp3);
  doSumOrSubOfMatrix(Temp1, Temp3, False, Temp4);
  Writeln('A * B - 2 * A: ');
  doPrintMatrix(Temp4);
  doMultiplyMatrix(Temp2, Temp4, resultMatrix);

  // Output result matrix
  Writeln('Result matrix: ');
  doPrintMatrix(resultMatrix);

  Write('Press any key to end...');
  Readln;
End.

