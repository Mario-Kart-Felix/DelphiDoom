//------------------------------------------------------------------------------
//
//  DelphiDoom is a source port of the game Doom and it is
//  based on original Linux Doom as published by "id Software"
//  Copyright (C) 1993-1996 by id Software, Inc.
//  Copyright (C) 2004-2022 by Jim Valavanis
//
//  This program is free software; you can redistribute it and/or
//  modify it under the terms of the GNU General Public License
//  as published by the Free Software Foundation; either version 2
//  of the License, or (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program; if not, write to the Free Software
//  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
//  02111-1307, USA.
//
//------------------------------------------------------------------------------
//  Site  : https://sourceforge.net/projects/delphidoom/
//------------------------------------------------------------------------------

{$I Doom32.inc}

unit r_draw;

interface

uses
  d_delphi,
  doomdef,
  r_defs,
// Needs access to LFB (guess what).
  v_video;

procedure R_VideoErase(const ofs: integer; const count: integer);

procedure R_VideoBlanc(const scn: integer; const ofs: integer; const count: integer; const black: byte = 0);

procedure R_PlayerViewBlanc(const black: byte);

procedure R_InitBuffer(width, height: integer);

// Initialize color translation tables,
//  for player rendering etc.
procedure R_InitTranslationTables;

// Rendering function.
procedure R_FillBackScreen;

// If the view size is not full screen, draws a border around it.
procedure R_DrawViewBorder;

// Draw disk busy patch
procedure R_DrawDiskBusy;

var
  displaydiskbusyicon: boolean = true;

  translationtables: PByteArray;
  dc_translation: PByteArray;

  viewwidth: integer;
  viewheight: integer;
  scaledviewwidth: integer;

  viewwindowx: integer;
  viewwindowy: integer;

//
// All drawing to the view buffer is accomplished in this file.
// The other refresh files only know about ccordinates,
//  not the architecture of the frame buffer.
// Conveniently, the frame buffer is a linear one,
//  and we need only the base address,
//  and the total size == width*height*depth/8.,
//

var
  ylookup: array[0..MAXHEIGHT - 1] of PByteArray;
  ylookupl: array[0..MAXHEIGHT - 1] of PLongWordArray;
  columnofs: array[0..MAXWIDTH - 1] of integer;

type
  crange_idx_e = (
    CR_BRICK,   //0
    CR_TAN,     //1
    CR_GRAY,    //2
    CR_GREEN,   //3
    CR_BROWN,   //4
    CR_GOLD,    //5
    CR_RED,     //6
    CR_BLUE,    //7
    CR_ORANGE,  //8
    CR_YELLOW,  //9
    CR_BLUE2,   //10
    CR_BLACK,   //11
    CR_PURPL,   //12
    CR_WHITE,   //13
    CR_TRANS0,  //14
    CR_TRANS1,  //15
    CR_TRANS2,  //16
    CR_TRANS3,  //17
    CR_TRANS4,  //18
    CR_TRANS5,  //19
    CR_TRANS6,  //20
    CR_TRANS7,  //21
    CR_TRANS8,  //22
    CR_TRANS9,  //23
    CR_LIMIT    //24
  );

var
  colorregions: array[0..Ord(CR_LIMIT) - 1] of PByteArray;
{$IFDEF OPENGL}
  diskbusy_height: integer = 0;
{$ENDIF}

var
  xlatab: PByteArray;

implementation

uses
  am_map,
  m_argv,
  w_wad,
  z_zone,
  st_stuff,
  i_system,
{$IFDEF OPENGL}
  gl_render,
{$ELSE}
  r_hires,
{$ENDIF}
// State.
  doomstat,
  v_data;

//
// R_InitTranslationTables
// Creates the translation tables to map
//  the green color ramp to gray, brown, red.
// Assumes a given structure of the PLAYPAL.
// Could be read from a lump instead.
//
procedure R_InitTranslationTables;
var
  i, j: integer;
  lump: integer;
  lump2: integer;
  col1, col2: byte;
begin
  xlatab := W_CacheLumpName('XLATAB', PU_STATIC);

  translationtables := Z_Malloc(256 * 8, PU_STATIC, nil);

  col1 := $FA;
  col2 := $E0;

  // villsa [STRIFE] setup all translation tables
  for i := 0 to 255 do
  begin
    if (i >= $80) and (i <= $8f) then
    begin
      translationtables [i          ] := (i and $0f) + 64;
      translationtables [i +     256] := (i and $0f) - 80;
      translationtables [i + 2 * 256] := (i and $0f) + 16;
      translationtables [i + 3 * 256] := (i and $0f) + 48;
      translationtables [i + 4 * 256] := (i and $0f) + 80;
      translationtables [i + 5 * 256] := (i and $0f) + 96;
      translationtables [i + 6 * 256] := (i and $0f) - 112;
    end
    else if (i >= $50) and (i <= $5f) then
    begin
      translationtables [i          ] := i;
      translationtables [i +     256] := i;
      translationtables [i + 2 * 256] := i;
      translationtables [i + 3 * 256] := i;
      translationtables [i + 4 * 256] := (i and $0f) + $80;
      translationtables [i + 5 * 256] := (i and $0f) + 16;
      translationtables [i + 6 * 256] := (i and $0f) + 64;
    end
    else if (i >= $d0) and (i <= $df) then
    begin
      translationtables [i          ] := i;
      translationtables [i +     256] := i;
      translationtables [i + 2 * 256] := i;
      translationtables [i + 3 * 256] := i;
      translationtables [i + 4 * 256] := (i and $0f) - 80;
      translationtables [i + 5 * 256] := (i and $0f) + 48;
      translationtables [i + 6 * 256] := (i and $0f) + 16;
    end
    else if (i >= $c0) and (i <= $cf) then
    begin
      translationtables [i          ] := i;
      translationtables [i +     256] := i;
      translationtables [i + 2 * 256] := i;
      translationtables [i + 3 * 256] := i;
      translationtables [i + 4 * 256] := (i and $0f) - 96;
      translationtables [i + 5 * 256] := (i and $0f) + 32;
      translationtables [i + 6 * 256] := (i and $0f);
      // haleyjd 20110213: missing code:
      if i and $0f = 0 then
        translationtables[i + 6 * 256] := 1;
    end
    else if (i >= $f7) and (i <= $fb) then
    begin
      translationtables [i          ] := col1;
      translationtables [i +     256] := i;
      translationtables [i + 2 * 256] := i;
      translationtables [i + 3 * 256] := i;
      translationtables [i + 4 * 256] := i;
      translationtables [i + 5 * 256] := i;
      translationtables [i + 6 * 256] := i;
    end
    else if (i >= $f1) and (i <= $f6) then
    begin
      translationtables [i          ] := (i and $0f) - 33;
      translationtables [i +     256] := i;
      translationtables [i + 2 * 256] := i;
      translationtables [i + 3 * 256] := i;
      translationtables [i + 4 * 256] := i;
      translationtables [i + 5 * 256] := i;
      translationtables [i + 6 * 256] := i;
    end
    else if (i >= $20) and (i <= $3f) then // haleyjd 20110213: fixed upper end
    begin
      translationtables [i          ] := col2;
      translationtables [i +     256] := col2;
      translationtables [i + 2 * 256] := (i and $0f) - 48;
      translationtables [i + 3 * 256] := (i and $0f) - 48;
      translationtables [i + 4 * 256] := col2;
      translationtables [i + 5 * 256] := col2;
      translationtables [i + 6 * 256] := col2;
    end
    else  // Keep all other colors as is.
    begin
      translationtables[i          ] := i;
      translationtables[i +     256] := i;
      translationtables[i + 2 * 256] := i;
      translationtables[i + 3 * 256] := i;
      translationtables[i + 4 * 256] := i;
      translationtables[i + 5 * 256] := i;
      translationtables[i + 6 * 256] := i;
    end;
    inc(col1);
    inc(col2);
  end;

  // JVAL: Initialize ColorRegions
  lump := W_CheckNumForName('CR_START');
  for i := 0 to Ord(CR_LIMIT) - 1 do
    colorregions[i] := Z_Malloc(256, PU_STATIC, nil);
  if lump = -1 then
  begin
    printf(#13#10); // JVAL: keep stdout happy...
    I_Warning('Colormap extensions not found, using default translations'#13#10);
    for i := 0 to Ord(CR_LIMIT) - 1 do
      for j := 0 to 255 do
        colorregions[i][j] := j;
  end
  else
  begin
    for i := 0 to Ord(CR_LIMIT) - 1 do
    begin
      inc(lump);
      lump2 := W_CheckNumForName(W_GetNameForNum(lump));
      if W_LumpLength(lump2) = 256 then
        W_ReadLump(lump2, colorregions[i])
      else
        W_ReadLump(lump, colorregions[i]);
    end;
  end;

end;

//
// R_InitBuffer
// Creats lookup tables that avoid
//  multiplies and other hazzles
//  for getting the framebuffer address
//  of a pixel to draw.
//
procedure R_InitBuffer(width, height: integer);
var
  i: integer;
begin
  // Handle resize,
  //  e.g. smaller view windows
  //  with border and/or status bar.
  viewwindowx := (SCREENWIDTH - width) div 2;

  // Column offset. For windows.
  for i := 0 to width - 1 do
    columnofs[i] := viewwindowx + i;

  // Same with base row offset.
  if width = SCREENWIDTH then
  begin
    viewwindowy := 0;
  end
  else
  begin
  {$IFDEF OPENGL}
    viewwindowy := (trunc(ST_Y * SCREENHEIGHT / 200) - height) div 2;
  {$ELSE}
    viewwindowy := (V_PreserveY(ST_Y) - height) div 2;
  {$ENDIF}
  end;

{$IFNDEF OPENGL}
  // Preclaculate all row offsets.
  for i := 0 to height - 1 do
  begin
    ylookup[i] := PByteArray(integer(screens[SCN_FG]) + (i + viewwindowy) * SCREENWIDTH);
    ylookupl[i] := PLongWordArray(@screen32[(i + viewwindowy) * SCREENWIDTH]);
  end;
{$ENDIF}
end;

procedure R_ScreenBlanc(const scn: integer; const black: byte = 0);
var
  x, i: integer;
begin
  x := viewwindowy * SCREENWIDTH + viewwindowx;
  for i := 0 to viewheight - 1 do
  begin
    R_VideoBlanc(scn, x, scaledviewwidth, black);
    inc(x, SCREENWIDTH);
  end;
end;


//
// R_FillBackScreen
// Fills the back screen with a pattern
//  for variable screen sizes
// Also draws a beveled edge.
//
procedure R_FillBackScreen;
var
{$IFNDEF OPENGL}
  src: PByteArray;
  dest: PByteArray;
  x: integer;
  y: integer;
  patch: Ppatch_t;
  tviewwindowx: integer;
  tviewwindowy: integer;
  tviewheight: integer;
  tscaledviewwidth: integer;
{$ENDIF}
  name: string;
begin
  if scaledviewwidth = SCREENWIDTH then
    exit;

  name := 'F_PAVE01'; // Border patch

{$IFDEF OPENGL}
  gld_DrawBackground(name);
{$ELSE}

  needsbackscreen := false;

  src := W_CacheLumpName(name, PU_STATIC);

  dest := screens[SCN_TMP];

  for y := 0 to 200 - ST_HEIGHT do
  begin
    for x := 0 to 320 div 64 - 1 do
    begin
      memcpy(dest, PByteArray(integer(src) + _SHL(y and 63, 6)), 64);
      dest := @dest[64];
    end;
    if 320 and 63 <> 0 then
    begin
      memcpy(dest, PByteArray(integer(src) + _SHL(y and 63, 6)), 320 and 63);
      dest := @dest[64];
    end;
  end;

  Z_ChangeTag(src, PU_CACHE);

  tviewwindowx := viewwindowx * 320 div SCREENWIDTH + 1;
  tviewwindowy := viewwindowy * 200 div SCREENHEIGHT + 1;
  tviewheight := viewheight * 200 div SCREENHEIGHT - 2;
  tscaledviewwidth := scaledviewwidth * 320 div SCREENWIDTH - 2;

  patch := W_CacheLumpName('brdr_t', PU_STATIC);
  x := 0;
  while x < tscaledviewwidth do
  begin
    V_DrawPatch(tviewwindowx + x, tviewwindowy - 8, SCN_TMP, patch, false);
    x := x + 8;
  end;
  Z_ChangeTag(patch, PU_CACHE);

  patch := W_CacheLumpName('brdr_b', PU_STATIC);
  x := 0;
  while x < tscaledviewwidth do
  begin
    V_DrawPatch(tviewwindowx + x, tviewwindowy + tviewheight, SCN_TMP, patch, false);
    x := x + 8;
  end;
  Z_ChangeTag(patch, PU_CACHE);

  patch := W_CacheLumpName('brdr_l', PU_STATIC);
  y := 0;
  while y < tviewheight do
  begin
    V_DrawPatch(tviewwindowx - 8, tviewwindowy + y, SCN_TMP, patch, false);
    y := y + 8;
  end;
  Z_ChangeTag(patch, PU_CACHE);

  patch := W_CacheLumpName('brdr_r', PU_STATIC);
  y := 0;
  while y < tviewheight do
  begin
    V_DrawPatch(tviewwindowx + tscaledviewwidth, tviewwindowy + y, SCN_TMP, patch, false);
    y := y + 8;
  end;
  Z_ChangeTag(patch, PU_CACHE);

  // Draw beveled edge.
  V_DrawPatch(tviewwindowx - 8, tviewwindowy - 8, SCN_TMP,
    'brdr_tl', false);

  V_DrawPatch(tviewwindowx + tscaledviewwidth, tviewwindowy - 8, SCN_TMP,
    'brdr_tr', false);

  V_DrawPatch(tviewwindowx - 8, tviewwindowy + tviewheight, SCN_TMP,
    'brdr_bl', false);

  V_DrawPatch(tviewwindowx + tscaledviewwidth, tviewwindowy + tviewheight, SCN_TMP,
    'brdr_br', false);

  V_RemoveTransparency(SCN_TMP, 0, -1);
  V_CopyRect(0, 0, SCN_TMP, V_GetScreenWidth(SCN_TMP), V_GetScreenHeight(SCN_TMP), 0, 0, SCN_BG, true);

  R_ScreenBlanc(SCN_BG);
  x := V_PreserveY(ST_Y) * V_GetScreenWidth(SCN_BG); //SCREENWIDTH;
  R_VideoBlanc(SCN_BG, x, (V_GetScreenHeight(SCN_BG) - V_PreserveY(ST_Y)) * V_GetScreenWidth(SCN_BG));
{$ENDIF}
end;

//
// Copy a screen buffer.
//
procedure R_VideoErase(const ofs: integer; const count: integer);
var
  i: integer;
  src: PByte;
  dest: PLongWord;
begin
  // LFB copy.
  // This might not be a good idea if memcpy
  //  is not optiomal, e.g. byte by byte on
  //  a 32bit CPU, as GNU GCC/Linux libc did
  //  at one point.
{$IFNDEF OPENGL}
  if videomode = vm32bit then
  begin
{$ENDIF}
    src := PByte(integer(screens[SCN_BG]) + ofs);
    dest := @screen32[ofs];
    for i := 1 to count do
    begin
      dest^ := videopal[src^];
      inc(dest);
      inc(src);
    end;
{$IFNDEF OPENGL}
  end
  else
    memcpy(Pointer(integer(screens[SCN_FG]) + ofs), Pointer(integer(screens[SCN_BG]) + ofs), count);
{$ENDIF}
end;

procedure R_VideoBlanc(const scn: integer; const ofs: integer; const count: integer; const black: byte = 0);
var
  start: PByte;
  lstrart: PLongWord;
  i: integer;
  lblack: LongWord;
begin
  if {$IFNDEF OPENGL}(videomode = vm32bit) and{$ENDIF} (scn = SCN_FG) then
  begin
    lblack := curpal[black];
    lstrart := @screen32[ofs];
    for i := 0 to count - 1 do
    begin
      lstrart^ := lblack;
      inc(lstrart);
    end;
  end
  else
  begin
    start := @screens[scn][ofs];
    memset(start, black, count);
  end;
end;

procedure R_PlayerViewBlanc(const black: byte);
begin
  R_ScreenBlanc(SCN_FG, black);
end;

//
// R_DrawViewBorder
// Draws the border around the view
//  for different size windows?
//
procedure R_DrawViewBorder;
begin
  if scaledviewwidth < SCREENWIDTH then
    if (gamestate = GS_LEVEL) and (amstate <> am_only) then
      V_CopyScreenTransparent(SCN_BG, SCN_FG);
end;

var
  disklump: integer = -2;
  diskpatch: Ppatch_t = nil;

procedure R_DrawDiskBusy;
begin
  if not displaydiskbusyicon then
    exit;

// Draw disk busy patch
  if disklump = -2 then
  begin
    disklump := W_CheckNumForName('STDISK');
    if disklump >= 0 then
      diskpatch := W_CacheLumpNum(disklump, PU_STATIC)
    else
    begin
      I_Warning('Disk busy lump not found!'#13#10);
      exit;
    end;
  end;

  if diskpatch <> nil then
    V_DrawPatch(318 - diskpatch.width, 2, SCN_FG,
      diskpatch, true);
  {$IFDEF OPENGL}
  diskbusy_height := diskpatch.height + 3;
  {$ENDIF}
end;

end.
