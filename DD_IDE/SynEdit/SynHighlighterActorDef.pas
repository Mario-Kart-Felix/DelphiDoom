{-------------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: SynHighlighterGeneral.pas, released 2000-04-07.
The Original Code is based on the mwGeneralSyn.pas file from the
mwEdit component suite by Martin Waldenburg and other developers, the Initial
Author of this file is Martin Waldenburg.
Portions written by Martin Waldenburg are copyright 1999 Martin Waldenburg.
Unicode translation by Ma�l H�rz.
All Rights Reserved.

Contributors to the SynEdit and mwEdit projects are listed in the
Contributors.txt file.

Alternatively, the contents of this file may be used under the terms of the
GNU General Public License Version 2 or later (the "GPL"), in which case
the provisions of the GPL are applicable instead of those above.
If you wish to allow use of your version of this file only under the terms
of the GPL and not to allow others to use your version of this file
under the MPL, indicate your decision by deleting the provisions above and
replace them with the notice and other provisions required by the GPL.
If you do not delete the provisions above, a recipient may use your version
of this file under either the MPL or the GPL.

$Id: SynHighlighterGeneral.pas,v 1.12 2011/04/14 15:12:54 Egg Exp $

You may retrieve the latest version of this file at the SynEdit home page,
located at http://SynEdit.SourceForge.net

Known Issues:
-------------------------------------------------------------------------------}
{
@abstract(Provides a customizable highlighter for SynEdit)
@author(Martin Waldenburg, converted to SynEdit by Michael Hieke)
@created(1999)
@lastmod(2000-06-23)
The SynHighlighterGeneral unit provides a customizable highlighter for SynEdit.
}

{$IFNDEF QSYNHIGHLIGHTERGENERAL}
unit SynHighlighterActorDef;
{$ENDIF}

{$I SynEdit.inc}

interface

uses
{$IFDEF SYN_CLX}
  QGraphics,
  QSynEditTypes,
  QSynEditHighlighter,
  QSynUnicode,
{$ELSE}
  Windows,
  Graphics,
  SynEditTypes,
  SynEditHighlighter,
  SynUnicode,
{$ENDIF}
  SysUtils,
  Classes;

type
  TtkTokenKind = (tkComment, tkIdentifier, tkKey, tkNull, tkNumber,
    tkPreprocessor, tkSpace, tkString, tkSymbol, tkUnknown);

  TRangeState = (rsANil, rsAnsi, rsPasStyle, rsCStyle, rsUnKnown);

  TStringDelim = (sdSingleQuote, sdDoubleQuote, sdSingleAndDoubleQuote);

  TGetTokenAttributeEvent = procedure (attribute : TSynHighlighterAttributes) of object;

const
   cDefaultIdentChars = '_0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ' +
                         'abcdefghijklmnopqrstuvwxyz';

type
  TSynActordefSyn = class(TSynCustomHighlighter)
  private
    fIdentChars: UnicodeString;
    fRange: TRangeState;
    fTokenID: TtkTokenKind;
    fCommentAttri: TSynHighlighterAttributes;
    fIdentifierAttri: TSynHighlighterAttributes;
    fKeyAttri: TSynHighlighterAttributes;
    fNumberAttri: TSynHighlighterAttributes;
    fPreprocessorAttri: TSynHighlighterAttributes;
    fSpaceAttri: TSynHighlighterAttributes;
    fStringAttri: TSynHighlighterAttributes;
    fSymbolAttri: TSynHighlighterAttributes;
    fKeyWords: TUnicodeStrings;
    fStringDelim: TStringDelim;
    fDetectPreprocessor: Boolean;
    fOnGetTokenAttribute: TGetTokenAttributeEvent;
    procedure AsciiCharProc;
    procedure BraceOpenProc;
    procedure PointCommaProc;
    procedure CRProc;
    procedure IdentProc;
    procedure IntegerProc;
    procedure LFProc;
    procedure NullProc;
    procedure NumberProc;
    procedure RoundOpenProc;
    procedure SlashProc;
    procedure SpaceProc;
    procedure StringProc;
    procedure UnknownProc;
    procedure AnsiProc;
    procedure PasStyleProc;
    procedure CStyleProc;
    procedure SetKeyWords(const Value: TUnicodeStrings);
    function GetStringDelim: TStringDelim;
    procedure SetStringDelim(const Value: TStringDelim);
    function GetIdentifierChars: UnicodeString;
    procedure SetIdentifierChars(const Value: UnicodeString);
    function StoreIdentChars : Boolean;
    procedure SetDetectPreprocessor(Value: boolean);
  public
    class function GetLanguageName: string; override;
    class function GetFriendlyLanguageName: UnicodeString; override;
    function IsStringDelim(aChar : WideChar) : Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetDefaultAttribute(Index: integer): TSynHighlighterAttributes;
      override;
    function GetEol: Boolean; override;
    function GetRange: Pointer; override;
    function GetTokenID: TtkTokenKind;
    function GetCharBeforeToken(offset : Integer = -1) : WideChar;
    function GetCharAfterToken(offset : Integer = 1) : WideChar;
    function GetTokenAttribute: TSynHighlighterAttributes; override;
    function GetTokenKind: integer; override;
    function IsIdentChar(AChar: WideChar): Boolean; override;
    function IsKeyword(const AKeyword: UnicodeString): Boolean; override;
    function IsWordBreakChar(AChar: WideChar): Boolean; override;
    procedure Next; override;
    procedure ResetRange; override;
    procedure SetRange(Value: Pointer); override;
    {$IFNDEF SYN_CLX}
    function SaveToRegistry(RootKey: HKEY; Key: string): boolean; override;
    function LoadFromRegistry(RootKey: HKEY; Key: string): boolean; override;
    {$ENDIF}
    property OnGetTokenAttribute : TGetTokenAttributeEvent read fOnGetTokenAttribute write fOnGetTokenAttribute;
  published
    property CommentAttri: TSynHighlighterAttributes read fCommentAttri
      write fCommentAttri;
    property DetectPreprocessor: boolean read fDetectPreprocessor
      write SetDetectPreprocessor;
    property IdentifierAttri: TSynHighlighterAttributes read fIdentifierAttri
      write fIdentifierAttri;
    property IdentifierChars: UnicodeString read GetIdentifierChars
      write SetIdentifierChars stored StoreIdentChars;
    property KeyAttri: TSynHighlighterAttributes read fKeyAttri write fKeyAttri;
    property KeyWords: TUnicodeStrings read fKeyWords write SetKeyWords;
    property NumberAttri: TSynHighlighterAttributes read fNumberAttri
      write fNumberAttri;
    property PreprocessorAttri: TSynHighlighterAttributes
      read fPreprocessorAttri write fPreprocessorAttri;
    property SpaceAttri: TSynHighlighterAttributes read fSpaceAttri
      write fSpaceAttri;
    property StringAttri: TSynHighlighterAttributes read fStringAttri
      write fStringAttri;
    property SymbolAttri: TSynHighlighterAttributes read fSymbolAttri
      write fSymbolAttri;
    property StringDelim: TStringDelim read GetStringDelim write SetStringDelim
      default sdSingleAndDoubleQuote;
  end;

implementation

uses
{$IFDEF SYN_CLX}
  QSynEditStrConst;
{$ELSE}
  SynEditStrConst;
{$ENDIF}

function TSynActordefSyn.IsIdentChar(AChar: WideChar): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 1 to Length(fIdentChars) do
    if AChar = fIdentChars[i] then
    begin
      Result := True;
      Exit;
    end;
end;

function TSynActordefSyn.IsKeyword(const AKeyword: UnicodeString): Boolean;
var
  First, Last, I, Compare: Integer;
  Token: UnicodeString;
begin
  First := 0;
  Last := fKeywords.Count - 1;
  Result := False;
  Token := SynWideUpperCase(AKeyword);
  while First <= Last do
  begin
    I := (First + Last) shr 1;
    Compare := WideCompareText(fKeywords[i], Token);
    if Compare = 0 then
    begin
      Result := True;
      break;
    end
    else if Compare < 0 then
      First := I + 1
    else
      Last := I - 1;
  end;
end; { IsKeyWord }

function TSynActordefSyn.IsWordBreakChar(AChar: WideChar): Boolean;
begin
  Result := inherited IsWordBreakChar(AChar) and not IsIdentChar(AChar);
end;

//==============================================================================
//
// TSynActordefSyn.Create
//
//==============================================================================
constructor TSynActordefSyn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fKeyWords := TUnicodeStringList.Create;
  // Actordef keywords
  fKeyWords.Add('ACTOR');
  fKeyWords.Add('THINKER');
  fKeyWords.Add('REPLACES');
  fKeyWords.Add('LOOP');
  fKeyWords.Add('STOP');
  fKeyWords.Add('GOTO');
  fKeyWords.Add('WAIT');
  fKeyWords.Add('SPAWN');
  fKeyWords.Add('SEE');
  fKeyWords.Add('MELEE');
  fKeyWords.Add('MISSILE');
  fKeyWords.Add('PAIN');
  fKeyWords.Add('DEATH');
  fKeyWords.Add('XDEATH');
  fKeyWords.Add('RAISE');
  fKeyWords.Add('HEAL');
  fKeyWords.Add('CRASH');
  fKeyWords.Add('CRUSH');
  fKeyWords.Add('INTERACT');
  fKeyWords.Add('BRIGHT');
  fKeyWords.Add('FAST');
  fKeyWords.Add('INHERITS');
  fKeyWords.Add('INHERITSFROM');
  fKeyWords.Add('HEALTH');
  fKeyWords.Add('MONSTER');
  fKeyWords.Add('RENDERSTYLE');
  fKeyWords.Add('ALPHA');
  fKeyWords.Add('DEFAULTMISSILE');
  fKeyWords.Add('DEFAULTTRANSPARENT');
  fKeyWords.Add('+DEFAULTMISSILE');
  fKeyWords.Add('+DEFAULTTRANSPARENT');
  fKeyWords.Add('TRANSLUCENT');
  fKeyWords.Add('RADIUS');
  fKeyWords.Add('WIDTH');
  fKeyWords.Add('HEIGHT');
  fKeyWords.Add('SPEED');
  fKeyWords.Add('DAMAGE');
  fKeyWords.Add('PAINCHANCE');
  fKeyWords.Add('MASS');
  fKeyWords.Add('REACTIONTIME');
  fKeyWords.Add('DROPITEM');
  fKeyWords.Add('MISSILETYPE');
  fKeyWords.Add('EXPLOSIONDAMAGE');
  fKeyWords.Add('MELEEDAMAGE');
  fKeyWords.Add('SEESOUND');
  fKeyWords.Add('ATTACKSOUND');
  fKeyWords.Add('PAINSOUND');
  fKeyWords.Add('DEATHSOUND');
  fKeyWords.Add('ACTIVESOUND');
  fKeyWords.Add('CUSTOMSOUND1');
  fKeyWords.Add('CUSTOMSOUND2');
  fKeyWords.Add('CUSTOMSOUND3');
  fKeyWords.Add('MELEESOUND');
  fKeyWords.Add('MISSILEHEIGHT');
  fKeyWords.Add('STATES');
  fKeyWords.Add('SPAWN:');
  fKeyWords.Add('SEE:');
  fKeyWords.Add('HEAL:');
  fKeyWords.Add('CRASH:');
  fKeyWords.Add('CRUSH:');
  fKeyWords.Add('INTERACT:');
  fKeyWords.Add('MELEE:');
  fKeyWords.Add('MISSILE:');
  fKeyWords.Add('PAIN:');
  fKeyWords.Add('DEATH:');
  fKeyWords.Add('XDEATH:');
  fKeyWords.Add('RAISE:');
  fKeyWords.Add('WEAPON');
  fKeyWords.Add('UP');
  fKeyWords.Add('DOWN');
  fKeyWords.Add('READY');
  fKeyWords.Add('ATTACK');
  fKeyWords.Add('HOLD');
  fKeyWords.Add('FLASH');
  fKeyWords.Add('RANDOMSELECT');
  fKeyWords.Add('RANDOMRANGE');
  // Inline Script detectors
  fKeyWords.Add('ACTORALIAS');
  fKeyWords.Add('DEH_PARSE');
  fKeyWords.Add('DEH_PARSE_ALL');
  fKeyWords.Add('SCRIPT');
  fKeyWords.Add('ENDSCRIPT');
  fKeyWords.Add('FOREVER');
  fKeyWords.Add('COMPILED');
  fKeyWords.Add('PRECOMPILED');
  fKeyWords.Add('EXTERNAL');
  fKeyWords.Add('GLOBAL');
  // Pascal Script
  fKeyWords.Add('BEGIN');
  fKeyWords.Add('END');
  fKeyWords.Add('REPEAT');
  fKeyWords.Add('UNTIL');
  fKeyWords.Add('PROGRAM');
  fKeyWords.Add('INTERFACE');
  fKeyWords.Add('IMPLEMENTATION');
  fKeyWords.Add('INITIALIZATION');
  fKeyWords.Add('AND');
  fKeyWords.Add('ARRAY');
  fKeyWords.Add('CASE');
  fKeyWords.Add('CONST');
  fKeyWords.Add('DIV');
  fKeyWords.Add('DO');
  fKeyWords.Add('DOWNTO');
  fKeyWords.Add('EVENT');
  fKeyWords.Add('ELSE');
  fKeyWords.Add('FOR');
  fKeyWords.Add('FUNCTION');
  fKeyWords.Add('IF');
  fKeyWords.Add('IN');
  fKeyWords.Add('LABEL');
  fKeyWords.Add('MOD');
  fKeyWords.Add('NIL');
  fKeyWords.Add('NOT');
  fKeyWords.Add('OF');
  fKeyWords.Add('OR');
  fKeyWords.Add('PROCEDURE');
  fKeyWords.Add('RECORD');
  fKeyWords.Add('SET');
  fKeyWords.Add('SHL');
  fKeyWords.Add('SHR');
  fKeyWords.Add('STRING');
  fKeyWords.Add('TASK');
  fKeyWords.Add('THEN');
  fKeyWords.Add('TO');
  fKeyWords.Add('TYPE');
  fKeyWords.Add('UNIT');
  fKeyWords.Add('USES');
  fKeyWords.Add('VAR');
  fKeyWords.Add('WHILE');
  fKeyWords.Add('WITH');
  fKeyWords.Add('XOR');
  fKeyWords.Add('TRY');
  fKeyWords.Add('FINALLY');
  fKeyWords.Add('EXCEPT');
  TUnicodeStringList(fKeyWords).Sorted := True;
  TUnicodeStringList(fKeyWords).Duplicates := dupIgnore;
  fCommentAttri := TSynHighlighterAttributes.Create(SYNS_AttrComment, SYNS_FriendlyAttrComment);
  fCommentAttri.Style := [fsItalic];
  AddAttribute(fCommentAttri);
  fIdentifierAttri := TSynHighlighterAttributes.Create(SYNS_AttrIdentifier, SYNS_FriendlyAttrIdentifier);
  AddAttribute(fIdentifierAttri);
  fKeyAttri := TSynHighlighterAttributes.Create(SYNS_AttrReservedWord, SYNS_FriendlyAttrReservedWord);
  fKeyAttri.Style := [fsBold];
  AddAttribute(fKeyAttri);
  fNumberAttri := TSynHighlighterAttributes.Create(SYNS_AttrNumber, SYNS_FriendlyAttrNumber);
  AddAttribute(fNumberAttri);
  fSpaceAttri := TSynHighlighterAttributes.Create(SYNS_AttrSpace, SYNS_FriendlyAttrSpace);
  AddAttribute(fSpaceAttri);
  fStringAttri := TSynHighlighterAttributes.Create(SYNS_AttrString, SYNS_FriendlyAttrString);
  AddAttribute(fStringAttri);
  fSymbolAttri := TSynHighlighterAttributes.Create(SYNS_AttrSymbol, SYNS_FriendlyAttrSymbol);
  AddAttribute(fSymbolAttri);
  fPreprocessorAttri := TSynHighlighterAttributes.Create(SYNS_AttrPreprocessor, SYNS_FriendlyAttrPreprocessor);
  AddAttribute(fPreprocessorAttri);
  SetAttributesOnChange(DefHighlightChange);

  fStringDelim := sdSingleAndDoubleQuote;
  fIdentChars := cDefaultIdentChars;
  fRange := rsUnknown;
end; { Create }

//==============================================================================
//
// TSynActordefSyn.Destroy
//
//==============================================================================
destructor TSynActordefSyn.Destroy;
begin
  fKeyWords.Free;
  inherited Destroy;
end; { Destroy }

procedure TSynActordefSyn.AnsiProc;
begin
  case fLine[Run] of
     #0: NullProc;
    #10: LFProc;
    #13: CRProc;
  else
    fTokenID := tkComment;
    repeat
      if (fLine[Run] = '*') and (fLine[Run + 1] = ')') then
      begin
        fRange := rsUnKnown;
        Inc(Run, 2);
        break;
      end;
      Inc(Run);
    until IsLineEnd(Run);
  end;
end;

procedure TSynActordefSyn.PasStyleProc;
begin
  case fLine[Run] of
     #0: NullProc;
    #10: LFProc;
    #13: CRProc;
  else
    fTokenID := tkComment;
    repeat
      if fLine[Run] = '}' then
      begin
        fRange := rsUnKnown;
        Inc(Run);
        break;
      end;
      Inc(Run);
    until IsLineEnd(Run);
  end;
end;

procedure TSynActordefSyn.CStyleProc;
begin
  case fLine[Run] of
     #0: NullProc;
    #10: LFProc;
    #13: CRProc;
  else
    fTokenID := tkComment;
    repeat
      if (fLine[Run] = '*') and (fLine[Run + 1] = '/') then
      begin
        fRange := rsUnKnown;
        Inc(Run, 2);
        break;
      end;
      Inc(Run);
    until IsLineEnd(Run);
  end;
end;

procedure TSynActordefSyn.AsciiCharProc;
begin
  if fDetectPreprocessor then
  begin
    fTokenID := tkPreprocessor;
    repeat
      inc(Run);
    until IsLineEnd(Run);
  end
  else
  begin
    fTokenID := tkString;
    repeat
      inc(Run);
    until not CharInSet(fLine[Run], ['0'..'9']);
  end;
end;

procedure TSynActordefSyn.BraceOpenProc;
begin
  inc(Run);
  fTokenID := tkSymbol;
end;

procedure TSynActordefSyn.PointCommaProc;
begin
  inc(Run);
  fTokenID := tkSymbol;
end;

procedure TSynActordefSyn.CRProc;
begin
  fTokenID := tkSpace;
  Inc(Run);
  if fLine[Run] = #10 then
    Inc(Run);
end;

procedure TSynActordefSyn.IdentProc;
begin
  while IsIdentChar(fLine[Run]) do inc(Run);
  if IsKeyWord(GetToken) then
    fTokenId := tkKey
  else
    fTokenId := tkIdentifier;
end;

procedure TSynActordefSyn.IntegerProc;

  function IsIntegerChar: Boolean;
  begin
    case fLine[Run] of
      '0'..'9', 'A'..'F', 'a'..'f':
        Result := True;
      else
        Result := False;
    end;
  end;

begin
  inc(Run);
  fTokenID := tkNumber;
  while IsIntegerChar do inc(Run);
end;

procedure TSynActordefSyn.LFProc;
begin
  fTokenID := tkSpace;
  inc(Run);
end;

procedure TSynActordefSyn.NullProc;
begin
  fTokenID := tkNull;
  inc(Run);
end;

procedure TSynActordefSyn.NumberProc;

  function IsNumberChar: Boolean;
  begin
    case fLine[Run] of
      '0'..'9', '.', ',', '$':
        Result := True;
      else
        Result := False;
    end;
  end;

begin
  inc(Run);
  fTokenID := tkNumber;
  while IsNumberChar do
  begin
    case FLine[Run] of
      '$': begin // handle $FF Style numbers
             IntegerProc;
             break;
           end;
      '.':
        if FLine[Run + 1] = '.' then break;
    end;
    inc(Run);
  end;
end;

procedure TSynActordefSyn.RoundOpenProc;
begin
  inc(Run);
  fTokenId := tkSymbol;
end;

procedure TSynActordefSyn.SlashProc;
begin
  Inc(Run);
  if FLine[Run] = '/' then
  begin
    fTokenID := tkComment;
    Inc(Run);
    while FLine[Run] <> #0 do
    begin
      case FLine[Run] of
        #10, #13: break;
      end;
      inc(Run);
    end;
  end
  else
    fTokenID := tkSymbol;
end;

procedure TSynActordefSyn.SpaceProc;
begin
  inc(Run);
  fTokenID := tkSpace;
  while (FLine[Run] <= #32) and not IsLineEnd(Run) do inc(Run);
end;

procedure TSynActordefSyn.StringProc;
var
   delim : WideChar;
begin
  fTokenID := tkString;
  if IsStringDelim(fLine[Run + 1]) and IsStringDelim(fLine[Run + 2]) then
    Inc(Run, 2);
  delim:=fLine[Run];
  repeat
    case FLine[Run] of
      #0, #10, #13: break;
    end;
    inc(Run);
  until FLine[Run] = delim;
  if FLine[Run] <> #0 then inc(Run);
end;

procedure TSynActordefSyn.UnknownProc;
begin
  inc(Run);
  fTokenID := tkUnknown;
end;

procedure TSynActordefSyn.Next;
begin
  fTokenPos := Run;
  case fRange of
    rsAnsi: AnsiProc;
    rsPasStyle: PasStyleProc;
    rsCStyle: CStyleProc;
  else
    if IsStringDelim(fLine[Run]) then
      StringProc
    else
      case fLine[Run] of
        '#': AsciiCharProc;
        '{': BraceOpenProc;
        ';': PointCommaProc;
        #13: CRProc;
        'A'..'Z', 'a'..'z', '_': IdentProc;
        '$': IntegerProc;
        #10: LFProc;
        #0: NullProc;
        '0'..'9': NumberProc;
        '(': RoundOpenProc;
        '/': SlashProc;
        #1..#9, #11, #12, #14..#32: SpaceProc;
        else UnknownProc;
      end;
  end;
  inherited;
end;

function TSynActordefSyn.GetDefaultAttribute(Index: integer): TSynHighlighterAttributes;
begin
  case Index of
    SYN_ATTR_COMMENT: Result := fCommentAttri;
    SYN_ATTR_IDENTIFIER: Result := fIdentifierAttri;
    SYN_ATTR_KEYWORD: Result := fKeyAttri;
    SYN_ATTR_STRING: Result := fStringAttri;
    SYN_ATTR_WHITESPACE: Result := fSpaceAttri;
    SYN_ATTR_SYMBOL: Result := fSymbolAttri;
  else
    Result := nil;
  end;
end;

function TSynActordefSyn.GetEol: Boolean;
begin
  Result := Run = fLineLen + 1;
end;

function TSynActordefSyn.GetRange: Pointer;
begin
  Result := Pointer(fRange);
end;

function TSynActordefSyn.GetTokenID: TtkTokenKind;
begin
  Result := fTokenId;
end;

// GetCharBeforeToken
//
function TSynActordefSyn.GetCharBeforeToken(offset : Integer = -1) : WideChar;
begin
   if fTokenPos+offset >= 0 then
     Result := FLine[fTokenPos+offset]
   else
     Result := #0;
end;

// GetCharAfterToken
//
function TSynActordefSyn.GetCharAfterToken(offset : Integer = 1) : WideChar;
begin
   Result := FLine[fTokenPos+offset];
end;

function TSynActordefSyn.GetTokenAttribute: TSynHighlighterAttributes;
begin
  case fTokenID of
    tkComment: Result := fCommentAttri;
    tkIdentifier: Result := fIdentifierAttri;
    tkKey: Result := fKeyAttri;
    tkNumber: Result := fNumberAttri;
    tkPreprocessor: Result := fPreprocessorAttri;
    tkSpace: Result := fSpaceAttri;
    tkString: Result := fStringAttri;
    tkSymbol: Result := fSymbolAttri;
    tkUnknown: Result := fSymbolAttri;
  else
    Result := nil;
  end;
  if Assigned(fOnGetTokenAttribute) then
    fOnGetTokenAttribute(Result);
end;

function TSynActordefSyn.GetTokenKind: integer;
begin
  Result := Ord(fTokenId);
end;

procedure TSynActordefSyn.ResetRange;
begin
  fRange := rsUnknown;
end;

procedure TSynActordefSyn.SetRange(Value: Pointer);
begin
  fRange := TRangeState(Value);
end;

procedure TSynActordefSyn.SetKeyWords(const Value: TUnicodeStrings);
var
  i: Integer;
begin
  if Value <> nil then
    begin
      Value.BeginUpdate;
      for i := 0 to Value.Count - 1 do
        Value[i] := SynWideUpperCase(Value[i]);
      Value.EndUpdate;
    end;

  TUnicodeStringList(fKeyWords).Sorted:=False;
  fKeyWords.Assign(Value);
  TUnicodeStringList(fKeyWords).Sorted:=True;

  DefHighLightChange(nil);
end;

class function TSynActordefSyn.GetLanguageName: string;
begin
  Result := 'Actordef';
end;

{$IFNDEF SYN_CLX}
function TSynActordefSyn.LoadFromRegistry(RootKey: HKEY; Key: string): boolean;
var
  r: TBetterRegistry;
begin
  r := TBetterRegistry.Create;
  try
    r.RootKey := RootKey;
    if r.OpenKeyReadOnly(Key) then
    begin
      if r.ValueExists('KeyWords') then
        KeyWords.Text := r.ReadString('KeyWords');
      Result := inherited LoadFromRegistry(RootKey, Key);
    end
    else
      Result := false;
  finally
    r.Free;
  end;
end;

function TSynActordefSyn.SaveToRegistry(RootKey: HKEY; Key: string): boolean;
var
  r: TBetterRegistry;
begin
  r := TBetterRegistry.Create;
  try
    r.RootKey := RootKey;
    if r.OpenKey(Key,true) then
    begin
      Result := true;
      r.WriteString('KeyWords', KeyWords.Text);
      Result := inherited SaveToRegistry(RootKey, Key);
    end
    else
      Result := false;
  finally
    r.Free;
  end;
end;
{$ENDIF}

function TSynActordefSyn.GetStringDelim: TStringDelim;
begin
  Result := fStringDelim;
end;

procedure TSynActordefSyn.SetStringDelim(const Value: TStringDelim);
begin
   fStringDelim := Value;
end;

function TSynActordefSyn.GetIdentifierChars: UnicodeString;
begin
  Result := fIdentChars;
end;

procedure TSynActordefSyn.SetIdentifierChars(const Value: UnicodeString);
begin
  fIdentChars := Value;
end;

function TSynActordefSyn.StoreIdentChars : Boolean;
begin
   Result := (fIdentChars<>cDefaultIdentChars);
end;

procedure TSynActordefSyn.SetDetectPreprocessor(Value: boolean);
begin
  if Value <> fDetectPreprocessor then
  begin
    fDetectPreprocessor := Value;
    DefHighlightChange(Self);
  end;
end;

class function TSynActordefSyn.GetFriendlyLanguageName: UnicodeString;
begin
  Result := 'Actordef';
end;

// IsStringDelim
//
function TSynActordefSyn.IsStringDelim(aChar : WideChar) : Boolean;
begin
   case fStringDelim of
      sdSingleQuote : Result:=(aChar='''');
      sdDoubleQuote : Result:=(aChar='"');
   else
      Result:=(aChar='''') or (aChar='"');
   end;
end;

initialization
{$IFNDEF SYN_CPPB_1}
  RegisterPlaceableHighlighter(TSynActordefSyn);
{$ENDIF}
end.

