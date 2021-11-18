{ *************************************************************************** }
{                                                                             }
{ Delphi and Kylix Cross-Platform Visual Component Library                    }
{                                                                             }
{ Copyright (c) 2000, 2001 Borland Software Corporation                       }
{                                                                             }
{ Licensees holding a valid Borland No-Nonsense License for this Software may }
{ use this file in accordance with such license, which appears in the file    }
{ license.txt that came with this Software.                                   }
{                                                                             }
{ *************************************************************************** }


unit QDBGrids;

{$R-}

interface

uses Variants, SysUtils, Classes, Types, Qt, QControls, QForms, QStdCtrls, QGraphics,
  QImgList, QGrids, QDBCtrls, QExtCtrls, QMenus, DB;

type
  TColumnValue = (cvColor, cvWidth, cvFont, cvAlignment, cvReadOnly, cvTitleColor,
    cvTitleCaption, cvTitleAlignment, cvTitleFont, cvImeMode, cvImeName);
  TColumnValues = set of TColumnValue;

const
  ColumnTitleValues = [cvTitleColor..cvTitleFont];

{ TColumn defines internal storage for column attributes.  If IsStored is
  True, values assigned to properties are stored in this object, the grid-
  or field-based default sources are not modified.  Values read from
  properties are the previously assigned value, if any, or the grid- or
  field-based default values if nothing has been assigned to that property.
  This class also publishes the column attribute properties for persistent
  storage.

  If IsStored is True, the column does not maintain local storage of
  property values.  Assignments to column properties are passed through to
  the underlying grid- or field-based default sources.  }
type
  TColumn = class;
  TCustomDBGrid = class;

  TColumnTitle = class(TPersistent)
  private
    FColumn: TColumn;
    FCaption: string;
    FFont: TFont;
    FColor: TColor;
    FAlignment: TAlignment;
    procedure FontChanged(Sender: TObject);
    function GetAlignment: TAlignment;
    function GetColor: TColor;
    function GetCaption: string;
    function GetFont: TFont;
    function IsAlignmentStored: Boolean;
    function IsColorStored: Boolean;
    function IsFontStored: Boolean;
    function IsCaptionStored: Boolean;
    procedure SetAlignment(Value: TAlignment);
    procedure SetColor(Value: TColor);
    procedure SetFont(Value: TFont);
    procedure SetCaption(const Value: string); virtual;
  protected
    procedure RefreshDefaultFont;
  public
    constructor Create(Column: TColumn);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function DefaultAlignment: TAlignment;
    function DefaultColor: TColor;
    function DefaultFont: TFont;
    function DefaultCaption: string;
    procedure RestoreDefaults; virtual;
    property Column: TColumn read FColumn;
  published
    property Alignment: TAlignment read GetAlignment write SetAlignment
      stored IsAlignmentStored;
    property Caption: string read GetCaption write SetCaption stored IsCaptionStored;
    property Color: TColor read GetColor write SetColor stored IsColorStored;
    property Font: TFont read GetFont write SetFont stored IsFontStored;
  end;

  TColumnButtonStyle = (cbsAuto, cbsEllipsis, cbsNone);

  TColumn = class(TCollectionItem)
  private
    FField: TField;
    FFieldName: string;
    FColor: TColor;
    FWidth: Integer;
    FTitle: TColumnTitle;
    FFont: TFont;
    FPickList: TStrings;
    FPopupMenu: TPopupMenu;
    FDropDownRows: Cardinal;
    FButtonStyle: TColumnButtonStyle;
    FAlignment: TAlignment;
    FReadonly: Boolean;
    FAssignedValues: TColumnValues;
    FVisible: Boolean;
    FExpanded: Boolean;
    FStored: Boolean;
    procedure FontChanged(Sender: TObject);
    function  GetAlignment: TAlignment;
    function  GetColor: TColor;
    function  GetExpanded: Boolean;
    function  GetField: TField;
    function  GetFont: TFont;
    function  GetParentColumn: TColumn;
    function  GetPickList: TStrings;
    function  GetReadOnly: Boolean;
    function  GetShowing: Boolean;
    function  GetWidth: Integer;
    function  GetVisible: Boolean;
    function  IsAlignmentStored: Boolean;
    function  IsColorStored: Boolean;
    function  IsFontStored: Boolean;
    function  IsReadOnlyStored: Boolean;
    function  IsWidthStored: Boolean;
    procedure SetAlignment(Value: TAlignment); virtual;
    procedure SetButtonStyle(Value: TColumnButtonStyle);
    procedure SetColor(Value: TColor);
    procedure SetExpanded(Value: Boolean);
    procedure SetField(Value: TField); virtual;
    procedure SetFieldName(const Value: String);
    procedure SetFont(Value: TFont);
    procedure SetPickList(Value: TStrings);
    procedure SetPopupMenu(Value: TPopupMenu);
    procedure SetReadOnly(Value: Boolean); virtual;
    procedure SetTitle(Value: TColumnTitle);
    procedure SetWidth(Value: Integer); virtual;
    procedure SetVisible(Value: Boolean);
    function GetExpandable: Boolean;
  protected
    function  CreateTitle: TColumnTitle; virtual;
    function  GetGrid: TCustomDBGrid;
    function GetDisplayName: string; override;
    procedure RefreshDefaultFont;
    procedure SetIndex(Value: Integer); override;
    property IsStored: Boolean read FStored write FStored default True;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function  DefaultAlignment: TAlignment;
    function  DefaultColor: TColor;
    function  DefaultFont: TFont;
    function  DefaultReadOnly: Boolean;
    function  DefaultWidth: Integer;
    function  Depth: Integer;
    procedure RestoreDefaults; virtual;
    property  Grid: TCustomDBGrid read GetGrid;
    property  AssignedValues: TColumnValues read FAssignedValues;
    property  Expandable: Boolean read GetExpandable;
    property  Field: TField read GetField write SetField;
    property  ParentColumn: TColumn read GetParentColumn;
    property  Showing: Boolean read GetShowing;
  published
    property  Alignment: TAlignment read GetAlignment write SetAlignment
      stored IsAlignmentStored;
    property  ButtonStyle: TColumnButtonStyle read FButtonStyle write SetButtonStyle
      default cbsAuto;
    property  Color: TColor read GetColor write SetColor stored IsColorStored;
    property  DropDownRows: Cardinal read FDropDownRows write FDropDownRows default 7;
    property  Expanded: Boolean read GetExpanded write SetExpanded default True;
    property  FieldName: String read FFieldName write SetFieldName;
    property  Font: TFont read GetFont write SetFont stored IsFontStored;
    property  PickList: TStrings read GetPickList write SetPickList;
    property  PopupMenu: TPopupMenu read FPopupMenu write SetPopupMenu;
    property  ReadOnly: Boolean read GetReadOnly write SetReadOnly
      stored IsReadOnlyStored;
    property  Title: TColumnTitle read FTitle write SetTitle;
    property  Width: Integer read GetWidth write SetWidth stored IsWidthStored;
    property  Visible: Boolean read GetVisible write SetVisible;
  end;

  TColumnClass = class of TColumn;

  TDBGridColumnsState = (csDefault, csCustomized);

  TDBGridColumns = class(TCollection)
  private
    FGrid: TCustomDBGrid;
    function GetColumn(Index: Integer): TColumn;
    function InternalAdd: TColumn;
    procedure SetColumn(Index: Integer; Value: TColumn);
    procedure SetState(NewState: TDBGridColumnsState);
    function GetState: TDBGridColumnsState;
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(Grid: TCustomDBGrid; ColumnClass: TColumnClass);
    function  Add: TColumn;
    procedure LoadFromFile(const Filename: string);
    procedure LoadFromStream(S: TStream);
    procedure RestoreDefaults;
    procedure RebuildColumns;
    procedure SaveToFile(const Filename: string);
    procedure SaveToStream(S: TStream);
    property State: TDBGridColumnsState read GetState write SetState;
    property Grid: TCustomDBGrid read FGrid;
    property Items[Index: Integer]: TColumn read GetColumn write SetColumn; default;
  end;

  TGridDataLink = class(TDataLink)
  private
    FGrid: TCustomDBGrid;
    FFieldCount: Integer;
    FFieldMap: array of Integer;
    FModified: Boolean;
    FInUpdateData: Boolean;
    FSparseMap: Boolean;
    function GetDefaultFields: Boolean;
    function GetFields(I: Integer): TField;
  protected
    procedure ActiveChanged; override;
    procedure BuildAggMap;
    procedure DataSetChanged; override;
    procedure DataSetScrolled(Distance: Integer); override;
    procedure FocusControl(Field: TFieldRef); override;
    procedure EditingChanged; override;
    function IsAggRow(Value: Integer): Boolean; virtual;
    procedure LayoutChanged; override;
    procedure RecordChanged(Field: TField); override;
    procedure UpdateData; override;
    function  GetMappedIndex(ColIndex: Integer): Integer;
  public
    constructor Create(AGrid: TCustomDBGrid);
    destructor Destroy; override;
    function AddMapping(const FieldName: string): Boolean;
    procedure ClearMapping;
    procedure Modified;
    procedure Reset;
    property DefaultFields: Boolean read GetDefaultFields;
    property FieldCount: Integer read FFieldCount;
    property Fields[I: Integer]: TField read GetFields;
    property SparseMap: Boolean read FSparseMap write FSparseMap;
  end;

  TBookmarkList = class
  private
    FList: TStringList;
    FGrid: TCustomDBGrid;
    FCache: TBookmarkStr;
    FCacheIndex: Integer;
    FCacheFind: Boolean;
    FLinkActive: Boolean;
    function GetCount: Integer;
    function GetCurrentRowSelected: Boolean;
    function GetItem(Index: Integer): TBookmarkStr;
    procedure SetCurrentRowSelected(Value: Boolean);
    procedure StringsChanged(Sender: TObject);
  protected
    function CurrentRow: TBookmarkStr;
    function Compare(const Item1, Item2: TBookmarkStr): Integer;
    procedure LinkActive(Value: Boolean);
  public
    constructor Create(AGrid: TCustomDBGrid);
    destructor Destroy; override;
    procedure Clear;           // free all bookmarks
    procedure Delete;          // delete all selected rows from dataset
    function  Find(const Item: TBookmarkStr; var Index: Integer): Boolean;
    function  IndexOf(const Item: TBookmarkStr): Integer;
    function  Refresh: Boolean;// drop orphaned bookmarks; True = orphans found
    property Count: Integer read GetCount;
    property CurrentRowSelected: Boolean read GetCurrentRowSelected
      write SetCurrentRowSelected;
    property Items[Index: Integer]: TBookmarkStr read GetItem; default;
  end;

  TSubGridForm = class(TWidgetControl)
  private
    FSubGrid: TCustomDBGrid;
  protected
    function WidgetFlags: Integer; override;
    procedure InitWidget; override;
  public
    constructor CreateParented(ParentWidget: QWidgetH; AGrid: TCustomDBGrid);
    property SubGrid: TCustomDBGrid read FSubGrid;
  end;

  TDBGridOption = (dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator,
    dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect,
    dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect);
  TDBGridOptions = set of TDBGridOption;

  { The DBGrid's DrawDataCell virtual method and OnDrawDataCell event are only
    called when the grid's Columns.State is csDefault.  This is for compatibility
    with existing code. These routines don't provide sufficient information to
    determine which column is being drawn, so the column attributes aren't
    easily accessible in these routines.  Column attributes also introduce the
    possibility that a column's field may be nil, which would break existing
    DrawDataCell code.   DrawDataCell, OnDrawDataCell, and DefaultDrawDataCell
    are obsolete, retained for compatibility purposes. }
  TDrawDataCellEvent = procedure (Sender: TObject; const Rect: TRect; Field: TField;
    State: TGridDrawState) of object;

  { The DBGrid's DrawColumnCell virtual method and OnDrawColumnCell event are
    always called, when the grid has defined column attributes as well as when
    it is in default mode.  These new routines provide the additional
    information needed to access the column attributes for the cell being
    drawn, and must support nil fields.  }

  TDrawColumnCellEvent = procedure (Sender: TObject; const Rect: TRect;
    DataCol: Integer; Column: TColumn; State: TGridDrawState) of object;
  TDBGridClickEvent = procedure (Column: TColumn) of object;

  TCustomDBGrid = class(TCustomGrid)
  private
    FIndicators: TImageList;
    FTitleFont: TFont;
    FReadOnly: Boolean;
    FUserChange: Boolean;
    FIsESCKey: Boolean;
    FLayoutFromDataset: Boolean;
    FOptions: TDBGridOptions;
    FTitleOffset, FIndicatorOffset: Byte;
    FUpdateLock: Byte;
    FLayoutLock: Byte;
    FInColExit: Boolean;
    FDefaultDrawing: Boolean;
    FSelfChangingTitleFont: Boolean;
    FSelecting: Boolean;
    FSelRow: Integer;
    FDataLink: TGridDataLink;
    FOnColEnter: TNotifyEvent;
    FOnColExit: TNotifyEvent;
    FOnDrawDataCell: TDrawDataCellEvent;
    FOnDrawColumnCell: TDrawColumnCellEvent;
    FColumns: TDBGridColumns;
    FVisibleColumns: TList;
    FBookmarks: TBookmarkList;
    FSelectionAnchor: TBookmarkStr;
    FOnEditButtonClick: TNotifyEvent;
    FOnColumnMoved: TMovedEvent;
    FOnCellClick: TDBGridClickEvent;
    FOnTitleClick:TDBGridClickEvent;
    FDragCol: TColumn;

    // What's New
    FTextLocked: Boolean;
    FDatasetLocked: Boolean;
    function IsRightToLeft: Boolean;
    function UseRightToLeftAlignment: Boolean;
    function GetInPlaceEditText: string;

    function AcquireFocus: Boolean;
    procedure DataChanged;
    procedure EditingChanged;
    function GetDataSource: TDataSource;
    function GetFieldCount: Integer;
    function GetFields(FieldIndex: Integer): TField;
    function GetSelectedField: TField;
    function GetSelectedIndex: Integer;
    procedure InternalLayout;
    procedure MoveCol(RawCol, Direction: Integer);
    function PtInExpandButton(X,Y: Integer; var MasterCol: TColumn): Boolean;
    procedure ReadColumns(Reader: TReader);
    procedure RecordChanged(Field: TField);
    procedure SetColumns(Value: TDBGridColumns);
    procedure SetDataSource(Value: TDataSource);
    procedure SetOptions(Value: TDBGridOptions);
    procedure SetSelectedField(Value: TField);
    procedure SetSelectedIndex(Value: Integer);
    procedure SetTitleFont(Value: TFont);
    procedure TitleFontChanged(Sender: TObject);
    procedure UpdateData;
    procedure UpdateActive;
    procedure UpdateScrollBar;
    procedure UpdateRowCount;
    procedure WriteColumns(Writer: TWriter);
  protected
    FUpdateFields: Boolean;
    FAcquireFocus: Boolean;

    // What's New
    procedure BoundsChanged; override;
    function CalcScrollBarVisible(ScrollBar: TScrollStyle; const AxisInfo: TGridAxisDrawInfo;
      Max: Integer): boolean; override;
    procedure DoExit; override;
    function  EventFilter(Sender: QObjectH; Event: QEventH): Boolean; override;
    procedure FontChanged; override;
    function IsActiveControl: Boolean; override;
    procedure ModifyScrollBar(ScrollBar: TScrollBarKind; ScrollCode: TScrollCode; Pos: Cardinal;
      UseRightToLeft: Boolean); override;
    procedure ParentFontChanged; override;

    function  RawToDataColumn(ACol: Integer): Integer;
    function  DataToRawColumn(ACol: Integer): Integer;
    function  AcquireLayoutLock: Boolean;
    procedure BeginLayout;
    procedure BeginUpdate;
    procedure CalcSizingState(X, Y: Integer; var State: TGridState;
      var Index: Longint; var SizingPos, SizingOfs: Integer;
      var FixedInfo: TGridDrawInfo); override;
    procedure CancelLayout;
    function  CanEditAcceptKey(Key: Char): Boolean; override;
    function  CanEditModify: Boolean; override;
    function  CanEditShow: Boolean; override;
    procedure CellClick(Column: TColumn); dynamic;
    procedure ColumnMoved(FromIndex, ToIndex: Longint); override;
    function CalcTitleRect(Col: TColumn; ARow: Integer;
      var MasterCol: TColumn): TRect;
    function ColumnAtDepth(Col: TColumn; ADepth: Integer): TColumn;
    procedure ColEnter; dynamic;
    procedure ColExit; dynamic;
    procedure ColWidthsChanged; override;
    function  CreateColumns: TDBGridColumns; dynamic;
    function  CreateEditor: TInplaceEdit; override;
    procedure DeferLayout;
    procedure DefineFieldMap; virtual;
    procedure DefineProperties(Filer: TFiler); override;
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState); override;
    procedure DrawDataCell(const Rect: TRect; Field: TField;
      State: TGridDrawState); dynamic; { obsolete }
    procedure DrawColumnCell(const Rect: TRect; DataCol: Integer;
      Column: TColumn; State: TGridDrawState); dynamic;
    procedure EditButtonClick; dynamic;
    procedure EndLayout;
    procedure EndUpdate;
    function  GetColField(DataCol: Integer): TField;
    function  GetEditLimit: Integer; override;
    function  GetEditMask(ACol, ARow: Longint): WideString; override;
    function  GetEditText(ACol, ARow: Longint): WideString; override;
    function  GetFieldValue(ACol: Integer): string;
    function  HighlightCell(DataCol, DataRow: Integer; const Value: string;
      AState: TGridDrawState): Boolean; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure GridKeyPress(var Key: Char); override;
    procedure InvalidateTitles;
    procedure LayoutChanged; virtual;
    procedure LinkActive(Value: Boolean); virtual;
    procedure Loaded; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Scroll(Distance: Integer); virtual;
    procedure SetColumnAttributes; virtual;
    procedure SetEditText(ACol, ARow: Longint; const Value: WideString); override;
    function  StoreColumns: Boolean;
    procedure TimedScroll(Direction: TGridScrollDirection); override;
    procedure TitleClick(Column: TColumn); dynamic;
    procedure TopLeftChanged; override;
    function UseRightToLeftAlignmentForField(const AField: TField;
      Alignment: TAlignment): Boolean;
    function BeginColumnDrag(var Origin, Destination: Integer;
      const MousePt: TPoint): Boolean; override;
    function CheckColumnDrag(var Origin, Destination: Integer;
      const MousePt: TPoint): Boolean; override;
    function EndColumnDrag(var Origin, Destination: Integer;
      const MousePt: TPoint): Boolean; override;
    property Columns: TDBGridColumns read FColumns write SetColumns;
    property DefaultDrawing: Boolean read FDefaultDrawing write FDefaultDrawing default True;
    property DataLink: TGridDataLink read FDataLink;
    property IndicatorOffset: Byte read FIndicatorOffset;
    property LayoutLock: Byte read FLayoutLock;
    property Options: TDBGridOptions read FOptions write SetOptions
      default [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines,
      dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit];
    property ParentColor default False;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default False;
    property SelectedRows: TBookmarkList read FBookmarks;
    property TitleFont: TFont read FTitleFont write SetTitleFont;
    property UpdateLock: Byte read FUpdateLock;
    property OnColEnter: TNotifyEvent read FOnColEnter write FOnColEnter;
    property OnColExit: TNotifyEvent read FOnColExit write FOnColExit;
    property OnDrawDataCell: TDrawDataCellEvent read FOnDrawDataCell
      write FOnDrawDataCell; { obsolete }
    property OnDrawColumnCell: TDrawColumnCellEvent read FOnDrawColumnCell
      write FOnDrawColumnCell;
    property OnEditButtonClick: TNotifyEvent read FOnEditButtonClick
      write FOnEditButtonClick;
    property OnColumnMoved: TMovedEvent read FOnColumnMoved write FOnColumnMoved;
    property OnCellClick: TDBGridClickEvent read FOnCellClick write FOnCellClick;
    property OnTitleClick: TDBGridClickEvent read FOnTitleClick write FOnTitleClick;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DefaultDrawDataCell(const Rect: TRect; Field: TField;
      State: TGridDrawState); { obsolete }
    procedure DefaultDrawColumnCell(const Rect: TRect; DataCol: Integer;
      Column: TColumn; State: TGridDrawState);
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    procedure ShowPopupEditor(Column: TColumn; X: Integer = Low(Integer);
      Y: Integer = Low(Integer)); dynamic;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function ValidFieldIndex(FieldIndex: Integer): Boolean;
    property EditorMode;
    property FieldCount: Integer read GetFieldCount;
    property Fields[FieldIndex: Integer]: TField read GetFields;
    property SelectedField: TField read GetSelectedField write SetSelectedField;
    property SelectedIndex: Integer read GetSelectedIndex write SetSelectedIndex;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  end;

  TDBGrid = class(TCustomDBGrid)
  public
    property Canvas;
    property SelectedRows;
  published
    property Align;
    property Anchors;
    property BorderStyle;
    property Color;
    property Columns stored False; //StoreColumns;
    property Constraints;
    property DataSource;
    property DefaultDrawing;
    property DragMode;
    property Enabled;
    property FixedColor;
    property Font;
    property Options;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property TitleFont;
    property Visible;
    property OnCellClick;
    property OnColEnter;
    property OnColExit;
    property OnColumnMoved;
    property OnDrawDataCell;  { obsolete }
    property OnDrawColumnCell;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEditButtonClick;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyString;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property OnTitleClick;
  end;

const
  IndicatorWidth = 11;

implementation

uses Math, DBConsts, QDBConsts, QDialogs;

{$R QDBGrids.res}

const
//  STooManyColumns = 'Grid requested to display more than 256 columns';
//  SDataSetClosed = 'Cannot perform this operation on a closed dataset';
//  SDeleteMultipleRecordsQuestion = 'Delete all selected records?';
//  SDeleteRecordQuestion = 'Delete record?';

  bmArrow = 'DBGARROW';
  bmEdit = 'DBEDIT';
  bmInsert = 'DBINSERT';
  bmMultiDot = 'DBMULTIDOT';
  bmMultiArrow = 'DBMULTIARROW';

  MaxMapSize = (MaxInt div 2) div SizeOf(Integer);  { 250 million }

  CXHSCROLL = 12;
  CYHSCROLL = 12;
  CXVSCROLL = 18;

{ Error reporting }

procedure RaiseGridError(const S: string);
begin
  raise EInvalidGridOperation.Create(S);
end;

{ TDBGridInplaceEdit }

{ TDBGridInplaceEdit adds support for a button on the in-place editor,
  which can be used to drop down a table-based lookup list, a stringlist-based
  pick list, or (if button style is esEllipsis) fire the grid event
  OnEditButtonClick.  }

type
  TEditStyle = (esSimple, esEllipsis, esPickList, esDataList);
  TPopupListbox = class;

  TDBGridInplaceEdit = class(TInplaceEdit)
  private
    FButtonWidth: Integer;
    FDataList: TDBLookupListBox;
    FPickList: TPopupListbox;
    FActiveList: TWidgetControl;
    FLookupSource: TDatasource;
    FEditStyle: TEditStyle;
    FListVisible: Boolean;
    FTracking: Boolean;
    FPressed: Boolean;
    FCanvas: TCanvas;

    procedure CMKeyDown(var Msg: TCMKeyDown); message CM_KEYDOWN;
    procedure ListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ListKeypress(Sender: TObject; var Key: Char);
    procedure ListMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure ListMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SetEditStyle(Value: TEditStyle);
    procedure StopTracking;
    procedure TrackButton(X,Y: Integer);
    function OverButton(const P: TPoint): Boolean;
    function ButtonRect: TRect;
  protected
    procedure BoundsChanged; override;
    procedure Change; override;
    procedure CloseUp(Accept: Boolean);
    procedure DoDropDownKeys(var Key: Word; Shift: TShiftState);
    procedure DropDown;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure Painting(Sender: QObjectH; EventRegion: QRegionH); override;
    procedure Paint;
    procedure UpdateContents; override;
    property  EditStyle: TEditStyle read FEditStyle write SetEditStyle;
    property  ActiveList: TWinControl read FActiveList write FActiveList;
    property  DataList: TDBLookupListBox read FDataList;
    property  PickList: TPopupListbox read FPickList;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
  end;

{ TPopupListbox }

  TPopupListbox = class(TCustomControl)
  private
    FCustomListBox: TListBox;
    procedure CMKeyDown(var Msg: TCMKeyDown); message CM_KEYDOWN;

  protected
    procedure InitWidget; override;
    function WidgetFlags: Integer; override;

  public
    constructor CreateParented(ParentWidget: QWidgetH);
    destructor Destroy; override;
    procedure Adjust;
    property ListBox: TListBox read FCustomListBox;
  end;

constructor TPopupListbox.CreateParented(ParentWidget: QWidgetH);
begin
  inherited CreateParented(ParentWidget);
  ControlStyle := [csOpaque, csFramed, csDoubleClicks];
  FCustomListBox := TListBox.Create(Self);
  FCustomListBox.Parent := Self;
  Adjust;
end;

destructor TPopupListbox.Destroy;
begin
  FCustomListBox.Free;
  inherited Destroy;
end;

procedure TPopupListbox.CMKeyDown(var Msg: TCMKeyDown);
begin
  with Msg do
  if not (Key = Key_Down) or not (ssAlt in Shift) then
    inherited;
end;

procedure TPopupListbox.InitWidget;
begin
  inherited InitWidget;
  Visible := False;
end;

function TPopupListbox.WidgetFlags: Integer;
begin
  Result := inherited WidgetFlags
              or Integer(WidgetFlags_WType_Popup)
              or Integer(WidgetFlags_WStyle_Tool)
              or Integer(WidgetFlags_WNorthWestGravity);
end;

procedure TPopupListbox.Adjust;
begin
  Width := FCustomListBox.Width + 1;
  Height := FCustomListBox.Height + 1;
  FCustomListBox.Align := alClient;
end;

{ TDBGridInplaceEdit }

constructor TDBGridInplaceEdit.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  FLookupSource := TDataSource.Create(Self);
  FButtonWidth := 13;
  FEditStyle := esSimple;
  FCanvas := TControlCanvas.Create;
  TControlCanvas(FCanvas).Control := Self;
end;

destructor TDBGridInplaceEdit.Destroy;
begin
  FCanvas.Free;
  inherited Destroy;
end;

procedure TDBGridInplaceEdit.BoundsChanged;
var
  R: TRect;
begin
  R := Rect(2, 2, Width - 2, Height);
  if FEditStyle <> esSimple then
    if not TCustomDBGrid(Owner).UseRightToLeftAlignment then
      Dec(R.Right, FButtonWidth)
    else
      Inc(R.Left, FButtonWidth - 2);
end;

procedure TDBGridInplaceEdit.Change;
begin
  if not TCustomDBGrid(Owner).FTextLocked then
  begin
    TCustomDBGrid(Owner).FDatasetLocked := True;
    try
      TCustomDBGrid(Owner).FDataLink.Edit;
      TCustomDBGrid(Owner).FDataLink.Modified;
    finally
      TCustomDBGrid(Owner).FDatasetLocked := False;
    end;
    inherited Change;
  end;
end;

procedure TDBGridInplaceEdit.CloseUp(Accept: Boolean);
var
  MasterField: TField;
  ListValue: Variant;
begin
  if FListVisible then
  begin
    if FActiveList = FDataList then
      ListValue := FDataList.KeyValue
    else
      if FPickList.ListBox.ItemIndex <> -1 then
        ListValue := FPickList.ListBox.Items[FPicklist.ListBox.ItemIndex];
    FActiveList.Visible := False;
    FListVisible := False;
    if Assigned(FDataList) then
      FDataList.ListSource := nil;
    FLookupSource.Dataset := nil;
    Invalidate;
    if Accept then
      if FActiveList = FDataList then
        with TCustomDBGrid(Grid), Columns[SelectedIndex].Field do
        begin
          MasterField := DataSet.FieldByName(KeyFields);
          if MasterField.CanModify and FDataLink.Edit then
            MasterField.Value := ListValue;
        end
      else
        if (not VarIsNull(ListValue)) and EditCanModify then
          with TCustomDBGrid(Grid), Columns[SelectedIndex].Field do
            Text := ListValue;
  end;
end;

procedure TDBGridInplaceEdit.DoDropDownKeys(var Key: Word; Shift: TShiftState);
begin
  case Key of
    Key_Up, Key_Down:
      if ssAlt in Shift then
      begin
        if FListVisible then CloseUp(True) else DropDown;
        Key := 0;
      end;
    Key_Return, Key_Escape:
      if FListVisible and not (ssAlt in Shift) then
      begin
        CloseUp(Key = Key_Return);
        Key := 0;
      end;
  end;
end;

procedure TDBGridInplaceEdit.DropDown;
var
  P: TPoint;
  W, Wi: Integer;
  Column: TColumn;

  procedure SetupListBox;
  var
    I: Integer;
  begin
    with Column.Field do
    begin
      FPickList.ListBox.Align := alNone;
      FPickList.ListBox.Font := Font;
      FPickList.ListBox.Color := Color;
      FPickList.ListBox.Items.Assign(Column.Picklist);
      FPickList.ListBox.Rows := Min(Column.DropDownRows, Column.PickList.Count);
      FPickList.ListBox.Columns := 1;
      if Column.Field.IsNull then
        FPickList.ListBox.ItemIndex := -1
      else
        FPickList.ListBox.ItemIndex := FPickList.ListBox.Items.IndexOf(Column.Field.Text);
      W := FPickList.ListBox.ClientWidth;
      for I := 0 to FPickList.ListBox.Items.Count - 1 do
      begin
        Wi := FPickList.ListBox.Canvas.TextWidth(FPickList.ListBox.Items[I]);
        if Wi > W then W := Wi;
      end;
      FPickList.ListBox.ClientWidth := W;
      FPickList.Adjust;
    end;
  end;

  procedure SetupLookupListBox;
  begin
    with Column.Field do
    begin
      FDataList.Font := Font;
      FDataList.Color := Color;
      FDataList.RowCount := Column.DropDownRows;
      FLookupSource.DataSet := LookupDataSet;
      FDataList.KeyField := LookupKeyFields;
      FDataList.ListField := LookupResultField;
      FDataList.ListSource := FLookupSource;
      FDataList.KeyValue := DataSet.FieldByName(KeyFields).Value;
    end;
  end;

begin
  if Assigned(FActiveList) and not FListVisible then
  begin
    Column := TCustomDBGrid(Grid).Columns[TCustomDBGrid(Grid).SelectedIndex];
    FActiveList.Width := Column.Width;
    if FActiveList = FPickList then
      SetupListBox else
      SetupLookupListBox;
    P := Parent.ClientToScreen(Point(Left, Top));
    if P.Y + FActiveList.Height > Screen.Height then
      P.Y := P.Y - FActiveList.Height
    else
      P.Y := P.Y + Height + 1;
    FActiveList.Left := P.X;
    FActiveList.Top := P.Y;
    FActiveList.Visible := True;
    FListVisible := True;
    if FActiveList = FPickList then
      FPickList.ListBox.SetFocus
    else
      FActiveList.SetFocus;
  end;
end;

procedure TDBGridInplaceEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (EditStyle = esEllipsis) and (Key = Key_Return) and (Shift = [ssCtrl]) then
    TCustomDBGrid(Grid).EditButtonClick
  else
  begin
    DoDropDownKeys(Key, Shift);
    if Key <> 0 then
      inherited KeyDown(Key, Shift);
  end;
end;

procedure TDBGridInplaceEdit.KeyPress(var Key: Char);
begin
  if ReadOnly then
    Key := #0
  else
    inherited KeyPress(Key);
end;

procedure TDBGridInplaceEdit.CMKeyDown(var Msg: TCMKeyDown);
begin
  with Msg do
  if not (Key = Key_Down) or not (ssAlt in Shift) then
    inherited;
end;

procedure TDBGridInplaceEdit.ListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if FListVisible and (Key = Key_Down) and (ssAlt in Shift) then
    CloseUp(True);
end;

procedure TDBGridInplaceEdit.ListKeypress(Sender: TObject; var Key: Char);
begin
  if FListVisible and (Key in [#13, #27]) then
    CloseUp(Key = #13);
end;

procedure TDBGridInplaceEdit.ListMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  FTracking := FTracking and not PtInRect(FActiveList.ClientRect, Types.Point(X,Y));
  TrackButton(X,Y);
end;

procedure TDBGridInplaceEdit.ListMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    if not FTracking then
      CloseUp(PtInRect(FActiveList.ClientRect, Types.Point(X, Y)));
    StopTracking;
  end;
end;

procedure TDBGridInplaceEdit.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if (Button = mbLeft) and (FEditStyle <> esSimple) then
  begin
    if FListVisible then
      CloseUp(False)
    else
      if (FEditStyle <> esEllipsis) or OverButton(Point(X,Y)) then
      begin
        FTracking := True;
        TrackButton(X, Y);
        if Assigned(FActiveList) then
          DropDown;
      end;
  end;
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TDBGridInplaceEdit.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if FTracking then
    TrackButton(X,Y);
  inherited MouseMove(Shift, X, Y);
end;

procedure TDBGridInplaceEdit.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
 WasPressed: Boolean;
begin
  WasPressed := FPressed;
  StopTracking;
  if (Button = mbLeft) and (FEditStyle = esEllipsis) and WasPressed then
    TCustomDBGrid(Grid).EditButtonClick;
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TDBGridInplaceEdit.SetEditStyle(Value: TEditStyle);
begin
  if Value = FEditStyle then Exit;
  FEditStyle := Value;
  case Value of
    esPickList:
      begin
        if FPickList = nil then
        begin
          FPickList := TPopupListbox.CreateParented(QApplication_Desktop);
          FPickList.ListBox.OnKeyDown := ListKeyDown;
          FPickList.ListBox.OnKeyPress := ListKeyPress;
          FPickList.ListBox.OnMouseMove := ListMouseMove;
          FPickList.ListBox.OnMouseUp := ListMouseUp;
          FPickList.OnMouseUp := ListMouseUp;
          FPickList.ListBox.Align := alNone;
          FPickList.ListBox.ItemHeight := 11;
          FPickList.Adjust;
        end;
        FActiveList := FPickList;
      end;
    esDataList:
      begin
        if FDataList = nil then
        begin
          FDataList := TPopupDataList.CreateParented(QApplication_Desktop);
          FDataList.OnKeyDown := ListKeyDown;
          FDataList.OnKeyPress := ListKeyPress;
          FDataList.OnMouseMove := ListMouseMove;
          FDataList.OnMouseUp := ListMouseUp;
        end;
        FActiveList := FDataList;
      end;
  else  { cbsNone, cbsEllipsis, or read only field }
    FActiveList := nil;
  end;
  with TCustomDBGrid(Grid) do
    Self.ReadOnly := Columns[SelectedIndex].ReadOnly;
  Repaint;
end;

procedure TDBGridInplaceEdit.StopTracking;
begin
  if FTracking then
  begin
    TrackButton(-1, -1);
    FTracking := False;
    MouseCapture := False;
  end;
end;

procedure TDBGridInplaceEdit.TrackButton(X,Y: Integer);
var
  NewState: Boolean;
  R: TRect;
begin
  R := ButtonRect;
  NewState := PtInRect(R, Point(X, Y));
  if FPressed <> NewState then
  begin
    FPressed := NewState;
    Invalidate;
  end;
end;

procedure TDBGridInplaceEdit.Painting(Sender: QObjectH; EventRegion: QRegionH);
begin
  inherited;
  TControlCanvas(FCanvas).StartPaint;
  try
    QPainter_setClipRegion(FCanvas.Handle, EventRegion);
    Paint;
  finally
    TControlCanvas(FCanvas).StopPaint;
  end;
end;

procedure TDBGridInplaceEdit.Paint;
var
  R: TRect;
  I, Xd, Yd: Integer;
  Style: QStyleH;
  cg: QColorGroupH;
begin
  if FEditStyle <> esSimple then
  begin
    Style := QApplication_style;
    if FEditStyle in [esDataList, esPickList] then
    begin
      R := ClientRect;
      if Assigned(FActiveList) then
        cg := Palette.ColorGroup(cgActive)
      else
        cg := Palette.ColorGroup(cgDisabled);
      QPainter_setRasterOp(FCanvas.Handle, RasterOp_AndROP);
      QStyle_drawComboButton(Style, FCanvas.Handle, R.Left, R.Top, R.Right, R.Bottom,
        cg, FPressed, ReadOnly, Enabled, nil);
    end
    else   { esEllipsis }
    begin
      R := ButtonRect;
      cg := Palette.ColorGroup(cgActive);
      Qstyle_drawButton(Style, FCanvas.Handle, R.Left, R.Top, R.Right, R.Bottom,
        cg, FPressed, nil);
      for I := -1 to 1 do
      begin
        Xd := (R.Left + R.Right) div 2 + 3 * I + 1;
        Yd := (R.Top + R.Bottom) div 2;
        FCanvas.DrawPoint(Xd, Yd);
      end;
    end;
  end;
end;

procedure TDBGridInplaceEdit.UpdateContents;
var
  Column: TColumn;
  NewStyle: TEditStyle;
  MasterField: TField;
begin
  with TCustomDBGrid(Grid) do
    Column := Columns[SelectedIndex];
  NewStyle := esSimple;
  case Column.ButtonStyle of
   cbsEllipsis: NewStyle := esEllipsis;
   cbsAuto:
     if Assigned(Column.Field) then
     with Column.Field do
     begin
       { Show the dropdown button only if the field is editable }
       if FieldKind = fkLookup then
       begin
         MasterField := Dataset.FieldByName(KeyFields);
         { Column.DefaultReadonly will always be True for a lookup field.
           Test if Column.ReadOnly has been assigned a value of True }
         if Assigned(MasterField) and MasterField.CanModify and
           not ((cvReadOnly in Column.AssignedValues) and Column.ReadOnly) then
           with TCustomDBGrid(Grid) do
             if not ReadOnly and DataLink.Active and not Datalink.ReadOnly then
               NewStyle := esDataList
       end
       else
       if Assigned(Column.Picklist) and (Column.PickList.Count > 0) and
         not Column.Readonly then
         NewStyle := esPickList
       else if DataType in [ftDataset, ftReference] then
         NewStyle := esEllipsis;
     end;
  end;
  EditStyle := NewStyle;
  TCustomDBGrid(Owner).FTextLocked := True;
  try
    inherited UpdateContents;
  finally
    TCustomDBGrid(Owner).FTextLocked := False;
  end;
  ReadOnly := not Assigned(Column.Field) or Column.Field.IsBlob;
  Font.Assign(Column.Font);
end;

function TDBGridInplaceEdit.ButtonRect: TRect;
begin
  if not TCustomDBGrid(Owner).UseRightToLeftAlignment then
    Result := Rect(Width - FButtonWidth - 1, 0, Width - 1, Height)
  else
    Result := Rect(0, 0, FButtonWidth, Height);
end;

function TDBGridInplaceEdit.OverButton(const P: TPoint): Boolean;
begin
  Result := PtInRect(ButtonRect, P);
end;

{ TGridDataLink }

type
  TIntArray = array[0..MaxMapSize] of Integer;
  PIntArray = ^TIntArray;

constructor TGridDataLink.Create(AGrid: TCustomDBGrid);
begin
  inherited Create;
  FGrid := AGrid;
  VisualControl := True;
end;

destructor TGridDataLink.Destroy;
begin
  ClearMapping;
  inherited Destroy;
end;

function TGridDataLink.GetDefaultFields: Boolean;
var
  I: Integer;
begin
  Result := True;
  if DataSet <> nil then Result := DataSet.DefaultFields;
  if Result and SparseMap then
  for I := 0 to FFieldCount-1 do
    if FFieldMap[I] < 0 then
    begin
      Result := False;
      Exit;
    end;
end;

function TGridDataLink.GetFields(I: Integer): TField;
begin
  if (0 <= I) and (I < FFieldCount) and (FFieldMap[I] >= 0) then
    Result := DataSet.FieldList[FFieldMap[I]]
  else
    Result := nil;
end;

function TGridDataLink.AddMapping(const FieldName: string): Boolean;
var
  Field: TField;
  NewSize: Integer;
begin
  Result := True;
  if FFieldCount >= MaxMapSize then RaiseGridError(STooManyColumns);
  if SparseMap then
    Field := DataSet.FindField(FieldName)
  else
    Field := DataSet.FieldByName(FieldName);

  if FFieldCount = Length(FFieldMap) then
  begin
    NewSize := Length(FFieldMap);
    if NewSize = 0 then
      NewSize := 8
    else
      Inc(NewSize, NewSize);
    if (NewSize < FFieldCount) then
      NewSize := FFieldCount + 1;
    if (NewSize > MaxMapSize) then
      NewSize := MaxMapSize;
    SetLength(FFieldMap, NewSize);
  end;
  if Assigned(Field) then
  begin
    FFieldMap[FFieldCount] := Dataset.FieldList.IndexOfObject(Field);
    Field.FreeNotification(FGrid);
  end
  else
    FFieldMap[FFieldCount] := -1;
  Inc(FFieldCount);
end;

procedure TGridDataLink.ActiveChanged;
begin
  if Active and Assigned(DataSource) then
    if Assigned(DataSource.DataSet) then
      if DataSource.DataSet.IsUnidirectional then
        DatabaseError(SDataSetUnidirectional);
  FGrid.LinkActive(Active);
  FModified := False;
end;

procedure TGridDataLink.ClearMapping;
begin
  FFieldMap := nil;
  FFieldCount := 0;
end;

procedure TGridDataLink.Modified;
begin
  FModified := True;
end;

procedure TGridDataLink.DataSetChanged;
begin
  FGrid.DataChanged;
  FModified := False;
end;

procedure TGridDataLink.DataSetScrolled(Distance: Integer);
begin
  FGrid.Scroll(Distance);
end;

procedure TGridDataLink.LayoutChanged;
var
  SaveState: Boolean;
begin
  { FLayoutFromDataset determines whether default column width is forced to
    be at least wide enough for the column title.  }
  SaveState := FGrid.FLayoutFromDataset;
  FGrid.FLayoutFromDataset := True;
  try
    FGrid.LayoutChanged;
  finally
    FGrid.FLayoutFromDataset := SaveState;
  end;
  inherited LayoutChanged;
end;

procedure TGridDataLink.FocusControl(Field: TFieldRef);
begin
  if Assigned(Field) and Assigned(Field^) then
  begin
    FGrid.SelectedField := Field^;
    if (FGrid.SelectedField = Field^) and FGrid.AcquireFocus then
    begin
      Field^ := nil;
      FGrid.ShowEditor;
    end;
  end;
end;

procedure TGridDataLink.EditingChanged;
begin
  FGrid.EditingChanged;
end;

procedure TGridDataLink.RecordChanged(Field: TField);
begin
  FGrid.RecordChanged(Field);
  FModified := False;
end;

procedure TGridDataLink.UpdateData;
begin
  FInUpdateData := True;
  try
    if FModified then FGrid.UpdateData;
    FModified := False;
  finally
    FInUpdateData := False;
  end;
end;

function TGridDataLink.GetMappedIndex(ColIndex: Integer): Integer;
begin
  if (0 <= ColIndex) and (ColIndex < FFieldCount) then
    Result := FFieldMap[ColIndex]
  else
    Result := -1;
end;

procedure TGridDataLink.Reset;
begin
  if FModified then RecordChanged(nil) else Dataset.Cancel;
end;

function TGridDataLink.IsAggRow(Value: Integer): Boolean;
begin
  Result := False;
end;

procedure TGridDataLink.BuildAggMap;
begin
end;

{ TColumnTitle }
constructor TColumnTitle.Create(Column: TColumn);
begin
  inherited Create;
  FColumn := Column;
  FFont := TFont.Create;
  FFont.Assign(DefaultFont);
  FFont.OnChange := FontChanged;
end;

destructor TColumnTitle.Destroy;
begin
  FFont.Free;
  inherited Destroy;
end;

procedure TColumnTitle.Assign(Source: TPersistent);
begin
  if Source is TColumnTitle then
  begin
    if cvTitleAlignment in TColumnTitle(Source).FColumn.FAssignedValues then
      Alignment := TColumnTitle(Source).Alignment;
    if cvTitleColor in TColumnTitle(Source).FColumn.FAssignedValues then
      Color := TColumnTitle(Source).Color;
    if cvTitleCaption in TColumnTitle(Source).FColumn.FAssignedValues then
      Caption := TColumnTitle(Source).Caption;
    if cvTitleFont in TColumnTitle(Source).FColumn.FAssignedValues then
      Font := TColumnTitle(Source).Font;
  end
  else
    inherited Assign(Source);
end;

function TColumnTitle.DefaultAlignment: TAlignment;
begin
  Result := taLeftJustify;
end;

function TColumnTitle.DefaultColor: TColor;
var
  Grid: TCustomDBGrid;
begin
  Grid := FColumn.GetGrid;
  if Assigned(Grid) then
    Result := Grid.FixedColor
  else
    Result := clBtnFace;
end;

function TColumnTitle.DefaultFont: TFont;
var
  Grid: TCustomDBGrid;
begin
  Grid := FColumn.GetGrid;
  if Assigned(Grid) then
    Result := Grid.TitleFont
  else
    Result := FColumn.Font;
end;

function TColumnTitle.DefaultCaption: string;
var
  Field: TField;
begin
  Field := FColumn.Field;
  if Assigned(Field) then
    Result := Field.DisplayName
  else
    Result := FColumn.FieldName;
end;

procedure TColumnTitle.FontChanged(Sender: TObject);
begin
  Include(FColumn.FAssignedValues, cvTitleFont);
  FColumn.Changed(True);
end;

function TColumnTitle.GetAlignment: TAlignment;
begin
  if cvTitleAlignment in FColumn.FAssignedValues then
    Result := FAlignment
  else
    Result := DefaultAlignment;
end;

function TColumnTitle.GetColor: TColor;
begin
  if cvTitleColor in FColumn.FAssignedValues then
    Result := FColor
  else
    Result := DefaultColor;
end;

function TColumnTitle.GetCaption: string;
begin
  if cvTitleCaption in FColumn.FAssignedValues then
    Result := FCaption
  else
    Result := DefaultCaption;
end;

function TColumnTitle.GetFont: TFont;
var
  Save: TNotifyEvent;
  Def: TFont;
begin
  if not (cvTitleFont in FColumn.FAssignedValues) then
  begin
    Def := DefaultFont;
    if (FFont.Handle <> Def.Handle) or (FFont.Color <> Def.Color) then
    begin
      Save := FFont.OnChange;
      FFont.OnChange := nil;
      FFont.Assign(DefaultFont);
      FFont.OnChange := Save;
    end;
  end;
  Result := FFont;
end;

function TColumnTitle.IsAlignmentStored: Boolean;
begin
  Result := (cvTitleAlignment in FColumn.FAssignedValues) and
    (FAlignment <> DefaultAlignment);
end;

function TColumnTitle.IsColorStored: Boolean;
begin
  Result := (cvTitleColor in FColumn.FAssignedValues) and
    (FColor <> DefaultColor);
end;

function TColumnTitle.IsFontStored: Boolean;
begin
  Result := (cvTitleFont in FColumn.FAssignedValues);
end;

function TColumnTitle.IsCaptionStored: Boolean;
begin
  Result := (cvTitleCaption in FColumn.FAssignedValues) and
    (FCaption <> DefaultCaption);
end;

procedure TColumnTitle.RefreshDefaultFont;
var
  Save: TNotifyEvent;
begin
  if (cvTitleFont in FColumn.FAssignedValues) then Exit;
  Save := FFont.OnChange;
  FFont.OnChange := nil;
  try
    FFont.Assign(DefaultFont);
  finally
    FFont.OnChange := Save;
  end;
end;

procedure TColumnTitle.RestoreDefaults;
var
  FontAssigned: Boolean;
begin
  FontAssigned := cvTitleFont in FColumn.FAssignedValues;
  FColumn.FAssignedValues := FColumn.FAssignedValues - ColumnTitleValues;
  FCaption := '';
  RefreshDefaultFont;
  { If font was assigned, changing it back to default may affect grid title
    height, and title height changes require layout and redraw of the grid. }
  FColumn.Changed(FontAssigned);
end;

procedure TColumnTitle.SetAlignment(Value: TAlignment);
begin
  if (cvTitleAlignment in FColumn.FAssignedValues) and (Value = FAlignment) then Exit;
  FAlignment := Value;
  Include(FColumn.FAssignedValues, cvTitleAlignment);
  FColumn.Changed(False);
end;

procedure TColumnTitle.SetColor(Value: TColor);
begin
  if (cvTitleColor in FColumn.FAssignedValues) and (Value = FColor) then Exit;
  FColor := Value;
  Include(FColumn.FAssignedValues, cvTitleColor);
  FColumn.Changed(False);
end;

procedure TColumnTitle.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TColumnTitle.SetCaption(const Value: string);
var
  Grid: TCustomDBGrid;
begin
  if Column.IsStored then
  begin
    if (cvTitleCaption in FColumn.FAssignedValues) and (Value = FCaption) then Exit;
    FCaption := Value;
    Include(Column.FAssignedValues, cvTitleCaption);
    Column.Changed(False);
  end
  else
  begin
    Grid := Column.GetGrid;
    if Assigned(Grid) and (Grid.Datalink.Active) and Assigned(Column.Field) then
      Column.Field.DisplayLabel := Value;
  end;
end;


{ TColumn }

constructor TColumn.Create(Collection: TCollection);
var
  Grid: TCustomDBGrid;
begin
  Grid := nil;
  if Assigned(Collection) and (Collection is TDBGridColumns) then
    Grid := TDBGridColumns(Collection).Grid;
  if Assigned(Grid) then Grid.BeginLayout;
  try
    inherited Create(Collection);
    FDropDownRows := 7;
    FButtonStyle := cbsAuto;
    FFont := TFont.Create;
    FFont.Assign(DefaultFont);
    FFont.OnChange := FontChanged;
    FTitle := CreateTitle;
    FVisible := True;
    FExpanded := True;
    FStored := True;
  finally
    if Assigned(Grid) then Grid.EndLayout;
  end;
end;

destructor TColumn.Destroy;
begin
  FTitle.Free;
  FFont.Free;
  FPickList.Free;
  inherited Destroy;
end;

procedure TColumn.Assign(Source: TPersistent);
begin
  if Source is TColumn then
  begin
    if Assigned(Collection) then Collection.BeginUpdate;
    try
      RestoreDefaults;
      FieldName := TColumn(Source).FieldName;
      if cvColor in TColumn(Source).AssignedValues then
        Color := TColumn(Source).Color;
      if cvWidth in TColumn(Source).AssignedValues then
        Width := TColumn(Source).Width;
      if cvFont in TColumn(Source).AssignedValues then
        Font := TColumn(Source).Font;
      if cvAlignment in TColumn(Source).AssignedValues then
        Alignment := TColumn(Source).Alignment;
      if cvReadOnly in TColumn(Source).AssignedValues then
        ReadOnly := TColumn(Source).ReadOnly;
      Title := TColumn(Source).Title;
      DropDownRows := TColumn(Source).DropDownRows;
      ButtonStyle := TColumn(Source).ButtonStyle;
      PickList := TColumn(Source).PickList;
      PopupMenu := TColumn(Source).PopupMenu;
      FVisible := TColumn(Source).FVisible;
      FExpanded := TColumn(Source).FExpanded;
    finally
      if Assigned(Collection) then Collection.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TColumn.CreateTitle: TColumnTitle;
begin
  Result := TColumnTitle.Create(Self);
end;

function TColumn.DefaultAlignment: TAlignment;
begin
  if Assigned(Field) then
    Result := FField.Alignment
  else
    Result := taLeftJustify;
end;

function TColumn.DefaultColor: TColor;
var
  Grid: TCustomDBGrid;
begin
  Grid := GetGrid;
  if Assigned(Grid) then
    Result := Grid.Color
  else
    Result := clWindow;
end;

function TColumn.DefaultFont: TFont;
var
  Grid: TCustomDBGrid;
begin
  Grid := GetGrid;
  if Assigned(Grid) then
    Result := Grid.Font
  else
    Result := FFont;
end;
(*
function TColumn.DefaultImeMode: TImeMode;
var
  Grid: TCustomDBGrid;
begin
  Grid := GetGrid;
  if Assigned(Grid) then
    Result := Grid.ImeMode
  else
    Result := FImeMode;
end;

function TColumn.DefaultImeName: TImeName;
var
  Grid: TCustomDBGrid;
begin
  Grid := GetGrid;
  if Assigned(Grid) then
    Result := Grid.ImeName
  else
    Result := FImeName;
end;
*)
function TColumn.DefaultReadOnly: Boolean;
var
  Grid: TCustomDBGrid;
begin
  Grid := GetGrid;
  Result := (Assigned(Grid) and Grid.ReadOnly) or
    (Assigned(Field) and FField.ReadOnly);
end;

function TColumn.DefaultWidth: Integer;
var
  W: Integer;
begin
  if GetGrid = nil then
  begin
    Result := 64;
    Exit;
  end;
  with GetGrid do
  begin
    if Assigned(Field) then
    begin
      try
        Canvas.Font := Self.Font;
        Result := Field.DisplayWidth * Canvas.TextWidth('0') + 4;
        if dgTitles in Options then
        begin
          Canvas.Font := Title.Font;
          W := Canvas.TextWidth(Title.Caption) + 4;
          if Result < W then
            Result := W;
        end;
      finally
      end;
    end
    else
      Result := DefaultColWidth;
  end;
end;

procedure TColumn.FontChanged;
begin
  Include(FAssignedValues, cvFont);
  Title.RefreshDefaultFont;
  Changed(False);
end;

function TColumn.GetAlignment: TAlignment;
begin
  if cvAlignment in FAssignedValues then
    Result := FAlignment
  else
    Result := DefaultAlignment;
end;

function TColumn.GetColor: TColor;
begin
  if cvColor in FAssignedValues then
    Result := FColor
  else
    Result := DefaultColor;
end;

function TColumn.GetExpanded: Boolean;
begin
  Result := FExpanded and Expandable;
end;

function TColumn.GetField: TField;
var
  Grid: TCustomDBGrid;
begin    { Returns Nil if FieldName can't be found in dataset }
  Grid := GetGrid;
  if (FField = nil) and (Length(FFieldName) > 0) and Assigned(Grid) and
    Assigned(Grid.DataLink.DataSet) then
  with Grid.Datalink.Dataset do
    if Active or (not DefaultFields) then
      SetField(FindField(FieldName));
  Result := FField;
end;

function TColumn.GetFont: TFont;
var
  Save: TNotifyEvent;
begin
  if not (cvFont in FAssignedValues) and (FFont.Handle <> DefaultFont.Handle) then
  begin
    Save := FFont.OnChange;
    FFont.OnChange := nil;
    FFont.Assign(DefaultFont);
    FFont.OnChange := Save;
  end;
  Result := FFont;
end;

function TColumn.GetGrid: TCustomDBGrid;
begin
  if Assigned(Collection) and (Collection is TDBGridColumns) then
    Result := TDBGridColumns(Collection).Grid
  else
    Result := nil;
end;

function TColumn.GetDisplayName: string;
begin
  Result := FFieldName;
  if Result = '' then Result := inherited GetDisplayName;
end;
(*
function TColumn.GetImeMode: TImeMode;
begin
  if cvImeMode in FAssignedValues then
    Result := FImeMode
  else
    Result := DefaultImeMode;
end;

function TColumn.GetImeName: TImeName;
begin
  if cvImeName in FAssignedValues then
    Result := FImeName
  else
    Result := DefaultImeName;
end;
*)
function TColumn.GetParentColumn: TColumn;
var
  Col: TColumn;
  Fld: TField;
  I: Integer;
begin
  Result := nil;
  Fld := Field;
  if (Fld <> nil) and (Fld.ParentField <> nil) and (Collection <> nil) then
    for I := Index - 1 downto 0 do
    begin
      Col := TColumn(Collection.Items[I]);
      if Fld.ParentField = Col.Field then
      begin
        Result := Col;
        Exit;
      end;
    end;
end;

function TColumn.GetPickList: TStrings;
begin
  if FPickList = nil then
    FPickList := TStringList.Create;
  Result := FPickList;
end;

function TColumn.GetReadOnly: Boolean;
begin
  if cvReadOnly in FAssignedValues then
    Result := FReadOnly
  else
    Result := DefaultReadOnly;
end;

function TColumn.GetShowing: Boolean;
var
  Col: TColumn;
begin
  Result := not Expanded and Visible;
  if Result then
  begin
    Col := Self;
    repeat
      Col := Col.ParentColumn;
    until (Col = nil) or not Col.Expanded;
    Result := Col = nil;
  end;
end;

function TColumn.GetVisible: Boolean;
var
  Col: TColumn;
begin
  Result := FVisible;
  if Result then
  begin
    Col := ParentColumn;
    Result := Result and ((Col = nil) or Col.Visible);
  end;
end;

function TColumn.GetWidth: Integer;
begin
  if not Showing then
    Result := -1
  else if cvWidth in FAssignedValues then
    Result := FWidth
  else
    Result := DefaultWidth;
end;

function TColumn.IsAlignmentStored: Boolean;
begin
  Result := (cvAlignment in FAssignedValues) and (FAlignment <> DefaultAlignment);
end;

function TColumn.IsColorStored: Boolean;
begin
  Result := (cvColor in FAssignedValues) and (FColor <> DefaultColor);
end;

function TColumn.IsFontStored: Boolean;
begin
  Result := (cvFont in FAssignedValues);
end;

function TColumn.IsReadOnlyStored: Boolean;
begin
  Result := (cvReadOnly in FAssignedValues) and (FReadOnly <> DefaultReadOnly);
end;

function TColumn.IsWidthStored: Boolean;
begin
  Result := (cvWidth in FAssignedValues) and (FWidth <> DefaultWidth);
end;

procedure TColumn.RefreshDefaultFont;
var
  Save: TNotifyEvent;
begin
  if cvFont in FAssignedValues then Exit;
  Save := FFont.OnChange;
  FFont.OnChange := nil;
  try
    FFont.Assign(DefaultFont);
  finally
    FFont.OnChange := Save;
  end;
end;

procedure TColumn.RestoreDefaults;
var
  FontAssigned: Boolean;
begin
  FontAssigned := cvFont in FAssignedValues;
  FTitle.RestoreDefaults;
  FAssignedValues := [];
  RefreshDefaultFont;
  FPickList.Free;
  FPickList := nil;
  ButtonStyle := cbsAuto;
  Changed(FontAssigned);
end;

procedure TColumn.SetAlignment(Value: TAlignment);
var
  Grid: TCustomDBGrid;
begin
  if IsStored then
  begin
    if (cvAlignment in FAssignedValues) and (Value = FAlignment) then Exit;
    FAlignment := Value;
    Include(FAssignedValues, cvAlignment);
    Changed(False);
  end
  else
  begin
    Grid := GetGrid;
    if Assigned(Grid) and (Grid.Datalink.Active) and Assigned(Field) then
      Field.Alignment := Value;
  end;
end;

procedure TColumn.SetButtonStyle(Value: TColumnButtonStyle);
begin
  if Value = FButtonStyle then Exit;
  FButtonStyle := Value;
  Changed(False);
end;

procedure TColumn.SetColor(Value: TColor);
begin
  if (cvColor in FAssignedValues) and (Value = FColor) then Exit;
  FColor := Value;
  Include(FAssignedValues, cvColor);
  Changed(False);
end;

procedure TColumn.SetField(Value: TField);
begin
  if FField = Value then Exit;
  if Assigned(FField) and (GetGrid <> nil) then
    FField.RemoveFreeNotification(GetGrid);
  if Assigned(Value) and (csDestroying in Value.ComponentState) then
    Value := nil;    // don't acquire references to fields being destroyed
  FField := Value;
  if Assigned(Value) then
  begin
    if GetGrid <> nil then
      FField.FreeNotification(GetGrid);
    FFieldName := Value.FullName;
  end;
  if not IsStored then
  begin
    if Value = nil then
      FFieldName := '';
    RestoreDefaults;
  end;
  Changed(False);
end;

procedure TColumn.SetFieldName(const Value: String);
var
  AField: TField;
  Grid: TCustomDBGrid;
begin
  AField := nil;
  Grid := GetGrid;
  if Assigned(Grid) and Assigned(Grid.DataLink.DataSet) and
    not (csLoading in Grid.ComponentState) and (Length(Value) > 0) then
      AField := Grid.DataLink.DataSet.FindField(Value); { no exceptions }
  FFieldName := Value;
  SetField(AField);
  Changed(False);
end;

procedure TColumn.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
  Include(FAssignedValues, cvFont);
  Changed(False);
end;
(*
procedure TColumn.SetImeMode(Value: TImeMode);
begin
  if (cvImeMode in FAssignedValues) or (Value <> DefaultImeMode) then
  begin
    FImeMode := Value;
    Include(FAssignedValues, cvImeMode);
  end;
  Changed(False);
end;

procedure TColumn.SetImeName(Value: TImeName);
begin
  if (cvImeName in FAssignedValues) or (Value <> DefaultImeName) then
  begin
    FImeName := Value;
    Include(FAssignedValues, cvImeName);
  end;
  Changed(False);
end;
*)
procedure TColumn.SetIndex(Value: Integer);
var
  Grid: TCustomDBGrid;
  Fld: TField;
  I, OldIndex: Integer;
  Col: TColumn;
begin
  OldIndex := Index;
  Grid := GetGrid;

  if IsStored then
  begin
    Grid.BeginLayout;
    try
      I := OldIndex + 1;  // move child columns along with parent
      while (I < Collection.Count) and (TColumn(Collection.Items[I]).ParentColumn = Self) do
        Inc(I);
      Dec(I);
      if OldIndex > Value then   // column moving left
      begin
        while I > OldIndex do
        begin
          Collection.Items[I].Index := Value;
          Inc(OldIndex);
        end;
        inherited SetIndex(Value);
      end
      else
      begin
        inherited SetIndex(Value);
        while I > OldIndex do
        begin
          Collection.Items[OldIndex].Index := Value;
          Dec(I);
        end;
      end;
    finally
      Grid.EndLayout;
    end;
  end
  else
  begin
    if (Grid <> nil) and Grid.Datalink.Active then
    begin
      if Grid.AcquireLayoutLock then
      try
        Col := Grid.ColumnAtDepth(Grid.Columns[Value], Depth);
        if (Col <> nil) then
        begin
          Fld := Col.Field;
          if Assigned(Fld) then
            Field.Index := Fld.Index;
        end;
      finally
        Grid.EndLayout;
      end;
    end;
    inherited SetIndex(Value);
  end;
end;

procedure TColumn.SetPickList(Value: TStrings);
begin
  if Value = nil then
  begin
    FPickList.Free;
    FPickList := nil;
    Exit;
  end;
  PickList.Assign(Value);
end;

procedure TColumn.SetPopupMenu(Value: TPopupMenu);
begin
  FPopupMenu := Value;
  if Value <> nil then Value.FreeNotification(GetGrid);
end;

procedure TColumn.SetReadOnly(Value: Boolean);
var
  Grid: TCustomDBGrid;
begin
  Grid := GetGrid;
  if not IsStored and Assigned(Grid) and Grid.Datalink.Active and Assigned(Field) then
    Field.ReadOnly := Value
  else
  begin
    if (cvReadOnly in FAssignedValues) and (Value = FReadOnly) then Exit;
    FReadOnly := Value;
    Include(FAssignedValues, cvReadOnly);
    Changed(False);
  end;
end;

procedure TColumn.SetTitle(Value: TColumnTitle);
begin
  FTitle.Assign(Value);
end;

procedure TColumn.SetWidth(Value: Integer);
var
  Grid: TCustomDBGrid;
  DoSetWidth: Boolean;
begin
  DoSetWidth := IsStored;
  if not DoSetWidth then
  begin
    Grid := GetGrid;
    if Assigned(Grid) then
    begin
      if Grid.HandleAllocated and Assigned(Field) and Grid.FUpdateFields then
      with Grid do
      begin
        Canvas.Font := Self.Font;
        Field.DisplayWidth := (Value + (Canvas.TextWidth('0') div 2) - 3) div Canvas.TextWidth('0');
      end;
      if (not Grid.FLayoutFromDataset) or (cvWidth in FAssignedValues) then
        DoSetWidth := True;
    end
    else
      DoSetWidth := True;
  end;
  if DoSetWidth then
  begin
    if ((cvWidth in FAssignedValues) or (Value <> DefaultWidth))
      and (Value <> -1) then
    begin
      FWidth := Value;
      Include(FAssignedValues, cvWidth);
    end;
    Changed(False);
  end;
end;

procedure TColumn.SetVisible(Value: Boolean);
begin
  if Value <> FVisible then
  begin
    FVisible := Value;
    Changed(True);
  end;
end;

procedure TColumn.SetExpanded(Value: Boolean);
const
  Direction: array [Boolean] of ShortInt = (-1,1);
var
  Grid: TCustomDBGrid;
  WasShowing: Boolean;
begin
  if Value <> FExpanded then
  begin
    Grid := GetGrid;
    WasShowing := (Grid <> nil) and Grid.Columns[Grid.SelectedIndex].Showing;
    FExpanded := Value;
    Changed(True);
    if (Grid <> nil) and WasShowing then
    begin
      if not Grid.Columns[Grid.SelectedIndex].Showing then
        // The selected cell was hidden by this expand operation
        // Select 1st child (next col = 1) when parent is expanded
        // Select child's parent (prev col = -1) when parent is collapsed
        Grid.MoveCol(Grid.Col, Direction[FExpanded]);
    end;
  end;
end;

function TColumn.Depth: Integer;
var
  Col: TColumn;
begin
  Result := 0;
  Col := ParentColumn;
  if Col <> nil then Result := Col.Depth + 1;
end;

function TColumn.GetExpandable: Boolean;
var
  Fld: TField;
begin
  Fld := Field;
  Result := (Fld <> nil) and (Fld.DataType in [ftADT, ftArray]);
end;

{ TDBGridColumns }

constructor TDBGridColumns.Create(Grid: TCustomDBGrid; ColumnClass: TColumnClass);
begin
  inherited Create(ColumnClass);
  FGrid := Grid;
end;

function TDBGridColumns.Add: TColumn;
begin
  Result := TColumn(inherited Add);
end;

function TDBGridColumns.GetColumn(Index: Integer): TColumn;
begin
  Result := TColumn(inherited Items[Index]);
end;

function TDBGridColumns.GetOwner: TPersistent;
begin
  Result := FGrid;
end;

procedure TDBGridColumns.LoadFromFile(const Filename: string);
var
  S: TFileStream;
begin
  S := TFileStream.Create(Filename, fmOpenRead);
  try
    LoadFromStream(S);
  finally
    S.Free;
  end;
end;

type
  TColumnsWrapper = class(TComponent)
  private
    FColumns: TDBGridColumns;
  published
    property Columns: TDBGridColumns read FColumns write FColumns;
  end;

procedure TDBGridColumns.LoadFromStream(S: TStream);
var
  Wrapper: TColumnsWrapper;
begin
  Wrapper := TColumnsWrapper.Create(nil);
  try
    Wrapper.Columns := FGrid.CreateColumns;
    S.ReadComponent(Wrapper);
    Assign(Wrapper.Columns);
  finally
    Wrapper.Columns.Free;
    Wrapper.Free;
  end;
end;

procedure TDBGridColumns.RestoreDefaults;
var
  I: Integer;
begin
  BeginUpdate;
  try
    for I := 0 to Count-1 do
      Items[I].RestoreDefaults;
  finally
    EndUpdate;
  end;
end;

procedure TDBGridColumns.RebuildColumns;

  procedure AddFields(Fields: TFields; Depth: Integer);
  var
    I: Integer;
  begin
    Inc(Depth);
    for I := 0 to Fields.Count-1 do
    begin
      Add.FieldName := Fields[I].FullName;
      if Fields[I].DataType in [ftADT, ftArray] then
        AddFields((Fields[I] as TObjectField).Fields, Depth);
    end;
  end;

begin
  if Assigned(FGrid) and Assigned(FGrid.DataSource) and
    Assigned(FGrid.Datasource.Dataset) then
  begin
    FGrid.BeginLayout;
    try
      Clear;
      AddFields(FGrid.Datasource.Dataset.Fields, 0);
    finally
      FGrid.EndLayout;
    end
  end
  else
    Clear;
end;

procedure TDBGridColumns.SaveToFile(const Filename: string);
var
  S: TStream;
begin
  S := TFileStream.Create(Filename, fmCreate);
  try
    SaveToStream(S);
  finally
    S.Free;
  end;
end;

procedure TDBGridColumns.SaveToStream(S: TStream);
var
  Wrapper: TColumnsWrapper;
begin
  Wrapper := TColumnsWrapper.Create(nil);
  try
    Wrapper.Columns := Self;
    S.WriteComponent(Wrapper);
  finally
    Wrapper.Free;
  end;
end;

procedure TDBGridColumns.SetColumn(Index: Integer; Value: TColumn);
begin
  Items[Index].Assign(Value);
end;

procedure TDBGridColumns.SetState(NewState: TDBGridColumnsState);
begin
  if NewState = State then Exit;
  if NewState = csDefault then
    Clear
  else
    RebuildColumns;
end;

procedure TDBGridColumns.Update(Item: TCollectionItem);
var
  Raw: Integer;
begin
  if (FGrid = nil) or (csLoading in FGrid.ComponentState) then Exit;
  if Item = nil then
  begin
    FGrid.LayoutChanged;
  end
  else
  begin
    Raw := FGrid.DataToRawColumn(Item.Index);
    FGrid.InvalidateCol(Raw);
    FGrid.ColWidths[Raw] := TColumn(Item).Width;
  end;
end;

function TDBGridColumns.InternalAdd: TColumn;
begin
  Result := Add;
  Result.IsStored := False;
end;

function TDBGridColumns.GetState: TDBGridColumnsState;
begin
  Result := TDBGridColumnsState((Count > 0) and Items[0].IsStored);
end;

{ TBookmarkList }

constructor TBookmarkList.Create(AGrid: TCustomDBGrid);
begin
  inherited Create;
  FList := TStringList.Create;
  FList.OnChange := StringsChanged;
  FGrid := AGrid;
end;

destructor TBookmarkList.Destroy;
begin
  Clear;
  FList.Free;
  inherited Destroy;
end;

procedure TBookmarkList.Clear;
begin
  if FList.Count = 0 then Exit;
  FList.Clear;
  FGrid.Invalidate;
end;

function TBookmarkList.Compare(const Item1, Item2: TBookmarkStr): Integer;
begin
  with FGrid.Datalink.Datasource.Dataset do
    Result := CompareBookmarks(TBookmark(Item1), TBookmark(Item2));
end;

function TBookmarkList.CurrentRow: TBookmarkStr;
begin
  if not FLinkActive then RaiseGridError(sDataSetClosed);
  Result := FGrid.Datalink.Datasource.Dataset.Bookmark;
end;

function TBookmarkList.GetCurrentRowSelected: Boolean;
var
  Index: Integer;
begin
  Result := Find(CurrentRow, Index);
end;

function TBookmarkList.Find(const Item: TBookmarkStr; var Index: Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  if (Item = FCache) and (FCacheIndex >= 0) then
  begin
    Index := FCacheIndex;
    Result := FCacheFind;
    Exit;
  end;
  Result := False;
  L := 0;
  H := FList.Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := Compare(FList[I], Item);
    if C < 0 then L := I + 1 else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := True;
        L := I;
      end;
    end;
  end;
  Index := L;
  FCache := Item;
  FCacheIndex := Index;
  FCacheFind := Result;
end;

function TBookmarkList.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TBookmarkList.GetItem(Index: Integer): TBookmarkStr;
begin
  Result := FList[Index];
end;

function TBookmarkList.IndexOf(const Item: TBookmarkStr): Integer;
begin
  if not Find(Item, Result) then
    Result := -1;
end;

procedure TBookmarkList.LinkActive(Value: Boolean);
begin
  Clear;
  FLinkActive := Value;
end;

procedure TBookmarkList.Delete;
var
  I: Integer;
begin
  with FGrid.Datalink.Datasource.Dataset do
  begin
    DisableControls;
    try
      for I := FList.Count-1 downto 0 do
      begin
        Bookmark := FList[I];
        Delete;
        FList.Delete(I);
      end;
    finally
      EnableControls;
    end;
  end;
end;

function TBookmarkList.Refresh: Boolean;
var
  I: Integer;
begin
  Result := False;
  with FGrid.DataLink.Datasource.Dataset do
  try
    CheckBrowseMode;
    for I := FList.Count - 1 downto 0 do
      if not BookmarkValid(TBookmark(FList[I])) then
      begin
        Result := True;
        FList.Delete(I);
      end;
  finally
    UpdateCursorPos;
    if Result then FGrid.Invalidate;
  end;
end;

procedure TBookmarkList.SetCurrentRowSelected(Value: Boolean);
var
  Index: Integer;
  Current: TBookmarkStr;
begin
  Current := CurrentRow;
  if (Length(Current) = 0) or (Find(Current, Index) = Value) then Exit;
  if Value then
    FList.Insert(Index, Current)
  else
    FList.Delete(Index);
  FGrid.InvalidateRow(FGrid.Row);
end;

procedure TBookmarkList.StringsChanged(Sender: TObject);
begin
  FCache := '';
  FCacheIndex := -1;
end;

{ TSubGridForm }

constructor TSubGridForm.CreateParented(ParentWidget: QWidgetH; AGrid: TCustomDBGrid);
begin
  inherited CreateParented(ParentWidget);
  if AGrid <> nil then AGrid.InsertComponent(Self);
  FSubGrid := TCustomDBGrid(TComponentClass(AGrid.ClassType).Create(Self));
  FSubGrid.Visible := False;
  FSubGrid.Parent := Self;
  with AGrid do
  begin
    FSubGrid.Color := Color;
    FSubGrid.Cursor := Cursor;
    FSubGrid.Enabled := Enabled;
    FSubGrid.FixedColor := FixedColor;
    FSubGrid.Font := Font;
    FSubGrid.HelpType := HelpType;
    FSubGrid.HelpContext := HelpContext;
    FSubGrid.HelpKeyword := HelpKeyword;
    FSubGrid.Options := Options;
  end;
end;

function TSubGridForm.WidgetFlags: Integer;
begin
  Result := inherited WidgetFlags
              or Integer(WidgetFlags_WType_TopLevel)
              or Integer(WidgetFlags_WStyle_StaysOnTop);
end;

procedure TSubGridForm.InitWidget;
begin
  inherited InitWidget;
  Visible := False;
end;

{ TCustomDBGrid }

var
  DrawBitmap: TBitmap;
  UserCount: Integer;

procedure UsesBitmap;
begin
  if UserCount = 0 then
    DrawBitmap := TBitmap.Create;
  Inc(UserCount);
end;

procedure ReleaseBitmap;
begin
  Dec(UserCount);
  if UserCount = 0 then DrawBitmap.Free;
end;

procedure WriteText(ACanvas: TCanvas; ARect: TRect; DX, DY: Integer;
  const Text: string; Alignment: TAlignment; ARightToLeft: Boolean);
var
  Left: Integer;
begin
  case Alignment of
    taLeftJustify:
      Left := ARect.Left + DX;
    taRightJustify:
      Left := ARect.Right - ACanvas.TextWidth(Text) - 3;
  else { taCenter }
    Left := ARect.Left + (ARect.Right - ARect.Left) shr 1
      - (ACanvas.TextWidth(Text) shr 1);
  end;
  if Left < ARect.Left then
    Left := ARect.Left;
  ACanvas.TextRect(ARect, Left, ARect.Top + DY, Text);
end;

constructor TCustomDBGrid.Create(AOwner: TComponent);
var
  Bmp: TBitmap;
begin
  inherited Create(AOwner);
  inherited DefaultDrawing := False;
  FAcquireFocus := True;
  Bmp := TBitmap.Create;
  try
    Bmp.LoadFromResourceName(HInstance, bmArrow);
    FIndicators := TImageList.CreateSize(Bmp.Width, Bmp.Height);
    FIndicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmEdit);
    FIndicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmInsert);
    FIndicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmMultiDot);
    FIndicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmMultiArrow);
    FIndicators.AddMasked(Bmp, clWhite);
  finally
    Bmp.Free;
  end;
  FTitleOffset := 1;
  FIndicatorOffset := 1;
  FUpdateFields := True;
  FOptions := [dgEditing, dgTitles, dgIndicator, dgColumnResize,
    dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit];
  DesignOptionsBoost := [goColSizing];
  VirtualView := True;
  UsesBitmap;
  ScrollBars := ssAutoBoth;
  inherited Options := [goFixedHorzLine, goFixedVertLine, goHorzLine,
    goVertLine, goColSizing, goColMoving, goTabs, goEditing];
  FColumns := CreateColumns;
  FVisibleColumns := TList.Create;
  inherited RowCount := 2;
  inherited ColCount := 2;
  FDataLink := TGridDataLink.Create(Self);
  Color := clWindow;
  ParentColor := False;
  FTitleFont := TFont.Create;
  FTitleFont.OnChange := TitleFontChanged;
  FSaveCellExtents := False;
  FUserChange := True;
  FDefaultDrawing := True;
  FBookmarks := TBookmarkList.Create(Self);
  HideEditor;
end;

destructor TCustomDBGrid.Destroy;
begin
   FColumns.Free;
  FColumns := nil;
  FVisibleColumns.Free;
  FVisibleColumns := nil;
  FDataLink.Free;
  FDataLink := nil;
  FIndicators.Free;
  FTitleFont.Free;
  FTitleFont := nil;
  FBookmarks.Free;
  FBookmarks := nil;
  inherited Destroy;
  ReleaseBitmap;
end;

function TCustomDBGrid.IsRightToLeft: Boolean;
begin
  Result := False;
end;

function TCustomDBGrid.UseRightToLeftAlignment: Boolean;
begin
  Result := False;
end;

function TCustomDBGrid.GetInPlaceEditText: string;
begin
  if Assigned(InplaceEditor) then
    Result := InplaceEditor.Text
  else
    Result := '';
end;

function TCustomDBGrid.AcquireFocus: Boolean;
begin
  Result := True;
  if FAcquireFocus and CanFocus and not (csDesigning in ComponentState) then
  begin
    SetFocus;
    Result := Focused or (InplaceEditor <> nil) and InplaceEditor.Focused;
  end;
end;

procedure TCustomDBGrid.BoundsChanged;
begin
  inherited;
  if UpdateLock = 0 then
  begin
    UpdateRowCount;
    UpdateScrollBar;
  end;
  InvalidateTitles;
end;

function TCustomDBGrid.CalcScrollBarVisible(ScrollBar: TScrollStyle;
  const AxisInfo: TGridAxisDrawInfo; Max: Integer): boolean;
begin
  if ScrollBar = ssHorizontal then
    Result := inherited CalcScrollBarVisible(ScrollBar, AxisInfo, Max)
  else
    Result := Assigned(FDataLink) and FDataLink.Active and
              (FDataLink.DataSet.RecordCount > VisibleRowCount);
end;

procedure TCustomDBGrid.DoExit;
begin
  try
    if FDatalink.Active then
      with FDatalink.Dataset do
        if (dgCancelOnExit in Options) and (State = dsInsert) and
          not Modified and not FDatalink.FModified then
          Cancel else
          FDataLink.UpdateData;
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

function TCustomDBGrid.EventFilter(Sender: QObjectH; Event: QEventH): Boolean;
var
  X,Y: Integer;
  P: TPopupMenu;
  Cell: TGridCoord;
begin
  Result := False;
  case QEvent_type(Event) of
    QEventType_mouseButtonPress:
      if QMouseEvent_button(QMouseEventH(Event)) = ButtonState_RightButton then
      begin
        X := QMouseEvent_x(QMouseEventH(Event));
        Y := QMouseEvent_y(QMouseEventH(Event));
        Cell := MouseCoord(X, Y);
        if (Cell.X < FIndicatorOffset) or (Y < 0) then exit;
        P := Columns[RawToDataColumn(Cell.X)].PopupMenu;
        if Assigned(P) and P.AutoPopup then
        begin
          P.PopupComponent := Self;
          with ClientToScreen(Point(X, Y)) do
          P.Popup(X, Y);
          Result := True;
          Exit;
        end;
      end;
  end;
  Result := inherited EventFilter(Sender, Event);
end;

procedure TCustomDBGrid.FontChanged;
var
  I: Integer;
begin
  inherited;
  BeginLayout;
  try
    for I := 0 to Columns.Count-1 do
      Columns[I].RefreshDefaultFont;
  finally
    EndLayout;
  end;
end;

function TCustomDBGrid.IsActiveControl: Boolean;
begin
  Result := (Owner is TSubGridForm) or inherited IsActiveControl;
end;

procedure TCustomDBGrid.ModifyScrollBar(ScrollBar: TScrollBarKind; ScrollCode: TScrollCode; Pos: Cardinal;
  UseRightToLeft: Boolean);
begin
  if not AcquireFocus then Exit;
  if (Scrollbar = sbVertical) then
  begin
    if Assigned(FDataLink) and FDatalink.Active then
    with FDataLink.DataSet do
      case ScrollCode of
        scLineUp: FDataLink.MoveBy(-FDatalink.ActiveRecord - 1);
        scLineDown: FDataLink.MoveBy(FDatalink.RecordCount - FDatalink.ActiveRecord);
        scPageUp: FDataLink.MoveBy(-VisibleRowCount);
        scPageDown: FDataLink.MoveBy(VisibleRowCount);
        scPosition:
          begin
            if IsSequenced then
            begin
              if VScrollBar.Position <= 1 then First
              else if VScrollBar.Position >= RecordCount then Last
              else RecNo := Pos;
            end
            else
              case Pos of
                0: First;
                1: FDataLink.MoveBy(-VisibleRowCount);
                2: Exit;
                3: FDataLink.MoveBy(VisibleRowCount);
                4: Last;
              end;
          end;
        scBottom: Last;
        scTop: First;
      end;
  end
  else inherited;
end;

procedure TCustomDBGrid.ParentFontChanged;
begin
  inherited;
  if ParentFont then
  begin
    FSelfChangingTitleFont := True;
    try
      TitleFont := Font;
    finally
      FSelfChangingTitleFont := False;
    end;
    LayoutChanged;
  end;
end;

function TCustomDBGrid.RawToDataColumn(ACol: Integer): Integer;
begin
  Result := ACol - FIndicatorOffset;
end;

function TCustomDBGrid.DataToRawColumn(ACol: Integer): Integer;
begin
  Result := ACol + FIndicatorOffset;
end;

function TCustomDBGrid.AcquireLayoutLock: Boolean;
begin
  Result := (FUpdateLock = 0) and (FLayoutLock = 0);
  if Result then BeginLayout;
end;

procedure TCustomDBGrid.BeginLayout;
begin
  BeginUpdate;
  if FLayoutLock = 0 then Columns.BeginUpdate;
  Inc(FLayoutLock);
end;

procedure TCustomDBGrid.BeginUpdate;
begin
  Inc(FUpdateLock);
end;

procedure TCustomDBGrid.CancelLayout;
begin
  if FLayoutLock > 0 then
  begin
    if FLayoutLock = 1 then
      Columns.EndUpdate;
    Dec(FLayoutLock);
    EndUpdate;
  end;
end;

function TCustomDBGrid.CanEditAcceptKey(Key: Char): Boolean;
begin
  with Columns[SelectedIndex] do
    Result := FDatalink.Active and Assigned(Field) and Field.IsValidChar(Key);
end;

function TCustomDBGrid.CanEditModify: Boolean;
begin
  Result := False;
  if not ReadOnly and FDatalink.Active and not FDatalink.Readonly then
  with Columns[SelectedIndex] do
    if (not ReadOnly) and Assigned(Field) and Field.CanModify
      and (not (Field.DataType in ftNonTextTypes) or Assigned(Field.OnSetText)) then
    begin
      FDatalink.Edit;
      Result := FDatalink.Editing;
      if Result then FDatalink.Modified;
    end;
end;

function TCustomDBGrid.CanEditShow: Boolean;
begin
  Result := (LayoutLock = 0) and inherited CanEditShow;
end;

procedure TCustomDBGrid.CellClick(Column: TColumn);
begin
  if Assigned(FOnCellClick) then FOnCellClick(Column);
end;

procedure TCustomDBGrid.ColEnter;
begin
  if Assigned(FOnColEnter) then FOnColEnter(Self);
end;

procedure TCustomDBGrid.ColExit;
begin
  if Assigned(FOnColExit) then FOnColExit(Self);
end;

procedure TCustomDBGrid.ColumnMoved(FromIndex, ToIndex: Longint);
begin
  FromIndex := RawToDataColumn(FromIndex);
  ToIndex := RawToDataColumn(ToIndex);
  Columns[FromIndex].Index := ToIndex;
  if Assigned(FOnColumnMoved) then FOnColumnMoved(Self, FromIndex, ToIndex);
end;

procedure TCustomDBGrid.ColWidthsChanged;
var
  I: Integer;
begin
  inherited ColWidthsChanged;
  if (FDatalink.Active or (FColumns.State = csCustomized)) and
    AcquireLayoutLock then
  try
    for I := FIndicatorOffset to ColCount - 1 do
      FColumns[I - FIndicatorOffset].Width := ColWidths[I];
  finally
    EndLayout;
  end;
end;

function TCustomDBGrid.CreateColumns: TDBGridColumns;
begin
  Result := TDBGridColumns.Create(Self, TColumn);
end;

function TCustomDBGrid.CreateEditor: TInplaceEdit;
begin
  Result := TDBGridInplaceEdit.Create(Self);
end;

procedure TCustomDBGrid.DataChanged;
begin
  if not HandleAllocated or FDatasetLocked then Exit;
  UpdateRowCount;
  UpdateScrollBars;
  UpdateScrollBar;
  UpdateActive;
  InvalidateEditor;
  Invalidate;
end;

procedure TCustomDBGrid.DefineFieldMap;
var
  I: Integer;
begin
  if FColumns.State = csCustomized then
  begin   { Build the column/field map from the column attributes }
    DataLink.SparseMap := True;
    for I := 0 to FColumns.Count-1 do
      FDataLink.AddMapping(FColumns[I].FieldName);
  end
  else   { Build the column/field map from the field list order }
  begin
    FDataLink.SparseMap := False;
    with Datalink.Dataset do
      for I := 0 to FieldList.Count - 1 do
        with FieldList[I] do if Visible then Datalink.AddMapping(FullName);
  end;
end;

function TCustomDBGrid.UseRightToLeftAlignmentForField(const AField: TField;
  Alignment: TAlignment): Boolean;
begin
  Result := False;
  if IsRightToLeft then
    Result := OkToChangeFieldAlignment(AField, Alignment);
end;

procedure TCustomDBGrid.DefaultDrawDataCell(const Rect: TRect; Field: TField;
  State: TGridDrawState);
var
  Alignment: TAlignment;
  Value: string;
begin
  Alignment := taLeftJustify;
  Value := '';
  if Assigned(Field) then
  begin
    Alignment := Field.Alignment;
    Value := Field.DisplayText;
  end;
  WriteText(Canvas, Rect, 2, 2, Value, Alignment,
    UseRightToLeftAlignmentForField(Field, Alignment));
end;

procedure TCustomDBGrid.DefaultDrawColumnCell(const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  Value: string;
begin
  Value := '';
  if Assigned(Column.Field) then
    Value := Column.Field.DisplayText;
  Canvas.FillRect(Rect);
  WriteText(Canvas, Rect, 2, 2, Value, Column.Alignment,
    UseRightToLeftAlignmentForField(Column.Field, Column.Alignment));
end;

procedure TCustomDBGrid.ReadColumns(Reader: TReader);
begin
  Columns.Clear;
  Reader.ReadValue;
  Reader.ReadCollection(Columns);
end;

procedure TCustomDBGrid.WriteColumns(Writer: TWriter);
begin
  if Columns.State = csCustomized then
    Writer.WriteCollection(Columns)
  else  // ancestor state is customized, ours is not
    Writer.WriteCollection(nil);
end;

procedure TCustomDBGrid.DefineProperties(Filer: TFiler);
var
  StoreIt: Boolean;
  vState: TDBGridColumnsState;
begin
  vState := Columns.State;
  if Filer.Ancestor = nil then
    StoreIt := vState = csCustomized
  else
    if vState <> TCustomDBGrid(Filer.Ancestor).Columns.State then
      StoreIt := True
    else
      StoreIt := (vState = csCustomized) and
        (not CollectionsEqual(Columns, TCustomDBGrid(Filer.Ancestor).Columns, Self, TCustomDBGrid(Filer.Ancestor)));

  Filer.DefineProperty('Columns', ReadColumns, WriteColumns, StoreIt);  {do not localize }
end;

function TCustomDBGrid.ColumnAtDepth(Col: TColumn; ADepth: Integer): TColumn;
begin
  Result := Col;
  while (Result <> nil) and (Result.Depth > ADepth) do
    Result := Result.ParentColumn;
end;

function TCustomDBGrid.CalcTitleRect(Col: TColumn; ARow: Integer;
  var MasterCol: TColumn): TRect;
var
  I,J: Integer;
  DrawInfo: TGridDrawInfo;
begin
  MasterCol := ColumnAtDepth(Col, ARow);
  if MasterCol = nil then Exit;

  I := DataToRawColumn(MasterCol.Index);
  if I >= LeftCol then
    J := MasterCol.Depth
  else
  begin
    I := LeftCol;
    if Col.Depth > ARow then
      J := ARow
    else
      J := Col.Depth;
  end;

  Result := CellRect(I, J);

  for I := Col.Index to Columns.Count-1 do
  begin
    if ColumnAtDepth(Columns[I], ARow) <> MasterCol then Break;
    J := CellRect(DataToRawColumn(I), ARow).Right;
    if J = 0 then Break;
    Result.Right := Max(Result.Right, J);
  end;
  J := Col.Depth;
  if (J <= ARow) and (J < FixedRows-1) then
  begin
    CalcFixedInfo(DrawInfo);
    Result.Bottom := DrawInfo.Vert.FixedBoundary - DrawInfo.Vert.EffectiveLineWidth + BorderSize;
  end;
end;

procedure TCustomDBGrid.DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState);
var
  FrameOffs: Byte;

  function RowIsMultiSelected: Boolean;
  var
    Index: Integer;
  begin
    Result := (dgMultiSelect in Options) and Datalink.Active and
      FBookmarks.Find(Datalink.Datasource.Dataset.Bookmark, Index);
  end;

  procedure DrawTitleCell(ACol, ARow: Integer; Column: TColumn; var AState: TGridDrawState);
  const
    ScrollArrows: array [Boolean] of ArrowType =
      (ArrowType_RightArrow, ArrowType_LeftArrow);
  var
    MasterCol: TColumn;
    TitleRect, TextRect, ButtonRect: TRect;
    I: Integer;
    Style: QStyleH;
    cg: QColorGroupH;
  begin
    TitleRect := CalcTitleRect(Column, ARow, MasterCol);

    if MasterCol = nil then
    begin
      Canvas.FillRect(ARect);
      Exit;
    end;

    Canvas.Font := MasterCol.Title.Font;
    Canvas.Brush.Color := MasterCol.Title.Color;
    Canvas.Brush.Style := bsSolid;
    if [dgRowLines, dgColLines] * Options = [dgRowLines, dgColLines] then
      InflateRect(TitleRect, -1, -1);
    TextRect := TitleRect;
    I := CXHSCROLL;
    if ((TextRect.Right - TextRect.Left) > I) and MasterCol.Expandable then
    begin
      Dec(TextRect.Right, I);
      ButtonRect := TitleRect;
      ButtonRect.Left := TextRect.Right;
      Canvas.FillRect(ButtonRect);
      InflateRect(ButtonRect, -1, -1);
      Style := QApplication_style;
      if Enabled then
        cg := Palette.ColorGroup(cgActive)
      else
        cg := Palette.ColorGroup(cgDisabled);
      with ButtonRect do
      QStyle_drawArrow(Style, Canvas.Handle, ScrollArrows[MasterCol.Expanded], false,
        Left, Top, Right - Left, Bottom - Top, cg, True, nil);
  end;
    Canvas.FillRect(TextRect);
    with MasterCol.Title do
      WriteText(Canvas, TextRect, FrameOffs, FrameOffs, Caption, Alignment,
        IsRightToLeft);
    if [dgRowLines, dgColLines] * Options = [dgRowLines, dgColLines] then
    begin
      InflateRect(TitleRect, 2, 2);
      DrawEdge(Canvas, TitleRect, esRaised, esNone, [ebBottom, ebRight]);
      DrawEdge(Canvas, TitleRect, esRaised, esNone, [ebTop, ebLeft]);
    end;
    AState := AState - [gdFixed];  // prevent box drawing later
  end;

var
  OldActive: Integer;
  Indicator: Integer;
  Highlight: Boolean;
  Value: string;
  DrawColumn: TColumn;
  MultiSelected: Boolean;
  ALeft: Integer;
begin
  if (csLoading in ComponentState) then
  begin
    Canvas.Brush.Color := Color;
    Canvas.FillRect(ARect);
    Exit;
  end;

  Dec(ARow, FTitleOffset);
  Dec(ACol, FIndicatorOffset);

  if (gdFixed in AState) and ([dgRowLines, dgColLines] * Options =
    [dgRowLines, dgColLines]) then
  begin
    InflateRect(ARect, -1, -1);
    FrameOffs := 1;
  end
  else
    FrameOffs := 2;

  if (gdFixed in AState) and (ACol < 0) then
  begin
    Canvas.Brush.Color := FixedColor;
    Canvas.Brush.Style := bsSolid;
    Canvas.FillRect(ARect);
    if Assigned(DataLink) and DataLink.Active  then
    begin
      MultiSelected := False;
      if ARow >= 0 then
      begin
        OldActive := FDataLink.ActiveRecord;
        try
          FDatalink.ActiveRecord := ARow;
          MultiSelected := RowIsMultiselected;
        finally
          FDatalink.ActiveRecord := OldActive;
        end;
      end;
      if (ARow = FDataLink.ActiveRecord) or MultiSelected then
      begin
        Indicator := 0;
        if FDataLink.DataSet <> nil then
          case FDataLink.DataSet.State of
            dsEdit: Indicator := 1;
            dsInsert: Indicator := 2;
            dsBrowse:
              if MultiSelected then
                if (ARow <> FDatalink.ActiveRecord) then
                  Indicator := 3
                else
                  Indicator := 4;  // multiselected and current row
          end;
        FIndicators.BkColor := FixedColor;
        ALeft := ARect.Right - FIndicators.Width - FrameOffs;
        Canvas.Pen.Color := clBlack;
        FIndicators.Draw(Canvas, ALeft,
          (ARect.Top + ARect.Bottom - FIndicators.Height) shr 1, Indicator, itImage, True);
        if ARow = FDatalink.ActiveRecord then
          FSelRow := ARow + FTitleOffset;
      end;
    end;
  end
  else with Canvas do
  begin
    DrawColumn := Columns[ACol];
    if not DrawColumn.Showing then Exit;
    if not (gdFixed in AState) then
    begin
      Font := DrawColumn.Font;
      Brush.Color := DrawColumn.Color;
    end;
    if ARow < 0 then
      DrawTitleCell(ACol, ARow + FTitleOffset, DrawColumn, AState)
    else if (FDataLink = nil) or not FDataLink.Active then
      FillRect(ARect)
    else
    begin
      Value := '';
      OldActive := FDataLink.ActiveRecord;
      try
        FDataLink.ActiveRecord := ARow;
        if Assigned(DrawColumn.Field) then
          Value := DrawColumn.Field.DisplayText;
        Highlight := HighlightCell(ACol, ARow, Value, AState);
        if Highlight then
        begin
          Brush.Color := clHighlight;
          Font.Color := clHighlightText;
        end;
        if not Enabled then
          Font.Color := clGrayText;
        if FDefaultDrawing then begin
          Canvas.Brush.Style := bsSolid;
          Canvas.FillRect(ARect);
          WriteText(Canvas, ARect, 2, 2, Value, DrawColumn.Alignment,
            UseRightToLeftAlignmentForField(DrawColumn.Field, DrawColumn.Alignment));
        end;
        if Columns.State = csDefault then
          DrawDataCell(ARect, DrawColumn.Field, AState);
        DrawColumnCell(ARect, ACol, DrawColumn, AState);
      finally
        FDataLink.ActiveRecord := OldActive;
      end;
      if FDefaultDrawing and (gdSelected in AState)
        and ((dgAlwaysShowSelection in Options) or Focused)
        and not (csDesigning in ComponentState)
        and not (dgRowSelect in Options)
        and (UpdateLock = 0)
        and ((Owner is TSubGridForm) or (ValidParentForm(Self).ActiveControl = Self)) then
        Canvas.DrawFocusRect(ARect);
    end;
  end;
  if (gdFixed in AState) and ([dgRowLines, dgColLines] * Options =
    [dgRowLines, dgColLines]) then
  begin
    InflateRect(ARect, 2, 2);
    DrawEdge(Canvas, ARect, esRaised, esNone, [ebBottom, ebRight]);
    DrawEdge(Canvas, ARect, esRaised, esNone, [ebTop, ebLEft]);
  end;
end;

procedure TCustomDBGrid.DrawDataCell(const Rect: TRect; Field: TField;
  State: TGridDrawState);
begin
  if Assigned(FOnDrawDataCell) then FOnDrawDataCell(Self, Rect, Field, State);
end;

procedure TCustomDBGrid.DrawColumnCell(const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState);
begin
  if Assigned(OnDrawColumnCell) then
    OnDrawColumnCell(Self, Rect, DataCol, Column, State);
end;

procedure TCustomDBGrid.EditButtonClick;
begin
  if Assigned(FOnEditButtonClick) then
    FOnEditButtonClick(Self)
  else
    ShowPopupEditor(Columns[SelectedIndex]);
end;

procedure TCustomDBGrid.EditingChanged;
begin
  if dgIndicator in Options then InvalidateCell(0, FSelRow);
end;

procedure TCustomDBGrid.EndLayout;
begin
  if FLayoutLock > 0 then
  begin
    try
      try
        if FLayoutLock = 1 then
          InternalLayout;
      finally
        if FLayoutLock = 1 then
          FColumns.EndUpdate;
      end;
    finally
      Dec(FLayoutLock);
      EndUpdate;
    end;
  end;
end;

procedure TCustomDBGrid.EndUpdate;
begin
  if FUpdateLock > 0 then
    Dec(FUpdateLock);
end;

function TCustomDBGrid.GetColField(DataCol: Integer): TField;
begin
  Result := nil;
  if (DataCol >= 0) and FDatalink.Active and (DataCol < Columns.Count) then
    Result := Columns[DataCol].Field;
end;

function TCustomDBGrid.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TCustomDBGrid.GetEditLimit: Integer;
begin
  Result := 0;
  if Assigned(SelectedField) and not SelectedField.IsBlob then
      Result := SelectedField.DisplayWidth;
end;

function TCustomDBGrid.GetEditMask(ACol, ARow: Longint): WideString;
begin
  Result := '';
  if FDatalink.Active then
  with Columns[RawToDataColumn(ACol)] do
    if Assigned(Field) then
      Result := Field.EditMask;
end;

function TCustomDBGrid.GetEditText(ACol, ARow: Longint): WideString;
begin
  Result := '';
  if FDatalink.Active then
  with Columns[RawToDataColumn(ACol)] do
    if Assigned(Field) then
      Result := Field.Text;
end;

function TCustomDBGrid.GetFieldCount: Integer;
begin
  Result := FDatalink.FieldCount;
end;

function TCustomDBGrid.GetFields(FieldIndex: Integer): TField;
begin
  Result := FDatalink.Fields[FieldIndex];
end;

function TCustomDBGrid.GetFieldValue(ACol: Integer): string;
var
  Field: TField;
begin
  Result := '';
  Field := GetColField(ACol);
  if Field <> nil then Result := Field.DisplayText;
end;

function TCustomDBGrid.GetSelectedField: TField;
var
  Index: Integer;
begin
  Index := SelectedIndex;
  if Index <> -1 then
    Result := Columns[Index].Field
  else
    Result := nil;
end;

function TCustomDBGrid.GetSelectedIndex: Integer;
begin
  Result := RawToDataColumn(Col);
end;

function TCustomDBGrid.HighlightCell(DataCol, DataRow: Integer;
  const Value: string; AState: TGridDrawState): Boolean;
var
  Index: Integer;
begin
  Result := False;
  if (dgMultiSelect in Options) and Datalink.Active then
    Result := FBookmarks.Find(Datalink.Datasource.Dataset.Bookmark, Index);
  if not Result then
    Result := (gdSelected in AState)
      and ((dgAlwaysShowSelection in Options) or Focused)
        { updatelock eliminates flicker when tabbing between rows }
      and ((UpdateLock = 0) or (dgRowSelect in Options));
end;

procedure TCustomDBGrid.KeyDown(var Key: Word; Shift: TShiftState);
var
  KeyDownEvent: TKeyEvent;

  procedure ClearSelection;
  begin
    if (dgMultiSelect in Options) then
    begin
      FBookmarks.Clear;
      FSelecting := False;
    end;
  end;

  procedure DoSelection(Select: Boolean; Direction: Integer);
  var
    AddAfter: Boolean;
  begin
    AddAfter := False;
    BeginUpdate;
    try
      if (dgMultiSelect in Options) and FDatalink.Active then
        if Select and (ssShift in Shift) then
        begin
          if not FSelecting then
          begin
            FSelectionAnchor := FBookmarks.CurrentRow;
            FBookmarks.CurrentRowSelected := True;
            FSelecting := True;
            AddAfter := True;
          end
          else
          with FBookmarks do
          begin
            AddAfter := Compare(CurrentRow, FSelectionAnchor) <> -Direction;
            if not AddAfter then
              CurrentRowSelected := False;
          end
        end
        else
          ClearSelection;
      FDatalink.MoveBy(Direction);
      if AddAfter then FBookmarks.CurrentRowSelected := True;
    finally
      EndUpdate;
    end;
  end;

  procedure NextRow(Select: Boolean);
  begin
    with FDatalink.Dataset do
    begin
      if (State = dsInsert) and not Modified and not FDatalink.FModified then
        if FDataLink.EOF then Exit else Cancel
      else
        DoSelection(Select, 1);
      if FDataLink.EOF and CanModify and (not ReadOnly) and (dgEditing in Options) then
        Append;
    end;
  end;

  procedure PriorRow(Select: Boolean);
  begin
    with FDatalink.Dataset do
      if (State = dsInsert) and not Modified and FDataLink.EOF and
        not FDatalink.FModified then
        Cancel
      else
        DoSelection(Select, -1);
  end;

  procedure Tab(GoForward: Boolean);
  var
    ACol, Original: Integer;
  begin
    ACol := Col;
    Original := ACol;
    BeginUpdate;    { Prevent highlight flicker on tab to next/prior row }
    try
      while True do
      begin
        if GoForward then
          Inc(ACol) else
          Dec(ACol);
        if ACol >= ColCount then
        begin
          NextRow(False);
          ACol := FIndicatorOffset;
        end
        else if ACol < FIndicatorOffset then
        begin
          PriorRow(False);
          ACol := ColCount - FIndicatorOffset;
        end;
        if ACol = Original then Exit;
        if TabStops[ACol] then
        begin
          MoveCol(ACol, 0);
          Exit;
        end;
      end;
    finally
      EndUpdate;
    end;
  end;

  function DeletePrompt: Boolean;
  var
    Msg: string;
  begin
    if (FBookmarks.Count > 1) then
      Msg := SDeleteMultipleRecordsQuestion
    else
      Msg := SDeleteRecordQuestion;
    Result := not (dgConfirmDelete in Options) or
      (MessageDlg(SConfirmCaption, Msg, mtCustom, mbOKCancel, 0, -1, -1) = 1);
  end;

begin
  KeyDownEvent := OnKeyDown;
  if Assigned(KeyDownEvent) then KeyDownEvent(Self, Key, Shift);
  if not FDatalink.Active or not CanGridAcceptKey(Key, Shift) then Exit;
  if UseRightToLeftAlignment then
    if Key = Key_Left then
      Key := Key_Right
    else if Key = Key_Right then
      Key := Key_Left;
  with FDatalink.DataSet do
    if ssCtrl in Shift then
    begin
      if (Key = Key_Up) or (Key = Key_Prior)
         or (Key = Key_Down) or (Key = Key_Next)
         or (Key = Key_Home) or (Key = Key_End) then ClearSelection;
      case Key of
        Key_Up, Key_Prior: FDataLink.MoveBy(-FDatalink.ActiveRecord);
        Key_Down, Key_Next: FDataLink.MoveBy(FDatalink.BufferCount - FDatalink.ActiveRecord - 1);
        Key_Left: MoveCol(FIndicatorOffset, 1);
        Key_Right: MoveCol(ColCount - 1, -1);
        Key_Home: First;
        Key_End: Last;
        Key_Delete:
          if (not ReadOnly) and not IsEmpty
            and CanModify and DeletePrompt then
          if FBookmarks.Count > 0 then
            FBookmarks.Delete
          else
            Delete;
      end
    end
    else
      case Key of
        Key_Up: PriorRow(True);
        Key_Down: NextRow(True);
        Key_Left:
          if dgRowSelect in Options then
            PriorRow(False) else
            MoveCol(Col - 1, -1);
        Key_Right:
          if dgRowSelect in Options then
            NextRow(False) else
            MoveCol(Col + 1, 1);
        Key_Home:
          if (ColCount = FIndicatorOffset+1)
            or (dgRowSelect in Options) then
          begin
            ClearSelection;
            First;
          end
          else
            MoveCol(FIndicatorOffset, 1);
        Key_End:
          if (ColCount = FIndicatorOffset+1)
            or (dgRowSelect in Options) then
          begin
            ClearSelection;
            Last;
          end
          else
            MoveCol(ColCount - 1, -1);
        Key_Next:
          begin
            ClearSelection;
            FDataLink.MoveBy(VisibleRowCount);
          end;
        Key_Prior:
          begin
            ClearSelection;
            FDataLink.MoveBy(-VisibleRowCount);
          end;
        Key_Insert:
          if CanModify and (not ReadOnly) and (dgEditing in Options) then
          begin
            ClearSelection;
            Insert;
          end;
        Key_Tab,
        Key_Backtab: if not (ssAlt in Shift) then Tab(not (ssShift in Shift));
        Key_Escape:
          begin
            FDatalink.Reset;
            ClearSelection;
            if not (dgAlwaysShowEditor in Options) then HideEditor;
          end;
        Key_F2: EditorMode := True;
      end;
end;

procedure TCustomDBGrid.GridKeyPress(var Key: Char);
begin
  FIsESCKey := False;
  if not (dgAlwaysShowEditor in Options) and (Key = #13) then
    FDatalink.UpdateData;
  inherited GridKeyPress(Key);
end;

{ InternalLayout is called with layout locks and column locks in effect }
procedure TCustomDBGrid.InternalLayout;

  function FieldIsMapped(F: TField): Boolean;
  var
    X: Integer;
  begin
    Result := False;
    if F = nil then Exit;
    for X := 0 to FDatalink.FieldCount-1 do
      if FDatalink.Fields[X] = F then
      begin
        Result := True;
        Exit;
      end;
  end;

  procedure CheckForPassthroughs;  // check for Columns.State flip-flop
  var
    SeenPassthrough: Boolean;
    I, J: Integer;
    Column: TColumn;
  begin
    SeenPassthrough := False;
    for I := 0 to FColumns.Count-1 do
      if not FColumns[I].IsStored then
        SeenPassthrough := True
      else if SeenPassthrough then
      begin  // we have both persistent and non-persistent columns.  Kill the latter
        for J := FColumns.Count-1 downto 0 do
        begin
          Column := FColumns[J];
          if not Column.IsStored then
            Column.Free;
        end;
        Exit;
      end;
  end;

  procedure ResetColumnFieldBindings;
  var
    I, J, K: Integer;
    Fld: TField;
    Column: TColumn;
  begin
    if FColumns.State = csDefault then
    begin
       { Destroy columns whose fields have been destroyed or are no longer
         in field map }
      if (not FDataLink.Active) and (FDatalink.DefaultFields) then
        FColumns.Clear
      else
        for J := FColumns.Count-1 downto 0 do
          with FColumns[J] do
          if not Assigned(Field)
            or not FieldIsMapped(Field) then Free;
      I := FDataLink.FieldCount;
      if (I = 0) and (FColumns.Count = 0) then Inc(I);
      for J := 0 to I-1 do
      begin
        Fld := FDatalink.Fields[J];
        if Assigned(Fld) then
        begin
          K := J;
           { Pointer compare is valid here because the grid sets matching
             column.field properties to nil in response to field object
             free notifications.  Closing a dataset that has only default
             field objects will destroy all the fields and set associated
             column.field props to nil. }
          while (K < FColumns.Count) and (FColumns[K].Field <> Fld) do
            Inc(K);
          if K < FColumns.Count then
            Column := FColumns[K]
          else
          begin
            Column := FColumns.InternalAdd;
            Column.Field := Fld;
          end;
        end
        else
          Column := FColumns.InternalAdd;
        Column.Index := J;
      end;
    end
    else
    begin
      { Force columns to reaquire fields (in case dataset has changed) }
      for I := 0 to FColumns.Count-1 do
        FColumns[I].Field := nil;
    end;
  end;

  procedure MeasureTitleHeights;
  var
    I, J, K, D, B: Integer;
    Heights: array of Integer;
  begin
    Canvas.Font := Font;
    K := Canvas.TextHeight('Wg') + 3;
    if dgRowLines in Options then
      Inc(K, GridLineWidth);
    DefaultRowHeight := K;
    B := CYHSCROLL;
    if dgTitles in Options then
    begin
      SetLength(Heights, FTitleOffset+1);
      for I := 0 to FColumns.Count-1 do
      begin
        Canvas.Font := FColumns[I].Title.Font;
        D := FColumns[I].Depth;
        if D <= High(Heights) then
        begin
          J := Canvas.TextHeight('Wg') + 4;
          if FColumns[I].Expandable and (B > J) then
            J := B;
          Heights[D] := Max(J, Heights[D]);
        end;
      end;
      if Heights[0] = 0 then
      begin
        Canvas.Font := FTitleFont;
        Heights[0] := Canvas.TextHeight('Wg') + 4;
      end;
      for I := 0 to High(Heights)-1 do
        RowHeights[I] := Heights[I];
    end;
  end;

var
  I, J: Integer;
begin
  if ([csLoading, csDestroying] * ComponentState) <> [] then Exit;

  CheckForPassthroughs;
  FIndicatorOffset := 0;
  if dgIndicator in Options then
    Inc(FIndicatorOffset);
  FDatalink.ClearMapping;
  if FDatalink.Active then DefineFieldMap;
  ResetColumnFieldBindings;
  FVisibleColumns.Clear;
  for I := 0 to FColumns.Count-1 do
    if FColumns[I].Showing then FVisibleColumns.Add(FColumns[I]);
  ColCount := FColumns.Count + FIndicatorOffset;
  inherited FixedCols := FIndicatorOffset;
  FTitleOffset := 0;
  if dgTitles in Options then
  begin
    FTitleOffset := 1;
    if (FDatalink <> nil) and (FDatalink.Dataset <> nil)
      and FDatalink.Dataset.ObjectView then
    begin
      for I := 0 to FColumns.Count-1 do
      begin
        if FColumns[I].Showing then
        begin
          J := FColumns[I].Depth;
          if J >= FTitleOffset then FTitleOffset := J+1;
        end;
      end;
      if FTitleOffset > 1 then RowCount := RowCount + FTitleOffset - 1;
    end;
  end;
  MeasureTitleHeights;
  SetColumnAttributes;
  UpdateScrollBars;
  UpdateRowCount;
  UpdateScrollBars;
  UpdateActive;
  Invalidate;
end;

procedure TCustomDBGrid.LayoutChanged;
begin
  if AcquireLayoutLock then
    EndLayout;
end;

procedure TCustomDBGrid.LinkActive(Value: Boolean);
var
  Comp: TComponent;
  I: Integer;
begin
  if not Value then HideEditor;
  FBookmarks.LinkActive(Value);
  try
    LayoutChanged;
  finally
    for I := ComponentCount-1 downto 0 do
    begin
      Comp := Components[I];   // Free all the popped-up subgrids
      if (Comp is TSubGridForm) then
        Comp.Free;
    end;
    UpdateScrollBar;
    if Value and (dgAlwaysShowEditor in Options) then ShowEditor;
  end;
end;

procedure TCustomDBGrid.Loaded;
begin
  inherited Loaded;
  if FColumns.Count > 0 then
    ColCount := FColumns.Count;
  LayoutChanged;
end;

function TCustomDBGrid.PtInExpandButton(X,Y: Integer; var MasterCol: TColumn): Boolean;
var
  Cell: TGridCoord;
  R: TRect;
begin
  MasterCol := nil;
  Result := False;
  Cell := MouseCoord(X,Y);
  if (Cell.Y < FTitleOffset) and FDatalink.Active
    and (Cell.X >= FIndicatorOffset)
    and (RawToDataColumn(Cell.X) < Columns.Count) then
  begin
    R := CalcTitleRect(Columns[RawToDataColumn(Cell.X)], Cell.Y, MasterCol);
    if not UseRightToLeftAlignment then
      R.Left := R.Right - CXHSCROLL
    else
      R.Right := R.Left + CXHSCROLL;
    Result := MasterCol.Expandable and PtInRect(R, Point(X,Y));
  end;
end;

procedure TCustomDBGrid.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  Cell: TGridCoord;
  OldCol,OldRow: Integer;
  MasterCol: TColumn;
begin
  if not AcquireFocus then Exit;
  if (ssDouble in Shift) and (Button = mbLeft) then
  begin
    DblClick;
    Exit;
  end;

  if Sizing(X, Y) then
  begin
    FDatalink.UpdateData;
    inherited MouseDown(Button, Shift, X, Y);
    Exit;
  end;

  Cell := MouseCoord(X, Y);
  if (Cell.X < 0) and (Cell.Y < 0) then
  begin
    inherited MouseDown(Button, Shift, X, Y);
    Exit;
  end;

  if PtInExpandButton(X,Y, MasterCol) then
  begin
    MasterCol.Expanded := not MasterCol.Expanded;
    SetMouseGrabControl(nil);
    UpdateDesigner;
    Exit;
  end;

  if ((csDesigning in ComponentState) or (dgColumnResize in Options)) and
    (Cell.Y < FTitleOffset) then
  begin
    FDataLink.UpdateData;
    inherited MouseDown(Button, Shift, X, Y);
    Exit;
  end;

  if FDatalink.Active then
    with Cell do
    begin
      BeginUpdate;   { eliminates highlight flicker when selection moves }
      try
        FDatalink.UpdateData; // validate before moving
        HideEditor;
        OldCol := Col;
        OldRow := Row;
        if (Y >= FTitleOffset) and (Y - Row <> 0) then
          FDatalink.MoveBy(Y - Row);
        if X >= FIndicatorOffset then
          MoveCol(X, 0);
        if (dgMultiSelect in Options) and FDatalink.Active then
          with FBookmarks do
          begin
            FSelecting := False;
            if ssCtrl in Shift then
              CurrentRowSelected := not CurrentRowSelected
            else
            begin
              Clear;
              if dgIndicator in Options then
                InvalidateCol(0);
              CurrentRowSelected := True;
            end;
          end;
        if (Button = mbLeft) and
          (((X = OldCol) and (Y = OldRow)) or (dgAlwaysShowEditor in Options)) then
          ShowEditor         { put grid in edit mode }
        else
          InvalidateEditor;  { draw editor, if needed }
      finally
        EndUpdate;
      end;
    end;
end;

procedure TCustomDBGrid.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  Cell: TGridCoord;
  SaveState: TGridState;
begin
  SaveState := FGridState;
  inherited MouseUp(Button, Shift, X, Y);
  if (SaveState = gsRowSizing) or (SaveState = gsColSizing) or
    ((InplaceEditor <> nil) and (InplaceEditor.Visible) and
     (PtInRect(InplaceEditor.BoundsRect, Point(X,Y)))) then Exit;
  Cell := MouseCoord(X,Y);
  if (Button = mbLeft) and (Cell.X >= FIndicatorOffset) and (Cell.Y >= 0) then
    if Cell.Y < FTitleOffset then
      TitleClick(Columns[RawToDataColumn(Cell.X)])
    else
      CellClick(Columns[SelectedIndex]);
end;

procedure TCustomDBGrid.MoveCol(RawCol, Direction: Integer);
var
  OldCol: Integer;
begin
  FDatalink.UpdateData;
  if RawCol >= ColCount then
    RawCol := ColCount - 1;
  if RawCol < FIndicatorOffset then RawCol := FIndicatorOffset;
  if Direction <> 0 then
  begin
    while (RawCol < ColCount) and (RawCol >= FIndicatorOffset) and
      (ColWidths[RawCol] <= 0) do
      Inc(RawCol, Direction);
    if (RawCol >= ColCount) or (RawCol < FIndicatorOffset) then Exit;
  end;
  OldCol := Col;
  if RawCol <> OldCol then
  begin
    if not FInColExit then
    begin
      FInColExit := True;
      try
        ColExit;
      finally
        FInColExit := False;
      end;
      if Col <> OldCol then Exit;
    end;
    if not (dgAlwaysShowEditor in Options) then HideEditor;
    Col := RawCol;
    ColEnter;
  end;
end;

procedure TCustomDBGrid.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  I: Integer;
  NeedLayout: Boolean;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if (AComponent is TPopupMenu) then
    begin
      for I := 0 to Columns.Count-1 do
        if Columns[I].PopupMenu = AComponent then
          Columns[I].PopupMenu := nil;
    end
    else if (FDataLink <> nil) then
      if (AComponent = DataSource)  then
        DataSource := nil
      else if (AComponent is TField) then
      begin
        NeedLayout := False;
        BeginLayout;
        try
          for I := 0 to Columns.Count-1 do
            with Columns[I] do
              if Field = AComponent then
              begin
                Field := nil;
                NeedLayout := True;
              end;
        finally
          if NeedLayout and Assigned(FDatalink.Dataset)
            and not (csDestroying in FDatalink.DataSet.ComponentState) 
            and not FDatalink.Dataset.ControlsDisabled then
            EndLayout
          else
            DeferLayout;
        end;
      end;
  end;
end;

procedure TCustomDBGrid.RecordChanged(Field: TField);
var
  I: Integer;
  CField: TField;
begin
  if not HandleAllocated or FDatasetLocked then Exit;
  if Field = nil then
    Invalidate
  else
  begin
    for I := 0 to Columns.Count - 1 do
      if Columns[I].Field = Field then
        InvalidateCol(DataToRawColumn(I));
  end;
  CField := SelectedField;
  if ((Field = nil) or (CField = Field)) and
    (Assigned(CField) and (CField.Text <> GetInPlaceEditText)) then
  begin
    InvalidateEditor;
    if InplaceEditor <> nil then InplaceEditor.Deselect;
  end;
end;

procedure TCustomDBGrid.Scroll(Distance: Integer);
var
  OldRect, NewRect: TRect;
  RowHeight: Integer;
begin
  if not HandleAllocated then Exit;
  OldRect := BoxRect(0, Row - 1, 0, Row);
  if (FDataLink.ActiveRecord >= RowCount - FTitleOffset) then
  begin
    UpdateRowCount;
    UpdateScrollBars;
  end;
  UpdateScrollBar;
  UpdateActive;
  if Distance <> 0 then
  begin
    HideEditor;
    try
      if Abs(Distance) > VisibleRowCount then
      begin
        Invalidate;
        Exit;
      end
      else
      begin
        RowHeight := DefaultRowHeight;
        if dgRowLines in Options then Inc(RowHeight, GridLineWidth);
        OldRect := BoxRect(0, FDataLink.ActiveRecord - Distance, ColCount - 1, FDataLink.ActiveRecord - Distance);
        InvalidateRect(OldRect, False);
        NewRect := BoxRect(0, FTitleOffset, ColCount - 1, 1000);
        QWidget_Scroll(Handle, 0, -RowHeight * Distance, @NewRect);
        if dgIndicator in Options then
        begin
          NewRect := BoxRect(0, Row - 1, ColCount - 1, Row);
          InvalidateRect(NewRect, False);
        end;
      end;
    finally
      if dgAlwaysShowEditor in Options then ShowEditor;
    end;
  end
  else if dgIndicator in Options then
  begin
    NewRect := BoxRect(0, Row - 1, 0, Row);
    InvalidateRect(OldRect, False);
    InvalidateRect(NewRect, False);
  end;
  if UpdateLock = 0 then Update;
end;

procedure TCustomDBGrid.SetColumns(Value: TDBGridColumns);
begin
  Columns.Assign(Value);
end;

function ReadOnlyField(Field: TField): Boolean;
var
  MasterField: TField;
begin
  Result := Field.ReadOnly;
  if not Result and (Field.FieldKind = fkLookup) then
  begin
    Result := True;
    if Field.DataSet = nil then Exit;
    MasterField := Field.Dataset.FindField(Field.KeyFields);
    if MasterField = nil then Exit;
    Result := MasterField.ReadOnly;
  end;
end;

procedure TCustomDBGrid.SetColumnAttributes;
var
  I: Integer;
begin
  for I := 0 to FColumns.Count-1 do
  with FColumns[I] do
  begin
    TabStops[I + FIndicatorOffset] := Showing and not ReadOnly and DataLink.Active and
      Assigned(Field) and not (Field.FieldKind = fkCalculated) and not ReadOnlyField(Field);
    ColWidths[I + FIndicatorOffset] := Width;
  end;
  if (dgIndicator in Options) then
    ColWidths[0] := IndicatorWidth;
end;

procedure TCustomDBGrid.SetDataSource(Value: TDataSource);
begin
  if Value = FDatalink.Datasource then Exit;
  if Assigned(Value) then
    if Assigned(Value.DataSet) then
      if Value.DataSet.IsUnidirectional then
        DatabaseError(SDataSetUnidirectional);
  FBookmarks.Clear;
  FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TCustomDBGrid.SetEditText(ACol, ARow: Longint; const Value: WideString);
begin
  InplaceEditor.Text := Value;
end;

procedure TCustomDBGrid.SetOptions(Value: TDBGridOptions);
const
  LayoutOptions = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator,
    dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection];
var
  NewGridOptions: TGridOptions;
  ChangedOptions: TDBGridOptions;
begin
  if FOptions <> Value then
  begin
    NewGridOptions := [];
    if dgColLines in Value then
      NewGridOptions := NewGridOptions + [goFixedVertLine, goVertLine];
    if dgRowLines in Value then
      NewGridOptions := NewGridOptions + [goFixedHorzLine, goHorzLine];
    if dgColumnResize in Value then
      NewGridOptions := NewGridOptions + [goColSizing, goColMoving];
    if dgTabs in Value then Include(NewGridOptions, goTabs);
    if dgRowSelect in Value then
    begin
      Include(NewGridOptions, goRowSelect);
      Exclude(Value, dgAlwaysShowEditor);
      Exclude(Value, dgEditing);
    end;
    if dgEditing in Value then Include(NewGridOptions, goEditing);
    inherited Options := NewGridOptions;
    if dgMultiSelect in (FOptions - Value) then FBookmarks.Clear;
    ChangedOptions := (FOptions + Value) - (FOptions * Value);
    FOptions := Value;
    if ChangedOptions * LayoutOptions <> [] then LayoutChanged;
    if dgAlwaysShowEditor in Value then begin
      Include(NewGridOptions, goAlwaysShowEditor);
      inherited Options := NewGridOptions;
    end;
  end;
end;

procedure TCustomDBGrid.SetSelectedField(Value: TField);
var
  I: Integer;
begin
  if Value = nil then Exit;
  for I := 0 to Columns.Count - 1 do
    if Columns[I].Field = Value then
      MoveCol(DataToRawColumn(I), 0);
end;

procedure TCustomDBGrid.SetSelectedIndex(Value: Integer);
begin
  MoveCol(DataToRawColumn(Value), 0);
end;

procedure TCustomDBGrid.SetTitleFont(Value: TFont);
begin
  FTitleFont.Assign(Value);
  if dgTitles in Options then LayoutChanged;
end;

function TCustomDBGrid.StoreColumns: Boolean;
begin
  Result := Columns.State = csCustomized;
end;

procedure TCustomDBGrid.TimedScroll(Direction: TGridScrollDirection);
begin
  if FDatalink.Active then
  begin
    with FDatalink do
    begin
      if sdUp in Direction then
      begin
        FDataLink.MoveBy(-ActiveRecord - 1);
        Exclude(Direction, sdUp);
      end;
      if sdDown in Direction then
      begin
        FDataLink.MoveBy(RecordCount - ActiveRecord);
        Exclude(Direction, sdDown);
      end;
    end;
    if Direction <> [] then inherited TimedScroll(Direction);
  end;
end;

procedure TCustomDBGrid.TitleClick(Column: TColumn);
begin
  if Assigned(FOnTitleClick) then FOnTitleClick(Column);
end;

procedure TCustomDBGrid.TitleFontChanged(Sender: TObject);
begin
  if (not FSelfChangingTitleFont) and not (csLoading in ComponentState) then
    ParentFont := False;
  if dgTitles in Options then LayoutChanged;
end;

procedure TCustomDBGrid.UpdateActive;
var
  NewRow: Integer;
  Field: TField;
begin
  if FDatalink.Active and HandleAllocated and not (csLoading in ComponentState) then
  begin
    NewRow := FDatalink.ActiveRecord + FTitleOffset;
    if Row <> NewRow then
    begin
      if not (dgAlwaysShowEditor in Options) then HideEditor;
      MoveColRow(Col, NewRow, False, False);
      InvalidateEditor;
    end;
    Field := SelectedField;
    if Assigned(Field) and (Field.Text <> GetInplaceEditText) then
      InvalidateEditor;
  end;
end;

procedure TCustomDBGrid.UpdateData;
var
  Field: TField;
begin
  FDatasetLocked := True;
  try
    Field := SelectedField;
    if Assigned(Field) then
      Field.Text := GetInplaceEditText;
  finally
    FDatasetLocked := False;
  end;
end;

procedure TCustomDBGrid.UpdateRowCount;
var
  OldRowCount: Integer;
begin
  OldRowCount := RowCount;
  if RowCount <= FTitleOffset then RowCount := FTitleOffset + 1;
  FixedRows := FTitleOffset;
  if Assigned(FDataLink) then
  with FDataLink do
    if not Active or (RecordCount = 0) or not HandleAllocated then
      RowCount := 1 + FTitleOffset
    else
    begin
      RowCount := 1000;
      FDataLink.BufferCount := VisibleRowCount;
      RowCount := RecordCount + FTitleOffset;
      if dgRowSelect in Options then TopRow := FixedRows;
      UpdateActive;
    end;
  if OldRowCount <> RowCount then Invalidate;
end;

procedure TCustomDBGrid.UpdateScrollBar;
begin
  if Assigned(FDataLink) and FDatalink.Active and HandleAllocated then
    with FDatalink.DataSet do
    begin
      if IsSequenced then
      begin
        if RecordCount > 0 then
          if State in [dsInactive, dsBrowse, dsEdit] then
            VScrollBar.SetParams(RecNo, 1, RecordCount)
          else
            VScrollBar.SetParams(1, 1, RecordCount)
        else
          VScrollBar.SetParams(1, 1, 1);
      end
      else
      begin
        if FDataLink.BOF then VScrollBar.SetParams(0, 0, 4)
        else if FDataLink.EOF then VScrollBar.SetParams(4, 0, 4)
        else VScrollBar.SetParams(2, 0, 4);
      end;
    end;
end;

function TCustomDBGrid.ValidFieldIndex(FieldIndex: Integer): Boolean;
begin
  Result := DataLink.GetMappedIndex(FieldIndex) >= 0;
end;

procedure TCustomDBGrid.DeferLayout;
begin
  CancelLayout;
end;

{ Defer action processing to datalink }

function TCustomDBGrid.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := (DataLink <> nil) and DataLink.ExecuteAction(Action);
end;

function TCustomDBGrid.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := (DataLink <> nil) and DataLink.UpdateAction(Action);
end;

procedure TCustomDBGrid.ShowPopupEditor(Column: TColumn; X, Y: Integer);
var
  SubGridForm: TSubGridForm;
  DS: TDataSource;
  I: Integer;
  FloatRect: TRect;
  Cmp: TControl;
begin
  if not ((Column.Field <> nil) and (Column.Field is TDataSetField)) then  Exit;

  // find existing popup for this column field, if any, and show it
  for I := 0 to ComponentCount-1 do
    if Components[I] is TSubGridForm then
    begin
      SubGridForm := TSubGridForm(Components[I]);
      if (SubGridForm.SubGrid.DataSource <> nil) and
        (SubGridForm.SubGrid.DataSource.DataSet = (Column.Field as TDatasetField).NestedDataset) then
      begin
        FloatRect.TopLeft := ClientToScreen(CellRect(Col, Row).BottomRight);
        if X > Low(Integer) then FloatRect.Left := X;
        if Y > Low(Integer) then FloatRect.Top := Y;
        SubGridForm.Top := FloatRect.Top;
        SubGridForm.Left := FloatRect.Left;
        SubGridForm.Visible := False;
        SubGridForm.Show;
        SubGridForm.SubGrid.SetFocus;
        Exit;
      end;
    end;

  // create another instance of this kind of grid
  SubGridForm := TSubGridForm.CreateParented(QApplication_Desktop, Self);
  try
    DS := TDataSource.Create(SubGridForm);
    DS.Dataset := (Column.Field as TDatasetField).NestedDataset;
    DS.DataSet.CheckBrowseMode;
    SubGridForm.SubGrid.DataSource := DS;
    SubGridForm.SubGrid.Columns.State := Columns.State;
    SubGridForm.SubGrid.Columns[0].Expanded := True;
    FloatRect.TopLeft := ClientToScreen(CellRect(Col, Row).BottomRight);
    if X > Low(Integer) then FloatRect.Left := X;
    if Y > Low(Integer) then FloatRect.Top := Y;
    SubGridForm.SubGrid.Parent.SetBounds(FloatRect.Left, FloatRect.Top, Screen.Width div 4, Screen.Height div 4);
    SubGridForm.SubGrid.Align := alClient;
    Cmp := Self;
    while (Cmp <> nil) and (TCustomDBGrid(Cmp).PopupMenu = nil) do
      Cmp := Cmp.Parent;
    if Cmp <> nil then
      SubGridForm.SubGrid.PopupMenu := TCustomDBGrid(Cmp).PopupMenu;
    SubGridForm.SubGrid.TitleFont := TitleFont;
    SubGridForm.SubGrid.Visible := True;
    SubGridForm.Show;
  except
    SubGridForm.Free;
    raise;
  end;
end;

procedure TCustomDBGrid.CalcSizingState(X, Y: Integer;
  var State: TGridState; var Index, SizingPos, SizingOfs: Integer;
  var FixedInfo: TGridDrawInfo);
var
  R: TGridCoord;
begin
  inherited CalcSizingState(X, Y, State, Index, SizingPos, SizingOfs, FixedInfo);
  if (State = gsColSizing) and (FDataLink <> nil)
    and (FDatalink.Dataset <> nil) and FDataLink.Dataset.ObjectView then
  begin
    R := MouseCoord(X, Y);
    R.X := RawToDataColumn(R.X);
    if (R.X >= 0) and (R.X < Columns.Count) and (Columns[R.X].Depth > R.Y) then
      State := gsNormal;
  end;
end;

function TCustomDBGrid.CheckColumnDrag(var Origin, Destination: Integer;
  const MousePt: TPoint): Boolean;
var
  I, ARow: Integer;
  DestCol: TColumn;
begin
  Result := inherited CheckColumnDrag(Origin, Destination, MousePt);
  if Result and (FDatalink.Dataset <> nil) and FDatalink.Dataset.ObjectView then
  begin
    assert(FDragCol <> nil);
    ARow := FDragCol.Depth;
    if Destination <> Origin then
    begin
      DestCol := ColumnAtDepth(Columns[RawToDataColumn(Destination)], ARow);
      if DestCol.ParentColumn <> FDragCol.ParentColumn then
        if Destination < Origin then
          DestCol := Columns[FDragCol.ParentColumn.Index+1]
        else
        begin
          I := DestCol.Index;
          while DestCol.ParentColumn <> FDragCol.ParentColumn do
          begin
            Dec(I);
            DestCol := Columns[I];
          end;
        end;
      if (DestCol.Index > FDragCol.Index) then
      begin
        I := DestCol.Index + 1;
        while (I < Columns.Count) and (ColumnAtDepth(Columns[I],ARow) = DestCol) do
          Inc(I);
        DestCol := Columns[I-1];
      end;
      Destination := DataToRawColumn(DestCol.Index);
    end;
  end;
end;

function TCustomDBGrid.BeginColumnDrag(var Origin, Destination: Integer;
  const MousePt: TPoint): Boolean;
var
  I, ARow: Integer;
begin
  Result := inherited BeginColumnDrag(Origin, Destination, MousePt);
  if Result and (FDatalink.Dataset <> nil) and FDatalink.Dataset.ObjectView then
  begin
    ARow := MouseCoord(MousePt.X, MousePt.Y).Y;
    FDragCol := ColumnAtDepth(Columns[RawToDataColumn(Origin)], ARow);
    if FDragCol = nil then Exit;
    I := DataToRawColumn(FDragCol.Index);
    if Origin <> I then Origin := I;
    Destination := Origin;
  end;
end;

function TCustomDBGrid.EndColumnDrag(var Origin, Destination: Integer;
  const MousePt: TPoint): Boolean;
begin
  Result := inherited EndColumnDrag(Origin, Destination, MousePt);
  FDragCol := nil;
end;

procedure TCustomDBGrid.InvalidateTitles;
var
  R: TRect;
  DrawInfo: TGridDrawInfo;
begin
  if HandleAllocated and (dgTitles in Options) then
  begin
    CalcFixedInfo(DrawInfo);
    R := Rect(0, 0, Width, DrawInfo.Vert.FixedBoundary);
    QWidget_update(Handle, @R);
  end;
end;

procedure TCustomDBGrid.TopLeftChanged;
begin
  InvalidateTitles; 
  inherited TopLeftChanged;
end;

end.