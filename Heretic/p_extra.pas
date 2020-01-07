//------------------------------------------------------------------------------
//
//  DelphiHeretic: A modified and improved Heretic port for Windows
//  based on original Linux Doom as published by "id Software", on
//  Heretic source as published by "Raven" software and DelphiDoom
//  as published by Jim Valavanis.
//  Copyright (C) 2004-2020 by Jim Valavanis
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
//  Site  : http://sourceforge.net/projects/delphidoom/
//------------------------------------------------------------------------------

{$I Doom32.inc}

unit p_extra;

//
// JVAL
// Extra mobj functions

interface

uses
  m_fixed,
  p_mobj_h;

procedure A_LowGravity(actor: Pmobj_t);

procedure A_NoGravity(actor: Pmobj_t);

procedure A_Gravity(actor: Pmobj_t);

procedure A_MeleeAttack(actor: Pmobj_t);

procedure A_Die(actor: Pmobj_t);

procedure A_CustomBulletAttack(actor: Pmobj_t);

procedure A_Countdown(actor: Pmobj_t);

procedure A_FastChase(actor: Pmobj_t);

procedure A_SetInvulnerable(actor: Pmobj_t);

procedure A_UnSetInvulnerable(actor: Pmobj_t);

procedure A_FloatBob(actor: Pmobj_t);

procedure A_NoFloatBob(actor: Pmobj_t);

procedure A_ComboAttack(actor: Pmobj_t);

procedure A_BulletAttack(actor: Pmobj_t);

procedure A_MediumGravity(actor: Pmobj_t);

procedure A_PlayerMessage(actor: Pmobj_t);

implementation

uses
  d_delphi,
  doomdef,
  d_player,
  g_game,
  i_system,
  info_h,
  info,
  m_rnd,
  m_vectors,
  p_enemy,
  p_mobj,
  p_inter,
  p_map,
  p_maputl,
  p_local,
  p_pspr,
  p_common,
  r_main,
  sounds,
  s_sound,
  tables;

//
// JVAL
// Low gravity
//
procedure A_LowGravity(actor: Pmobj_t);
begin
  actor.flags := actor.flags and (not MF_NOGRAVITY);
  actor.flags2 := actor.flags2 or MF2_LOGRAV;
  actor.flags_ex := actor.flags_ex or MF_EX_LOWGRAVITY;
  actor.flags2_ex := actor.flags2_ex and (not MF2_EX_MEDIUMGRAVITY);
end;

//
// JVAL
// Remove gravity
//
procedure A_NoGravity(actor: Pmobj_t);
begin
  actor.flags := actor.flags or MF_NOGRAVITY;
  actor.flags2 := actor.flags2 and (not MF2_LOGRAV);
  actor.flags_ex := actor.flags_ex and (not MF_EX_LOWGRAVITY);
  actor.flags2_ex := actor.flags2_ex and (not MF2_EX_MEDIUMGRAVITY);
end;

//
// JVAL
// Normal gravity
//
procedure A_Gravity(actor: Pmobj_t);
begin
  actor.flags := actor.flags and (not MF_NOGRAVITY);
  actor.flags2 := actor.flags2 and (not MF2_LOGRAV);
  actor.flags_ex := actor.flags_ex and (not MF_EX_LOWGRAVITY);
  actor.flags2_ex := actor.flags2_ex and (not MF2_EX_MEDIUMGRAVITY);
end;

//
// JVAL
// Close distance attack
// A_MeleeAttack(mindamage=0; maxdamage=0);
//
procedure A_MeleeAttack(actor: Pmobj_t);
var
  dmin, dmax: integer;  // Minimum and maximum damage
  damage: integer;
begin
  if actor.target = nil then
    exit;

  A_FaceTarget(actor);
  if P_CheckMeleeRange(actor) then
  begin
    if actor.info.meleesound > 0 then
    begin
      if actor.flags_ex and MF_EX_RANDOMMELEESOUND <> 0 then
        P_RandomSound(actor, actor.info.meleesound)
      else
        S_StartSound(actor, actor.info.meleesound);
    end;
    if actor.state.params = nil then
      damage := actor.info.meleedamage
    else
    begin
      if actor.state.params.Count = 1 then
      begin
        dmin := actor.state.params.IntVal[0];
        dmax := dmin;
      end
      else
      begin
        dmin := actor.state.params.IntVal[0];
        dmax := actor.state.params.IntVal[1];
      end;
      if dmax < dmin then
      begin
        damage := dmax;
        dmax := dmin;
        dmin := damage;
      end;
      damage := dmin + N_Random mod (dmax - dmin + 1);
    end;
    P_DamageMobj(actor.target, actor, actor, damage);
  end;
end;

procedure A_Die(actor: Pmobj_t);
begin
  actor.flags_ex := actor.flags_ex and not MF_EX_INVULNERABLE;  // Clear invulnerability flag
  actor.flags2_ex := actor.flags2_ex and not MF2_EX_NODAMAGE;   // Clear no damage flag
  if G_PlayingEngineVersion > VERSION114 then
    P_DamageMobj(actor, nil, nil, 10000)
  else
    P_DamageMobj(actor, nil, nil, actor.health);
end;

//
// CustomBulletAttack(spread_xy, numbullets, damageperbullet, range)
//
procedure A_CustomBulletAttack(actor: Pmobj_t);
var
  spread_xy: angle_t;
  numbullets: integer;
  damageperbullet: integer;
  range: fixed_t;
  i: integer;
  angle, bangle: angle_t;
  slope: fixed_t;
  rnd: byte;
begin
  if not P_CheckStateParams(actor) then
    exit;

  if actor.target = nil then
    exit;

  spread_xy := round(actor.state.params.FloatVal[0] * ANG1);
  numbullets := actor.state.params.IntVal[1];
  damageperbullet := actor.state.params.IntVal[2];
  range := actor.state.params.FixedVal[3];

  if range <= 0 then
    range := MISSILERANGE;

  A_FaceTarget(actor);
  bangle := actor.angle;

  slope := P_AimLineAttack(actor, bangle, range);

  if actor.info.flags_ex and MF_EX_RANDOMATTACKSOUND <> 0 then
    P_RandomSound(actor, actor.info.attacksound)
  else
    S_StartSound(actor, actor.info.attacksound);

  spread_xy := spread_xy div 256;
  for i := 0 to numbullets - 1 do
  begin
    rnd := N_Random;
    angle := bangle + 128 * spread_xy - rnd * spread_xy;
    P_LineAttack(actor, angle, range, slope, damageperbullet);
  end;
end;

//
// A_Countdown(void)
//
procedure A_Countdown(actor: Pmobj_t);
begin
  dec(actor.reactiontime);
  if actor.reactiontime <= 0 then
  begin
    P_ExplodeMissile(actor);
    actor.flags := actor.flags and not MF_SKULLFLY;
  end;
end;

procedure A_FastChase(actor: Pmobj_t);
begin
  P_DoChase(actor, true);
end;

procedure A_SetInvulnerable(actor: Pmobj_t);
begin
  actor.flags_ex := actor.flags_ex or MF_EX_INVULNERABLE;
end;

procedure A_UnSetInvulnerable(actor: Pmobj_t);
begin
  actor.flags_ex := actor.flags_ex and not MF_EX_INVULNERABLE;
end;

procedure A_FloatBob(actor: Pmobj_t);
begin
  actor.flags_ex := actor.flags_ex or MF_EX_FLOATBOB;
  actor.flags2 := actor.flags2 or MF2_FLOATBOB;
end;

procedure A_NoFloatBob(actor: Pmobj_t);
begin
  actor.flags_ex := actor.flags_ex and not MF_EX_FLOATBOB;
  actor.flags2 := actor.flags2 and not MF2_FLOATBOB;
end;

procedure A_Missile(actor: Pmobj_t);
begin
  actor.flags := actor.flags or MF_MISSILE;
end;

procedure A_NoMissile(actor: Pmobj_t);
begin
  actor.flags := actor.flags and not MF_MISSILE;
end;

//
// A_ComboAttack(void)
//
procedure A_ComboAttack(actor: Pmobj_t);
var
  missile: Pmobj_t;
  mobj_no: integer;
begin
  A_FaceTarget(actor);

  if P_CheckMeleeRange(actor) then
  begin
    if actor.info.meleesound > 0 then
    begin
      if actor.flags_ex and MF_EX_RANDOMMELEESOUND <> 0 then
        P_RandomSound(actor, actor.info.meleesound)
      else
        S_StartSound(actor, actor.info.meleesound);
    end;
    P_DamageMobj(actor.target, actor, actor, actor.info.meleedamage);
  end
  else
  begin
    mobj_no := actor.info.missiletype;

    if mobj_no <= 0 then
      exit;

    if mobjinfo[mobj_no].speed < 256 then
      mobjinfo[mobj_no].speed := mobjinfo[mobj_no].speed * FRACUNIT;  // JVAL fix me!!!

    actor.z := actor.z;
    missile := P_SpawnMissile(actor, actor.target, mobj_no);
    actor.z := actor.z;

    if missile <> nil then
    begin
      if missile.info.flags_ex and MF_EX_SEEKERMISSILE <> 0 then
        missile.tracer := actor.target;
    end;
  end;
end;

//
// A_BulletAttack(numbullets: integer [optional])
//
procedure A_BulletAttack(actor: Pmobj_t);
var
  i: integer;
  angle, bangle: angle_t;
  slope: fixed_t;
  damage: integer;
  numbullets: integer;
begin
  if actor.target = nil then
    exit;

  A_FaceTarget(actor);
  bangle := actor.angle;

  slope := P_AimLineAttack(actor, bangle, MISSILERANGE);

  if actor.info.flags_ex and MF_EX_RANDOMATTACKSOUND <> 0 then
    P_RandomSound(actor, actor.info.attacksound)
  else
    S_StartSound(actor, actor.info.attacksound);

// Attack with a customizable amount of bullets (specified in damage)
  numbullets := actor.info.damage;
// If parameter specified, then use parameter as custom number of bullets
  if actor.state.params <> nil then
    if actor.state.params.Count = 1 then
      numbullets := actor.state.params.IntVal[0];

  for i := 0 to numbullets - 1 do
  begin
    angle := bangle + _SHLW(P_Random - P_Random, 20);
    damage := ((P_Random mod 5) + 1) * 3;
    P_LineAttack(actor, angle, MISSILERANGE, slope, damage);
  end;
end;

//
// JVAL
// Medium gravity
//
procedure A_MediumGravity(actor: Pmobj_t);
begin
  actor.flags := actor.flags and (not MF_NOGRAVITY);
  actor.flags_ex := actor.flags_ex and (not MF_EX_LOWGRAVITY);
  actor.flags2_ex := actor.flags2_ex or MF2_EX_MEDIUMGRAVITY;
end;

//
// A_PlayerMessage
//
procedure A_PlayerMessage(actor: Pmobj_t);
var
  p: Pplayer_t;
  msg: string;
  i: integer;
begin
  if not P_CheckStateParams(actor) then
    exit;

  p := actor.player;
  if p = nil then
  begin
    if actor.target <> nil then
      Exit;
    p := actor.target.player;
    if p = nil then
      exit;
  end;

  msg := actor.state.params.StrVal[0];
  for i := 1 to actor.state.params.Count - 1 do
    msg := msg + ' ' + actor.state.params.StrVal[i];

  p._message := msg;
end;

end.

