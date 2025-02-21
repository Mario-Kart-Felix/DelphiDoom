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

unit jpg_IDctFst;

{ This file contains a fast, not so accurate integer implementation of the
  inverse DCT (Discrete Cosine Transform).  In the IJG code, this routine
  must also perform dequantization of the input coefficients.

  A 2-D IDCT can be done by 1-D IDCT on each column followed by 1-D IDCT
  on each row (or vice versa, but it's more convenient to emit a row at
  a time).  Direct algorithms are also available, but they are much more
  complex and seem not to be any faster when reduced to code.

  This implementation is based on Arai, Agui, and Nakajima's algorithm for
  scaled DCT.  Their original paper (Trans. IEICE E-71(11):1095) is in
  Japanese, but the algorithm is described in the Pennebaker & Mitchell
  JPEG textbook (see REFERENCES section in file README).  The following code
  is based directly on figure 4-8 in P&M.
  While an 8-point DCT cannot be done in less than 11 multiplies, it is
  possible to arrange the computation so that many of the multiplies are
  simple scalings of the final outputs.  These multiplies can then be
  folded into the multiplications or divisions by the JPEG quantization
  table entries.  The AA&N method leaves only 5 multiplies and 29 adds
  to be done in the DCT itself.
  The primary disadvantage of this method is that with fixed-point math,
  accuracy is lost due to imprecise representation of the scaled
  quantization values.  The smaller the quantization table entry, the less
  precise the scaled value, so this implementation does worse with high-
  quality-setting files than with low-quality ones. }

{ Original : jidctfst.c ; Copyright (C) 1994-1996, Thomas G. Lane. }

interface

{$I jconfig.inc}

uses
  jpg_morecfg,
  jpg_lib,
  jpg_dct;       { Private declarations for DCT subsystem }

{ Perform dequantization and inverse DCT on one block of coefficients. }

{GLOBAL}

//==============================================================================
//
// jpeg_idct_ifast 
//
//==============================================================================
procedure jpeg_idct_ifast (cinfo : j_decompress_ptr;
                           compptr : jpeg_component_info_ptr;
               coef_block : JCOEFPTR;
               output_buf : JSAMPARRAY;
                           output_col : JDIMENSION);

implementation

{ This module is specialized to the case DCTSIZE = 8. }

{$ifndef DCTSIZE_IS_8}
  Sorry, this code only copes with 8x8 DCTs. { deliberate syntax err }
{$endif}

{ Scaling decisions are generally the same as in the LL&M algorithm;
  see jidctint.c for more details.  However, we choose to descale
  (right shift) multiplication products as soon as they are formed,
  rather than carrying additional fractional bits into subsequent additions.
  This compromises accuracy slightly, but it lets us save a few shifts.
  More importantly, 16-bit arithmetic is then adequate (for 8-bit samples)
  everywhere except in the multiplications proper; this saves a good deal
  of work on 16-bit-int machines.

  The dequantized coefficients are not integers because the AA&N scaling
  factors have been incorporated.  We represent them scaled up by PASS1_BITS,
  so that the first and second IDCT rounds have the same input scaling.
  For 8-bit JSAMPLEs, we choose IFAST_SCALE_BITS = PASS1_BITS so as to
  avoid a descaling shift; this compromises accuracy rather drastically
  for small quantization table entries, but it saves a lot of shifts.
  For 12-bit JSAMPLEs, there's no hope of using 16x16 multiplies anyway,
  so we use a much larger scaling factor to preserve accuracy.

  A final compromise is to represent the multiplicative constants to only
  8 fractional bits, rather than 13.  This saves some shifting work on some
  machines, and may also reduce the cost of multiplication (since there
  are fewer one-bits in the constants). }

{$ifdef BITS_IN_JSAMPLE_IS_8}
const
  CONST_BITS = 8;
  PASS1_BITS = 2;
{$else}
const
  CONST_BITS = 8;
  PASS1_BITS = 1;  { lose a little precision to avoid overflow }
{$endif}

const
  FIX_1_082392200 = INT32(Round((INT32(1) shl CONST_BITS)*1.082392200));  {277}
  FIX_1_414213562 = INT32(Round((INT32(1) shl CONST_BITS)*1.414213562));  {362}
  FIX_1_847759065 = INT32(Round((INT32(1) shl CONST_BITS)*1.847759065));  {473}
  FIX_2_613125930 = INT32(Round((INT32(1) shl CONST_BITS)*2.613125930));  {669}

{ Descale and correctly round an INT32 value that's scaled by N bits.
  We assume RIGHT_SHIFT rounds towards minus infinity, so adding
  the fudge factor is correct for either sign of X. }

//==============================================================================
//
// DESCALE
//
//==============================================================================
function DESCALE(x : INT32; n : int) : INT32;
var
  shift_temp : INT32;
begin
{$ifdef USE_ACCURATE_ROUNDING}
  shift_temp := x + (INT32(1) shl (n-1));
{$else}
{ We can gain a little more speed, with a further compromise in accuracy,
  by omitting the addition in a descaling shift.  This yields an incorrectly
  rounded result half the time... }
  shift_temp := x;
{$endif}

{$ifdef RIGHT_SHIFT_IS_UNSIGNED}
  if shift_temp < 0 then
    Descale :=  (shift_temp shr n) or ((not INT32(0)) shl (32-n))
  else
{$endif}
    Descale :=  (shift_temp shr n);
end;

{ Multiply a DCTELEM variable by an INT32 constant, and immediately
  descale to yield a DCTELEM result. }

  {(DCTELEM( DESCALE((var) * (const), CONST_BITS))}
  function Multiply(Avar, Aconst: Integer): DCTELEM;
  begin
    Multiply := DCTELEM( Avar*INT32(Aconst) div (INT32(1) shl CONST_BITS));
  end;

{ Dequantize a coefficient by multiplying it by the multiplier-table
  entry; produce a DCTELEM result.  For 8-bit data a 16x16->16
  multiplication will do.  For 12-bit data, the multiplier table is
  declared INT32, so a 32-bit multiply will be used. }

{$ifdef BITS_IN_JSAMPLE_IS_8}
  function DEQUANTIZE(coef,quantval : int) : int;
  begin
    Dequantize := ( IFAST_MULT_TYPE(coef) * quantval);
  end;
{$else}
  function DEQUANTIZE(coef,quantval : INT32) : int;
  begin
    Dequantize := DESCALE((coef)*(quantval), IFAST_SCALE_BITS-PASS1_BITS);
  end;
{$endif}

{ Like DESCALE, but applies to a DCTELEM and produces an int.
  We assume that int right shift is unsigned if INT32 right shift is. }

//==============================================================================
//
// IDESCALE
//
//==============================================================================
function IDESCALE(x : DCTELEM; n : int) : int;
{$ifdef BITS_IN_JSAMPLE_IS_8}
const
  DCTELEMBITS = 16;  { DCTELEM may be 16 or 32 bits }
{$else}
const
  DCTELEMBITS = 32;  { DCTELEM must be 32 bits }
{$endif}
var
  ishift_temp : DCTELEM;
begin
{$ifndef USE_ACCURATE_ROUNDING}
  ishift_temp := x + (INT32(1) shl (n-1));
{$else}
{ We can gain a little more speed, with a further compromise in accuracy,
  by omitting the addition in a descaling shift.  This yields an incorrectly
  rounded result half the time... }
  ishift_temp := x;
{$endif}

{$ifdef RIGHT_SHIFT_IS_UNSIGNED}
  if ishift_temp < 0 then
    IDescale :=  (ishift_temp shr n)
             or ((not DCTELEM(0)) shl (DCTELEMBITS-n))
  else
{$endif}
    IDescale :=  (ishift_temp shr n);
end;

{ Perform dequantization and inverse DCT on one block of coefficients. }

{GLOBAL}

//==============================================================================
//
// jpeg_idct_ifast 
//
//==============================================================================
procedure jpeg_idct_ifast (cinfo : j_decompress_ptr;
                           compptr : jpeg_component_info_ptr;
               coef_block : JCOEFPTR;
               output_buf : JSAMPARRAY;
                           output_col : JDIMENSION);
type
  PWorkspace = ^TWorkspace;
  TWorkspace = coef_bits_field; { buffers data between passes }
var
  tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7 : DCTELEM;
  tmp10, tmp11, tmp12, tmp13 : DCTELEM;
  z5, z10, z11, z12, z13 : DCTELEM;
  inptr : JCOEFPTR;
  quantptr : IFAST_MULT_TYPE_FIELD_PTR;
  wsptr : PWorkspace;
  outptr : JSAMPROW;
  range_limit : JSAMPROW;
  ctr : int;
  workspace : TWorkspace;        { buffers data between passes }
  {SHIFT_TEMPS}      { for DESCALE }
  {ISHIFT_TEMPS}    { for IDESCALE }
var
  dcval : int;
var
  dcval_ : JSAMPLE;
begin
{ Each IDCT routine is responsible for range-limiting its results and
  converting them to unsigned form (0..MAXJSAMPLE).  The raw outputs could
  be quite far out of range if the input data is corrupt, so a bulletproof
  range-limiting step is required.  We use a mask-and-table-lookup method
  to do the combined operations quickly.  See the comments with
  prepare_range_limit_table (in jdmaster.c) for more info. }

  range_limit := JSAMPROW(@(cinfo^.sample_range_limit^[CENTERJSAMPLE]));
  { Pass 1: process columns from input, store into work array. }

  inptr := coef_block;
  quantptr := IFAST_MULT_TYPE_FIELD_PTR(compptr^.dct_table);
  wsptr := @workspace;
  for ctr := pred(DCTSIZE) downto 0 do
  begin
    { Due to quantization, we will usually find that many of the input
      coefficients are zero, especially the AC terms.  We can exploit this
      by short-circuiting the IDCT calculation for any column in which all
      the AC terms are zero.  In that case each output is equal to the
      DC coefficient (with scale factor as needed).
      With typical images and quantization tables, half or more of the
      column DCT calculations can be simplified this way. }

    if (inptr^[DCTSIZE*1]=0) and (inptr^[DCTSIZE*2]=0) and (inptr^[DCTSIZE*3]=0) and
       (inptr^[DCTSIZE*4]=0) and (inptr^[DCTSIZE*5]=0) and (inptr^[DCTSIZE*6]=0) and
       (inptr^[DCTSIZE*7]=0) then
    begin
      { AC terms all zero }
      dcval := int(DEQUANTIZE(inptr^[DCTSIZE*0], quantptr^[DCTSIZE*0]));

      wsptr^[DCTSIZE*0] := dcval;
      wsptr^[DCTSIZE*1] := dcval;
      wsptr^[DCTSIZE*2] := dcval;
      wsptr^[DCTSIZE*3] := dcval;
      wsptr^[DCTSIZE*4] := dcval;
      wsptr^[DCTSIZE*5] := dcval;
      wsptr^[DCTSIZE*6] := dcval;
      wsptr^[DCTSIZE*7] := dcval;

      inc(JCOEF_PTR(inptr));    { advance pointers to next column }
      inc(IFAST_MULT_TYPE_PTR(quantptr));
      inc(int_ptr(wsptr));
      continue;
    end;

    { Even part }

    tmp0 := DEQUANTIZE(inptr^[DCTSIZE*0], quantptr^[DCTSIZE*0]);
    tmp1 := DEQUANTIZE(inptr^[DCTSIZE*2], quantptr^[DCTSIZE*2]);
    tmp2 := DEQUANTIZE(inptr^[DCTSIZE*4], quantptr^[DCTSIZE*4]);
    tmp3 := DEQUANTIZE(inptr^[DCTSIZE*6], quantptr^[DCTSIZE*6]);

    tmp10 := tmp0 + tmp2;  { phase 3 }
    tmp11 := tmp0 - tmp2;

    tmp13 := tmp1 + tmp3;  { phases 5-3 }
    tmp12 := MULTIPLY(tmp1 - tmp3, FIX_1_414213562) - tmp13; { 2*c4 }

    tmp0 := tmp10 + tmp13;  { phase 2 }
    tmp3 := tmp10 - tmp13;
    tmp1 := tmp11 + tmp12;
    tmp2 := tmp11 - tmp12;

    { Odd part }

    tmp4 := DEQUANTIZE(inptr^[DCTSIZE*1], quantptr^[DCTSIZE*1]);
    tmp5 := DEQUANTIZE(inptr^[DCTSIZE*3], quantptr^[DCTSIZE*3]);
    tmp6 := DEQUANTIZE(inptr^[DCTSIZE*5], quantptr^[DCTSIZE*5]);
    tmp7 := DEQUANTIZE(inptr^[DCTSIZE*7], quantptr^[DCTSIZE*7]);

    z13 := tmp6 + tmp5;    { phase 6 }
    z10 := tmp6 - tmp5;
    z11 := tmp4 + tmp7;
    z12 := tmp4 - tmp7;

    tmp7 := z11 + z13;    { phase 5 }
    tmp11 := MULTIPLY(z11 - z13, FIX_1_414213562); { 2*c4 }

    z5 := MULTIPLY(z10 + z12, FIX_1_847759065); { 2*c2 }
    tmp10 := MULTIPLY(z12, FIX_1_082392200) - z5; { 2*(c2-c6) }
    tmp12 := MULTIPLY(z10, - FIX_2_613125930) + z5; { -2*(c2+c6) }

    tmp6 := tmp12 - tmp7;  { phase 2 }
    tmp5 := tmp11 - tmp6;
    tmp4 := tmp10 + tmp5;

    wsptr^[DCTSIZE*0] := int (tmp0 + tmp7);
    wsptr^[DCTSIZE*7] := int (tmp0 - tmp7);
    wsptr^[DCTSIZE*1] := int (tmp1 + tmp6);
    wsptr^[DCTSIZE*6] := int (tmp1 - tmp6);
    wsptr^[DCTSIZE*2] := int (tmp2 + tmp5);
    wsptr^[DCTSIZE*5] := int (tmp2 - tmp5);
    wsptr^[DCTSIZE*4] := int (tmp3 + tmp4);
    wsptr^[DCTSIZE*3] := int (tmp3 - tmp4);

    inc(JCOEF_PTR(inptr));    { advance pointers to next column }
    inc(IFAST_MULT_TYPE_PTR(quantptr));
    inc(int_ptr(wsptr));
  end;

  { Pass 2: process rows from work array, store into output array. }
  { Note that we must descale the results by a factor of 8 == 2**3, }
  { and also undo the PASS1_BITS scaling. }

  wsptr := @workspace;
  for ctr := 0 to pred(DCTSIZE) do
  begin
    outptr := JSAMPROW(@output_buf^[ctr]^[output_col]);
    { Rows of zeroes can be exploited in the same way as we did with columns.
      However, the column calculation has created many nonzero AC terms, so
      the simplification applies less often (typically 5% to 10% of the time).
      On machines with very fast multiplication, it's possible that the
      test takes more time than it's worth.  In that case this section
      may be commented out. }

{$ifndef NO_ZERO_ROW_TEST}
    if (wsptr^[1]=0) and (wsptr^[2]=0) and (wsptr^[3]=0) and (wsptr^[4]=0) and
       (wsptr^[5]=0) and (wsptr^[6]=0) and (wsptr^[7]=0) then
    begin
      { AC terms all zero }
      dcval_ := range_limit^[IDESCALE(wsptr^[0], PASS1_BITS+3)
                          and RANGE_MASK];

      outptr^[0] := dcval_;
      outptr^[1] := dcval_;
      outptr^[2] := dcval_;
      outptr^[3] := dcval_;
      outptr^[4] := dcval_;
      outptr^[5] := dcval_;
      outptr^[6] := dcval_;
      outptr^[7] := dcval_;

      inc(int_ptr(wsptr), DCTSIZE);  { advance pointer to next row }
      continue;
    end;
{$endif}

    { Even part }

    tmp10 := (DCTELEM(wsptr^[0]) + DCTELEM(wsptr^[4]));
    tmp11 := (DCTELEM(wsptr^[0]) - DCTELEM(wsptr^[4]));

    tmp13 := (DCTELEM(wsptr^[2]) + DCTELEM(wsptr^[6]));
    tmp12 := MULTIPLY(DCTELEM(wsptr^[2]) - DCTELEM(wsptr^[6]), FIX_1_414213562)
      - tmp13;

    tmp0 := tmp10 + tmp13;
    tmp3 := tmp10 - tmp13;
    tmp1 := tmp11 + tmp12;
    tmp2 := tmp11 - tmp12;

    { Odd part }

    z13 := DCTELEM(wsptr^[5]) + DCTELEM(wsptr^[3]);
    z10 := DCTELEM(wsptr^[5]) - DCTELEM(wsptr^[3]);
    z11 := DCTELEM(wsptr^[1]) + DCTELEM(wsptr^[7]);
    z12 := DCTELEM(wsptr^[1]) - DCTELEM(wsptr^[7]);

    tmp7 := z11 + z13;    { phase 5 }
    tmp11 := MULTIPLY(z11 - z13, FIX_1_414213562); { 2*c4 }

    z5 := MULTIPLY(z10 + z12, FIX_1_847759065); { 2*c2 }
    tmp10 := MULTIPLY(z12, FIX_1_082392200) - z5; { 2*(c2-c6) }
    tmp12 := MULTIPLY(z10, - FIX_2_613125930) + z5; { -2*(c2+c6) }

    tmp6 := tmp12 - tmp7;  { phase 2 }
    tmp5 := tmp11 - tmp6;
    tmp4 := tmp10 + tmp5;

    { Final output stage: scale down by a factor of 8 and range-limit }

    outptr^[0] := range_limit^[IDESCALE(tmp0 + tmp7, PASS1_BITS+3)
          and RANGE_MASK];
    outptr^[7] := range_limit^[IDESCALE(tmp0 - tmp7, PASS1_BITS+3)
          and RANGE_MASK];
    outptr^[1] := range_limit^[IDESCALE(tmp1 + tmp6, PASS1_BITS+3)
          and RANGE_MASK];
    outptr^[6] := range_limit^[IDESCALE(tmp1 - tmp6, PASS1_BITS+3)
          and RANGE_MASK];
    outptr^[2] := range_limit^[IDESCALE(tmp2 + tmp5, PASS1_BITS+3)
          and RANGE_MASK];
    outptr^[5] := range_limit^[IDESCALE(tmp2 - tmp5, PASS1_BITS+3)
          and RANGE_MASK];
    outptr^[4] := range_limit^[IDESCALE(tmp3 + tmp4, PASS1_BITS+3)
          and RANGE_MASK];
    outptr^[3] := range_limit^[IDESCALE(tmp3 - tmp4, PASS1_BITS+3)
          and RANGE_MASK];

    inc(int_ptr(wsptr), DCTSIZE);  { advance pointer to next row }
  end;
end;

end.
