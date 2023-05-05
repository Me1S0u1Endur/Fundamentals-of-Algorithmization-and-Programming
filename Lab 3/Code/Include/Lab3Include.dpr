program Lab3Include;
uses
  System.SysUtils;

{$APPTYPE CONSOLE}
{$I toInclude.pas}
begin
// Inputting matrixes
  writeln('Enter the matrix A: ');
  initArray(A);
  writeln('Enter the matrix B: ');
  initArray(B);
// Outputting the initial matrixes
  writeln('Matrix A: ');
  doPrintMatrix(A);
  writeln('Matrix B: ');
  doPrintMatrix(B);

  writeln('Sum of matrix A and B -  (A + B): ');
  Temp1 := doSumOrSubOfMatrix(A, B, True);
  doPrintMatrix(Temp1);

  writeln('Multiply of number 3 and matrix Temp1: ');
  Temp2 := doMultiplyNum(Temp1, 3);
  doPrintMatrix(Temp2);

  writeln('Multiply of matrix A and B: ');
  Temp3 := doMultiplyMatrix(A, B);
  doPrintMatrix(Temp3);

  writeln('Multiply of matrix 2 and A: ');
  Temp4 := doMultiplyNum(A, 2);
  doPrintMatrix(Temp4);

  writeln('Multiply of matrix Temp4 and -  Temp4 * B: ');
  Temp5 :=  doSumOrSubOfMatrix(Temp3, Temp4, False);
  doPrintMatrix(Temp5);

// Calculating the value of the expression
  writeln('The end result is  -  3 * (A + B) * (A * B - 2 * A): ');
  resultMatrix := doMultiplyMatrix(Temp2, Temp5);
  doPrintMatrix(resultMatrix);
  writeln('Press any key to end...');
readln;
end.
