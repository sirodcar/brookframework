(*
  Brook framework, Utilities Unit

  Copyright (C) 2014 Silvio Clecio

  See the file LICENSE.txt, included in this distribution,
  for details about the copyright.

  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
*)

unit BrookUtils;

{$i brook.inc}

interface

uses
  BrookException, BrookMessages, BrookConsts, BrookHTTPConsts, CustWeb,
  Classes, SysUtils, TypInfo;

type
  { Defines an array of strings. }
  TBrookArrayOfString = array of string;

  { Defines an enumerator to represent the HTTP request methods. }
  TBrookRequestMethod = (
    rmUnknown, rmAll, rmGet, rmPost, rmPut, rmDelete, rmHead, rmOptions, rmTrace
  );

  { Stores the Brook configurations. }
  TBrookSettings = record
    { Enables the mapping of HTTP request methods. }
    Mapped: Boolean;
    { Set the default application Charset. }
    Charset: ShortString;
    { Set the default application Content-Type. }
    ContentType: ShortString;
    { Set the 404 HTML page. The string will be sent as is. }
    Page404: string;
    { Set the 404 HTML page file. The file content will be sent.
      This has higher precedence than @code(TBrookSettings.Page404)
      so when both are set, this will be processed first and only
      if the file is not found or cannot be read the system will
      fallback to @code(TBrookSettings.Page404) }
    Page404File: string;
    { Set the 500 HTML page. The string will be sent as is. }
    Page500: string;
    { Set the 500 HTML page file. The file content will be sent.
      This has higher precedence than @code(TBrookSettings.Page500)
      so when both are set, this will be processed first and only
      if the file is not found or cannot be read the system will
      fallback to @code(TBrookSettings.Page500) }
    Page500File: string;
    { Set the default directory for uploads. }
    DirectoryForUploads: string;
    { Defines if the temporary uploaded files will be deleted. }
    DeleteUploadedFiles: Boolean;
    { Keeps the original name of the uploaded files. }
    KeepUploadedNames: Boolean;
    { Defines if the application allows JSON formated requests. }
    AcceptsJSONContent: Boolean;
    { Set a configuration for the application or for its object members. }
    Configuration: string;
    { Set the default root URL. This is used by methods such as
      @code(TBrookAction.UrlFor), @code(TBrookActionHelper.LinkTo),
      @code(TBrookActionHelper.ButtonTo) etc. By default, Brook assumes
      @code(SCRIPT_NAME) as root URL. }
    RootUrl: string;
    { Set the default application port. }
    Port: Word;
    { Handles the application exceptions. }
    OnError: TOnShowRequestException;
  end;

var
  { Global variable to store Brook settings. }
  BrookSettings: TBrookSettings = (
    Mapped: False;
    Charset: BROOK_HTTP_CHARSET_UTF_8;
    ContentType: BROOK_HTTP_CONTENT_TYPE_TEXT_HTML;
    Page404: BROOK_HTTP_RESPONSE_TEMPLATE_NOT_FOUND;
    Page404File: ES;
    Page500: BROOK_HTTP_RESPONSE_TEMPLATE_INTERNAL_SERVER_ERROR;
    Page500File: ES;
    DirectoryForUploads: ES;
    DeleteUploadedFiles: False;
    KeepUploadedNames: True;
    AcceptsJSONContent: False;
    Configuration: ES;
    RootUrl: ES;
    Port: 0;
    OnError: nil;
  );

{ Check whether a string starts with a given character. }
function BrookStartsChar(const Ch: Char; const S: string): Boolean;
{ Check whether a string ends with a given character. }
function BrookEndsChar(const Ch: Char; const S: string): Boolean;
{ Get the next pathinfo level. }
procedure BrookExtractPathLevels(S: string; var R: string; out ALvl: string;
  out AEndDelim: Boolean; const ADelimiter: Char = US);
{ Get the path level passing the respective index. Exemple:

  @code(BrookGetPathLavel('/a/b/c/', 1)) = b. }
function BrookGetPathLevel(const APath: string; const AIndex: SizeInt = 0;
  const ADelimiter: Char = US): string;
{ Get the path from the level correspondent to the index to the last level.
  Exemple:

  @code(BrookGetPathLevels('/a/b/c/', 1)) = b/c/. }
function BrookGetPathLevels(const APath: string; const AIndex: SizeInt = 0;
  const ADelimiter: Char = US): string;
{ Checks if a string is equivalent a enumerator representing a HTTP request
  method. }
function BrookMatchMethod(const ABrookMethod: TBrookRequestMethod;
  const AMethod: string): Boolean;
{ Get the datetime of a file. }
function BrookFileDate(const AFileName: TFileName): TDateTime;
{ Writes a backtrace of the current exception. }
function BrookDumpStack(const AEOL: ShortString = BR): string;
{ Ensures Url ends without delimiter. }
function BrookExcludeTrailingUrlDelimiter(const AUrl: string): string;
{ Ensures Url ends with delimiter. }
function BrookIncludeTrailingUrlDelimiter(const AUrl: string): string;
{ Fills a published property of an object passing the property as
  @code(PPropInfo) and value as @code(string). }
procedure BrookStringToObject(AObject: TObject; APropInfo: PPropInfo;
  const AValue: string); overload;
{ Fills a published property of an object passing the name and value as
  @code(string). }
procedure BrookStringToObject(AObject: TObject; const AName,
  AValue: string); overload;
{ Fills a published property of an object passing the name and value as
  string and checking the params. }
procedure BrookSafeStringToObject(AObject: TObject; const AName, AValue: string);
{ Fills the published properties of an object passing the names and values as
  a list of strings. }
procedure BrookStringsToObject(AObject: TObject; AStrings: TStrings);
{ Fills the published properties of an object passing the names and values as
  a list of strings and checking the params. }
procedure BrookSafeStringsToObject(AObject: TObject; AStrings: TStrings);
{ Reads a published property of an object passing the property as
  @code(PPropInfo) and getting the value as @code(string). }
procedure BrookObjectToString(AObject: TObject; APropInfo: PPropInfo;
  out AValue: string); overload;
{ Reads a published property of an object passing the name as @code(string) and
  getting the value as @code(string). }
procedure BrookObjectToString(AObject: TObject; const AName: string;
  out AValue: string); overload;
{ Reads a published property of an object passing the name, getting the value as
  string and checking the params. }
procedure BrookSafeObjectToString(AObject: TObject; const AName: string;
  out AValue: string);
{ Reads the published properties of an object getting the names and values as
  a list of strings. }
procedure BrookObjectToStrings(AObject: TObject; AStrings: TStrings);
{ Read the published properties of an object getting the names and values as
  a list of strings and checking the params. }
procedure BrookSafeObjectToStrings(AObject: TObject; AStrings: TStrings);

implementation

function BrookStartsChar(const Ch: Char; const S: string): Boolean;
begin
  Result := (Length(S) > 0) and (S[1] = Ch);
end;

function BrookEndsChar(const Ch: Char; const S: string): Boolean;
begin
  Result := (Length(S) > 0) and (S[Length(S)] = Ch);
end;

procedure BrookExtractPathLevels(S: string; var R: string; out ALvl: string;
  out AEndDelim: Boolean; const ADelimiter: Char = US);
var
  P, L: Integer;
begin
  L := Length(S);
  AEndDelim := (S <> ES) and (S[L] = ADelimiter);
  if AEndDelim then
    Delete(S, L, 1);
  if (S <> ES) and (S[1] = ADelimiter) then
    Delete(S, 1, 1);
  Delete(S, 1, Length(BrookIncludeTrailingUrlDelimiter(R)));
  P := Pos(ADelimiter, S);
  if P = 0 then
    P := Length(S) + 1;
  ALvl := Copy(S, 1, P - 1);
  R := BrookIncludeTrailingUrlDelimiter(R) + ALvl;
end;

function BrookGetPathLevel(const APath: string; const AIndex: SizeInt;
  const ADelimiter: Char): string;
var
  C, L: SizeInt;
  VSrc, VDest: PChar;
begin
  SetLength(Result, Length(APath));
  VSrc := PChar(APath);
  VDest := PChar(Result);
  C := Succ(AIndex);
  L := 0;
  while (VSrc^ <> NU) and (VSrc^ <> QU) do
  begin
    if (VSrc^ = ADelimiter) and (C <> 0) then
      Dec(C)
    else
      if C = 0 then
      begin
        if VSrc^ = ADelimiter then
          Break;
        VDest^ := VSrc^;
        Inc(VDest);
        Inc(L);
      end;
    Inc(VSrc);
  end;
  SetLength(Result, L);
end;

function BrookGetPathLevels(const APath: string; const AIndex: SizeInt;
  const ADelimiter: Char): string;
var
  C, L: Integer;
  VSrc, VDest: PChar;
begin
  SetLength(Result, Length(APath));
  VSrc := PChar(APath);
  VDest := PChar(Result);
  C := Succ(AIndex);
  L := 0;
  while (VSrc^ <> NU) and (VSrc^ <> QU) do
  begin
    if (VSrc^ = ADelimiter) and (C <> 0) then
      Dec(C)
    else
      if C = 0 then
      begin
        VDest^ := VSrc^;
        Inc(VDest);
        Inc(L);
      end;
    Inc(VSrc);
  end;
  SetLength(Result, L);
end;

function BrookMatchMethod(const ABrookMethod: TBrookRequestMethod;
  const AMethod: string): Boolean;
begin
  case ABrookMethod of
    rmAll: Result := True;
    rmGet: Result := AMethod = BROOK_HTTP_REQUEST_METHOD_GET;
    rmHead: Result := AMethod = BROOK_HTTP_REQUEST_METHOD_HEAD;
    rmOptions: Result := AMethod = BROOK_HTTP_REQUEST_METHOD_OPTIONS;
    rmPost: Result := AMethod = BROOK_HTTP_REQUEST_METHOD_POST;
    rmPut: Result := AMethod = BROOK_HTTP_REQUEST_METHOD_PUT;
    rmDelete: Result := AMethod = BROOK_HTTP_REQUEST_METHOD_DELETE;
  else
    Result := False;
  end;
end;

function BrookFileDate(const AFileName: TFileName): TDateTime;
begin
  if not FileExists(AFileName) then
    raise EBrook.CreateFmt('BrookFileDate',
      SBrookFileNotFoundError, [AFileName]);
  Result := FileDateToDateTime(FileAge(AFileName));
end;

function BrookDumpStack(const AEOL: ShortString): string;
var
  I: Integer;
begin
  Result := BackTraceStrFunc(ExceptAddr) + AEOL;
  for I := 0 to Pred(ExceptFrameCount) do
    Result += BackTraceStrFunc(ExceptFrames[I]) + AEOL;
end;

function BrookExcludeTrailingUrlDelimiter(const AUrl: string): string;
var
  L: Integer;
begin
  Result := AUrl;
  L := Length(Result);
  if (L > 0) and (Result[L] = US) then
    Delete(Result, L, 1);
end;

function BrookIncludeTrailingUrlDelimiter(const AUrl: string): string;
var
  L: Integer;
begin
  Result := AUrl;
  L := Length(Result);
  if (L > 0) and (Result[L] <> US) then
    Result += US;
end;

procedure BrookStringToObject(AObject: TObject; APropInfo: PPropInfo;
  const AValue: string);
begin
  if Assigned(APropInfo) then
    case APropInfo^.PropType^.Kind of
      tkAString: SetStrProp(AObject, APropInfo, AValue);
      tkChar: SetOrdProp(AObject, APropInfo, Ord(PChar(AValue)^));
      tkInteger: SetOrdProp(AObject, APropInfo, StrToIntDef(AValue, DefInt));
      tkInt64, tkQWord: SetInt64Prop(AObject, APropInfo,
        StrToInt64Def(AValue, DefInt64));
      tkBool: SetOrdProp(AObject, APropInfo,
        Ord((ShortCompareText(AValue, 'on') = 0) or
          StrToBoolDef(AValue, DefBool)));
      tkFloat:
        case APropInfo^.PropType^.Name of
          'TDate': SetFloatProp(AObject, APropInfo,
            StrToDateDef(AValue, DefDate));
          'TTime': SetFloatProp(AObject, APropInfo,
            StrToTimeDef(AValue, DefTime));
          'TDateTime': SetFloatProp(AObject, APropInfo,
            StrToDateTimeDef(AValue, DefDateTime));
        else
          SetFloatProp(AObject, APropInfo, StrToFloatDef(AValue, DefFloat));
        end;
      tkEnumeration: SetEnumProp(AObject, APropInfo, AValue);
      tkSet: SetSetProp(AObject, APropInfo, AValue);
    end;
end;

procedure BrookStringToObject(AObject: TObject; const AName, AValue: string);
begin
  BrookStringToObject(AObject,
    GetPropInfo(PTypeInfo(AObject.ClassInfo), AName), AValue);
end;

procedure BrookSafeStringToObject(AObject: TObject; const AName, AValue: string);
begin
  if not Assigned(AObject) then
    raise EBrook.CreateFmt('BrookSafeStringToObject',
      SBrookNotNilError, ['AObject']);
  BrookStringToObject(AObject, AName, AValue);
end;

procedure BrookStringsToObject(AObject: TObject; AStrings: TStrings);
var
  I: Integer;
  N, V: string;
begin
  for I := 0 to Pred(AStrings.Count) do
  begin
    AStrings.GetNameValue(I, N, V);
    BrookStringToObject(AObject, N, V);
  end;
end;

procedure BrookSafeStringsToObject(AObject: TObject; AStrings: TStrings);
begin
  if not Assigned(AStrings) then
    raise EBrook.CreateFmt('BrookSafeStringsToObject', SBrookNotNilError,
      ['AStrings']);
  if not Assigned(AObject) then
    raise EBrook.CreateFmt('BrookSafeStringsToObject', SBrookNotNilError,
      ['AObject']);
  BrookStringsToObject(AObject, AStrings);
end;

procedure BrookObjectToString(AObject: TObject; APropInfo: PPropInfo;
  out AValue: string);
begin
  if Assigned(APropInfo) then
    case APropInfo^.PropType^.Kind of
      tkAString: AValue := GetStrProp(AObject, APropInfo);
      tkChar: AValue := Char(GetOrdProp(AObject, APropInfo));
      tkInteger: AValue := IntToStr(GetOrdProp(AObject, APropInfo));
      tkInt64, tkQWord: AValue := IntToStr(GetInt64Prop(AObject, APropInfo));
      tkBool: AValue := BoolToStr(GetOrdProp(AObject, APropInfo) <> 0, True);
      tkFloat:
        case APropInfo^.PropType^.Name of
          'TDate': AValue := DateToStr(GetFloatProp(AObject, APropInfo));
          'TTime': AValue := TimeToStr(GetFloatProp(AObject, APropInfo));
          'TDateTime': AValue := DateTimeToStr(GetFloatProp(AObject, APropInfo));
          'Currency': AValue :=
            CurrToStrF(GetFloatProp(AObject, APropInfo), ffCurrency, -1);
        else
          AValue := FloatToStr(GetFloatProp(AObject, APropInfo));
        end;
      tkEnumeration: AValue := GetEnumProp(AObject, APropInfo);
      tkSet: AValue := GetSetProp(AObject, APropInfo, False);
    end;
end;

procedure BrookObjectToString(AObject: TObject; const AName: string;
  out AValue: string);
begin
  BrookObjectTostring(AObject,
    GetPropInfo(PTypeInfo(AObject.ClassInfo), AName), AValue);
end;

procedure BrookSafeObjectToString(AObject: TObject; const AName: string;
  out AValue: string);
begin
  if not Assigned(AObject) then
    raise EBrook.CreateFmt('BrookSafeObjectToString', SBrookNotNilError,
      ['AObject']);
  BrookObjectToString(AObject, AName, AValue);
end;

procedure BrookObjectToStrings(AObject: TObject; AStrings: TStrings);
var
  S: Char;
  V: string;
  I, C: Integer;
  PI: PPropInfo;
  PL: PPropList = nil;
begin
  C := GetPropList(PTypeInfo(AObject.ClassInfo), PL);
  if Assigned(PL) then
    try
      S := AStrings.NameValueSeparator;
      if S = NU then
        S := EQ;
      for I := 0 to Pred(C) do
      begin
        PI := PL^[I];
        BrookObjectToString(AObject, PI, V);
        AStrings.Add(PI^.Name + S + V);
      end;
    finally
      FreeMem(PL);
    end;
end;

procedure BrookSafeObjectToStrings(AObject: TObject; AStrings: TStrings);
begin
  if not Assigned(AStrings) then
    raise EBrook.CreateFmt('BrookSafeObjectToStrings', SBrookNotNilError,
      ['AStrings']);
  if not Assigned(AObject) then
    raise EBrook.CreateFmt('BrookSafeObjectToStrings', SBrookNotNilError,
      ['AObject']);
  BrookObjectToStrings(AObject, AStrings);
end;

end.
