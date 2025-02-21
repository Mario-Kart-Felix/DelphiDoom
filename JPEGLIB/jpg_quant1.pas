//------------------------------------------------------------------------------
//
//  DelphiDoom is a source port of the game Doom and it is
//  based on original Linux Doom as published by "id Software"
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
//  Foundation, inc., 59 Temple Place - Suite 330, Boston, MA
//  02111-1307, USA.
//
//------------------------------------------------------------------------------
//  E-Mail: jimmyvalavanis@yahoo.gr
//  Site  : https://sourceforge.net/projects/delphidoom/
//------------------------------------------------------------------------------

{$I Doom32.inc}

unit jpg_Quant1;

{ This file contains 1-pass color quantization (color mapping) routines.
  These routines provide mapping to a fixed color map using equally spaced
  color values.  Optional Floyd-Steinberg or ordered dithering is available. }

{ Original: jquant1.c; Copyright (C) 1991-1996, Thomas G. Lane. }

interface

uses
  jpg_lib;

{$I jconfig.inc}

{GLOBAL}

//==============================================================================
//
// jinit_1pass_quantizer 
//
//==============================================================================
procedure jinit_1pass_quantizer (cinfo: j_decompress_ptr);

implementation

uses
  jpg_morecfg,
  jpg_error,
  jpg_defErr,
  jpg_utils;

{ The main purpose of 1-pass quantization is to provide a fast, if not very
  high quality, colormapped output capability.  A 2-pass quantizer usually
  gives better visual quality; however, for quantized grayscale output this
  quantizer is perfectly adequate.  Dithering is highly recommended with this
  quantizer, though you can turn it off if you really want to.

  In 1-pass quantization the colormap must be chosen in advance of seeing the
  image.  We use a map consisting of all combinations of Ncolors[i] color
  values for the i'th component.  The Ncolors[] values are chosen so that
  their product, the total number of colors, is no more than that requested.
  (In most cases, the product will be somewhat less.)

  Since the colormap is orthogonal, the representative value for each color
  component can be determined without considering the other components;
  then these indexes can be combined into a colormap index by a standard
  N-dimensional-array-subscript calculation.  Most of the arithmetic involved
  can be precalculated and stored in the lookup table colorindex[].
  colorindex[i][j] maps pixel value j in component i to the nearest
  representative value (grid plane) for that component; this index is
  multiplied by the array stride for component i, so that the
  index of the colormap entry closest to a given pixel value is just
     sum( colorindex[component-number][pixel-component-value] )
  Aside from being fast, this scheme allows for variable spacing between
  representative values with no additional lookup cost.

  If gamma correction has been applied in color conversion, it might be wise
  to adjust the color grid spacing so that the representative colors are
  equidistant in linear space.  At this writing, gamma correction is not
  implemented by jdcolor, so nothing is done here. }

{ Declarations for ordered dithering.

  We use a standard 16x16 ordered dither array.  The basic concept of ordered
  dithering is described in many references, for instance Dale Schumacher's
  chapter II.2 of Graphics Gems II (James Arvo, ed. Academic Press, 1991).
  In place of Schumacher's comparisons against a "threshold" value, we add a
  "dither" value to the input pixel and then round the result to the nearest
  output value.  The dither value is equivalent to (0.5 - threshold) times
  the distance between output values.  For ordered dithering, we assume that
  the output colors are equally spaced; if not, results will probably be
  worse, since the dither may be too much or too little at a given point.

  The normal calculation would be to form pixel value + dither, range-limit
  this to 0..MAXJSAMPLE, and then index into the colorindex table as usual.
  We can skip the separate range-limiting step by extending the colorindex
  table in both directions. }

const
  ODITHER_SIZE  = 16;   { dimension of dither matrix }
{ NB: if ODITHER_SIZE is not a power of 2, ODITHER_MASK uses will break }
  ODITHER_CELLS = (ODITHER_SIZE*ODITHER_SIZE);  { # cells in matrix }
  ODITHER_MASK = (ODITHER_SIZE-1); { mask for wrapping around counters }

type
  ODITHER_vector = Array[0..ODITHER_SIZE-1] of int;
  ODITHER_MATRIX = Array[0..ODITHER_SIZE-1] of ODITHER_vector;
  {ODITHER_MATRIX_PTR = ^array[0..ODITHER_SIZE-1] of int;}
  ODITHER_MATRIX_PTR = ^ODITHER_MATRIX;

const
  base_dither_matrix: Array[0..ODITHER_SIZE-1,0..ODITHER_SIZE-1] of UINT8
  = (
  { Bayer's order-4 dither array.  Generated by the code given in
    Stephen Hawley's article "Ordered Dithering" in Graphics Gems I.
    The values in this array must range from 0 to ODITHER_CELLS-1. }

  (   0,192, 48,240, 12,204, 60,252,  3,195, 51,243, 15,207, 63,255 ),
  ( 128, 64,176,112,140, 76,188,124,131, 67,179,115,143, 79,191,127 ),
  (  32,224, 16,208, 44,236, 28,220, 35,227, 19,211, 47,239, 31,223 ),
  ( 160, 96,144, 80,172,108,156, 92,163, 99,147, 83,175,111,159, 95 ),
  (   8,200, 56,248,  4,196, 52,244, 11,203, 59,251,  7,199, 55,247 ),
  ( 136, 72,184,120,132, 68,180,116,139, 75,187,123,135, 71,183,119 ),
  (  40,232, 24,216, 36,228, 20,212, 43,235, 27,219, 39,231, 23,215 ),
  ( 168,104,152, 88,164,100,148, 84,171,107,155, 91,167,103,151, 87 ),
  (   2,194, 50,242, 14,206, 62,254,  1,193, 49,241, 13,205, 61,253 ),
  ( 130, 66,178,114,142, 78,190,126,129, 65,177,113,141, 77,189,125 ),
  (  34,226, 18,210, 46,238, 30,222, 33,225, 17,209, 45,237, 29,221 ),
  ( 162, 98,146, 82,174,110,158, 94,161, 97,145, 81,173,109,157, 93 ),
  (  10,202, 58,250,  6,198, 54,246,  9,201, 57,249,  5,197, 53,245 ),
  ( 138, 74,186,122,134, 70,182,118,137, 73,185,121,133, 69,181,117 ),
  (  42,234, 26,218, 38,230, 22,214, 41,233, 25,217, 37,229, 21,213 ),
  ( 170,106,154, 90,166,102,150, 86,169,105,153, 89,165,101,149, 85 )
  );

{ Declarations for Floyd-Steinberg dithering.

  Errors are accumulated into the array fserrors[], at a resolution of
  1/16th of a pixel count.  The error at a given pixel is propagated
  to its not-yet-processed neighbors using the standard F-S fractions,
     ...  (here)  7/16
     3/16  5/16  1/16
  We work left-to-right on even rows, right-to-left on odd rows.

  We can get away with a single array (holding one row's worth of errors)
  by using it to store the current row's errors at pixel columns not yet
  processed, but the next row's errors at columns already processed.  We
  need only a few extra variables to hold the errors immediately around the
  current column.  (If we are lucky, those variables are in registers, but
  even if not, they're probably cheaper to access than array elements are.)

  The fserrors[] array is indexed [component#][position].
  We provide (#columns + 2) entries per component; the extra entry at each
  end saves us from special-casing the first and last pixels.

  Note: on a wide image, we might not have enough room in a PC's near data
  segment to hold the error array; so it is allocated with alloc_large. }

{$ifdef BITS_IN_JSAMPLE_IS_8}
type
  FSERROR = INT16;              { 16 bits should be enough }
  LOCFSERROR = int;             { use 'int' for calculation temps }
{$else}
type
  FSERROR = INT32;              { may need more than 16 bits }
  LOCFSERROR = INT32;           { be sure calculation temps are big enough }
{$endif}

type
  jFSError = 0..(MaxInt div SizeOf(FSERROR))-1;
  FS_ERROR_FIELD = array[jFSError] of FSERROR;
  FS_ERROR_FIELD_PTR = ^FS_ERROR_FIELD;{far}
                                { pointer to error array (in FAR storage!) }
  FSERRORPTR = ^FSERROR;

{ Private subobject }

const
  MAX_Q_COMPS = 4;              { max components I can handle }

type
  my_cquantize_ptr = ^my_cquantizer;
  my_cquantizer = record
    pub: jpeg_color_quantizer; { public fields }

    { Initially allocated colormap is saved here }
    sv_colormap: JSAMPARRAY;   { The color map as a 2-D pixel array }
    sv_actual: int;            { number of entries in use }

    colorindex: JSAMPARRAY;    { Precomputed mapping for speed }
    { colorindex[i][j] = index of color closest to pixel value j in component i,
      premultiplied as described above.  Since colormap indexes must fit into
      JSAMPLEs, the entries of this array will too. }

    is_padded: boolean;        { is the colorindex padded for odither? }

    Ncolors: array[0..MAX_Q_COMPS-1] of int;
                                { # of values alloced to each component }

    { Variables for ordered dithering }
    row_index: int;            { cur row's vertical index in dither matrix }
    odither: array[0..MAX_Q_COMPS-1] of ODITHER_MATRIX_PTR;
                                { one dither array per component }
    { Variables for Floyd-Steinberg dithering }
    fserrors: array[0..MAX_Q_COMPS-1] of FS_ERROR_FIELD_PTR;
                                { accumulated errors }
    on_odd_row: boolean;       { flag to remember which row we are on }
  end;

{ Policy-making subroutines for create_colormap and create_colorindex.
  These routines determine the colormap to be used.  The rest of the module
  only assumes that the colormap is orthogonal.

   * select_ncolors decides how to divvy up the available colors
     among the components.
   * output_value defines the set of representative values for a component.
   * largest_input_value defines the mapping from input values to
     representative values for a component.
  Note that the latter two routines may impose different policies for
  different components, though this is not currently done. }

{LOCAL}

//==============================================================================
//
// select_ncolors 
//
//==============================================================================
function select_ncolors (cinfo: j_decompress_ptr;
                         var Ncolors: array of int): int;
{ Determine allocation of desired colors to components, }
{ and fill in Ncolors[] array to indicate choice. }
{ Return value is total number of colors (product of Ncolors[] values). }
var
  nc: int;
  max_colors: int;
  total_colors, iroot, i, j: int;
  changed: boolean;
  temp: long;
const
  RGB_order:array[0..2] of int = (RGB_GREEN, RGB_RED, RGB_BLUE);
begin
  nc := cinfo^.out_color_components; { number of color components }
  max_colors := cinfo^.desired_number_of_colors;

  { We can allocate at least the nc'th root of max_colors per component. }
  { Compute floor(nc'th root of max_colors). }
  iroot := 1;
  repeat
    inc(iroot);
    temp := iroot;    { set temp = iroot ** nc }
    for i := 1 to pred(nc) do
      temp := temp * iroot;
  until (temp > long(max_colors)); { repeat till iroot exceeds root }
  dec(iroot);                   { now iroot = floor(root) }

  { Must have at least 2 color values per component }
  if (iroot < 2) then
    ERREXIT1(j_common_ptr(cinfo), JERR_QUANT_FEW_COLORS, int(temp));

  { Initialize to iroot color values for each component }
  total_colors := 1;
  for i := 0 to pred(nc) do
  begin
    Ncolors[i] := iroot;
    total_colors := total_colors * iroot;
  end;

  { We may be able to increment the count for one or more components without
    exceeding max_colors, though we know not all can be incremented.
    Sometimes, the first component can be incremented more than once!
    (Example: for 16 colors, we start at 2*2*2, go to 3*2*2, then 4*2*2.)
    In RGB colorspace, try to increment G first, then R, then B. }

  repeat
    changed := FALSE;
    for i := 0 to pred(nc) do
    begin
      if cinfo^.out_color_space = JCS_RGB then
        j := RGB_order[i]
      else
        j := i;
      { calculate new total_colors if Ncolors[j] is incremented }
      temp := total_colors div Ncolors[j];
      temp := temp * (Ncolors[j]+1);   { done in long arith to avoid oflo }
      if (temp > long(max_colors)) then
  break;                  { won't fit, done with this pass }
      inc(Ncolors[j]);    { OK, apply the increment }
      total_colors := int(temp);
      changed := TRUE;
    end;
  until not changed;

  select_ncolors := total_colors;
end;

{LOCAL}

//==============================================================================
//
// output_value 
//
//==============================================================================
function output_value (cinfo: j_decompress_ptr;
                       ci: int; j: int; maxj: int): int;
{ Return j'th output value, where j will range from 0 to maxj }
{ The output values must fall in 0..MAXJSAMPLE in increasing order }
begin
  { We always provide values 0 and MAXJSAMPLE for each component;
    any additional values are equally spaced between these limits.
    (Forcing the upper and lower values to the limits ensures that
    dithering can't produce a color outside the selected gamut.) }

  output_value := int (( INT32(j) * MAXJSAMPLE + maxj div 2) div maxj);
end;

{LOCAL}

//==============================================================================
//
// largest_input_value 
//
//==============================================================================
function largest_input_value (cinfo: j_decompress_ptr;
                              ci: int; j: int; maxj: int): int;
{ Return largest input value that should map to j'th output value }
{ Must have largest(j=0) >= 0, and largest(j=maxj) >= MAXJSAMPLE }
begin
  { Breakpoints are halfway between values returned by output_value }
  largest_input_value := int (( INT32(2*j + 1) * MAXJSAMPLE +
                                 maxj) div (2*maxj));
end;

{ Create the colormap. }

{LOCAL}

//==============================================================================
//
// create_colormap 
//
//==============================================================================
procedure create_colormap (cinfo: j_decompress_ptr);
var
  cquantize: my_cquantize_ptr;
  colormap: JSAMPARRAY;        { Created colormap }

  total_colors: int;           { Number of distinct output colors }
  i,j,k, nci, blksize, blkdist, ptr, val: int;
begin
  cquantize := my_cquantize_ptr (cinfo^.cquantize);

  { Select number of colors for each component }
  total_colors := select_ncolors(cinfo, cquantize^.Ncolors);

  { Report selected color counts }
  {$IFDEF DEBUG}
  if (cinfo^.out_color_components = 3) then
    TRACEMS4(j_common_ptr(cinfo), 1, JTRC_QUANT_3_NCOLORS,
       total_colors, cquantize^.Ncolors[0],
       cquantize^.Ncolors[1], cquantize^.Ncolors[2])
  else
    TRACEMS1(j_common_ptr(cinfo), 1, JTRC_QUANT_NCOLORS, total_colors);
  {$ENDIF}

  { Allocate and fill in the colormap. }
  { The colors are ordered in the map in standard row-major order, }
  { i.e. rightmost (highest-indexed) color changes most rapidly. }

  colormap := cinfo^.mem^.alloc_sarray(
     j_common_ptr(cinfo), JPOOL_IMAGE,
     JDIMENSION(total_colors), JDIMENSION(cinfo^.out_color_components));

  { blksize is number of adjacent repeated entries for a component }
  { blkdist is distance between groups of identical entries for a component }
  blkdist := total_colors;

  for i := 0 to pred(cinfo^.out_color_components) do
  begin
    { fill in colormap entries for i'th color component }
    nci := cquantize^.Ncolors[i]; { # of distinct values for this color }
    blksize := blkdist div nci;
    for j := 0 to pred(nci) do
    begin
      { Compute j'th output value (out of nci) for component }
      val := output_value(cinfo, i, j, nci-1);
      { Fill in all colormap entries that have this value of this component }
      ptr := j * blksize;
      while (ptr < total_colors) do
      begin
  { fill in blksize entries beginning at ptr }
  for k := 0 to pred(blksize) do
          colormap^[i]^[ptr+k] := JSAMPLE(val);

        inc(ptr, blkdist);
      end;
    end;
    blkdist := blksize;    { blksize of this color is blkdist of next }
  end;

  { Save the colormap in private storage,
    where it will survive color quantization mode changes. }

  cquantize^.sv_colormap := colormap;
  cquantize^.sv_actual := total_colors;
end;

{ Create the color index table. }

{LOCAL}

//==============================================================================
//
// create_colorindex 
//
//==============================================================================
procedure create_colorindex (cinfo: j_decompress_ptr);
var
  cquantize: my_cquantize_ptr;
  indexptr,
  help_indexptr: JSAMPROW;  { for negative offsets }
  i,j,k, nci, blksize, val, pad: int;
begin
  cquantize := my_cquantize_ptr (cinfo^.cquantize);
  { For ordered dither, we pad the color index tables by MAXJSAMPLE in
    each direction (input index values can be -MAXJSAMPLE .. 2*MAXJSAMPLE).
    This is not necessary in the other dithering modes.  However, we
    flag whether it was done in case user changes dithering mode. }

  if (cinfo^.dither_mode = JDITHER_ORDERED) then
  begin
    pad := MAXJSAMPLE*2;
    cquantize^.is_padded := TRUE;
  end
  else
  begin
    pad := 0;
    cquantize^.is_padded := FALSE;
  end;

  cquantize^.colorindex := cinfo^.mem^.alloc_sarray
    (j_common_ptr(cinfo), JPOOL_IMAGE,
     JDIMENSION(MAXJSAMPLE+1 + pad),
     JDIMENSION(cinfo^.out_color_components));

  { blksize is number of adjacent repeated entries for a component }
  blksize := cquantize^.sv_actual;

  for i := 0 to pred(cinfo^.out_color_components) do
  begin
    { fill in colorindex entries for i'th color component }
    nci := cquantize^.Ncolors[i]; { # of distinct values for this color }
    blksize := blksize div nci;

    { adjust colorindex pointers to provide padding at negative indexes. }
    if (pad <> 0) then
      inc(JSAMPLE_PTR(cquantize^.colorindex^[i]), MAXJSAMPLE);

    { in loop, val = index of current output value, }
    { and k = largest j that maps to current val }
    indexptr := cquantize^.colorindex^[i];
    val := 0;
    k := largest_input_value(cinfo, i, 0, nci-1);
    for j := 0 to MAXJSAMPLE do
    begin
      while (j > k) do          { advance val if past boundary }
      begin
        inc(val);
  k := largest_input_value(cinfo, i, val, nci-1);
      end;
      { premultiply so that no multiplication needed in main processing }
      indexptr^[j] := JSAMPLE (val * blksize);
    end;
    { Pad at both ends if necessary }
    if (pad <> 0) then
    begin
      help_indexptr := indexptr;
      { adjust the help pointer to avoid negative offsets }
      dec(JSAMPLE_PTR(help_indexptr), MAXJSAMPLE);

      for j := 1 to MAXJSAMPLE do
      begin
        {indexptr^[-j] := indexptr^[0];}
        help_indexptr^[MAXJSAMPLE-j] := indexptr^[0];
        indexptr^[MAXJSAMPLE+j] := indexptr^[MAXJSAMPLE];
      end;
    end;
  end;
end;

{ Create an ordered-dither array for a component having ncolors
  distinct output values. }

{LOCAL}

//==============================================================================
//
// make_odither_array 
//
//==============================================================================
function make_odither_array (cinfo: j_decompress_ptr;
                             ncolors: int): ODITHER_MATRIX_PTR;
var
  odither: ODITHER_MATRIX_PTR;
  j, k: int;
  num, den: INT32;
begin
  odither := ODITHER_MATRIX_PTR (
        cinfo^.mem^.alloc_small(j_common_ptr(cinfo), JPOOL_IMAGE,
        SizeOf(ODITHER_MATRIX)));
  { The inter-value distance for this color is MAXJSAMPLE/(ncolors-1).
    Hence the dither value for the matrix cell with fill order f
    (f=0..N-1) should be (N-1-2*f)/(2*N) * MAXJSAMPLE/(ncolors-1).
    On 16-bit-int machine, be careful to avoid overflow. }

  den := 2 * ODITHER_CELLS * ( INT32(ncolors - 1));
  for j := 0 to pred(ODITHER_SIZE) do
  begin
    for k := 0 to pred(ODITHER_SIZE) do
    begin
      num := ( INT32(ODITHER_CELLS-1 - 2*( int(base_dither_matrix[j][k]))))
      * MAXJSAMPLE;
      { Ensure round towards zero despite C's lack of consistency
        about rounding negative values in integer division... }

      if num<0 then
        odither^[j][k] := int (-((-num) div den))
      else
        odither^[j][k] := int (num div den);
    end;
  end;
  make_odither_array := odither;
end;

{ Create the ordered-dither tables.
  Components having the same number of representative colors may
  share a dither table. }

{LOCAL}

//==============================================================================
//
// create_odither_tables 
//
//==============================================================================
procedure create_odither_tables (cinfo: j_decompress_ptr);
var
  cquantize: my_cquantize_ptr;
  odither: ODITHER_MATRIX_PTR;
  i, j, nci: int;
begin
  cquantize := my_cquantize_ptr (cinfo^.cquantize);

  for i := 0 to pred(cinfo^.out_color_components) do
  begin
    nci := cquantize^.Ncolors[i]; { # of distinct values for this color }
    odither := nil;      { search for matching prior component }
    for j := 0 to pred(i) do
    begin
      if (nci = cquantize^.Ncolors[j]) then
      begin
  odither := cquantize^.odither[j];
  break;
      end;
    end;
    if (odither = nil)  then { need a new table? }
      odither := make_odither_array(cinfo, nci);
    cquantize^.odither[i] := odither;
  end;
end;

{ Map some rows of pixels to the output colormapped representation. }

{METHODDEF}

//==============================================================================
//
// color_quantize 
//
//==============================================================================
procedure color_quantize (cinfo: j_decompress_ptr;
                          input_buf: JSAMPARRAY;
              output_buf: JSAMPARRAY;
                          num_rows: int); far;
{ General case, no dithering }
var
  cquantize: my_cquantize_ptr;
  colorindex: JSAMPARRAY;
  pixcode, ci: int; {register}
  ptrin, ptrout: JSAMPLE_PTR; {register}
  row: int;
  col: JDIMENSION;
  width: JDIMENSION;
  nc: int; {register}
begin
  cquantize := my_cquantize_ptr (cinfo^.cquantize);
  colorindex := cquantize^.colorindex;
  width := cinfo^.output_width;
  nc := cinfo^.out_color_components;

  for row := 0 to pred(num_rows) do
  begin
    ptrin := JSAMPLE_PTR(input_buf^[row]);
    ptrout := JSAMPLE_PTR(output_buf^[row]);
    for col := pred(width) downto 0 do
    begin
      pixcode := 0;
      for ci := 0 to pred(nc) do
      begin
  inc(pixcode, GETJSAMPLE(colorindex^[ci]^[GETJSAMPLE(ptrin^)]) );
        inc(ptrin);
      end;
      ptrout^ := JSAMPLE (pixcode);
      inc(ptrout);
    end;
  end;
end;

{METHODDEF}

//==============================================================================
//
// color_quantize3 
//
//==============================================================================
procedure color_quantize3 (cinfo: j_decompress_ptr;
                           input_buf: JSAMPARRAY;
               output_buf: JSAMPARRAY;
                           num_rows: int); far;
{ Fast path for out_color_components=3, no dithering }
var
  cquantize: my_cquantize_ptr;
  pixcode: int; {register}
  ptrin, ptrout: JSAMPLE_PTR; {register}
  colorindex0: JSAMPROW;
  colorindex1: JSAMPROW;
  colorindex2: JSAMPROW;
  row: int;
  col: JDIMENSION;
  width: JDIMENSION;
begin
  cquantize := my_cquantize_ptr (cinfo^.cquantize);
  colorindex0 := (cquantize^.colorindex)^[0];
  colorindex1 := (cquantize^.colorindex)^[1];
  colorindex2 := (cquantize^.colorindex)^[2];
  width := cinfo^.output_width;

  for row := 0 to pred(num_rows) do
  begin
    ptrin := JSAMPLE_PTR(input_buf^[row]);
    ptrout := JSAMPLE_PTR(output_buf^[row]);
    for col := pred(width) downto 0 do
    begin
      pixcode  := GETJSAMPLE((colorindex0)^[GETJSAMPLE(ptrin^)]);
      inc(ptrin);
      inc( pixcode, GETJSAMPLE((colorindex1)^[GETJSAMPLE(ptrin^)]) );
      inc(ptrin);
      inc( pixcode, GETJSAMPLE((colorindex2)^[GETJSAMPLE(ptrin^)]) );
      inc(ptrin);
      ptrout^ := JSAMPLE (pixcode);
      inc(ptrout);
    end;
  end;
end;

{METHODDEF}

//==============================================================================
//
// quantize_ord_dither 
//
//==============================================================================
procedure quantize_ord_dither (cinfo: j_decompress_ptr;
                               input_buf:  JSAMPARRAY;
                   output_buf: JSAMPARRAY;
                               num_rows: int); far;
{ General case, with ordered dithering }
var
  cquantize: my_cquantize_ptr;
  input_ptr,                {register}
  output_ptr: JSAMPLE_PTR; {register}
  colorindex_ci: JSAMPROW;
  dither: ^ODITHER_vector;     { points to active row of dither matrix }
  row_index, col_index: int;   { current indexes into dither matrix }
  nc: int;
  ci: int;
  row: int;
  col: JDIMENSION;
  width: JDIMENSION;
var
  pad_offset: int;
begin
  cquantize := my_cquantize_ptr (cinfo^.cquantize);
  nc := cinfo^.out_color_components;
  width := cinfo^.output_width;

  { Nomssi: work around negative offset }
  if my_cquantize_ptr (cinfo^.cquantize)^.is_padded then
    pad_offset := MAXJSAMPLE
  else
    pad_offset := 0;

  for row := 0 to pred(num_rows) do
  begin
    { Initialize output values to 0 so can process components separately }
    jzero_far( {far} pointer(output_buf^[row]),
        size_t(width * SizeOf(JSAMPLE)));
    row_index := cquantize^.row_index;
    for ci := 0 to pred(nc) do
    begin
      input_ptr := JSAMPLE_PTR(@ input_buf^[row]^[ci]);
      output_ptr := JSAMPLE_PTR(output_buf^[row]);
      colorindex_ci := cquantize^.colorindex^[ci];
      { Nomssi }
      dec(JSAMPLE_PTR(colorindex_ci), pad_offset);

      dither := @(cquantize^.odither[ci]^[row_index]);
      col_index := 0;

      for col := pred(width) downto 0 do
      begin
  { Form pixel value + dither, range-limit to 0..MAXJSAMPLE,
    select output value, accumulate into output code for this pixel.
    Range-limiting need not be done explicitly, as we have extended
    the colorindex table to produce the right answers for out-of-range
    inputs.  The maximum dither is +- MAXJSAMPLE; this sets the
    required amount of padding. }

  inc(output_ptr^,
            colorindex_ci^[GETJSAMPLE(input_ptr^) + pad_offset +
                                         dither^[col_index]]);
        inc(output_ptr);
  inc(input_ptr, nc);
  col_index := (col_index + 1) and ODITHER_MASK;
      end;
    end;
    { Advance row index for next row }
    row_index := (row_index + 1) and ODITHER_MASK;
    cquantize^.row_index := row_index;
  end;
end;

{METHODDEF}

//==============================================================================
//
// quantize3_ord_dither 
//
//==============================================================================
procedure quantize3_ord_dither (cinfo: j_decompress_ptr;
                                input_buf: JSAMPARRAY;
                    output_buf: JSAMPARRAY;
                                num_rows: int); far;
{ Fast path for out_color_components=3, with ordered dithering }
var
  cquantize: my_cquantize_ptr;
  pixcode: int; {register}
  input_ptr: JSAMPLE_PTR; {register}
  output_ptr: JSAMPLE_PTR; {register}
  colorindex0: JSAMPROW;
  colorindex1: JSAMPROW;
  colorindex2: JSAMPROW;
  dither0: ^ODITHER_vector;    { points to active row of dither matrix }
  dither1: ^ODITHER_vector;
  dither2: ^ODITHER_vector;
  row_index, col_index: int;   { current indexes into dither matrix }
  row: int;
  col: JDIMENSION;
  width: JDIMENSION;
var
  pad_offset: int;
begin
  cquantize := my_cquantize_ptr (cinfo^.cquantize);
  colorindex0 := (cquantize^.colorindex)^[0];
  colorindex1 := (cquantize^.colorindex)^[1];
  colorindex2 := (cquantize^.colorindex)^[2];
  width := cinfo^.output_width;

  { Nomssi: work around negative offset }
  if my_cquantize_ptr (cinfo^.cquantize)^.is_padded then
    pad_offset := MAXJSAMPLE
  else
    pad_offset := 0;

  dec(JSAMPLE_PTR(colorindex0), pad_offset);
  dec(JSAMPLE_PTR(colorindex1), pad_offset);
  dec(JSAMPLE_PTR(colorindex2), pad_offset);

  for row := 0 to pred(num_rows) do
  begin
    row_index := cquantize^.row_index;
    input_ptr := JSAMPLE_PTR(input_buf^[row]);
    output_ptr := JSAMPLE_PTR(output_buf^[row]);
    dither0 := @(cquantize^.odither[0]^[row_index]);
    dither1 := @(cquantize^.odither[1]^[row_index]);
    dither2 := @(cquantize^.odither[2]^[row_index]);
    col_index := 0;

    for col := pred(width) downto 0 do
    begin
      pixcode := GETJSAMPLE(colorindex0^[GETJSAMPLE(input_ptr^) + pad_offset
                                         + dither0^[col_index]]);
      inc(input_ptr);
      inc(pixcode, GETJSAMPLE(colorindex1^[GETJSAMPLE(input_ptr^) + pad_offset
                                           + dither1^[col_index]]));
      inc(input_ptr);
      inc(pixcode, GETJSAMPLE(colorindex2^[GETJSAMPLE(input_ptr^) + pad_offset
                                           + dither2^[col_index]]));
      inc(input_ptr);
      output_ptr^ := JSAMPLE (pixcode);
      inc(output_ptr);
      col_index := (col_index + 1) and ODITHER_MASK;
    end;
    row_index := (row_index + 1) and ODITHER_MASK;
    cquantize^.row_index := row_index;
  end;
end;

{METHODDEF}

//==============================================================================
//
// quantize_fs_dither 
//
//==============================================================================
procedure quantize_fs_dither (cinfo: j_decompress_ptr;
                              input_buf: JSAMPARRAY;
                  output_buf: JSAMPARRAY;
                              num_rows: int); far;
{ General case, with Floyd-Steinberg dithering }
var
  cquantize: my_cquantize_ptr;
  cur: LOCFSERROR; {register}  { current error or pixel value }
  belowerr: LOCFSERROR;        { error for pixel below cur }
  bpreverr: LOCFSERROR;        { error for below/prev col }
  bnexterr: LOCFSERROR;        { error for below/next col }
  delta: LOCFSERROR;
  prev_errorptr,
  errorptr: FSERRORPTR; {register} { => fserrors[] at column before current }
  input_ptr,                {register}
  output_ptr: JSAMPLE_PTR; {register}
  colorindex_ci: JSAMPROW;
  colormap_ci: JSAMPROW;
  pixcode: int;
  nc: int;
  dir: int;      { 1 for left-to-right, -1 for right-to-left }
  dirnc: int;      { dir * nc }
  ci: int;
  row: int;
  col: JDIMENSION;
  width: JDIMENSION;
  range_limit: range_limit_table_ptr;
begin
  cquantize := my_cquantize_ptr (cinfo^.cquantize);
  nc := cinfo^.out_color_components;
  width := cinfo^.output_width;
  range_limit := cinfo^.sample_range_limit;

  for row := 0 to pred(num_rows) do
  begin
    { Initialize output values to 0 so can process components separately }
    jzero_far( (output_buf)^[row],
               size_t(width * SizeOf(JSAMPLE)));
    for ci := 0 to pred(nc) do
    begin
      input_ptr := JSAMPLE_PTR(@ input_buf^[row]^[ci]);
      output_ptr := JSAMPLE_PTR(output_buf^[row]);
      errorptr := FSERRORPTR(cquantize^.fserrors[ci]); { => entry before first column }
      if (cquantize^.on_odd_row) then
      begin
  { work right to left in this row }
  inc(input_ptr, (width-1) * nc); { so point to rightmost pixel }
  inc(output_ptr, width-1);
  dir := -1;
  dirnc := -nc;
  inc(errorptr, (width+1)); { => entry after last column }
      end
      else
      begin
  { work left to right in this row }
  dir := 1;
  dirnc := nc;
        {errorptr := cquantize^.fserrors[ci];}
      end;

      colorindex_ci := cquantize^.colorindex^[ci];

      colormap_ci := (cquantize^.sv_colormap)^[ci];
      { Preset error values: no error propagated to first pixel from left }
      cur := 0;
      { and no error propagated to row below yet }
      belowerr := 0;
      bpreverr := 0;

      for col := pred(width) downto 0 do
      begin
        prev_errorptr := errorptr;
  inc(errorptr, dir);  { advance errorptr to current column }

  { cur holds the error propagated from the previous pixel on the
    current line.  Add the error propagated from the previous line
    to form the complete error correction term for this pixel, and
    round the error term (which is expressed * 16) to an integer.
    RIGHT_SHIFT rounds towards minus infinity, so adding 8 is correct
    for either sign of the error value.
    Note: errorptr points to *previous* column's array entry. }

        cur := (cur + errorptr^ + 8) div 16;

  { Form pixel value + error, and range-limit to 0..MAXJSAMPLE.
    The maximum error is +- MAXJSAMPLE; this sets the required size
    of the range_limit array. }

  inc( cur, GETJSAMPLE(input_ptr^));
  cur := GETJSAMPLE(range_limit^[cur]);
  { Select output value, accumulate into output code for this pixel }
  pixcode := GETJSAMPLE(colorindex_ci^[cur]);
  inc(output_ptr^, JSAMPLE (pixcode));
  { Compute actual representation error at this pixel }
  { Note: we can do this even though we don't have the final }
  { pixel code, because the colormap is orthogonal. }
  dec(cur, GETJSAMPLE(colormap_ci^[pixcode]));
  { Compute error fractions to be propagated to adjacent pixels.
    Add these into the running sums, and simultaneously shift the
    next-line error sums left by 1 column. }

  bnexterr := cur;
  delta := cur * 2;
  inc(cur, delta);        { form error * 3 }
  prev_errorptr^ := FSERROR (bpreverr + cur);
  inc(cur, delta);        { form error * 5 }
  bpreverr := belowerr + cur;
  belowerr := bnexterr;
  inc(cur, delta);        { form error * 7 }
  { At this point cur contains the 7/16 error value to be propagated
    to the next pixel on the current line, and all the errors for the
    next line have been shifted over. We are therefore ready to move on. }

  inc(input_ptr, dirnc);  { advance input ptr to next column }
  inc(output_ptr, dir);   { advance output ptr to next column }

      end;
      { Post-loop cleanup: we must unload the final error value into the
        final fserrors[] entry.  Note we need not unload belowerr because
        it is for the dummy column before or after the actual array. }

      errorptr^ := FSERROR (bpreverr); { unload prev err into array }
      { Nomssi: ?? }
    end;
    cquantize^.on_odd_row := not cquantize^.on_odd_row;
  end;
end;

{ Allocate workspace for Floyd-Steinberg errors. }

{LOCAL}

//==============================================================================
//
// alloc_fs_workspace 
//
//==============================================================================
procedure alloc_fs_workspace (cinfo: j_decompress_ptr);
var
  cquantize: my_cquantize_ptr;
  arraysize: size_t;
  i: int;
begin
  cquantize := my_cquantize_ptr (cinfo^.cquantize);
  arraysize := size_t ((cinfo^.output_width + 2) * SizeOf(FSERROR));
  for i := 0 to pred(cinfo^.out_color_components) do
  begin
    cquantize^.fserrors[i] := FS_ERROR_FIELD_PTR(
      cinfo^.mem^.alloc_large(j_common_ptr(cinfo), JPOOL_IMAGE, arraysize));
  end;
end;

{ Initialize for one-pass color quantization. }

{METHODDEF}

//==============================================================================
//
// start_pass_1_quant 
//
//==============================================================================
procedure start_pass_1_quant (cinfo: j_decompress_ptr;
                              is_pre_scan: boolean); far;
var
  cquantize: my_cquantize_ptr;
  arraysize: size_t;
  i: int;
begin
  cquantize := my_cquantize_ptr (cinfo^.cquantize);
  { Install my colormap. }
  cinfo^.colormap := cquantize^.sv_colormap;
  cinfo^.actual_number_of_colors := cquantize^.sv_actual;

  { Initialize for desired dithering mode. }
  case (cinfo^.dither_mode) of
  JDITHER_NONE:
    if (cinfo^.out_color_components = 3) then
      cquantize^.pub.color_quantize := color_quantize3
    else
      cquantize^.pub.color_quantize := color_quantize;
  JDITHER_ORDERED:
    begin
      if (cinfo^.out_color_components = 3) then
        cquantize^.pub.color_quantize := quantize3_ord_dither
      else
        cquantize^.pub.color_quantize := quantize_ord_dither;
      cquantize^.row_index := 0;    { initialize state for ordered dither }
      { If user changed to ordered dither from another mode,
        we must recreate the color index table with padding.
        This will cost extra space, but probably isn't very likely. }

      if (not cquantize^.is_padded) then
        create_colorindex(cinfo);
      { Create ordered-dither tables if we didn't already. }
      if (cquantize^.odither[0] = nil) then
        create_odither_tables(cinfo);
    end;
  JDITHER_FS:
    begin
      cquantize^.pub.color_quantize := quantize_fs_dither;
      cquantize^.on_odd_row := FALSE; { initialize state for F-S dither }
      { Allocate Floyd-Steinberg workspace if didn't already. }
      if (cquantize^.fserrors[0] = nil) then
        alloc_fs_workspace(cinfo);
      { Initialize the propagated errors to zero. }
      arraysize := size_t ((cinfo^.output_width + 2) * SizeOf(FSERROR));
      for i := 0 to pred(cinfo^.out_color_components) do
        jzero_far({far} pointer( cquantize^.fserrors[i] ), arraysize);
    end;
  else
    ERREXIT(j_common_ptr(cinfo), JERR_NOT_COMPILED);
  end;
end;

{ Finish up at the end of the pass. }

{METHODDEF}

//==============================================================================
//
// finish_pass_1_quant 
//
//==============================================================================
procedure finish_pass_1_quant (cinfo: j_decompress_ptr); far;
begin
  { no work in 1-pass case }
end;

{ Switch to a new external colormap between output passes.
  Shouldn't get to this module! }

{METHODDEF}

//==============================================================================
//
// new_color_map_1_quant 
//
//==============================================================================
procedure new_color_map_1_quant (cinfo: j_decompress_ptr); far;
begin
  ERREXIT(j_common_ptr(cinfo), JERR_MODE_CHANGE);
end;

{ Module initialization routine for 1-pass color quantization. }

{GLOBAL}

//==============================================================================
//
// jinit_1pass_quantizer 
//
//==============================================================================
procedure jinit_1pass_quantizer (cinfo: j_decompress_ptr);
var
  cquantize: my_cquantize_ptr;
begin
  cquantize := my_cquantize_ptr(
     cinfo^.mem^.alloc_small (j_common_ptr(cinfo), JPOOL_IMAGE,
        SizeOf(my_cquantizer)));
  cinfo^.cquantize := jpeg_color_quantizer_ptr(cquantize);
  cquantize^.pub.start_pass := start_pass_1_quant;
  cquantize^.pub.finish_pass := finish_pass_1_quant;
  cquantize^.pub.new_color_map := new_color_map_1_quant;
  cquantize^.fserrors[0] := nil; { Flag FS workspace not allocated }
  cquantize^.odither[0] := nil;  { Also flag odither arrays not allocated }

  { Make sure my internal arrays won't overflow }
  if (cinfo^.out_color_components > MAX_Q_COMPS) then
    ERREXIT1(j_common_ptr(cinfo), JERR_QUANT_COMPONENTS, MAX_Q_COMPS);
  { Make sure colormap indexes can be represented by JSAMPLEs }
  if (cinfo^.desired_number_of_colors > (MAXJSAMPLE+1)) then
    ERREXIT1(j_common_ptr(cinfo), JERR_QUANT_MANY_COLORS, MAXJSAMPLE+1);

  { Create the colormap and color index table. }
  create_colormap(cinfo);
  create_colorindex(cinfo);

  { Allocate Floyd-Steinberg workspace now if requested.
    We do this now since it is FAR storage and may affect the memory
    manager's space calculations.  If the user changes to FS dither
    mode in a later pass, we will allocate the space then, and will
    possibly overrun the max_memory_to_use setting. }

  if (cinfo^.dither_mode = JDITHER_FS) then
    alloc_fs_workspace(cinfo);
end;

end.
