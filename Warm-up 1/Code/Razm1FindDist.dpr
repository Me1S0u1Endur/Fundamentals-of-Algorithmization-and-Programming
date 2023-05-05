program Razm1FindDist;
{$APPTYPE CONSOLE}
{$R *.res}
uses
  System.SysUtils,
  Math;

type
  TArrayOfCoordinates = array[0..9, 0..1] of Integer;
  TArrayOfX = array of Integer;
  TArrayOfDistances = array of Real;
  TMatrixOfDistances = array of array of Real;
var
//  q: Integer;
  arrayOfCoordinates: TArrayOfCoordinates;
//  sortedArrayOfCoorfinates: TArrayOfCoordinates;
//  arrayOfX: TArrayOfX;
//  arrayOfDistances: TArrayOfDistances;
//  arrayOfDistances: TArrayOfDistances;
//  distanceOf: Real;
  resultOf: Integer;
//  endingX: Integer;
  xCoord, accuracyOf: Integer;
  distanceOf: Real;
procedure initArray(var arrayOf: TArrayOfCoordinates);
var
  i, j: Integer;
  check: String;
  flags: Integer;
begin
  i := 0;
  j := 0;
  for i := 0 to 9 do
  begin
    for j := 0 to 1 do
    begin
       repeat
        Write('Enter the [' + intToStr(i) + ', ' + intToStr(j) + '] element]: ');
        readln(check);
        val(check, resultOf, flags);
        if (flags <> 0) then
          writeln('Incorrect input')
        else
          arrayOf[i, j] := strToInt(check);
      until (flags = 0);
    end;
  end;
end;
procedure initAccuracy(var accuracy: Integer);
var
  check: String;
  flags: Integer;
begin
  repeat
    Write('Enter an accuracy...');
    readln(check);
    val(check, accuracy, flags);
    if (flags <> 0) then
      writeln('Incorrect input')
    else
      accuracy := strToInt(check);
  until (flags = 0) and (accuracy >= 1);
end;
procedure printArray(const arrayOf: TArrayOfCoordinates);
var
  i, j: Integer;
begin
  i := 0;
  j := 0;
  writeln('Array of coordinates: ');
  for i := 0 to 9 do
  begin
    for j := 0 to 1 do
    begin
      write('[' + intToStr(arrayOf[i, j]) + ']');
      write('    ');
    end;
    writeln;
  end;
end;
function sortArrayByX(arrayOf: TArrayOfCoordinates): TArrayOfCoordinates;
var
  i, j, temp, tempY: Integer;
  arrayToBeSorted: TArrayOfCoordinates;
begin
  arrayToBesorted := arrayOf;
  for i := Low(arrayToBesorted) to High(arrayToBesorted) - 1 do
  begin
    for j := Low(arrayToBesorted) to High(arrayToBesorted) - i - 1 do
    begin
      if arrayToBesorted[j, 0] > arrayToBesorted[j + 1, 0] then
      begin
        temp := arrayToBeSorted[j, 0];
        tempY := arrayToBeSorted[j, 1];
        arrayToBeSorted[j, 0] := arrayToBeSorted[j + 1, 0];
        arrayToBeSorted[j + 1, 0] := temp;
        arrayToBeSorted[j, 1] := arrayToBeSorted[j + 1, 1];
        arrayToBeSorted[j + 1, 1] := tempY;
      end;
      
    end;
      
  end;
  result := arrayToBesorted; 
  
end;
function findDistance(var x1, x2, y1, y2: Integer): Real;
var
  tempX, tempY: real;
begin
  tempX := x2 - x1;
  tempY := y2 - y1;
  result := sqrt(sqr(tempX) + sqr(tempY));
end;
procedure findMaxElem(const arrayOfDistances: TMatrixOfDistances; const length: Integer; const perI: Integer; var maxE: Real; var maxJ: Integer);
var
  i, j: Integer;
  tempJ: Integer;
  tempE, nextE: Real;
begin
  i := perI;
  j := 0;
  tempE := 0;
  tempJ := j;
  for j := 0 to length - 1 do
  begin
  nextE := arrayOfDistances[i, j];
    if tempE < nextE then
    begin
      tempE := nextE;
      tempJ := j;
    end;
  end;
  maxE :=  tempE;
  maxJ := tempJ;
end;
procedure findMinElem(const arrayOfHighest: TArrayOfDistances; var minE: Real; var minI: Integer);
var
  j: Integer;
  tempJ: Integer;
  tempE, nextE: Real;
begin
  tempE := arrayOfHighest[0];
  for j := 1 to high(arrayOfHighest) - 1 do
  begin
    if tempE > arrayOfHighest[j] then
    begin
      tempE := arrayOfHighest[j];
      tempJ := j;
    end;
  end;
  minE := tempE;
  minI := tempJ;
end;
procedure findElem(const arrayOfDistances: TMatrixOfDistances; const length: Integer; const elem: Real; var elemIX: Integer);
var
  i: Integer;
  j: Integer;
  tempI: Integer;
  isFound: boolean;
begin
  tempI := 0;
  isFound := false;
  i := 0;
  j := 0;
    repeat
      if arrayOfDistances[i, j] = elem then
      begin
        tempI := j;
        isFound := true;
      end
      else
      begin
        j := j + 1;
        if j = length then
        begin
          j := 0;
          i := i + 1;
        end;
      end;
    until (i > 9) or (isFound = true);
  elemIX := tempI;
end;
procedure readingDistance(const arrayOf: TArrayOfCoordinates; var xC: Integer; var dist: Real; const accuracy: Integer);
var
  i, j, k, length, nullX, maxI, minI, needI: Integer;
  testArray, testArraySorted: TArrayOfCoordinates;
  arrayOfX: TArrayOfX;
  arrayOfHighest: TArrayOfDistances;
  arrayOfDistances: TMatrixOfDistances;
  distanceIs: Real;
  maxE, minE: Real;
  needE: Integer;
const
  ROWS = 9;
begin
  k := 0;
  nullX := 0;
  maxE := 0;
  maxI := 0;
  testArray := arrayOf;
  testArraySorted := sortArrayByX(testArray);
  length := testArraySorted[9, 0] - testArraySorted[0, 0];
  setLength(arrayOfX, length);
  setLength(arrayOfDistances, 10, length);
  setLength(arrayOfHighest, 10);
  arrayOfX[0] := testArraySorted[0, 0];
  arrayOfX[High(arrayOfX)] := testArraySorted[high(testArraySorted), 0];
  for i := 1 to high(arrayOfX) do
  begin
    arrayOfX[i] := arrayOFx[0] + i;
  end;
  while k < ROWS do
  begin
    for i := 0 to ROWS do
    begin
      for j := 0 to length - 1 do
      begin
        arrayOfDistances[i, j] := findDistance(arrayOfX[j], testArraySorted[i, 0], nullX, testArraySorted[i, 1]);
      end;
      findMaxElem(arrayOfDistances, length, i, maxE, maxI);
      arrayOfHighest[k] := maxE;
      k := k + 1;
    end;
  end;
  findMinElem(arrayOfHighest, minE, minI);
  findElem(arrayOfDistances, length, minE, needI);
  needE := arrayOfX[needI];
//  result := needE;
  xC := needE;
  dist := roundTo(minE, -accuracy);
end;

begin
//  initArray(arrayOfCoordinates);
//  printArray(arrayOfCoordinates);
//  sortedArrayOfCoorfinates := sortArrayByX(arrayOfCoordinates);
//  printArray(sortedArrayOfCoorfinates);
//  initArray(arrayOfCoordinates);
//  arrayOfDistances := readingDistance(arrayOfCoordinates);
//  for q := 0 to High(arrayOfDistances) - 1 do
//    write(arrayOfDistances[q]:7:2);
  initArray(arrayOfCoordinates);
//  endingX := readingDistance(arrayOfCoordinates);
  initAccuracy(accuracyOf);
  readingDistance(arrayOfCoordinates, xCoord, distanceOf, accuracyOf);
  writeln;

  writeln('The result is: ' + intToStr(xCoord));
  writeln('The distance is: ' + floatToStr(distanceOf));
readln;
end.
