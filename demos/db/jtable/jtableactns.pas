unit jTableActns;

{$mode objfpc}{$H+}

interface

uses
  BrookAction, BrookHttpDefs, BrookUtils, dOpf, dSQLdbBroker, RUtils, dbutils,
  Classes, SysUtils, FPJSON;

type
  TjTableBeforeMakeFieldsEvent =
    procedure(var AFields: string; var AHandled: Boolean) of object;
  TjTableBeforeMakeSelectEvent = procedure(var AFields, ASelect: string;
    var AHandled: Boolean) of object;
  TjTableBeforeMakeWhereEvent = procedure(var ASelect, AWhere: string;
    var AHandled: Boolean) of object;
  TjTableBeforeMakeOrderByEvent = procedure(var ASelect, AjtSorting: string;
    var AHandled: Boolean) of object;
  TjTableBeforeMakeLimitEvent = procedure(var ASelect: string;
    var AHandled: Boolean) of object;
  TjTableBeforeCountRecordsEvent = procedure(var AWhere: string;
    var ACount: Integer; var AHandled: Boolean) of object;

  TjTableAfterMakeFieldsEvent = procedure(var AFields: string) of object;
  TjTableAfterMakeSelectEvent = procedure(var AFields,
    ASelect: string) of object;
  TjTableAfterMakeWhereEvent = procedure(var ASelect, AWhere: string) of object;
  TjTableAfterMakeOrderByEvent = procedure(var ASelect,
    AjtSorting: string) of object;
  TjTableAfterMakeLimitEvent = procedure(var ASelect: string) of object;
  TjTableAfterCountRecordsEvent = procedure(var AWhere: string) of object;

  { TjTableGOpf }

  generic TjTableGOpf<T> = class(specialize TdGOpf<TdSQLdbConnector, TdSQLdbQuery, T>)
  private
    FOnAfterCountRecords: TjTableAfterCountRecordsEvent;
    FOnAfterMakeFields: TjTableAfterMakeFieldsEvent;
    FOnAfterMakeLimit: TjTableAfterMakeLimitEvent;
    FOnAfterMakeOrderBy: TjTableAfterMakeOrderByEvent;
    FOnAfterMakeSelect: TjTableAfterMakeSelectEvent;
    FOnAfterMakeWhere: TjTableAfterMakeWhereEvent;
    FOnBeforeCountRecords: TjTableBeforeCountRecordsEvent;
    FOnBeforeMakeLimit: TjTableBeforeMakeLimitEvent;
    FOnBeforeMakeOrderBy: TjTableBeforeMakeOrderByEvent;
    FOnBeforeMakeSelect: TjTableBeforeMakeSelectEvent;
    FOnBeforeMakeFields: TjTableBeforeMakeFieldsEvent;
    FOnBeforeMakeWhere: TjTableBeforeMakeWhereEvent;
    FUnlistedFields: TStrings;
  protected
    procedure DoMakeFields(var AFields: string); virtual;
    procedure DoMakeSelect(var AFields, ASelect: string); virtual;
    procedure DoMakeWhere(var ASelect, AWhere: string); virtual;
    procedure DoMakeOrderBy(var ASelect, AjtSorting: string); virtual;
    procedure DoMakeLimit(var ASelect: string); virtual;
    function DoCountRecords(var AWhere: string;
      {%H-}AParams: TObject): Integer; virtual;
  public
    constructor Create; overload; virtual;
    destructor Destroy; override;
    procedure ListData(AEntity: T; AEntities: TEntities;
      AParamsStr: TStrings; AParams: TObject; var AWhere: string);
    property UnlistedFields: TStrings read FUnlistedFields;
    property OnBeforeMakeFields: TjTableBeforeMakeFieldsEvent
      read FOnBeforeMakeFields write FOnBeforeMakeFields;
    property OnBeforeMakeSelect: TjTableBeforeMakeSelectEvent
      read FOnBeforeMakeSelect write FOnBeforeMakeSelect;
    property OnBeforeMakeWhere: TjTableBeforeMakeWhereEvent
      read FOnBeforeMakeWhere write FOnBeforeMakeWhere;
    property OnBeforeMakeOrderBy: TjTableBeforeMakeOrderByEvent
      read FOnBeforeMakeOrderBy write FOnBeforeMakeOrderBy;
    property OnBeforeMakeLimit: TjTableBeforeMakeLimitEvent
      read FOnBeforeMakeLimit write FOnBeforeMakeLimit;
    property OnAfterMakeFields: TjTableAfterMakeFieldsEvent
      read FOnAfterMakeFields write FOnAfterMakeFields;
    property OnAfterMakeSelect: TjTableAfterMakeSelectEvent
      read FOnAfterMakeSelect write FOnAfterMakeSelect;
    property OnAfterMakeWhere: TjTableAfterMakeWhereEvent
      read FOnAfterMakeWhere write FOnAfterMakeWhere;
    property OnAfterMakeOrderBy: TjTableAfterMakeOrderByEvent
      read FOnAfterMakeOrderBy write FOnAfterMakeOrderBy;
    property OnAfterMakeLimit: TjTableAfterMakeLimitEvent
      read FOnAfterMakeLimit write FOnAfterMakeLimit;
    property OnBeforeCountRecords: TjTableBeforeCountRecordsEvent
      read FOnBeforeCountRecords write FOnBeforeCountRecords;
    property OnAfterCountRecords: TjTableAfterCountRecordsEvent
      read FOnAfterCountRecords write FOnAfterCountRecords;
  end;

  { TjTableGEntityOpf }

  generic TjTableGEntityOpf<T> = class(specialize TdGEntityOpf<TdSQLdbConnector, TdSQLdbQuery, T>)
  private
    FOnAfterCountRecords: TjTableAfterCountRecordsEvent;
    FOnAfterMakeFields: TjTableAfterMakeFieldsEvent;
    FOnAfterMakeLimit: TjTableAfterMakeLimitEvent;
    FOnAfterMakeOrderBy: TjTableAfterMakeOrderByEvent;
    FOnAfterMakeSelect: TjTableAfterMakeSelectEvent;
    FOnAfterMakeWhere: TjTableAfterMakeWhereEvent;
    FOnBeforeCountRecords: TjTableBeforeCountRecordsEvent;
    FOnBeforeMakeLimit: TjTableBeforeMakeLimitEvent;
    FOnBeforeMakeOrderBy: TjTableBeforeMakeOrderByEvent;
    FOnBeforeMakeSelect: TjTableBeforeMakeSelectEvent;
    FOnBeforeMakeFields: TjTableBeforeMakeFieldsEvent;
    FOnBeforeMakeWhere: TjTableBeforeMakeWhereEvent;
    FUnlistedFields: TStrings;
  protected
    procedure DoMakeFields(var AFields: string); virtual;
    procedure DoMakeSelect(var AFields, ASelect: string); virtual;
    procedure DoMakeWhere(var ASelect, AWhere: string); virtual;
    procedure DoMakeOrderBy(var ASelect, AjtSorting: string); virtual;
    procedure DoMakeLimit(var ASelect: string); virtual;
    function DoCountRecords(var AWhere: string;
      {%H-}AParams: TObject): Integer; virtual;
  public
    constructor Create; overload; virtual;
    destructor Destroy; override;
    procedure ListData(AEntity: T; AEntities: TEntities;
      AParamsStr: TStrings; AParams: TObject; var AWhere: string); virtual;
    property UnlistedFields: TStrings read FUnlistedFields;
    property OnBeforeMakeFields: TjTableBeforeMakeFieldsEvent
      read FOnBeforeMakeFields write FOnBeforeMakeFields;
    property OnBeforeMakeSelect: TjTableBeforeMakeSelectEvent
      read FOnBeforeMakeSelect write FOnBeforeMakeSelect;
    property OnBeforeMakeWhere: TjTableBeforeMakeWhereEvent
      read FOnBeforeMakeWhere write FOnBeforeMakeWhere;
    property OnBeforeMakeOrderBy: TjTableBeforeMakeOrderByEvent
      read FOnBeforeMakeOrderBy write FOnBeforeMakeOrderBy;
    property OnBeforeMakeLimit: TjTableBeforeMakeLimitEvent
      read FOnBeforeMakeLimit write FOnBeforeMakeLimit;
    property OnAfterMakeFields: TjTableAfterMakeFieldsEvent
      read FOnAfterMakeFields write FOnAfterMakeFields;
    property OnAfterMakeSelect: TjTableAfterMakeSelectEvent
      read FOnAfterMakeSelect write FOnAfterMakeSelect;
    property OnAfterMakeWhere: TjTableAfterMakeWhereEvent
      read FOnAfterMakeWhere write FOnAfterMakeWhere;
    property OnAfterMakeOrderBy: TjTableAfterMakeOrderByEvent
      read FOnAfterMakeOrderBy write FOnAfterMakeOrderBy;
    property OnAfterMakeLimit: TjTableAfterMakeLimitEvent
      read FOnAfterMakeLimit write FOnAfterMakeLimit;
    property OnBeforeCountRecords: TjTableBeforeCountRecordsEvent
      read FOnBeforeCountRecords write FOnBeforeCountRecords;
    property OnAfterCountRecords: TjTableAfterCountRecordsEvent
      read FOnAfterCountRecords write FOnAfterCountRecords;
  end;

  { TjTableGAction }

  generic TjTableGAction<T1, T2> = class(specialize TBrookGAction<T2>)
  private
    FOpf: T1;
    FData: TJSONObject;
  public
    constructor Create; overload; override;
    destructor Destroy; override;
    procedure Request(ARequest: TBrookRequest;
      AResponse: TBrookResponse); override;
    procedure Post; override;
    procedure WriteData; virtual;
    property Data: TJSONObject read FData;
    property Opf: T1 read FOpf;
  end;

  { TjTableGListAction }

  generic TjTableGListAction<T1, T2> = class(specialize TjTableGAction<T1, T2>)
  private
    FjtPageSize: Integer;
    FjtSorting: string;
    FjtStartIndex: Integer;
  public
    procedure Post; override;
  published
    property jtSorting: string read FjtSorting write FjtSorting;
    property jtPageSize: Integer read FjtPageSize write FjtPageSize;
    property jtStartIndex: Integer read FjtStartIndex write FjtStartIndex;
  end;

  { TjTableGCreateAction }

  generic TjTableGCreateAction<T1, T2> = class(specialize TjTableGAction<T1, T2>)
  public
    procedure Post; override;
  end;

  { TjTableGUpdateAction }

  generic TjTableGUpdateAction<T1, T2> = class(specialize TjTableGAction<T1, T2>)
  public
    procedure Post; override;
  end;

  { TjTableGDeleteAction }

  generic TjTableGDeleteAction<T1, T2> = class(specialize TjTableGAction<T1, T2>)
  public
    procedure Post; override;
  end;

  { TjTableGLookupAction }

  generic TjTableGLookupAction<T1, T2> = class(specialize TjTableGAction<T1, T2>)
  public
    class function DisplayText: string; virtual;
    class function Value: string; virtual;
    procedure Post; override;
  end;

implementation

{ TjTableGOpf }

constructor TjTableGOpf.Create;
begin
  inherited Create(dbutils.con, '');
  FUnlistedFields := TStringList.Create;
end;

destructor TjTableGOpf.Destroy;
begin
  FUnlistedFields.Free;
  inherited Destroy;
end;

procedure TjTableGOpf.DoMakeFields(var AFields: string);
var
  VHandled: Boolean = False;
begin
  if Assigned(FOnBeforeMakeFields) then
    FOnBeforeMakeFields(AFields, VHandled);
  if not VHandled then
    GetFieldNames(AFields);
  if Assigned(FOnAfterMakeFields) then
    FOnAfterMakeFields(AFields);
end;

procedure TjTableGOpf.DoMakeSelect(var AFields, ASelect: string);
var
  VHandled: Boolean = False;
begin
  if Assigned(FOnBeforeMakeSelect) then
    FOnBeforeMakeSelect(AFields, ASelect, VHandled);
  if not VHandled then
    ASelect := 'select ' + AFields + ' from ' + Table.Name;
  if Assigned(FOnAfterMakeSelect) then
    FOnAfterMakeSelect(AFields, ASelect);
end;

procedure TjTableGOpf.DoMakeWhere(var ASelect, AWhere: string);
var
  VHandled: Boolean = False;
begin
  if Assigned(FOnBeforeMakeWhere) then
    FOnBeforeMakeWhere(ASelect, AWhere, VHandled);
  if not VHandled then
    ASelect += ' where ' + AWhere;
  if Assigned(FOnAfterMakeWhere) then
    FOnAfterMakeWhere(ASelect, AWhere);
end;

procedure TjTableGOpf.DoMakeOrderBy(var ASelect, AjtSorting: string);
var
  VHandled: Boolean = False;
begin
  if Assigned(FOnBeforeMakeOrderBy) then
    FOnBeforeMakeOrderBy(ASelect, AjtSorting, VHandled);
  if not VHandled then
    ASelect += ' order by ' + AjtSorting;
  if Assigned(FOnAfterMakeOrderBy) then
    FOnAfterMakeOrderBy(ASelect, AjtSorting);
end;

procedure TjTableGOpf.DoMakeLimit(var ASelect: string);
var
  VHandled: Boolean = False;
begin
  if Assigned(FOnBeforeMakeLimit) then
    FOnBeforeMakeLimit(ASelect, VHandled);
  if not VHandled then
    ASelect += ' limit :jtPageSize offset :jtStartIndex';
  if Assigned(FOnAfterMakeLimit) then
    FOnAfterMakeLimit(ASelect);
end;

function TjTableGOpf.DoCountRecords(var AWhere: string;
  AParams: TObject): Integer;
var
  VHandled: Boolean = False;
begin
  if Assigned(FOnBeforeCountRecords) then
  begin
    Result := -1;
    FOnBeforeCountRecords(AWhere, Result, VHandled);
  end;
  if not VHandled then
    Result := pgCount(Table.Name, AWhere, AParams);
  if Assigned(FOnAfterCountRecords) then
    FOnAfterCountRecords(AWhere);
end;

procedure TjTableGOpf.ListData(AEntity: T; AEntities: TEntities;
  AParamsStr: TStrings; AParams: TObject; var AWhere: string);
var
  VjtSorting: string;
  VSelect: string = '';
  VFields: string = '';
  VjtSortingIdx, VjtStartIndexIdx, VjtPageSizeIdx: Integer;
begin
  VjtSortingIdx := AParamsStr.IndexOfName('jtSorting');
  VjtPageSizeIdx := AParamsStr.IndexOfName('jtPageSize');
  VjtStartIndexIdx := AParamsStr.IndexOfName('jtStartIndex');
  DoMakeFields(VFields);
  DoMakeSelect(VFields, VSelect);
  if AWhere <> '' then
    DoMakeWhere(VSelect, AWhere);
  if VjtSortingIdx > -1 then
  begin
    VjtSorting := AParamsStr.ValueFromIndex[VjtSortingIdx];
    DoMakeOrderBy(VSelect, VjtSorting);
  end;
  if (VjtPageSizeIdx > -1) and (VjtStartIndexIdx > -1) then
  begin
    DoMakeLimit(VSelect);
    Search(AEntity, AEntities, AParams, VSelect, False);
  end
  else
    Search(AEntity, AEntities, nil, '', False);
end;

{ TjTableGEntityOpf }

constructor TjTableGEntityOpf.Create;
begin
  inherited Create(dbutils.con, '');
  FUnlistedFields := TStringList.Create;
end;

destructor TjTableGEntityOpf.Destroy;
begin
  FUnlistedFields.Free;
  inherited Destroy;
end;

procedure TjTableGEntityOpf.DoMakeFields(var AFields: string);
var
  VHandled: Boolean = False;
begin
  if Assigned(FOnBeforeMakeFields) then
    FOnBeforeMakeFields(AFields, VHandled);
  if not VHandled then
    GetFieldNames(AFields);
  if Assigned(FOnAfterMakeFields) then
    FOnAfterMakeFields(AFields);
end;

procedure TjTableGEntityOpf.DoMakeSelect(var AFields, ASelect: string);
var
  VHandled: Boolean = False;
begin
  if Assigned(FOnBeforeMakeSelect) then
    FOnBeforeMakeSelect(AFields, ASelect, VHandled);
  if not VHandled then
    ASelect := 'select ' + AFields + ' from ' + Table.Name;
  if Assigned(FOnAfterMakeSelect) then
    FOnAfterMakeSelect(AFields, ASelect);
end;

procedure TjTableGEntityOpf.DoMakeWhere(var ASelect, AWhere: string);
var
  VHandled: Boolean = False;
begin
  if Assigned(FOnBeforeMakeWhere) then
    FOnBeforeMakeWhere(ASelect, AWhere, VHandled);
  if not VHandled then
    ASelect += ' where ' + AWhere;
  if Assigned(FOnAfterMakeWhere) then
    FOnAfterMakeWhere(ASelect, AWhere);
end;

procedure TjTableGEntityOpf.DoMakeOrderBy(var ASelect, AjtSorting: string);
var
  VHandled: Boolean = False;
begin
  if Assigned(FOnBeforeMakeOrderBy) then
    FOnBeforeMakeOrderBy(ASelect, AjtSorting, VHandled);
  if not VHandled then
    ASelect += ' order by ' + AjtSorting;
  if Assigned(FOnAfterMakeOrderBy) then
    FOnAfterMakeOrderBy(ASelect, AjtSorting);
end;

procedure TjTableGEntityOpf.DoMakeLimit(var ASelect: string);
var
  VHandled: Boolean = False;
begin
  if Assigned(FOnBeforeMakeLimit) then
    FOnBeforeMakeLimit(ASelect, VHandled);
  if not VHandled then
    ASelect += ' limit :jtPageSize offset :jtStartIndex';
  if Assigned(FOnAfterMakeLimit) then
    FOnAfterMakeLimit(ASelect);
end;

function TjTableGEntityOpf.DoCountRecords(var AWhere: string;
  AParams: TObject): Integer;
var
  VHandled: Boolean = False;
begin
  if Assigned(FOnBeforeCountRecords) then
  begin
    Result := -1;
    FOnBeforeCountRecords(AWhere, Result, VHandled);
  end;
  if not VHandled then
    Result := pgCount(Table.Name, AWhere, AParams);
  if Assigned(FOnAfterCountRecords) then
    FOnAfterCountRecords(AWhere);
end;

procedure TjTableGEntityOpf.ListData(AEntity: T; AEntities: TEntities;
  AParamsStr: TStrings; AParams: TObject; var AWhere: string);
var
  VjtSorting: string;
  VSelect: string = '';
  VFields: string = '';
  VjtSortingIdx, VjtStartIndexIdx, VjtPageSizeIdx: Integer;
begin
  VjtSortingIdx := AParamsStr.IndexOfName('jtSorting');
  VjtPageSizeIdx := AParamsStr.IndexOfName('jtPageSize');
  VjtStartIndexIdx := AParamsStr.IndexOfName('jtStartIndex');
  DoMakeFields(VFields);
  DoMakeSelect(VFields, VSelect);
  if AWhere <> '' then
    DoMakeWhere(VSelect, AWhere);
  if VjtSortingIdx > -1 then
  begin
    VjtSorting := AParamsStr.ValueFromIndex[VjtSortingIdx];
    DoMakeOrderBy(VSelect, VjtSorting);
  end;
  if (VjtPageSizeIdx > -1) and (VjtStartIndexIdx > -1) then
  begin
    DoMakeLimit(VSelect);
    Search(AEntity, AEntities, AParams, VSelect, False)
  end
  else
    Search(AEntity, AEntities, nil, '', False);
end;

{ TjTableGAction }

constructor TjTableGAction.Create;
begin
  inherited Create;
  FData := TJSONObject.Create;
  FOpf := T1.Create;
end;

destructor TjTableGAction.Destroy;
begin
  FData.Free;
  FOpf.Free;
  inherited Destroy;
end;

procedure TjTableGAction.Request(ARequest: TBrookRequest;
  AResponse: TBrookResponse);
var
  I: Integer;
  N, V: string;
begin
  for I := 0 to Pred(Values.Count) do
  begin
    Values.GetNameValue(I, N, V);
    Fields.Values[N] := V;
  end;
  inherited Request(ARequest, AResponse);
end;

procedure TjTableGAction.Post;
begin
  Data.Add('Result', 'OK');
  WriteData;
end;

procedure TjTableGAction.WriteData;
begin
  Write(FData.AsJSON);
end;

{ TjTableGListAction }

{$NOTES OFF}
procedure TjTableGListAction.Post;
var
  I: Integer;
  N, V: string;
  VWhere: string = '';
  VEntity: TObject;
  VEntities: TObject;
  VArray: TJSONArray;
  VObject: TJSONObject;
begin
  VEntities := T1.TEntities.Create;
  try
    BrookStringsToObject(Entity, Values);
    GetParams(Self);
    for I := 0 to Pred(Values.Count) do
    begin
      Values.GetNameValue(I, N, V);
      if Opf.Table.IgnoredFields.IndexOf(N) > -1 then
        Continue;
      Params.Add(N + '=' + V);
      VWhere += N + ' = :' + N + ' and';
    end;
    SetLength(VWhere, Length(VWhere) - 4);
    StrLower(PChar(VWhere));
    Opf.ListData(Entity, T1.TEntities(VEntities), Params, Self, VWhere);
    VArray := TJSONArray.Create;
    for I := 0 to Pred(T1.TEntities(VEntities).Count) do
    begin
      VObject := TJSONObject.Create;
      VEntity := T1.TEntities(VEntities).Items[I];
      ObjectToJSON(Opf.Table.PropList, Opf.Table.PropCount, VEntity, VObject,
        Opf.UnlistedFields);
      VArray.Add(VObject);
    end;
    Data.Add('TotalRecordCount', Opf.DoCountRecords(VWhere, Entity));
    Data.Add('Records', VArray);
    inherited Post;
  finally
    VEntities.Free;
  end;
end;
{$NOTES ON}

{ TjTableGCreateAction }

procedure TjTableGCreateAction.Post;
var
  VObject: TJSONObject;
begin
  VObject := TJSONObject.Create;
  if Entity.Id < 1 then
    Entity.Id := pgNextSeq(Opf.Table.Name + '_id_seq');
  Opf.Add(Entity, False);
  Opf.Apply;
  ObjectToJSON(Opf.Table.PropList, Opf.Table.PropCount, Entity, VObject,
    Opf.UnlistedFields);
  Data.Add('Record', VObject);
  inherited Post;
end;

{ TjTableGUpdateAction }

procedure TjTableGUpdateAction.Post;
var
  VObject: TJSONObject;
begin
  VObject := TJSONObject.Create;
  Opf.Modify(Entity, False);
  Opf.Apply;
  ObjectToJSON(Opf.Table.PropList, Opf.Table.PropCount, Entity, VObject,
    Opf.UnlistedFields);
  Data.Add('Record', VObject);
  inherited Post;
end;

{ TjTableGDeleteAction }

procedure TjTableGDeleteAction.Post;
begin
  Opf.Remove(Entity);
  Opf.Apply;
  inherited Post;
end;

{ TjTableGLookupAction }

class function TjTableGLookupAction.DisplayText: string;
begin
  Result := 'TjTableGLookupAction.DisplayText not implemented.';
end;

class function TjTableGLookupAction.Value: string;
begin
  Result := 'TjTableGLookupAction.Value not implemented.';
end;

procedure TjTableGLookupAction.Post;
var
  VArray: TJSONArray;
  VObject: TJSONObject;
  VQuery: TdSQLdbQuery;
begin
  VQuery := TdSQLdbQuery.Create(dbutils.con);
  try
    VQuery.SQL.Text := 'select ' + DisplayText + ' as "DisplayText", ' + Value +
      ' as "Value" from ' + Opf.Table.Name;
    VQuery.Open;
    VArray := TJSONArray.Create;
    while not VQuery.EOF do
    begin
      VObject := TJSONObject.Create;
      VObject.Add('DisplayText', VQuery.Fields[0].AsString);
      VObject.Add('Value', VQuery.Fields[1].AsString);
      VArray.Add(VObject);
      VQuery.Next;
    end;
    Data.Add('Options', VArray);
    inherited Post;
  finally
    VQuery.Free;
  end;
end;

end.

