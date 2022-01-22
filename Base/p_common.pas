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
//  Foundation, inc., 59 Temple Place - Suite 330, Boston, MA
//  02111-1307, USA.
//
//------------------------------------------------------------------------------
//  Site  : https://sourceforge.net/projects/delphidoom/
//------------------------------------------------------------------------------

{$I Doom32.inc}

unit p_common;

interface

uses
  d_player,
  m_fixed,
  tables,
  info_h,
  p_pspr_h,
  p_mobj_h;

const
  CSP_AT_LEAST = 1;
  CSP_AT_MOST = 2;

function P_CheckStateParams(actor: Pmobj_t; const numparms: integer = -1; const flags: LongWord = 0): boolean;

procedure A_GoTo(actor: Pmobj_t);

procedure A_GoToIfCloser(actor: Pmobj_t);

procedure A_GoToIfHealthLower(actor: Pmobj_t);

procedure A_ConsoleCommand(actor: Pmobj_t);

procedure A_SetFrightened(actor: Pmobj_t);

procedure A_UnSetFrightened(actor: Pmobj_t);

procedure A_SetNoDamage(actor: Pmobj_t);

procedure A_UnSetNoDamage(actor: Pmobj_t);

procedure A_SetCustomParam(actor: Pmobj_t);

procedure A_AddCustomParam(actor: Pmobj_t);

procedure A_SubtractCustomParam(actor: Pmobj_t);

procedure A_SetTargetCustomParam(actor: Pmobj_t);

procedure A_AddTargetCustomParam(actor: Pmobj_t);

procedure A_SubtractTargetCustomParam(actor: Pmobj_t);

procedure A_SetMasterCustomParam(actor: Pmobj_t);

procedure A_AddMasterCustomParam(actor: Pmobj_t);

procedure A_SubtractMasterCustomParam(actor: Pmobj_t);

procedure A_SetTracerCustomParam(actor: Pmobj_t);

procedure A_AddTracerCustomParam(actor: Pmobj_t);

procedure A_SubtractTracerCustomParam(actor: Pmobj_t);

procedure A_JumpIf(actor: Pmobj_t);

procedure A_JumpIfCustomParam(actor: Pmobj_t);

procedure A_JumpIfCustomParamLess(actor: Pmobj_t);

procedure A_JumpIfCustomParamGreater(actor: Pmobj_t);

procedure A_JumpIfTargetCustomParam(actor: Pmobj_t);

procedure A_JumpIfTargetCustomParamLess(actor: Pmobj_t);

procedure A_JumpIfTargetCustomParamGreater(actor: Pmobj_t);

procedure A_JumpIfMasterCustomParam(actor: Pmobj_t);

procedure A_JumpIfMasterCustomParamLess(actor: Pmobj_t);

procedure A_JumpIfMasterCustomParamGreater(actor: Pmobj_t);

procedure A_JumpIfTracerCustomParam(actor: Pmobj_t);

procedure A_JumpIfTracerCustomParamLess(actor: Pmobj_t);

procedure A_JumpIfTracerCustomParamGreater(actor: Pmobj_t);

procedure A_JumpIfMapStringEqual(actor: Pmobj_t);
procedure A_JumpIfMapStringLess(actor: Pmobj_t);
procedure A_JumpIfMapStringGreater(actor: Pmobj_t);

procedure A_JumpIfMapIntegerEqual(actor: Pmobj_t);
procedure A_JumpIfMapIntegerLess(actor: Pmobj_t);
procedure A_JumpIfMapIntegerGreater(actor: Pmobj_t);

procedure A_JumpIfMapFloatEqual(actor: Pmobj_t);
procedure A_JumpIfMapFloatLess(actor: Pmobj_t);
procedure A_JumpIfMapFloatGreater(actor: Pmobj_t);

procedure A_JumpIfWorldStringEqual(actor: Pmobj_t);
procedure A_JumpIfWorldStringLess(actor: Pmobj_t);
procedure A_JumpIfWorldStringGreater(actor: Pmobj_t);

procedure A_JumpIfWorldIntegerEqual(actor: Pmobj_t);
procedure A_JumpIfWorldIntegerLess(actor: Pmobj_t);
procedure A_JumpIfWorldIntegerGreater(actor: Pmobj_t);

procedure A_JumpIfWorldFloatEqual(actor: Pmobj_t);
procedure A_JumpIfWorldFloatLess(actor: Pmobj_t);
procedure A_JumpIfWorldFloatGreater(actor: Pmobj_t);

procedure A_GoToIfCustomParam(actor: Pmobj_t);

procedure A_GoToIfCustomParamLess(actor: Pmobj_t);

procedure A_GoToIfCustomParamGreater(actor: Pmobj_t);

procedure A_GoToIfTargetCustomParam(actor: Pmobj_t);

procedure A_GoToIfTargetCustomParamLess(actor: Pmobj_t);

procedure A_GoToIfTargetCustomParamGreater(actor: Pmobj_t);

procedure A_GoToIfMasterCustomParam(actor: Pmobj_t);

procedure A_GoToIfMasterCustomParamLess(actor: Pmobj_t);

procedure A_GoToIfMasterCustomParamGreater(actor: Pmobj_t);

procedure A_GoToIfTracerCustomParam(actor: Pmobj_t);

procedure A_GoToIfTracerCustomParamLess(actor: Pmobj_t);

procedure A_GoToIfTracerCustomParamGreater(actor: Pmobj_t);

procedure A_GoToIfMapStringEqual(actor: Pmobj_t);
procedure A_GoToIfMapStringLess(actor: Pmobj_t);
procedure A_GoToIfMapStringGreater(actor: Pmobj_t);

procedure A_GoToIfMapIntegerEqual(actor: Pmobj_t);
procedure A_GoToIfMapIntegerLess(actor: Pmobj_t);
procedure A_GoToIfMapIntegerGreater(actor: Pmobj_t);

procedure A_GoToIfMapFloatEqual(actor: Pmobj_t);
procedure A_GoToIfMapFloatLess(actor: Pmobj_t);
procedure A_GoToIfMapFloatGreater(actor: Pmobj_t);

procedure A_GoToIfWorldStringEqual(actor: Pmobj_t);
procedure A_GoToIfWorldStringLess(actor: Pmobj_t);
procedure A_GoToIfWorldStringGreater(actor: Pmobj_t);

procedure A_GoToIfWorldIntegerEqual(actor: Pmobj_t);
procedure A_GoToIfWorldIntegerLess(actor: Pmobj_t);
procedure A_GoToIfWorldIntegerGreater(actor: Pmobj_t);

procedure A_GoToIfWorldFloatEqual(actor: Pmobj_t);
procedure A_GoToIfWorldFloatLess(actor: Pmobj_t);
procedure A_GoToIfWorldFloatGreater(actor: Pmobj_t);

procedure A_CustomSound1(mo: Pmobj_t);

procedure A_CustomSound2(mo: Pmobj_t);

procedure A_CustomSound3(mo: Pmobj_t);

procedure P_RandomSound(const actor: Pmobj_t; const soundnum: integer);

procedure A_RandomPainSound(actor: Pmobj_t);

procedure A_RandomSeeSound(actor: Pmobj_t);

procedure A_RandomAttackSound(actor: Pmobj_t);

procedure A_RandomDeathSound(actor: Pmobj_t);

procedure A_RandomActiveSound(actor: Pmobj_t);

procedure A_RandomRipSound(actor: Pmobj_t);

procedure A_RandomCustomSound1(actor: Pmobj_t);

procedure A_RandomCustomSound2(actor: Pmobj_t);

procedure A_RandomCustomSound3(actor: Pmobj_t);

procedure A_RandomCustomSound(actor: Pmobj_t);

procedure A_RandomMeleeSound(actor: Pmobj_t);

procedure A_Playsound(actor: Pmobj_t);

procedure A_PlayWeaponsound(actor: Pmobj_t);

procedure A_RandomSound(actor: Pmobj_t);

procedure A_Stop(actor: Pmobj_t);

procedure A_Jump(actor: Pmobj_t);

procedure A_CustomMissile(actor: Pmobj_t);

procedure A_RandomMissile(actor: Pmobj_t);

procedure A_SpawnItem(actor: Pmobj_t);

procedure A_SpawnItemEx(actor: Pmobj_t);

procedure A_SeekerMissile(actor: Pmobj_t);

procedure A_CStaffMissileSlither(actor: Pmobj_t);

procedure A_SetTranslucent(actor: Pmobj_t);

procedure A_FadeOut(actor: Pmobj_t);

procedure A_FadeOut10(actor: Pmobj_t);

procedure A_FadeOut20(actor: Pmobj_t);

procedure A_FadeOut30(actor: Pmobj_t);

procedure A_FadeIn(actor: Pmobj_t);

procedure A_FadeIn10(actor: Pmobj_t);

procedure A_FadeIn20(actor: Pmobj_t);

procedure A_FadeIn30(actor: Pmobj_t);

procedure A_MissileAttack(actor: Pmobj_t);

procedure A_AdjustSideSpot(actor: Pmobj_t);

procedure A_ThrustZ(actor: Pmobj_t);

procedure A_ThrustXY(actor: Pmobj_t);

procedure A_Turn(actor: Pmobj_t);

procedure A_JumpIfCloser(actor: Pmobj_t);

procedure A_JumpIfHealthLower(actor: Pmobj_t);

procedure A_ScreamAndUnblock(actor: Pmobj_t);

procedure A_Missile(actor: Pmobj_t);

procedure A_NoMissile(actor: Pmobj_t);

procedure A_Wander(actor: Pmobj_t);

procedure A_GhostOn(actor: Pmobj_t);

procedure A_GhostOff(actor: Pmobj_t);

procedure A_Turn5(actor: Pmobj_t);

procedure A_Turn10(actor: Pmobj_t);

procedure A_Blocking(actor: Pmobj_t);

procedure A_DoNotRunScripts(actor: Pmobj_t);

procedure A_DoRunScripts(actor: Pmobj_t);

procedure A_SetDropItem(actor: Pmobj_t);

procedure A_SetDefaultDropItem(actor: Pmobj_t);

procedure A_TargetDropItem(actor: Pmobj_t);

procedure A_DefaultTargetDropItem(actor: Pmobj_t);

function P_ActorTarget(const actor: Pmobj_t): Pmobj_t;

procedure A_GlobalEarthQuake(actor: Pmobj_t);

procedure A_SetMapStr(actor: Pmobj_t);

procedure A_SetWorldStr(actor: Pmobj_t);

procedure A_SetMapInt(actor: Pmobj_t);

procedure A_SetWorldInt(actor: Pmobj_t);

procedure A_SetMapFloat(actor: Pmobj_t);

procedure A_SetWorldFloat(actor: Pmobj_t);

procedure A_RandomGoto(actor: Pmobj_t);

procedure A_ResetHealth(actor: Pmobj_t);

procedure A_SetHealth(actor: Pmobj_t);

procedure A_ResetTargetHealth(actor: Pmobj_t);

procedure A_SetTargetHealth(actor: Pmobj_t);

procedure A_Recoil(actor: Pmobj_t);

procedure A_SetSolid(actor: Pmobj_t);

procedure A_UnSetSolid(actor: Pmobj_t);

procedure A_SetFloat(actor: Pmobj_t);

procedure A_UnSetFloat(actor: Pmobj_t);

procedure A_ScaleVelocity(actor: Pmobj_t);

procedure A_ChangeVelocity(actor: Pmobj_t);

procedure A_SetPushFactor(actor: Pmobj_t);

procedure A_SetScale(actor: Pmobj_t);

procedure A_SetGravity(actor: Pmobj_t);

procedure A_SetFloorBounce(actor: Pmobj_t);

procedure A_UnSetFloorBounce(actor: Pmobj_t);

procedure A_SetCeilingBounce(actor: Pmobj_t);

procedure A_UnSetCeilingBounce(actor: Pmobj_t);

procedure A_SetWallBounce(actor: Pmobj_t);

procedure A_UnSetWallBounce(actor: Pmobj_t);

procedure A_GlowLight(actor: Pmobj_t);

procedure A_TraceNearestPlayer(actor: Pmobj_t);

procedure A_ChangeFlag(actor: Pmobj_t);

procedure A_CheckFloor(actor: Pmobj_t);

procedure A_CheckCeiling(actor: Pmobj_t);

procedure A_StopSound(actor: Pmobj_t);

procedure A_JumpIfTargetOutsideMeleeRange(actor: Pmobj_t);

procedure A_JumpIfTargetInsideMeleeRange(actor: Pmobj_t);

procedure A_JumpIfTracerCloser(actor: Pmobj_t);

procedure A_SetMass(actor: Pmobj_t);

procedure A_SetTargetMass(actor: Pmobj_t);

procedure A_SetTracerMass(actor: Pmobj_t);

procedure A_SetMasterMass(actor: Pmobj_t);

procedure A_CheckSight(actor: Pmobj_t);

procedure A_CheckSightOrRange(actor: Pmobj_t);

procedure A_CheckRange(actor: Pmobj_t);

procedure A_CountdownArg(actor: Pmobj_t);

procedure A_SetArg(actor: Pmobj_t);

procedure A_SetMasterArg(actor: Pmobj_t);

procedure A_SetTargetArg(actor: Pmobj_t);

procedure A_SetTracerArg(actor: Pmobj_t);

procedure A_SetSpecial(actor: Pmobj_t);

procedure A_CheckFlag(actor: Pmobj_t);

procedure A_SetAngle(actor: Pmobj_t);

procedure A_SetUserVar(actor: Pmobj_t);

procedure A_SetUserArray(actor: Pmobj_t);

procedure A_SetTics(actor: Pmobj_t);

procedure A_DropItem(actor: Pmobj_t);

procedure A_DamageSelf(actor: Pmobj_t);

procedure A_DamageTarget(actor: Pmobj_t);

procedure A_DamageTracer(actor: Pmobj_t);

procedure A_DamageMaster(actor: Pmobj_t);

procedure A_KillTarget(actor: Pmobj_t);

procedure A_KillTracer(actor: Pmobj_t);

procedure A_KillMaster(actor: Pmobj_t);

procedure A_RemoveTarget(actor: Pmobj_t);

procedure A_RemoveTracer(actor: Pmobj_t);

procedure A_RemoveMaster(actor: Pmobj_t);

procedure A_Remove(actor: Pmobj_t);

procedure A_SetFloatBobPhase(actor: Pmobj_t);

procedure A_Detonate(actor: Pmobj_t);

procedure A_Spawn(actor: Pmobj_t);

procedure A_Face(actor: Pmobj_t);

procedure A_Scratch(actor: Pmobj_t);

procedure A_RandomJump(obj: pointer; psp: Ppspdef_t);

{$IFNDEF HEXEN}
procedure A_LineEffect(actor: Pmobj_t);
{$ENDIF}

procedure A_FlipSprite(actor: Pmobj_t);

procedure A_RandomFlipSprite(actor: Pmobj_t);

procedure A_NoFlipSprite(actor: Pmobj_t);

procedure A_RandomNoFlipSprite(actor: Pmobj_t);

procedure A_ChangeSpriteFlip(actor: Pmobj_t);

procedure A_CustomMeleeAttack(actor: Pmobj_t);

procedure A_CustomComboAttack(actor: Pmobj_t);

procedure A_SetRenderStyle(actor: Pmobj_t);

procedure A_FadeTo(actor: Pmobj_t);

procedure A_SetSize(actor: Pmobj_t);

procedure A_RaiseMaster(actor: Pmobj_t);

procedure A_RaiseChildren(actor: Pmobj_t);

procedure A_RaiseSiblings(actor: Pmobj_t);

procedure A_HealThing(actor: Pmobj_t);

procedure A_BasicAttack(actor: Pmobj_t);

procedure A_Tracer2(actor: Pmobj_t);

procedure A_MonsterRefire(actor: Pmobj_t);

procedure A_RearrangePointers(actor: Pmobj_t);

procedure A_TransferPointer(actor: Pmobj_t);

procedure A_AlertMonsters(actor: Pmobj_t);

procedure A_LocalEarthQuake(actor: Pmobj_t);

procedure A_RemoveChildren(actor: Pmobj_t);

procedure A_RemoveSiblings(actor: Pmobj_t);

procedure A_KillChildren(actor: Pmobj_t);

procedure A_KillSiblings(actor: Pmobj_t);

procedure A_Weave(actor: Pmobj_t);

procedure A_SetWeaveIndexXY(actor: Pmobj_t);

procedure A_SetWeaveIndexZ(actor: Pmobj_t);

procedure A_SetWeaveIndexes(actor: Pmobj_t);

procedure A_SetSpriteDX(actor: Pmobj_t);

procedure A_SetSpriteDY(actor: Pmobj_t);

procedure A_SetHeight(actor: Pmobj_t);

procedure A_SetFriction(actor: Pmobj_t);

procedure A_PlayerHurtExplode(actor: Pmobj_t);

procedure A_SetPainChance(actor: Pmobj_t);

procedure A_SetPushable(actor: Pmobj_t);

procedure A_UnSetPushable(actor: Pmobj_t);

procedure A_MatchTargetZ(actor: Pmobj_t);

procedure A_SetInteractive(actor: Pmobj_t);

procedure A_UnSetInteractive(actor: Pmobj_t);

procedure A_SetMonsterInfight(actor: Pmobj_t);

procedure A_UnSetMonsterInfight(actor: Pmobj_t);

function P_CheckCustomMeleeRange(actor: Pmobj_t; mrange: integer): boolean;

function P_FaceMobj(source: Pmobj_t; target: Pmobj_t; var delta: angle_t): integer;

function P_CheckFov(t1, t2: Pmobj_t; ffov: angle_t): boolean;

function P_RoughTargetSearch(mo: Pmobj_t; ffov: angle_t; distance: integer): Pmobj_t;

// MBF21
procedure P_ResolveMBF21Flags(const m: Pmobjinfo_t);

function P_CheckStateArgs(state: Pstate_t): boolean;

function P_InfightingImmune(target, source: Pmobj_t): boolean;

function P_ProjectileImmune(target, source: Pmobj_t): boolean;

function P_SplashImmune(target, spot: Pmobj_t): boolean;

procedure A_SpawnObject(actor: Pmobj_t);

procedure A_MonsterProjectile(actor: Pmobj_t);

procedure A_MonsterBulletAttack(actor: Pmobj_t);

procedure A_MonsterMeleeAttack(actor: Pmobj_t);

procedure A_RadiusDamage(actor: Pmobj_t);

procedure A_NoiseAlert(actor: Pmobj_t);

function P_HealCorpse(actor: Pmobj_t; radius: integer; healstate: integer; healsound: integer): boolean;

procedure A_HealChase(actor: Pmobj_t);

function P_SeekerMissileEx(actor: Pmobj_t; var tracer: Pmobj_t; const thresh, turnMax: angle_t;
  const centerseek: boolean): boolean;

procedure A_SeekTracer(actor: Pmobj_t);

procedure A_FindTracer(actor: Pmobj_t);

procedure A_ClearTracer(actor: Pmobj_t);

procedure A_JumpIfHealthBelow(actor: Pmobj_t);

procedure A_JumpIfTargetInSight(actor: Pmobj_t);

procedure A_JumpIfTargetCloser(actor: Pmobj_t);

procedure A_JumpIfTracerInSight(actor: Pmobj_t);

procedure A_JumpIfTracerCloserMBF21(actor: Pmobj_t);

procedure A_JumpIfFlagsSet(actor: Pmobj_t);

procedure A_AddFlags(actor: Pmobj_t);

procedure A_RemoveFlags(actor: Pmobj_t);

procedure A_WeaponProjectile(player: Pplayer_t; psp: Ppspdef_t);

procedure A_WeaponBulletAttack(player: Pplayer_t; psp: Ppspdef_t);

procedure A_WeaponMeleeAttack(player: Pplayer_t; psp: Ppspdef_t);

procedure A_WeaponSound(player: Pplayer_t; psp: Ppspdef_t);

procedure A_WeaponAlert(player: Pplayer_t; psp: Ppspdef_t);

procedure A_WeaponJump(player: Pplayer_t; psp: Ppspdef_t);

procedure A_ConsumeAmmo(player: Pplayer_t; psp: Ppspdef_t);

procedure A_CheckAmmo(player: Pplayer_t; psp: Ppspdef_t);

procedure A_RefireTo(player: Pplayer_t; psp: Ppspdef_t);

procedure A_GunFlashTo(player: Pplayer_t; psp: Ppspdef_t);

// Non MBF21 codeptrs for manupulating MBF21 features
procedure A_SetProjectileGroup(actor: Pmobj_t);

procedure A_SetInfightingGroup(actor: Pmobj_t);

procedure A_SetSplashGroup(actor: Pmobj_t);

procedure A_SetTranslation(actor: Pmobj_t);

// MBF21 flags
const
  // low gravity
  MF_MBF21_LOGRAV = 1;
  // short missile range
  MF_MBF21_SHORTMRANGE = 2;
  // other things ignore its attacks
  MF_MBF21_DMGIGNORED = 4;
  // doesn't take splash damage
  MF_MBF21_NORADIUSDMG = 8;
  // causes splash damage even if target immune
  MF_MBF21_FORCERADIUSDMG = $10;
  // higher missile attack probability
  MF_MBF21_HIGHERMPROB = $20;
  // use half distance for missile attack probability
  MF_MBF21_RANGEHALF = $40;
  // no targeting threshold
  MF_MBF21_NOTHRESHOLD = $80;
  // long melee range
  MF_MBF21_LONGMELEE = $100;
  // full volume see/death sound + splash immunity
  MF_MBF21_BOSS = $200;
  // Tag 666 "boss" on doom 2 map 7
  MF_MBF21_MAP07BOSS1 = $400;
  // Tag 667 "boss" on doom 2 map 7
  MF_MBF21_MAP07BOSS2 = $800;
  // E1M8 boss
  MF_MBF21_E1M8BOSS = $1000;
  // E2M8 boss
  MF_MBF21_E2M8BOSS = $2000;
  // E3M8 boss
  MF_MBF21_E3M8BOSS = $4000;
  // E4M6 boss
  MF_MBF21_E4M6BOSS = $8000;
  // E4M8 boss
  MF_MBF21_E4M8BOSS = $10000;
  // projectile rips through targets
  MF_MBF21_RIP = $20000;
  // full volume see/death sound
  MF_MBF21_FULLVOLSOUNDS = $40000;

const
  FLOATBOBSIZE = 64;
  FLOATBOBMASK = FLOATBOBSIZE - 1;

  FloatBobOffsets: array[0..FLOATBOBSIZE - 1] of fixed_t = (
         0,  51389, 102283, 152192,
    200636, 247147, 291278, 332604,
    370727, 405280, 435929, 462380,
    484378, 501712, 514213, 521763,
    524287, 521763, 514213, 501712,
    484378, 462380, 435929, 405280,
    370727, 332604, 291278, 247147,
    200636, 152192, 102283,  51389,
        -1, -51390,-102284,-152193,
   -200637,-247148,-291279,-332605,
   -370728,-405281,-435930,-462381,
   -484380,-501713,-514215,-521764,
   -524288,-521764,-514214,-501713,
   -484379,-462381,-435930,-405280,
   -370728,-332605,-291279,-247148,
   -200637,-152193,-102284, -51389
  );

const
// Sector Flags
// Ladder
  SF_LADDER = 1;
// Slip while descenting if sloped
  SF_SLIPSLOPEDESCENT = 2;

// A_SpawnItemEx Flags
const
  SIXF_TRANSFERTRANSLATION = 1;
  SIXF_ABSOLUTEPOSITION = 2;
  SIXF_ABSOLUTEANGLE = 4;
  SIXF_ABSOLUTEMOMENTUM = 8;
  SIXF_SETMASTER = 16;
  SIXF_NOCHECKPOSITION = 32;
  SIXF_TELEFRAG = 64;
  // 128 is used by Skulltag!
  SIXF_TRANSFERAMBUSHFLAG = 256;
  SIXF_TRANSFERPITCH = $200;
  SIXF_TRANSFERPOINTERS = $400;
  SIXF_USEBLOODCOLOR = $800;
  SIXF_CLEARCALLERTID = $1000;
  SIXF_MULTIPLYSPEED = $2000;
  SIXF_TRANSFERSCALE = $4000;
  SIXF_TRANSFERSPECIAL = $8000;
  SIXF_CLEARCALLERSPECIAL = $10000;
  SIXF_TRANSFERSTENCILCOL = $20000;
  SIXF_TRANSFERALPHA = $40000;
  SIXF_TRANSFERRENDERSTYLE = $80000;
  SIXF_SETTARGET = $100000;
  SIXF_SETTRACER = $200000;
  SIXF_NOPOINTERS = $400000;
  SIXF_ORIGINATOR = $800000;
  SIXF_TRANSFERSPRITEFRAME = $1000000;
  SIXF_TRANSFERROLL = $2000000;
  SIXF_ISTARGET = $4000000;
  SIXF_ISMASTER = $8000000;
  SIXF_ISTRACER = $10000000;
  SIXF_DROPPED = $20000000;

// A_CustomMissile
const
  CMF_AIMOFFSET = 1;
  CMF_AIMDIRECTION = 2;
  CMF_TRACKOWNER = 4;
  CMF_CHECKTARGETDEAD = 8;
  CMF_ABSOLUTEPITCH = 16;
  CMF_OFFSETPITCH = 32;
  CMF_SAVEPITCH = 64;
  CMF_ABSOLUTEANGLE = 128;

// P_DoRemoveThing
const
  RMVF_MISSILES = 0;
  RMVF_NOMONSTERS = 1;
  RMVF_MISC = 2;
  RMVF_EVERYTHING = 4;
  RMVF_EXFILTER = 8;
  RMVF_EXSPECIES = 16;
  RMVF_EITHER = 32;

const
  SPF_FORCECLAMP = 1; // players always clamp
  SPF_INTERPOLATE = 2;

const
  FTF_REMOVE = 1;
  FTF_CLAMP = 2;

// Flags for A_AlertMonsters
const
  AMF_TARGETEMITTER = 1;
  AMF_TARGETNONPLAYER = 2;
  AMF_EMITFROMTARGET = 4;

function P_TicsFromState(const st: Pstate_t): integer;

procedure P_SetMobjRelativeState(const mo: Pmobj_t; const offset: integer);

function PlayerToId(const p: Pplayer_t): integer;

procedure P_CopyFriendliness(const originator, mo: Pmobj_t);

function P_RaiseActor(const thing, raiser: Pmobj_t): boolean;

function P_FloatSpeed(const actor: Pmobj_t): fixed_t;

procedure P_NoiseAlertEx(target: Pmobj_t; emmiter: Pmobj_t; const maxdist: fixed_t);

procedure P_LocalEarthQuake(const actor: Pmobj_t; const tics: integer; const intensity: fixed_t; const maxdist: fixed_t);

function P_NearestPlayer(const mo: Pmobj_t): Pplayer_t;

function P_CheckFlag(const mo: Pmobj_t; const aflag: string): boolean;

function P_GetPlayerMeleeRange(const p: Pplayer_t): fixed_t;

const
  xspeed: array[0..7] of fixed_t =
    (FRACUNIT, 47000, 0, -47000, -FRACUNIT, -47000, 0, 47000);

  yspeed: array[0..7] of fixed_t =
    (0, 47000, FRACUNIT, 47000, 0, -47000, -FRACUNIT, -47000);

var
  bulletslope: fixed_t;

procedure P_BulletSlope(mo: Pmobj_t);

procedure A_Delayfire(player: Pplayer_t; psp: Ppspdef_t);

implementation

uses
  d_delphi,
  doomdata,
  doomdef,
  deh_main,
  d_event,
  {$IFDEF DOOM_OR_STRIFE}
  d_items,
  {$ENDIF}
  d_think,
  m_vectors,
  i_system,
  c_con,
  g_game,
  info,
  info_common,
  info_rnd,
  p_aaptr,
  p_enemy,
  p_extra,
  p_friends,
  p_inter,
  p_local,
  p_mobj,
  p_pspr,
  p_map,
  p_maputl,
  p_params,
  p_setup,
  p_sight,
  p_spec,
  p_switch,
  p_tick,
  p_user,
  psi_globals,
  r_renderstyle,
  r_defs,
  r_main,
  r_translations,
  sc_engine,
  sc_params,
  sc_tokens,
  sc_states,
  s_sound,
  sounddata,
  sounds,
  m_rnd;

//
// P_BulletSlope
// Sets a slope so a near miss is at aproximately
// the height of the intended target
//
procedure P_DoBulletSlope(mo: Pmobj_t; const igflags: integer);
var
  an: angle_t;
begin
  // see which target is to be aimed at
  an := mo.angle;
  bulletslope := P_AimLineAttack(mo, an, 16 * 64 * FRACUNIT, igflags);

  if linetarget = nil then
  begin
    an := an + $4000000;
    bulletslope := P_AimLineAttack(mo, an, 16 * 64 * FRACUNIT, igflags);
    if linetarget = nil then
    begin
      an := an - $8000000;
      bulletslope := P_AimLineAttack(mo, an, 16 * 64 * FRACUNIT, igflags);
      if mo.player <> nil then
        if zaxisshift and (linetarget = nil) then
          bulletslope := (Pplayer_t(mo.player).lookdir * FRACUNIT) div 173;
    end;
  end;
end;

procedure P_BulletSlope(mo: Pmobj_t);
begin
  if G_PlayingEngineVersion >= 207 then
  begin
    P_DoBulletSlope(mo, MF2_EX_FRIEND);
    if linetarget = nil then
      P_DoBulletSlope(mo, 0);
  end
  else
    P_DoBulletSlope(mo, 0);
end;
function P_CheckStateParams(actor: Pmobj_t; const numparms: integer = -1; const flags: LongWord = 0): boolean;
begin
  if numparms = 0 then
  begin
    if actor.state.flags_ex and MF_EX_STATE_PARAMS_ERROR = 0 then
    begin
      I_Warning('P_CheckStateParams(): Expected params can not be 0 in actor "%s"'#13#10, [Info_GetMobjName(actor.info)]);
      actor.state.flags_ex := actor.state.flags_ex or MF_EX_STATE_PARAMS_ERROR;
    end;
    result := false;
    exit;
  end;

  if actor.state.params = nil then
  begin
    if actor.state.flags_ex and MF_EX_STATE_PARAMS_ERROR = 0 then
    begin
      I_Warning('P_CheckStateParams(): Parameter list is null in actor "%s"', [Info_GetMobjName(actor.info)]);
      if numparms > 0 then
        I_Warning(', %d parameters expected', [numparms]);
      I_Warning(#13#10);
      actor.state.flags_ex := actor.state.flags_ex or MF_EX_STATE_PARAMS_ERROR;
    end;
    result := false;
    exit;
  end;

  if numparms <> -1 then
  begin
    if (flags = 0) and (actor.state.params.Count <> numparms) then
    begin
      if actor.state.flags_ex and MF_EX_STATE_PARAMS_ERROR = 0 then
      begin
        I_Warning('P_CheckStateParams(): Parameter list has %d parameters, but %d parameters expected in actor "%s"'#13#10, [actor.state.params.Count, numparms, Info_GetMobjName(actor.info)]);
        actor.state.flags_ex := actor.state.flags_ex or MF_EX_STATE_PARAMS_ERROR;
      end;
      result := false;
      exit;
    end
    else if (flags and CSP_AT_LEAST <> 0) and (actor.state.params.Count < numparms) then
    begin
      if actor.state.flags_ex and MF_EX_STATE_PARAMS_ERROR = 0 then
      begin
        I_Warning('P_CheckStateParams(): Parameter list has %d parameters, but at least %d parameters expected in actor "%s"'#13#10, [actor.state.params.Count, numparms, Info_GetMobjName(actor.info)]);
        actor.state.flags_ex := actor.state.flags_ex or MF_EX_STATE_PARAMS_ERROR;
      end;
      result := false;
      exit;
    end
    else if (flags and CSP_AT_MOST <> 0) and (actor.state.params.Count > numparms) then
    begin
      if actor.state.flags_ex and MF_EX_STATE_PARAMS_ERROR = 0 then
      begin
        I_Warning('P_CheckStateParams(): Parameter list has %d parameters, but at most %d parameters expected in actor "%s"'#13#10, [actor.state.params.Count, numparms, Info_GetMobjName(actor.info)]);
        actor.state.flags_ex := actor.state.flags_ex or MF_EX_STATE_PARAMS_ERROR;
      end;
      result := false;
      exit;
    end;
  end;

  result := true;
end;

//
// JVAL
// Change state
// A_GoTo(propability, newstate)
//
procedure A_GoTo(actor: Pmobj_t);
var
  propability: integer;
  newstate: integer;
begin
  if not P_CheckStateParams(actor, 2) then
    exit;

  propability := actor.state.params.IntVal[0];  // JVAL simple integer values are precalculated

  if N_Random < propability then
  begin
    if not actor.state.params.IsComputed[1] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[1]);
      actor.state.params.IntVal[1] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[1];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

//
// JVAL
// A_GoToIfCloser(distancetotarget: float, newstate: integer)
// Jump conditionally to another state if distance to target is closer to first parameter
//
procedure A_GoToIfCloser(actor: Pmobj_t);
var
  dist: fixed_t;
  target: Pmobj_t;
  newstate: integer;
begin
  if not P_CheckStateParams(actor, 2) then
    exit;

  if actor.player = nil then
    target := actor.target
  else
  begin
    // Does the player aim at something that can be shot?
    P_BulletSlope(actor);
    target := linetarget;
  end;

  // No target - no jump
  if target = nil then
    exit;

  dist := actor.state.params.FixedVal[0];
  if P_AproxDistance(actor.x - target.x, actor.y - target.y) < dist then
  begin
    if not actor.state.params.IsComputed[1] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[1]);
      actor.state.params.IntVal[1] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[1];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

//
// JVAL
// A_GoToIfHealthLower(health: integer; newstate: integer)
// Jump conditionally to another state if health is lower to first parameter
//
procedure A_GoToIfHealthLower(actor: Pmobj_t);
var
  newstate: integer;
begin
  if not P_CheckStateParams(actor, 2) then
    exit;

  if actor.health < actor.state.params.IntVal[0] then
  begin
    if not actor.state.params.IsComputed[1] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[1]);
      actor.state.params.IntVal[1] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[1];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

procedure A_ConsoleCommand(actor: Pmobj_t);
var
  cmd: string;
  i: integer;
begin
  if not P_CheckStateParams(actor) then
    exit;

  cmd := actor.state.params.StrVal[0];
  for i := 1 to actor.state.params.Count - 1 do
    cmd := cmd + ' ' + actor.state.params.StrVal[i];

  C_AddCommand(cmd);
end;

procedure A_SetFrightened(actor: Pmobj_t);
begin
  actor.flags2_ex := actor.flags2_ex or MF2_EX_FRIGHTENED;
end;

procedure A_UnSetFrightened(actor: Pmobj_t);
begin
  actor.flags2_ex := actor.flags2_ex and not MF2_EX_FRIGHTENED;
end;

procedure A_SetNoDamage(actor: Pmobj_t);
begin
  actor.flags2_ex := actor.flags2_ex or MF2_EX_NODAMAGE;
end;

procedure A_UnSetNoDamage(actor: Pmobj_t);
begin
  actor.flags2_ex := actor.flags2_ex and not MF2_EX_NODAMAGE;
end;

procedure A_SetCustomParam(actor: Pmobj_t);
begin
  if not P_CheckStateParams(actor, 2) then
    exit;

  P_SetMobjCustomParam(actor, actor.state.params.StrVal[0], actor.state.params.IntVal[1]);
end;

procedure A_AddCustomParam(actor: Pmobj_t);
var
  parm: Pmobjcustomparam_t;
  sparm: string;
begin
  if not P_CheckStateParams(actor, 2) then
    exit;

  sparm := actor.state.params.StrVal[0];
  parm := P_GetMobjCustomParam(actor, sparm);
  if parm = nil then
    P_SetMobjCustomParam(actor, sparm, actor.state.params.IntVal[1])
  else
    P_SetMobjCustomParam(actor, sparm, parm.value + actor.state.params.IntVal[1])
end;

procedure A_SubtractCustomParam(actor: Pmobj_t);
var
  parm: Pmobjcustomparam_t;
  sparm: string;
begin
  if not P_CheckStateParams(actor, 2) then
    exit;

  sparm := actor.state.params.StrVal[0];
  parm := P_GetMobjCustomParam(actor, sparm);
  if parm <> nil then
    P_SetMobjCustomParam(actor, sparm, parm.value - actor.state.params.IntVal[1])
  else
    P_SetMobjCustomParam(actor, sparm, - actor.state.params.IntVal[1])
end;

procedure A_SetTargetCustomParam(actor: Pmobj_t);
begin
  if not P_CheckStateParams(actor, 2) then
    exit;

  if actor.target = nil then
    exit;

  P_SetMobjCustomParam(actor.target, actor.state.params.StrVal[0], actor.state.params.IntVal[1]);
end;

procedure A_AddTargetCustomParam(actor: Pmobj_t);
var
  parm: Pmobjcustomparam_t;
  sparm: string;
begin
  if not P_CheckStateParams(actor, 2) then
    exit;

  if actor.target = nil then
    exit;

  sparm := actor.state.params.StrVal[0];
  parm := P_GetMobjCustomParam(actor.target, sparm);
  if parm = nil then
    P_SetMobjCustomParam(actor.target, sparm, actor.state.params.IntVal[1])
  else
    P_SetMobjCustomParam(actor.target, sparm, parm.value + actor.state.params.IntVal[1])
end;

procedure A_SubtractTargetCustomParam(actor: Pmobj_t);
var
  parm: Pmobjcustomparam_t;
  sparm: string;
begin
  if not P_CheckStateParams(actor, 2) then
    exit;

  if actor.target = nil then
    exit;

  sparm := actor.state.params.StrVal[0];
  parm := P_GetMobjCustomParam(actor.target, sparm);
  if parm <> nil then
    P_SetMobjCustomParam(actor.target, sparm, parm.value - actor.state.params.IntVal[1])
  else
    P_SetMobjCustomParam(actor.target, sparm, - actor.state.params.IntVal[1])
end;

procedure A_SetMasterCustomParam(actor: Pmobj_t);
begin
  if not P_CheckStateParams(actor, 2) then
    exit;

  if actor.master = nil then
    exit;

  P_SetMobjCustomParam(actor.master, actor.state.params.StrVal[0], actor.state.params.IntVal[1]);
end;

procedure A_AddMasterCustomParam(actor: Pmobj_t);
var
  parm: Pmobjcustomparam_t;
  sparm: string;
begin
  if not P_CheckStateParams(actor, 2) then
    exit;

  if actor.master = nil then
    exit;

  sparm := actor.state.params.StrVal[0];
  parm := P_GetMobjCustomParam(actor.master, sparm);
  if parm = nil then
    P_SetMobjCustomParam(actor.master, sparm, actor.state.params.IntVal[1])
  else
    P_SetMobjCustomParam(actor.master, sparm, parm.value + actor.state.params.IntVal[1])
end;

procedure A_SubtractMasterCustomParam(actor: Pmobj_t);
var
  parm: Pmobjcustomparam_t;
  sparm: string;
begin
  if not P_CheckStateParams(actor, 2) then
    exit;

  if actor.master = nil then
    exit;

  sparm := actor.state.params.StrVal[0];
  parm := P_GetMobjCustomParam(actor.master, sparm);
  if parm <> nil then
    P_SetMobjCustomParam(actor.master, sparm, parm.value - actor.state.params.IntVal[1])
  else
    P_SetMobjCustomParam(actor.master, sparm, - actor.state.params.IntVal[1])
end;

procedure A_SetTracerCustomParam(actor: Pmobj_t);
begin
  if not P_CheckStateParams(actor, 2) then
    exit;

  if actor.tracer = nil then
    exit;

  P_SetMobjCustomParam(actor.tracer, actor.state.params.StrVal[0], actor.state.params.IntVal[1]);
end;

procedure A_AddTracerCustomParam(actor: Pmobj_t);
var
  parm: Pmobjcustomparam_t;
  sparm: string;
begin
  if not P_CheckStateParams(actor, 2) then
    exit;

  if actor.tracer = nil then
    exit;

  sparm := actor.state.params.StrVal[0];
  parm := P_GetMobjCustomParam(actor.tracer, sparm);
  if parm = nil then
    P_SetMobjCustomParam(actor.tracer, sparm, actor.state.params.IntVal[1])
  else
    P_SetMobjCustomParam(actor.tracer, sparm, parm.value + actor.state.params.IntVal[1])
end;

procedure A_SubtractTracerCustomParam(actor: Pmobj_t);
var
  parm: Pmobjcustomparam_t;
  sparm: string;
begin
  if not P_CheckStateParams(actor, 2) then
    exit;

  if actor.tracer = nil then
    exit;

  sparm := actor.state.params.StrVal[0];
  parm := P_GetMobjCustomParam(actor.tracer, sparm);
  if parm <> nil then
    P_SetMobjCustomParam(actor.tracer, sparm, parm.value - actor.state.params.IntVal[1])
  else
    P_SetMobjCustomParam(actor.tracer, sparm, - actor.state.params.IntVal[1])
end;

//
// JVAL
// Conditionally change state offset
// A_JumpIf(logical expression, offset to jump when true)
//
procedure A_JumpIf(actor: Pmobj_t);
var
  offset: integer;
  boolret: boolean;
  N: TDNumberList;
  i: integer;
begin
  if not P_CheckStateParams(actor, 2, CSP_AT_LEAST) then
    exit;

  boolret := actor.state.params.BoolVal[0];
  if boolret then
  begin
    N := TDNumberList.Create;
    for i := 1 to actor.state.params.Count - 1 do
    begin
      offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[i]);
      N.Add(offset);
    end;
    if N.Count > 0 then
    begin
      offset := N.Numbers[N_Random mod N.Count];
      if @states[offset] <> actor.state then
        P_SetMobjState(actor, statenum_t(offset));
    end;
    N.Free;
  end;
end;

//
// JVAL
// Change state offset
// A_JumpIfCustomParam(customparam, value of customparam, offset)
//
procedure A_JumpIfCustomParam(actor: Pmobj_t);
var
  offset: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if P_GetMobjCustomParamValue(actor, actor.state.params.StrVal[0]) = actor.state.params.IntVal[1] then
  begin
    offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[2]);
    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

//
// JVAL
// Change state offset
// A_JumpIfCustomParamLess(customparam, value of customparam, offset)
//
procedure A_JumpIfCustomParamLess(actor: Pmobj_t);
var
  offset: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if P_GetMobjCustomParamValue(actor, actor.state.params.StrVal[0]) < actor.state.params.IntVal[1] then
  begin
    offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[2]);
    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

//
// JVAL
// Change state offset
// A_JumpIfCustomParamGreater(customparam, value of customparam, offset)
//
procedure A_JumpIfCustomParamGreater(actor: Pmobj_t);
var
  offset: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if P_GetMobjCustomParamValue(actor, actor.state.params.StrVal[0]) > actor.state.params.IntVal[1] then
  begin
    offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[2]);
    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

//
// JVAL
// Change state offset
// A_JumpIfTargetCustomParam(customparam, value of customparam, offset)
//
procedure A_JumpIfTargetCustomParam(actor: Pmobj_t);
var
  offset: integer;
begin
  if actor.target = nil then
    exit;

  if not P_CheckStateParams(actor, 3) then
    exit;

  if P_GetMobjCustomParamValue(actor.target, actor.state.params.StrVal[0]) = actor.state.params.IntVal[1] then
  begin
    offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[2]);
    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

//
// JVAL
// Change state offset
// A_JumpIfTargetCustomParamLess(customparam, value of customparam, offset)
//
procedure A_JumpIfTargetCustomParamLess(actor: Pmobj_t);
var
  offset: integer;
begin
  if actor.target = nil then
    exit;

  if not P_CheckStateParams(actor, 3) then
    exit;

  if P_GetMobjCustomParamValue(actor.target, actor.state.params.StrVal[0]) < actor.state.params.IntVal[1] then
  begin
    offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[2]);
    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

//
// JVAL
// Change state offset
// A_JumpIfTargetCustomParamGreater(customparam, value of customparam, offset)
//
procedure A_JumpIfTargetCustomParamGreater(actor: Pmobj_t);
var
  offset: integer;
begin
  if actor.target = nil then
    exit;

  if not P_CheckStateParams(actor, 3) then
    exit;

  if P_GetMobjCustomParamValue(actor.target, actor.state.params.StrVal[0]) > actor.state.params.IntVal[1] then
  begin
    offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[2]);
    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

//
// JVAL
// Change state offset
// A_JumpIfMasterCustomParam(customparam, value of customparam, offset)
//
procedure A_JumpIfMasterCustomParam(actor: Pmobj_t);
var
  offset: integer;
begin
  if actor.master = nil then
    exit;

  if not P_CheckStateParams(actor, 3) then
    exit;

  if P_GetMobjCustomParamValue(actor.master, actor.state.params.StrVal[0]) = actor.state.params.IntVal[1] then
  begin
    offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[2]);
    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

//
// JVAL
// Change state offset
// A_JumpIfMasterCustomParamLess(customparam, value of customparam, offset)
//
procedure A_JumpIfMasterCustomParamLess(actor: Pmobj_t);
var
  offset: integer;
begin
  if actor.master = nil then
    exit;

  if not P_CheckStateParams(actor, 3) then
    exit;

  if P_GetMobjCustomParamValue(actor.master, actor.state.params.StrVal[0]) < actor.state.params.IntVal[1] then
  begin
    offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[2]);
    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

//
// JVAL
// Change state offset
// A_JumpIfMasterCustomParamGreater(customparam, value of customparam, offset)
//
procedure A_JumpIfMasterCustomParamGreater(actor: Pmobj_t);
var
  offset: integer;
begin
  if actor.master = nil then
    exit;

  if not P_CheckStateParams(actor, 3) then
    exit;

  if P_GetMobjCustomParamValue(actor.master, actor.state.params.StrVal[0]) > actor.state.params.IntVal[1] then
  begin
    offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[2]);
    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

//
// JVAL
// Change state offset
// A_JumpIfTracerCustomParam(customparam, value of customparam, offset)
//
procedure A_JumpIfTracerCustomParam(actor: Pmobj_t);
var
  offset: integer;
begin
  if actor.tracer = nil then
    exit;

  if not P_CheckStateParams(actor, 3) then
    exit;

  if P_GetMobjCustomParamValue(actor.tracer, actor.state.params.StrVal[0]) = actor.state.params.IntVal[1] then
  begin
    offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[2]);
    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

//
// JVAL
// Change state offset
// A_JumpIfTracerCustomParamLess(customparam, value of customparam, offset)
//
procedure A_JumpIfTracerCustomParamLess(actor: Pmobj_t);
var
  offset: integer;
begin
  if actor.tracer = nil then
    exit;

  if not P_CheckStateParams(actor, 3) then
    exit;

  if P_GetMobjCustomParamValue(actor.tracer, actor.state.params.StrVal[0]) < actor.state.params.IntVal[1] then
  begin
    offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[2]);
    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

//
// JVAL
// Change state offset
// A_JumpIfTracerCustomParamGreater(customparam, value of customparam, offset)
//
procedure A_JumpIfTracerCustomParamGreater(actor: Pmobj_t);
var
  offset: integer;
begin
  if actor.tracer = nil then
    exit;

  if not P_CheckStateParams(actor, 3) then
    exit;

  if P_GetMobjCustomParamValue(actor.tracer, actor.state.params.StrVal[0]) > actor.state.params.IntVal[1] then
  begin
    offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[2]);
    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

procedure A_JumpIfMapStringEqual(actor: Pmobj_t);
var
  offset: integer;
begin
  if actor.target = nil then
    exit;

  if not P_CheckStateParams(actor, 3) then
    exit;

  if mapvars.StrVal[actor.state.params.StrVal[0]] = actor.state.params.StrVal[1] then
  begin
    offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[2]);
    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

procedure A_JumpIfMapStringLess(actor: Pmobj_t);
var
  offset: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if mapvars.StrVal[actor.state.params.StrVal[0]] < actor.state.params.StrVal[1] then
  begin
    offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[2]);
    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

procedure A_JumpIfMapStringGreater(actor: Pmobj_t);
var
  offset: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if mapvars.StrVal[actor.state.params.StrVal[0]] > actor.state.params.StrVal[1] then
  begin
    offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[2]);
    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

procedure A_JumpIfMapIntegerEqual(actor: Pmobj_t);
var
  offset: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if mapvars.IntVal[actor.state.params.StrVal[0]] = actor.state.params.IntVal[1] then
  begin
    offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[2]);
    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

procedure A_JumpIfMapIntegerLess(actor: Pmobj_t);
var
  offset: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if mapvars.IntVal[actor.state.params.StrVal[0]] < actor.state.params.IntVal[1] then
  begin
    offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[2]);
    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

procedure A_JumpIfMapIntegerGreater(actor: Pmobj_t);
var
  offset: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if mapvars.IntVal[actor.state.params.StrVal[0]] > actor.state.params.IntVal[1] then
  begin
    offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[2]);
    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

procedure A_JumpIfMapFloatEqual(actor: Pmobj_t);
var
  offset: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if mapvars.FloatVal[actor.state.params.StrVal[0]] = actor.state.params.FloatVal[1] then
  begin
    offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[2]);
    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

procedure A_JumpIfMapFloatLess(actor: Pmobj_t);
var
  offset: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if mapvars.FloatVal[actor.state.params.StrVal[0]] < actor.state.params.FloatVal[1] then
  begin
    offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[2]);
    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

procedure A_JumpIfMapFloatGreater(actor: Pmobj_t);
var
  offset: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if mapvars.FloatVal[actor.state.params.StrVal[0]] > actor.state.params.FloatVal[1] then
  begin
    offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[2]);
    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

procedure A_JumpIfWorldStringEqual(actor: Pmobj_t);
var
  offset: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if Worldvars.StrVal[actor.state.params.StrVal[0]] = actor.state.params.StrVal[1] then
  begin
    offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[2]);
    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

procedure A_JumpIfWorldStringLess(actor: Pmobj_t);
var
  offset: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if Worldvars.StrVal[actor.state.params.StrVal[0]] < actor.state.params.StrVal[1] then
  begin
    offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[2]);
    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

procedure A_JumpIfWorldStringGreater(actor: Pmobj_t);
var
  offset: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if Worldvars.StrVal[actor.state.params.StrVal[0]] > actor.state.params.StrVal[1] then
  begin
    offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[2]);
    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

procedure A_JumpIfWorldIntegerEqual(actor: Pmobj_t);
var
  offset: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if Worldvars.IntVal[actor.state.params.StrVal[0]] = actor.state.params.IntVal[1] then
  begin
    offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[2]);
    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

procedure A_JumpIfWorldIntegerLess(actor: Pmobj_t);
var
  offset: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if Worldvars.IntVal[actor.state.params.StrVal[0]] < actor.state.params.IntVal[1] then
  begin
    offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[2]);
    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

procedure A_JumpIfWorldIntegerGreater(actor: Pmobj_t);
var
  offset: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if Worldvars.IntVal[actor.state.params.StrVal[0]] > actor.state.params.IntVal[1] then
  begin
    offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[2]);
    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

procedure A_JumpIfWorldFloatEqual(actor: Pmobj_t);
var
  offset: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if Worldvars.FloatVal[actor.state.params.StrVal[0]] = actor.state.params.FloatVal[1] then
  begin
    offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[2]);
    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

procedure A_JumpIfWorldFloatLess(actor: Pmobj_t);
var
  offset: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if Worldvars.FloatVal[actor.state.params.StrVal[0]] < actor.state.params.FloatVal[1] then
  begin
    offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[2]);
    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

procedure A_JumpIfWorldFloatGreater(actor: Pmobj_t);
var
  offset: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if Worldvars.FloatVal[actor.state.params.StrVal[0]] > actor.state.params.FloatVal[1] then
  begin
    offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[2]);
    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

//
// JVAL
// Change state
// A_GoToIfCustomParam(customparam, value of customparam, newstate)
//
procedure A_GoToIfCustomParam(actor: Pmobj_t);
var
  newstate: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if P_GetMobjCustomParamValue(actor, actor.state.params.StrVal[0]) = actor.state.params.IntVal[1] then
  begin
    if not actor.state.params.IsComputed[2] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[2]);
      actor.state.params.IntVal[2] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[2];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

//
// JVAL
// Change state
// A_GoToIfCustomParamLess(customparam, value of customparam, newstate)
//
procedure A_GoToIfCustomParamLess(actor: Pmobj_t);
var
  newstate: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if P_GetMobjCustomParamValue(actor, actor.state.params.StrVal[0]) < actor.state.params.IntVal[1] then
  begin
    if not actor.state.params.IsComputed[2] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[2]);
      actor.state.params.IntVal[2] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[2];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

//
// JVAL
// Change state
// A_GoToIfCustomParamGreater(customparam, value of customparam, newstate)
//
procedure A_GoToIfCustomParamGreater(actor: Pmobj_t);
var
  newstate: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if P_GetMobjCustomParamValue(actor, actor.state.params.StrVal[0]) > actor.state.params.IntVal[1] then
  begin
    if not actor.state.params.IsComputed[2] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[2]);
      actor.state.params.IntVal[2] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[2];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

//
// JVAL
// Change state
// A_GoToIfTargetCustomParam(customparam, value of customparam, newstate)
//
procedure A_GoToIfTargetCustomParam(actor: Pmobj_t);
var
  newstate: integer;
begin
  if actor.target = nil then
    exit;

  if not P_CheckStateParams(actor, 3) then
    exit;

  if P_GetMobjCustomParamValue(actor.target, actor.state.params.StrVal[0]) = actor.state.params.IntVal[1] then
  begin
    if not actor.state.params.IsComputed[2] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[2]);
      actor.state.params.IntVal[2] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[2];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

//
// JVAL
// Change state
// A_GoToIfTargetCustomParamLess(customparam, value of customparam, newstate)
//
procedure A_GoToIfTargetCustomParamLess(actor: Pmobj_t);
var
  newstate: integer;
begin
  if actor.target = nil then
    exit;

  if not P_CheckStateParams(actor, 3) then
    exit;

  if P_GetMobjCustomParamValue(actor.target, actor.state.params.StrVal[0]) < actor.state.params.IntVal[1] then
  begin
    if not actor.state.params.IsComputed[2] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[2]);
      actor.state.params.IntVal[2] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[2];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

//
// JVAL
// Change state
// A_GoToIfTargetCustomParamGreater(customparam, value of customparam, newstate)
//
procedure A_GoToIfTargetCustomParamGreater(actor: Pmobj_t);
var
  newstate: integer;
begin
  if actor.target = nil then
    exit;

  if not P_CheckStateParams(actor, 3) then
    exit;

  if P_GetMobjCustomParamValue(actor.target, actor.state.params.StrVal[0]) > actor.state.params.IntVal[1] then
  begin
    if not actor.state.params.IsComputed[2] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[2]);
      actor.state.params.IntVal[2] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[2];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

//
// JVAL
// Change state
// A_GoToIfMasterCustomParam(customparam, value of customparam, newstate)
//
procedure A_GoToIfMasterCustomParam(actor: Pmobj_t);
var
  newstate: integer;
begin
  if actor.master = nil then
    exit;

  if not P_CheckStateParams(actor, 3) then
    exit;

  if P_GetMobjCustomParamValue(actor.master, actor.state.params.StrVal[0]) = actor.state.params.IntVal[1] then
  begin
    if not actor.state.params.IsComputed[2] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[2]);
      actor.state.params.IntVal[2] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[2];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

//
// JVAL
// Change state
// A_GoToIfMasterCustomParamLess(customparam, value of customparam, newstate)
//
procedure A_GoToIfMasterCustomParamLess(actor: Pmobj_t);
var
  newstate: integer;
begin
  if actor.master = nil then
    exit;

  if not P_CheckStateParams(actor, 3) then
    exit;

  if P_GetMobjCustomParamValue(actor.master, actor.state.params.StrVal[0]) < actor.state.params.IntVal[1] then
  begin
    if not actor.state.params.IsComputed[2] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[2]);
      actor.state.params.IntVal[2] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[2];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

//
// JVAL
// Change state
// A_GoToIfMasterCustomParamGreater(customparam, value of customparam, newstate)
//
procedure A_GoToIfMasterCustomParamGreater(actor: Pmobj_t);
var
  newstate: integer;
begin
  if actor.master = nil then
    exit;

  if not P_CheckStateParams(actor, 3) then
    exit;

  if P_GetMobjCustomParamValue(actor.master, actor.state.params.StrVal[0]) > actor.state.params.IntVal[1] then
  begin
    if not actor.state.params.IsComputed[2] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[2]);
      actor.state.params.IntVal[2] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[2];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

//
// JVAL
// Change state
// A_GoToIfTracerCustomParam(customparam, value of customparam, newstate)
//
procedure A_GoToIfTracerCustomParam(actor: Pmobj_t);
var
  newstate: integer;
begin
  if actor.tracer = nil then
    exit;

  if not P_CheckStateParams(actor, 3) then
    exit;

  if P_GetMobjCustomParamValue(actor.tracer, actor.state.params.StrVal[0]) = actor.state.params.IntVal[1] then
  begin
    if not actor.state.params.IsComputed[2] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[2]);
      actor.state.params.IntVal[2] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[2];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

//
// JVAL
// Change state
// A_GoToIfTracerCustomParamLess(customparam, value of customparam, newstate)
//
procedure A_GoToIfTracerCustomParamLess(actor: Pmobj_t);
var
  newstate: integer;
begin
  if actor.tracer = nil then
    exit;

  if not P_CheckStateParams(actor, 3) then
    exit;

  if P_GetMobjCustomParamValue(actor.tracer, actor.state.params.StrVal[0]) < actor.state.params.IntVal[1] then
  begin
    if not actor.state.params.IsComputed[2] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[2]);
      actor.state.params.IntVal[2] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[2];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

//
// JVAL
// Change state
// A_GoToIfTracerCustomParamGreater(customparam, value of customparam, newstate)
//
procedure A_GoToIfTracerCustomParamGreater(actor: Pmobj_t);
var
  newstate: integer;
begin
  if actor.tracer = nil then
    exit;

  if not P_CheckStateParams(actor, 3) then
    exit;

  if P_GetMobjCustomParamValue(actor.tracer, actor.state.params.StrVal[0]) > actor.state.params.IntVal[1] then
  begin
    if not actor.state.params.IsComputed[2] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[2]);
      actor.state.params.IntVal[2] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[2];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

//
// JVAL
// Change state
// A_GoToIfMapStringEqual(map variable, value of map variable, newstate)
//
procedure A_GoToIfMapStringEqual(actor: Pmobj_t);
var
  newstate: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if mapvars.StrVal[actor.state.params.StrVal[0]] = actor.state.params.StrVal[1] then
  begin
    if not actor.state.params.IsComputed[2] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[2]);
      actor.state.params.IntVal[2] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[2];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

//
// JVAL
// Change state
// A_GoToIfMapStringLess(map variable, value of map variable, newstate)
//
procedure A_GoToIfMapStringLess(actor: Pmobj_t);
var
  newstate: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if mapvars.StrVal[actor.state.params.StrVal[0]] < actor.state.params.StrVal[1] then
  begin
    if not actor.state.params.IsComputed[2] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[2]);
      actor.state.params.IntVal[2] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[2];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

//
// JVAL
// Change state
// A_GoToIfMapStringGreater(map variable, value of map variable, newstate)
//
procedure A_GoToIfMapStringGreater(actor: Pmobj_t);
var
  newstate: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if mapvars.StrVal[actor.state.params.StrVal[0]] > actor.state.params.StrVal[1] then
  begin
    if not actor.state.params.IsComputed[2] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[2]);
      actor.state.params.IntVal[2] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[2];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

procedure A_GoToIfMapIntegerEqual(actor: Pmobj_t);
var
  newstate: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if mapvars.IntVal[actor.state.params.StrVal[0]] = actor.state.params.IntVal[1] then
  begin
    if not actor.state.params.IsComputed[2] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[2]);
      actor.state.params.IntVal[2] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[2];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

procedure A_GoToIfMapIntegerLess(actor: Pmobj_t);
var
  newstate: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if mapvars.IntVal[actor.state.params.StrVal[0]] < actor.state.params.IntVal[1] then
  begin
    if not actor.state.params.IsComputed[2] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[2]);
      actor.state.params.IntVal[2] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[2];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

procedure A_GoToIfMapIntegerGreater(actor: Pmobj_t);
var
  newstate: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if mapvars.IntVal[actor.state.params.StrVal[0]] > actor.state.params.IntVal[1] then
  begin
    if not actor.state.params.IsComputed[2] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[2]);
      actor.state.params.IntVal[2] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[2];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

procedure A_GoToIfMapFloatEqual(actor: Pmobj_t);
var
  newstate: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if mapvars.FloatVal[actor.state.params.StrVal[0]] = actor.state.params.FloatVal[1] then
  begin
    if not actor.state.params.IsComputed[2] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[2]);
      actor.state.params.IntVal[2] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[2];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

procedure A_GoToIfMapFloatLess(actor: Pmobj_t);
var
  newstate: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if mapvars.FloatVal[actor.state.params.StrVal[0]] < actor.state.params.FloatVal[1] then
  begin
    if not actor.state.params.IsComputed[2] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[2]);
      actor.state.params.IntVal[2] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[2];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

procedure A_GoToIfMapFloatGreater(actor: Pmobj_t);
var
  newstate: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if mapvars.FloatVal[actor.state.params.StrVal[0]] > actor.state.params.FloatVal[1] then
  begin
    if not actor.state.params.IsComputed[2] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[2]);
      actor.state.params.IntVal[2] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[2];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

//
// JVAL
// Change state
// A_GoToIfWorldStringEqual(World variable, value of World variable, newstate)
//
procedure A_GoToIfWorldStringEqual(actor: Pmobj_t);
var
  newstate: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if Worldvars.StrVal[actor.state.params.StrVal[0]] = actor.state.params.StrVal[1] then
  begin
    if not actor.state.params.IsComputed[2] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[2]);
      actor.state.params.IntVal[2] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[2];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

//
// JVAL
// Change state
// A_GoToIfWorldStringLess(World variable, value of World variable, newstate)
//
procedure A_GoToIfWorldStringLess(actor: Pmobj_t);
var
  newstate: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if Worldvars.StrVal[actor.state.params.StrVal[0]] < actor.state.params.StrVal[1] then
  begin
    if not actor.state.params.IsComputed[2] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[2]);
      actor.state.params.IntVal[2] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[2];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

//
// JVAL
// Change state
// A_GoToIfWorldStringGreater(World variable, value of World variable, newstate)
//
procedure A_GoToIfWorldStringGreater(actor: Pmobj_t);
var
  newstate: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if Worldvars.StrVal[actor.state.params.StrVal[0]] > actor.state.params.StrVal[1] then
  begin
    if not actor.state.params.IsComputed[2] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[2]);
      actor.state.params.IntVal[2] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[2];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

procedure A_GoToIfWorldIntegerEqual(actor: Pmobj_t);
var
  newstate: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if Worldvars.IntVal[actor.state.params.StrVal[0]] = actor.state.params.IntVal[1] then
  begin
    if not actor.state.params.IsComputed[2] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[2]);
      actor.state.params.IntVal[2] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[2];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

procedure A_GoToIfWorldIntegerLess(actor: Pmobj_t);
var
  newstate: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if Worldvars.IntVal[actor.state.params.StrVal[0]] < actor.state.params.IntVal[1] then
  begin
    if not actor.state.params.IsComputed[2] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[2]);
      actor.state.params.IntVal[2] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[2];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

procedure A_GoToIfWorldIntegerGreater(actor: Pmobj_t);
var
  newstate: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if Worldvars.IntVal[actor.state.params.StrVal[0]] > actor.state.params.IntVal[1] then
  begin
    if not actor.state.params.IsComputed[2] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[2]);
      actor.state.params.IntVal[2] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[2];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

procedure A_GoToIfWorldFloatEqual(actor: Pmobj_t);
var
  newstate: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if Worldvars.FloatVal[actor.state.params.StrVal[0]] = actor.state.params.FloatVal[1] then
  begin
    if not actor.state.params.IsComputed[2] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[2]);
      actor.state.params.IntVal[2] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[2];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

procedure A_GoToIfWorldFloatLess(actor: Pmobj_t);
var
  newstate: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if Worldvars.FloatVal[actor.state.params.StrVal[0]] < actor.state.params.FloatVal[1] then
  begin
    if not actor.state.params.IsComputed[2] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[2]);
      actor.state.params.IntVal[2] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[2];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

procedure A_GoToIfWorldFloatGreater(actor: Pmobj_t);
var
  newstate: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  if Worldvars.FloatVal[actor.state.params.StrVal[0]] > actor.state.params.FloatVal[1] then
  begin
    if not actor.state.params.IsComputed[2] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[2]);
      actor.state.params.IntVal[2] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[2];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

procedure A_CustomSound1(mo: Pmobj_t);
begin
  if mo.info.customsound1 <> 0 then
  begin
    if mo.flags_ex and MF_EX_RANDOMCUSTOMSOUND1 <> 0 then
      A_RandomCustomSound1(mo)
    else
      S_StartSound(mo, mo.info.customsound1);
  end;
end;

procedure A_CustomSound2(mo: Pmobj_t);
begin
  if mo.info.customsound2 <> 0 then
  begin
    if mo.flags_ex and MF_EX_RANDOMCUSTOMSOUND2 <> 0 then
      A_RandomCustomSound2(mo)
    else
      S_StartSound(mo, mo.info.customsound2);
  end;
end;

procedure A_CustomSound3(mo: Pmobj_t);
begin
  if mo.info.customsound3 <> 0 then
  begin
    if mo.flags_ex and MF_EX_RANDOMCUSTOMSOUND3 <> 0 then
      A_RandomCustomSound3(mo)
    else
      S_StartSound(mo, mo.info.customsound3);
  end;
end;

procedure P_RandomSound(const actor: Pmobj_t; const soundnum: integer);
var
  randomlist: TDNumberList;
  rndidx: integer;
begin
  if soundnum <> 0 then
  begin
    randomlist := S_GetRandomSoundList(soundnum);
    if randomlist <> nil then
    begin
      if randomlist.Count > 0 then
      begin
        rndidx := N_Random mod randomlist.Count;
        S_StartSound(actor, randomlist[rndidx]);
      end
      else
      // JVAL: This should never happen, see S_GetRandomSoundList() in sounds.pas
        I_Error('P_RandomSound(): Random list is empty for sound no %d', [soundnum]);
    end;
  end;
end;

procedure A_RandomPainSound(actor: Pmobj_t);
begin
  if actor.flags2_ex and MF2_EX_FULLVOLPAIN <> 0 then
    P_RandomSound(nil, actor.info.painsound)
  else
    P_RandomSound(actor, actor.info.painsound);
end;

procedure A_RandomSeeSound(actor: Pmobj_t);
begin
  if actor.flags2_ex and MF2_EX_FULLVOLSEE <> 0 then
    P_RandomSound(nil, actor.info.seesound)
  else
    P_RandomSound(actor, actor.info.seesound);
end;

procedure A_RandomAttackSound(actor: Pmobj_t);
begin
  if actor.flags2_ex and MF2_EX_FULLVOLATTACK <> 0 then
    P_RandomSound(nil, actor.info.attacksound)
  else
    P_RandomSound(actor, actor.info.attacksound);
end;

procedure A_RandomDeathSound(actor: Pmobj_t);
begin
  if actor.flags2_ex and MF2_EX_FULLVOLDEATH <> 0 then
    P_RandomSound(nil, actor.info.deathsound)
  else
    P_RandomSound(actor, actor.info.deathsound);
end;

procedure A_RandomActiveSound(actor: Pmobj_t);
begin
  if actor.flags2_ex and MF2_EX_FULLVOLACTIVE <> 0 then
    P_RandomSound(nil, actor.info.activesound)
  else
    P_RandomSound(actor, actor.info.activesound);
end;

procedure A_RandomRipSound(actor: Pmobj_t);
begin
  if actor.flags4_ex and MF4_EX_FULLVOLRIP <> 0 then
    P_RandomSound(nil, actor.info.ripsound)
  else
    P_RandomSound(actor, actor.info.ripsound);
end;

procedure A_RandomCustomSound1(actor: Pmobj_t);
begin
  P_RandomSound(actor, actor.info.customsound1);
end;

procedure A_RandomCustomSound2(actor: Pmobj_t);
begin
  P_RandomSound(actor, actor.info.customsound2);
end;

procedure A_RandomCustomSound3(actor: Pmobj_t);
begin
  P_RandomSound(actor, actor.info.customsound3);
end;

procedure A_RandomCustomSound(actor: Pmobj_t);
var
  list: TDNumberList;
  rndidx: integer;
begin
  list := TDNumberList.Create;
  try
    if actor.info.customsound1 > 0 then
      list.Add(actor.info.customsound1);
    if actor.info.customsound2 > 0 then
      list.Add(actor.info.customsound2);
    if actor.info.customsound3 > 0 then
      list.Add(actor.info.customsound3);
    if list.Count > 0 then
    begin
      rndidx := N_Random mod list.Count;
      P_RandomSound(actor, list[rndidx]);
    end;
  finally
    list.Free;
  end;
end;

procedure A_RandomMeleeSound(actor: Pmobj_t);
begin
  P_RandomSound(actor, actor.info.meleesound);
end;

//
// JVAL
// Play a sound
// A_Playsound(soundname)
//
procedure A_Playsound(actor: Pmobj_t);
var
  sndidx: integer;
begin
  // JVAL: 20210109 - DEHEXTRA support
  if actor.state.params = nil then
  begin
    if actor.state.misc2 <> 0 then
      S_StartSound(nil, actor.state.misc1)
    else
      S_StartSound(actor, actor.state.misc1);
    exit;
  end;

  if not P_CheckStateParams(actor, 1) then
    exit;

  if actor.state.params.IsComputed[0] then
    sndidx := actor.state.params.IntVal[0]
  else
  begin
    sndidx := S_GetSoundNumForName(actor.state.params.StrVal[0]);
    actor.state.params.IntVal[0] := sndidx;
  end;

  if sndidx > 0 then
    S_StartSound(actor, sndidx);
end;

procedure A_PlayWeaponsound(actor: Pmobj_t);
begin
  A_Playsound(actor);
end;

//
// JVAL
// Random sound
// A_RandomSound(sound1, sound2, ...)
//
procedure A_RandomSound(actor: Pmobj_t);
var
  sidxs: TDNumberList;
  sndidx: integer;
  i: integer;
begin
  if not P_CheckStateParams(actor) then
    exit;

  if actor.state.params.Count = 0 then // Should never happen
    exit;

  sidxs := TDNumberList.Create;
  try
    for i := 0 to actor.state.params.Count - 1 do
    begin
      if actor.state.params.IsComputed[i] then
        sndidx := actor.state.params.IntVal[i]
      else
      begin
        sndidx := S_GetSoundNumForName(actor.state.params.StrVal[i]);
        actor.state.params.IntVal[i] := sndidx;
      end;
      sidxs.Add(sndidx);
    end;
    sndidx := N_Random mod sidxs.Count;
    if sidxs[sndidx] > 0 then
      S_StartSound(actor, sidxs[sndidx]);
  finally
    sidxs.Free;
  end;
end;

//
// JVAL
// Set all momentum to zero
//
procedure A_Stop(actor: Pmobj_t);
begin
  actor.momx := 0;
  actor.momy := 0;
  actor.momz := 0;
end;

//
// JVAL
// Change state offset
// A_Jump(propability, offset1, offset2, ....)
//
procedure A_Jump(actor: Pmobj_t);
var
  propability: integer;
  offset: integer;
  N: TDNumberList;
  i: integer;
begin
  if not P_CheckStateParams(actor, 2, CSP_AT_LEAST) then
    exit;

  propability := actor.state.params.IntVal[0];  // JVAL simple integer values are precalculated

  if N_Random < propability then
  begin
    N := TDNumberList.Create;
    for i := 1 to actor.state.params.Count - 1 do
    begin
      offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[i]);
      N.Add(offset);
    end;
    if N.Count > 0 then
    begin
      offset := N.Numbers[N_Random mod N.Count];
      if @states[offset] <> actor.state then
        P_SetMobjState(actor, statenum_t(offset));
    end;
    N.Free;
  end;
end;

procedure P_CustomMissile(const actor: Pmobj_t; const missiletype: integer;
  const spawnheight: fixed_t; const spawnoffs: fixed_t; const angle: angle_t;
  const aimmode: integer; const pitch: angle_t);
var
  missile: Pmobj_t;
  ang: angle_t;
  x, y, z: fixed_t;
  vx, vz: fixed_t;
  velocity: vec3_t;
  missilespeed: fixed_t;
  owner: Pmobj_t;
  pitchang: angle_t;
begin
  if missiletype < 0 then
    exit;

  if mobjinfo[missiletype].speed < 2048 then
    mobjinfo[missiletype].speed := mobjinfo[missiletype].speed * FRACUNIT;  // JVAL fix me!!!
  if (actor.target <> nil) or (aimmode = 2) then
  begin
    ang := (actor.angle - ANG90) shr ANGLETOFINESHIFT;
    x := FixedMul(spawnoffs, finecosine[ang]);
    y := FixedMul(spawnoffs, finesine[ang]);
    if aimmode <> 0 then
      z := spawnheight
    else
      z := spawnheight - 32 * FRACUNIT;
    case aimmode of
      1:
        begin
          missile := P_SpawnMissileXYZ(actor.x + x, actor.y + y, actor.z + z, actor, actor.target, missiletype);
        end;
      2:
        begin
          missile := P_SpawnMissileAngleZ(actor, actor.z + z, missiletype, actor.angle, 0, 0);

          // It is not necessary to use the correct angle here.
          // The only important thing is that the horizontal momentum is correct.
          // Therefore use 0 as the missile's angle and simplify the calculations accordingly.
          // The actual momentum vector is set below.
          if missile <> nil then
          begin
            pitchang := pitch shr ANGLETOFINESHIFT;
            vx := finecosine[pitchang];
            vz := finesine[pitchang];
            missile.momx := FixedMul(vx, missile.info.speed);
            missile.momy := 0;
            missile.momz := FixedMul(vz, missile.info.speed);
          end;
        end;
      else
      begin
        inc(actor.x, x);
        inc(actor.y, y);
        inc(actor.z, z);
        missile := P_SpawnMissile(actor, actor.target, missiletype);
        dec(actor.x, x);
        dec(actor.y, y);
        dec(actor.z, z);

      end;
    end;  // case

    if missile <> nil then
    begin
      // Use the actual momentum instead of the missile's Speed property
      // so that this can handle missiles with a high vertical velocity
      // component properly.
      velocity[0] := missile.momx;
      velocity[1] := missile.momy;
      velocity[2] := 0.0;

      missilespeed := round(VectorLength(@velocity));

      missile.angle := missile.angle + angle;
      ang := missile.angle shr ANGLETOFINESHIFT;
      missile.momx := FixedMul(missilespeed, finecosine[ang]);
      missile.momy := FixedMul(missilespeed, finesine[ang]);

      // handle projectile shooting projectiles - track the
      // links back to a real owner
      if (actor.flags and MF_MISSILE <> 0) or (aimmode and 4 <> 0) then
      begin
        owner := actor;
        while (owner.flags and MF_MISSILE <> 0) and (owner.target <> nil) do
          owner := owner.target;
         missile.target := owner;
        // automatic handling of seeker missiles
        if actor.flags_ex and missile.flags_ex and MF_EX_SEEKERMISSILE <> 0 then
          missile.tracer := actor.tracer;
      end
      else if missile.flags_ex and MF_EX_SEEKERMISSILE <> 0 then
      // automatic handling of seeker missiles
        missile.tracer := actor.target;

    end;
  end;
end;

//
// JVAL
// Custom missile, based on A_CustomMissile() of ZDoom
// A_CustomMissile(type, height, offset, angle, aimmode, pitch)
//
procedure A_CustomMissile(actor: Pmobj_t);
var
  mobj_no: integer;
  spawnheight: fixed_t;
  spawnoffs: fixed_t;
  angle: angle_t;
  aimmode: integer;
  pitch: angle_t;
begin
  if not P_CheckStateParams(actor) then
    exit;

  if actor.state.params.IsComputed[0] then
    mobj_no := actor.state.params.IntVal[0]
  else
  begin
    mobj_no := Info_GetMobjNumForName(actor.state.params.EvaluateStrVal[0]);
    actor.state.params.IntVal[0] := mobj_no;
  end;
  if mobj_no = -1 then
  begin
    I_Warning('A_CustomMissile(): Unknown missile %s'#13#10, [actor.state.params.StrVal[0]]);
    exit;
  end;

  spawnheight := actor.state.params.FixedVal[1];
  spawnoffs := actor.state.params.FixedVal[2];
  angle := ANG1 * actor.state.params.IntVal[3];
  aimmode := actor.state.params.IntVal[4] and 3;
  pitch := ANG1 * actor.state.params.IntVal[5];

  P_CustomMissile(actor, mobj_no, spawnheight, spawnoffs, angle, aimmode, pitch);
end;

//
// JVAL
// Standard random missile procedure
// A_RandomMissile(type1, type2, type3, ...)
//
procedure A_RandomMissile(actor: Pmobj_t);
var
  ridx: integer;
  mobj_no: integer;
  spawnheight: fixed_t;
  spawnoffs: integer;
  angle: angle_t;
  missile: Pmobj_t;
  ang: angle_t;
  x, y, z: fixed_t;
  velocity: vec3_t;
  missilespeed: fixed_t;
  owner: Pmobj_t;
begin
  if not P_CheckStateParams(actor) then
    exit;

  // Random index
  ridx := N_Random mod actor.state.params.Count;

  if actor.state.params.IsComputed[ridx] then
    mobj_no := actor.state.params.IntVal[ridx]
  else
  begin
    mobj_no := Info_GetMobjNumForName(actor.state.params.EvaluateStrVal[ridx]);
    actor.state.params.IntVal[ridx] := mobj_no;
  end;
  if mobj_no = -1 then
  begin
    I_Warning('A_RandomMissile(): Unknown missile %s'#13#10, [actor.state.params.StrVal[ridx]]);
    exit;
  end;

  if mobjinfo[mobj_no].speed < 2048 then
    mobjinfo[mobj_no].speed := mobjinfo[mobj_no].speed * FRACUNIT;  // JVAL fix me!!!
  spawnheight := 0;
  spawnoffs := 0;
  angle := 0;

  if actor.target <> nil then
  begin
    ang := (actor.angle - ANG90) shr ANGLETOFINESHIFT;
    x := spawnoffs * finecosine[ang];
    y := spawnoffs * finesine[ang];
    z := (spawnheight - 32) * FRACUNIT;
    inc(actor.x, x);
    inc(actor.y, y);
    inc(actor.z, z);
    missile := P_SpawnMissile(actor, actor.target, mobj_no);
    dec(actor.x, x);
    dec(actor.y, y);
    dec(actor.z, z);

    if missile <> nil then
    begin
      // Use the actual momentum instead of the missile's Speed property
      // so that this can handle missiles with a high vertical velocity
      // component properly.
      velocity[0] := missile.momx;
      velocity[1] := missile.momy;
      velocity[2] := 0.0;

      missilespeed := round(VectorLength(@velocity));

      missile.angle := missile.angle + angle;
      ang := missile.angle shr ANGLETOFINESHIFT;
      missile.momx := FixedMul(missilespeed, finecosine[ang]);
      missile.momy := FixedMul(missilespeed, finesine[ang]);

      owner := actor;
      while (owner.flags and MF_MISSILE <> 0) and (owner.target <> nil) do
        owner := owner.target;
       missile.target := owner;
      // automatic handling of seeker missiles
      if actor.flags_ex and missile.flags_ex and MF_EX_SEEKERMISSILE <> 0 then
        missile.tracer := actor.tracer;

    end;
  end;
end;

//
// A_SpawnItem(type, distance, zheight, angle)
//
procedure A_SpawnItem(actor: Pmobj_t);
var
  mobj_no: integer;
  distance: fixed_t;
  zheight: fixed_t;
  mo: Pmobj_t;
  ang: angle_t;
begin
  if not P_CheckStateParams(actor) then
    exit;

  if actor.state.params.IsComputed[0] then
    mobj_no := actor.state.params.IntVal[0]
  else
  begin
    mobj_no := Info_GetMobjNumForName(actor.state.params.EvaluateStrVal[0]);
    actor.state.params.IntVal[0] := mobj_no;
  end;
  if mobj_no = -1 then
  begin
    I_Warning('A_SpawnItem(): Unknown item %s'#13#10, [actor.state.params.StrVal[0]]);
    exit;
  end;

  distance := actor.state.params.FixedVal[1] + actor.radius + mobjinfo[mobj_no].radius;

  zheight := actor.state.params.FixedVal[2];
  ang := ANG1 * actor.state.params.IntVal[3];

  ang := (ang + actor.angle) shr ANGLETOFINESHIFT;
  mo := P_SpawnMobj(actor.x + FixedMul(distance, finecosine[ang]),
                    actor.y + FixedMul(distance, finesine[ang]),
                    actor.z{ - actor.floorz }+ zheight, mobj_no);
  if mo <> nil then
    mo.angle := actor.angle;
end;

function InitSpawnedItem(const self, mo: Pmobj_t; flags: integer): boolean;
const
  MAXLOOP = 64;
var
  originator: Pmobj_t;
  loop: integer;
begin
  if mo = nil then
  begin
    result := false;
    exit;
  end;

  // JVAL: 20211118 - Dropped flag
  if flags and SIXF_DROPPED <> 0 then
  {$IFDEF HEXEN}
    mo.flags2 := mo.flags2 or MF2_DROPPED;
  {$ELSE}
    mo.flags := mo.flags or MF_DROPPED;
  {$ENDIF}

  if flags and SIXF_TRANSFERTRANSLATION <> 0 then
    mo.flags := (mo.flags and not MF_TRANSLATION) or (self.flags and MF_TRANSLATION);

  if flags and SIXF_TRANSFERPOINTERS <> 0 then
  begin
    mo.target := self.target;
    mo.master := self.master; // This will be overridden later if SIXF_SETMASTER is set
    mo.tracer := self.tracer;
  end;

  originator := self;

  if flags and SIXF_ORIGINATOR = 0 then
  begin
    loop := 0;
    while originator <> nil do
    begin
      if originator.flags and MF_MISSILE = 0 then
        break;
      if loop = MAXLOOP then
        break;
      originator := originator.target;
      inc(loop);
    end;
  end;

  if flags and SIXF_TELEFRAG <> 0 then
  begin
    P_TeleportMove(mo, mo.x, mo.y);
    // This is needed to ensure consistent behavior.
    // Otherwise it will only spawn if nothing gets telefragged
    flags := flags or SIXF_NOCHECKPOSITION;
  end;

  if Info_IsMonster(mo._type) then
  begin
    if (flags and SIXF_NOCHECKPOSITION = 0) and not P_TestMobjLocation(mo) then
    begin
      // The monster is blocked so don't spawn it at all!
      P_RemoveMobj(mo);
      result := false;
      exit;
    end
    else if (originator <> nil) and (flags and SIXF_NOPOINTERS = 0) then
      P_CopyFriendliness(originator, mo);
  end
  else if flags and SIXF_TRANSFERPOINTERS <> 0 then
  begin
    // If this is a missile or something else set the target to the originator
    if originator <> nil then
      mo.target := originator
    else
      mo.target := self;
  end;

  if flags and SIXF_NOPOINTERS <> 0 then
  begin
    //[MC]Intentionally eliminate pointers. Overrides TRANSFERPOINTERS, but is overridden by SETMASTER/TARGET/TRACER.
    mo.target := nil;
    mo.master := nil;
    mo.tracer := nil;
  end;

  if flags and SIXF_SETMASTER <> 0 then
  begin
    // don't let it attack you (optional)!
    mo.master := originator;
  end;

  if flags and SIXF_SETTARGET <> 0 then
  begin
    mo.target := originator;
  end;

  if flags and SIXF_SETTRACER <> 0 then
  begin
    mo.tracer := originator;
  end;

  if flags and SIXF_TRANSFERSCALE <> 0 then
  begin
    mo.scale := self.scale;
  end;

  if flags and SIXF_TRANSFERAMBUSHFLAG <> 0 then
  begin
    mo.flags := (mo.flags and not MF_AMBUSH) or (self.flags and MF_AMBUSH);
  end;

  {$IFDEF HEXEN}
  if flags and SIXF_CLEARCALLERTID <> 0 then
  begin
    P_RemoveMobjFromTIDList(self);
    self.tid := 0;
    P_InsertMobjIntoTIDList(self, 0); // ?
  end;
  {$ENDIF}

  if flags and SIXF_TRANSFERSPECIAL <> 0 then
  begin
    mo.special := self.special;
    mo.args := self.args;
  end;

  if flags and SIXF_CLEARCALLERSPECIAL <> 0 then
  begin
    self.special := 0;
    FillChar(self.args, SizeOf(self.args), Chr(0));
  end;

  if flags and SIXF_TRANSFERALPHA <> 0 then
  begin
    mo.alpha := self.alpha;
  end;

  if flags and SIXF_TRANSFERRENDERSTYLE <> 0 then
  begin
    mo.RenderStyle := self.RenderStyle;
  end;

  if flags and SIXF_TRANSFERSPRITEFRAME <> 0 then
  begin
    mo.sprite := self.sprite;
    mo.frame := self.frame;
  end;

  if flags and SIXF_ISTARGET <> 0 then
  begin
    self.target := mo;
  end;

  if flags and SIXF_ISMASTER <> 0 then
  begin
    self.master := mo;
  end;

  if flags and SIXF_ISTRACER <> 0 then
  begin
    self.tracer := mo;
  end;

  result := true;
end;

//
// A_SpawnItemEx(type, xofs, yofs, zofs, momx, momy, momz, Angle, flags, chance)
//
// type -> parm0
// xofs -> parm1
// yofs -> parm2
// zofs -> parm3
// momx -> parm4
// momy -> parm5
// momz -> parm6
// Angle -> parm7
// flags -> parm8
// chance -> parm9
//
procedure A_SpawnItemEx(actor: Pmobj_t);
var
  mobj_no: integer;
  x, y: fixed_t;
  xofs, yofs, zofs: fixed_t;
  momx, momy, momz: fixed_t;
  newxmom: fixed_t;
  mo: Pmobj_t;
  ang, pang1: angle_t;
  flags: integer;
  chance: integer;
begin
  if not P_CheckStateParams(actor) then
    exit;

  chance := actor.state.params.IntVal[9];

  if (chance > 0) and (chance < N_Random) then
    exit;

  if actor.state.params.IsComputed[0] then
    mobj_no := actor.state.params.IntVal[0]
  else
  begin
    mobj_no := Info_GetMobjNumForName(actor.state.params.EvaluateStrVal[0]);
    actor.state.params.IntVal[0] := mobj_no;
  end;
  if mobj_no = -1 then
  begin
    I_Warning('A_SpawnItemEx(): Unknown item %s'#13#10, [actor.state.params.StrVal[0]]);
    exit;
  end;

  // JVAL 20180222 -> IntVal changed to FixedVal
  xofs := actor.state.params.FixedVal[1];
  yofs := actor.state.params.FixedVal[2];
  zofs := actor.state.params.FixedVal[3];
  momx := actor.state.params.FixedVal[4];
  momy := actor.state.params.FixedVal[5];
  momz := actor.state.params.FixedVal[6];
  pang1 := round(actor.state.params.FloatVal[7] * ANG1);
  flags := actor.state.params.IntVal[8];

  if flags and SIXF_ABSOLUTEANGLE = 0 then
    pang1 := pang1 + actor.angle;

  ang := pang1 shr ANGLETOFINESHIFT;

  if flags and SIXF_ABSOLUTEPOSITION <> 0 then
  begin
    x := actor.x + xofs;
    y := actor.y + yofs;
  end
  else
  begin
    // in relative mode negative y values mean 'left' and positive ones mean 'right'
    // This is the inverse orientation of the absolute mode!
    x := actor.x + FixedMul(xofs, finecosine[ang]) + FixedMul(yofs, finesine[ang]);
    y := actor.y + FixedMul(xofs, finesine[ang]) - FixedMul(yofs, finecosine[ang]);
  end;

  if flags and SIXF_ABSOLUTEMOMENTUM = 0 then
  begin
    // Same orientation issue here!
    newxmom := FixedMul(momx, finecosine[ang]) + FixedMul(momy, finesine[ang]);
    momy := FixedMul(momx, finesine[ang]) - FixedMul(momy, finecosine[ang]);
    momx := newxmom;
  end;

  mo := P_SpawnMobj(x, y, actor.z + zofs, mobj_no);

  if mo <> nil then
  begin
    mo.angle := ang1;
    InitSpawnedItem(actor, mo, flags);
    if flags and SIXF_MULTIPLYSPEED <> 0 then
    begin
      if mo.info.speed < 64 then
      begin
        mo.momx := momx * mo.info.speed;
        mo.momy := momy * mo.info.speed;
        mo.momz := momz * mo.info.speed;
      end
      else
      begin
        mo.momx := FixedMul(momx, mo.info.speed);
        mo.momy := FixedMul(momy, mo.info.speed);
        mo.momz := FixedMul(momz, mo.info.speed);
      end;
    end
    else
    begin
      mo.momx := momx;
      mo.momy := momy;
      mo.momz := momz;
    end;
  end;
end;

//
// Generic seeker missile function
//
// A_SeekerMissile(threshold: angle; turnMax: angle)
procedure A_SeekerMissile(actor: Pmobj_t);
begin
  if not P_CheckStateParams(actor) then
    exit;

  P_SeekerMissile(actor, actor.state.params.IntVal[0] * ANG1, actor.state.params.IntVal[1] * ANG1);
end;

procedure A_CStaffMissileSlither(actor: Pmobj_t);
var
  newX, newY: fixed_t;
  weaveXY: integer;
  angle: angle_t;
begin
  weaveXY := actor.bob;
  angle := (actor.angle + ANG90) shr ANGLETOFINESHIFT;
  newX := actor.x - FixedMul(finecosine[angle], FloatBobOffsets[weaveXY]);
  newY := actor.y - FixedMul(finesine[angle], FloatBobOffsets[weaveXY]);
  weaveXY := (weaveXY + 3) and 63;
  newX := newX + FixedMul(finecosine[angle], FloatBobOffsets[weaveXY]);
  newY := newY + FixedMul(finesine[angle], FloatBobOffsets[weaveXY]);
  P_TryMove(actor, newX, newY);
  actor.bob := weaveXY;
end;

procedure A_SetTranslucent(actor: Pmobj_t);
var
  newstyle: integer;
begin
  if not P_CheckStateParams(actor) then
    exit;

  actor.alpha := actor.state.params.FixedVal[0];

  if actor.alpha <= 0 then
  begin
    actor.renderstyle := mrs_normal;
    actor.flags := actor.flags or MF_SHADOW;
    actor.alpha := 0;
  end
  else if actor.alpha >= FRACUNIT then
  begin
    actor.renderstyle := mrs_normal;
    actor.flags := actor.flags and not MF_SHADOW;
    actor.alpha := FRACUNIT;
  end
  else
  begin
    if actor.renderstyle = mrs_normal then
      actor.renderstyle := mrs_translucent;
  end;

  if actor.state.params.Count = 1 then
    Exit;

  if not actor.state.params.IsComputed[1] then
    actor.state.params.IntVal[1] := Ord(R_GetRenderstyleForName(actor.state.params.StrVal[1]));

  newstyle := actor.state.params.IntVal[1];
  if newstyle = Ord(mrs_translucent) then
  begin
    actor.renderstyle := mrs_translucent;
    actor.flags := actor.flags and not MF_SHADOW;
  end
  else if newstyle = Ord(mrs_add) then
  begin
    actor.renderstyle := mrs_add;
    actor.flags := actor.flags and not MF_SHADOW;
  end
  else if newstyle = Ord(mrs_subtract) then
  begin
    actor.renderstyle := mrs_subtract;
    actor.flags := actor.flags and not MF_SHADOW;
  end
  else if newstyle = Ord(mrs_normal) then
  begin
    actor.renderstyle := mrs_normal;
    actor.flags := actor.flags and not MF_SHADOW;
  end;

end;

//
// FadeOut(reduce = 10%)
//
procedure A_FadeOut(actor: Pmobj_t);
var
  reduce: fixed_t;
begin
  reduce := FRACUNIT div 10;

  if actor.state.params <> nil then
    if actor.state.params.Count > 0 then
      reduce := actor.state.params.FixedVal[0];

  if actor.renderstyle = mrs_normal then
  begin
    actor.renderstyle := mrs_translucent;
    actor.alpha := FRACUNIT;
  end;

  actor.alpha := actor.alpha - reduce;
  if actor.alpha <= 0 then
    P_RemoveMobj(actor);
end;

// reduce -> percentage to reduce fading
procedure Do_FadeOut(actor: Pmobj_t; const reduce: integer);
begin
  if actor.renderstyle = mrs_normal then
  begin
    actor.renderstyle := mrs_translucent;
    actor.alpha := FRACUNIT;
  end;

  actor.alpha := actor.alpha - (reduce * FRACUNIT) div 100;
  if actor.alpha <= 0 then
    P_RemoveMobj(actor);
end;

procedure A_FadeOut10(actor: Pmobj_t);
begin
  Do_FadeOut(actor, 10);
end;

procedure A_FadeOut20(actor: Pmobj_t);
begin
  Do_FadeOut(actor, 20);
end;

procedure A_FadeOut30(actor: Pmobj_t);
begin
  Do_FadeOut(actor, 30);
end;

//
// FadeIn(incriment = 10%)
//
procedure A_FadeIn(actor: Pmobj_t);
var
  incriment: fixed_t;
begin
  if actor.renderstyle = mrs_normal then
    exit;

  incriment := FRACUNIT div 10;

  if actor.state.params <> nil then
    if actor.state.params.Count > 0 then
      incriment := actor.state.params.FixedVal[0];

  actor.alpha := actor.alpha + incriment;
  if actor.alpha >= FRACUNIT then
  begin
    actor.renderstyle := mrs_normal;
    actor.alpha := FRACUNIT;
  end;
end;

// incriment -> percentage to inscrease fading
procedure Do_FadeIn(actor: Pmobj_t; const incriment: integer);
begin
  actor.renderstyle := mrs_translucent;
  actor.alpha := actor.alpha + (incriment * FRACUNIT) div 100;
  if actor.alpha > FRACUNIT then
  begin
    actor.alpha := FRACUNIT;
    actor.renderstyle := mrs_normal
  end;
end;

procedure A_FadeIn10(actor: Pmobj_t);
begin
  Do_FadeIn(actor, 10);
end;

procedure A_FadeIn20(actor: Pmobj_t);
begin
  Do_FadeIn(actor, 20);
end;

procedure A_FadeIn30(actor: Pmobj_t);
begin
  Do_FadeIn(actor, 30);
end;

//
// A_MissileAttack(missilename = actor.info.missiletype)
//
procedure A_MissileAttack(actor: Pmobj_t);
var
  missile: Pmobj_t;
  mobj_no: integer;
begin
  mobj_no := actor.info.missiletype;

  if actor.state.params <> nil then
  begin
    if actor.state.params.IsComputed[0] then
      mobj_no := actor.state.params.IntVal[0]
    else
    begin
      mobj_no := Info_GetMobjNumForName(actor.state.params.EvaluateStrVal[0]);
      actor.state.params.IntVal[0] := mobj_no;
    end;
    if mobj_no = -1 then
    begin
      I_Warning('A_MissileAttack(): Unknown missile %s'#13#10, [actor.state.params.StrVal[0]]);
      exit;
    end;
  end
  else if mobj_no <= 0 then
  begin
    I_Warning('A_MissileAttack(): Unknown missile'#13#10);
    exit;
  end;

  if mobjinfo[mobj_no].speed < 256 then
    mobjinfo[mobj_no].speed := mobjinfo[mobj_no].speed * FRACUNIT;  // JVAL fix me!!!

  missile := P_SpawnMissile(actor, actor.target, mobj_no);

  if missile <> nil then
  begin
    if missile.flags_ex and MF_EX_SEEKERMISSILE <> 0 then
      missile.tracer := actor.target;
  end;

end;

//
// A_AdjustSideSpot(sideoffset: float)
//
procedure A_AdjustSideSpot(actor: Pmobj_t);
var
  offs: fixed_t;
  ang: angle_t;
  x, y: fixed_t;
begin
  if not P_CheckStateParams(actor, 1) then
    exit;

  offs := actor.state.params.Fixedval[0];

  ang := actor.angle shr ANGLETOFINESHIFT;

  x := FixedMul(offs, finecosine[ang]);
  y := FixedMul(offs, finesine[ang]);

  actor.x := actor.x + x;
  actor.y := actor.y + y;
end;

//
// JVAL
// A_ThrustZ(momz: float)
// Changes z momentum
//
procedure A_ThrustZ(actor: Pmobj_t);
begin
  if not P_CheckStateParams(actor, 1) then
    exit;

  actor.momz := actor.momz + actor.state.params.FixedVal[0];
end;

//
// JVAL
// A_ThrustXY(mom: float; ang: angle)
// Changes x, y momentum
//
procedure A_ThrustXY(actor: Pmobj_t);
var
  ang: angle_t;
  thrust: fixed_t;
begin
  if not P_CheckStateParams(actor) then
    exit;

  thrust := actor.state.params.FixedVal[0];

  ang := actor.angle + round(actor.state.params.FloatVal[1] * ANG1);
  ang := ang shr ANGLETOFINESHIFT;

  actor.momx := actor.momx + FixedMul(thrust, finecosine[ang]);
  actor.momy := actor.momy + FixedMul(thrust, finesine[ang]);
end;

//
// JVAL
// A_Turn(angle: float)
// Changes the actor's angle
//
procedure A_Turn(actor: Pmobj_t);
var
  ang: angle_t;
begin
  // JVAL: 20210109 - DEHEXTRA support
  if actor.state.params = nil then
  begin
    actor.angle := actor.angle + actor.state.misc1 * ANG1;
    exit;
  end;

  if not P_CheckStateParams(actor, 1) then
    exit;

  ang := round(actor.state.params.FloatVal[0] * ANG1);
  actor.angle := actor.angle + ang;
end;

//
// JVAL
// A_JumpIfCloser(distancetotarget: float, offset: integer)
// Jump conditionally to another state if distance to target is closer to first parameter
//
procedure A_JumpIfCloser(actor: Pmobj_t);
var
  dist: fixed_t;
  target: Pmobj_t;
  offset: integer;
begin
  if not P_CheckStateParams(actor, 2) then
    exit;

  if actor.player = nil then
    target := actor.target
  else
  begin
    // Does the player aim at something that can be shot?
    P_BulletSlope(actor);
    target := linetarget;
  end;

  // No target - no jump
  if target = nil then
    exit;

  dist := actor.state.params.FixedVal[0];
  if P_AproxDistance(actor.x - target.x, actor.y - target.y) < dist then
  begin
    offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[1]);
    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

//
// JVAL
// A_JumpIfHealthLower(health: integer; offset: integer)
// Jump conditionally to another state if health is lower to first parameter
//
procedure A_JumpIfHealthLower(actor: Pmobj_t);
var
  offset: integer;
begin
  if not P_CheckStateParams(actor, 2) then
    exit;

  if actor.health < actor.state.params.IntVal[0] then
  begin
    offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[1]);
    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

procedure A_ScreamAndUnblock(actor: Pmobj_t);
begin
  A_Scream(actor);
  A_NoBlocking(actor);
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
// P_DoNewChaseDir
//
// killough 9/8/98:
//
// Most of P_NewChaseDir(), except for what
// determines the new direction to take
//
const
  opposite: array[0..8] of dirtype_t = (
    DI_WEST, DI_SOUTHWEST, DI_SOUTH, DI_SOUTHEAST,
    DI_EAST, DI_NORTHEAST, DI_NORTH, DI_NORTHWEST, DI_NODIR
  );

  diags: array[0..3] of dirtype_t = (
    DI_NORTHWEST, DI_NORTHEAST, DI_SOUTHWEST, DI_SOUTHEAST
  );

procedure P_DoNewChaseDir(actor: Pmobj_t; deltax, deltay: fixed_t);
var
  d: array[0..2] of dirtype_t;
  dt: dirtype_t;
  tdir: integer;
  olddir, turnaround: dirtype_t;
begin
  olddir := dirtype_t(actor.movedir);
  turnaround := opposite[Ord(olddir)];

  if deltax > 10 * FRACUNIT then
    d[1] := DI_EAST
  else if deltax < -10 * FRACUNIT then
    d[1] := DI_WEST
  else
    d[1] := DI_NODIR;

  if deltay < -10 * FRACUNIT then
    d[2] := DI_SOUTH
  else if deltay > 10 * FRACUNIT then
    d[2] := DI_NORTH
  else
    d[2] := DI_NODIR;

  // try direct route
  if (d[1] <> DI_NODIR) and (d[2] <> DI_NODIR) then
  begin
    actor.movedir := Ord(diags[(intval(deltay < 0) shl 1) + intval(deltax > 0)]);
    if (actor.movedir <> Ord(turnaround)) and P_TryWalk(actor) then
      exit;
  end;

  // try other directions
  if (N_Random > 200) or (abs(deltay) > abs(deltax)) then
  begin
    dt := d[1];
    d[1] := d[2];
    d[2] := dt;
  end;

  if d[1] = turnaround then
    d[1] := DI_NODIR;
  if d[2] = turnaround then
    d[2] := DI_NODIR;

  if d[1] <> DI_NODIR then
  begin
    actor.movedir := Ord(d[1]);
    if P_TryWalk(actor) then
      exit; // either moved forward or attacked
  end;

  if d[2] <> DI_NODIR then
  begin
    actor.movedir := Ord(d[2]);
    if P_TryWalk(actor) then
      exit;
  end;

  // there is no direct path to the player, so pick another direction.
  if olddir <> DI_NODIR then
  begin
    actor.movedir := Ord(olddir);
    if P_TryWalk(actor) then
      exit;
  end;

  // randomly determine direction of search
  if N_Random and 1 <> 0 then
  begin
    for tdir := Ord(DI_EAST) to Ord(DI_SOUTHEAST) do
    begin
      if tdir <> Ord(turnaround) then
      begin
        actor.movedir := tdir;
        if P_TryWalk(actor) then
          exit;
      end;
    end;
  end
  else
  begin
    for tdir := Ord(DI_SOUTHEAST) downto Ord(DI_EAST) - 1 do
    begin
      if tdir <> Ord(turnaround) then
      begin
        actor.movedir := tdir;
        if P_TryWalk(actor) then
          exit;
      end;
    end;
  end;

  if turnaround <> DI_NODIR then
  begin
    actor.movedir := Ord(turnaround);
    if P_TryWalk(actor) then
      exit;
  end;

  actor.movedir := Ord(DI_NODIR);  // can not move
end;

//
// P_RandomChaseDir
//
procedure P_RandomChaseDir(actor: Pmobj_t);
var
  turndir, tdir: integer;
  olddir: integer;
  turnaround: dirtype_t;
begin
  olddir := actor.movedir;
  turnaround := opposite[olddir];

  // If the actor elects to continue in its current direction, let it do
  // so unless the way is blocked. Then it must turn.
  if N_Random < 150 then
  begin
    if P_TryWalk(actor) then
      exit;
  end;

  turndir := 1 - 2 * (N_Random and 1);

  if olddir = Ord(DI_NODIR) then
    olddir := N_Random and 7;

  tdir := (Ord(olddir) + turndir) and 7;
  while tdir <> olddir do
  begin
    if tdir <> Ord(turnaround) then
    begin
      actor.movedir := tdir;
      if P_TryWalk(actor) then
        exit;
    end;
    tdir := (tdir + turndir) and 7;
  end;

  if turnaround <> DI_NODIR then
  begin
    actor.movedir := Ord(turnaround);
    if P_TryWalk(actor) then
    begin
      actor.movecount := N_Random and 15;
      exit;
    end;
  end;

  actor.movedir := Ord(DI_NODIR);  // cannot move
end;

//
// A_Wander
//
procedure A_Wander(actor: Pmobj_t);
var
  delta: integer;
begin
  // modify target threshold
  if actor.threshold <> 0 then
    actor.threshold := actor.threshold - 1;

  // turn towards movement direction if not there yet
  if actor.movedir < 8 then
  begin
    actor.angle := actor.angle and $E0000000;
    delta := actor.angle - _SHLW(actor.movedir, 29);

    if delta > 0 then
      actor.angle := actor.angle - ANG45
    else if delta < 0 then
      actor.angle := actor.angle + ANG45;
  end;

  dec(actor.movecount);
  if (actor.movecount < 0) or P_Move(actor) then
  begin
    P_RandomChaseDir(actor);
    actor.movecount := actor.movecount + 5;
  end;
end;

procedure A_GhostOn(actor: Pmobj_t);
begin
  actor.flags := actor.flags or MF_SHADOW;
end;

procedure A_GhostOff(actor: Pmobj_t);
begin
  actor.flags := actor.flags and not MF_SHADOW;
end;

procedure A_Turn5(actor: Pmobj_t);
var
  ang: angle_t;
begin
  ang := 5 * ANG1;
  actor.angle := actor.angle + ang;
end;

procedure A_Turn10(actor: Pmobj_t);
var
  ang: angle_t;
begin
  ang := 10 * ANG1;
  actor.angle := actor.angle + ang;
end;

//
// JVAL
// Set blocking flag
//
procedure A_Blocking(actor: Pmobj_t);
begin
  actor.flags := actor.flags or MF_SOLID;
end;

procedure A_DoNotRunScripts(actor: Pmobj_t);
begin
  actor.flags2_ex := actor.flags2_ex or MF2_EX_DONTRUNSCRIPTS;
end;

procedure A_DoRunScripts(actor: Pmobj_t);
begin
  actor.flags2_ex := actor.flags2_ex and not MF2_EX_DONTRUNSCRIPTS;
end;

procedure A_SetDropItem(actor: Pmobj_t);
var
  mobj_no: integer;
begin
  if not P_CheckStateParams(actor, 1) then
    exit;

  if actor.state.params.IsComputed[0] then
    mobj_no := actor.state.params.IntVal[0]
  else
  begin
    mobj_no := Info_GetMobjNumForName(actor.state.params.EvaluateStrVal[0]);
    actor.state.params.IntVal[0] := mobj_no;
  end;
  if mobj_no = -1 then
  begin
    I_Warning('A_SetDropItem(): Unknown item %s'#13#10, [actor.state.params.StrVal[0]]);
    exit;
  end;

  actor.dropitem := mobj_no;
  actor.flags2_ex := actor.flags2_ex or MF2_EX_CUSTOMDROPITEM;
end;

procedure A_SetDefaultDropItem(actor: Pmobj_t);
begin
  actor.dropitem := 0;
  actor.flags2_ex := actor.flags2_ex and not MF2_EX_CUSTOMDROPITEM;
end;

procedure A_TargetDropItem(actor: Pmobj_t);
var
  mobj_no: integer;
begin
  if not P_CheckStateParams(actor, 1) then
    exit;

  if actor.target = nil then
    exit;

  if actor.state.params.IsComputed[0] then
    mobj_no := actor.state.params.IntVal[0]
  else
  begin
    mobj_no := Info_GetMobjNumForName(actor.state.params.EvaluateStrVal[0]);
    actor.state.params.IntVal[0] := mobj_no;
  end;
  if mobj_no = -1 then
  begin
    I_Warning('A_TargetDropItem(): Unknown item %s'#13#10, [actor.state.params.StrVal[0]]);
    exit;
  end;

  actor.target.dropitem := mobj_no;
  actor.target.flags2_ex := actor.target.flags2_ex or MF2_EX_CUSTOMDROPITEM;
end;

procedure A_DefaultTargetDropItem(actor: Pmobj_t);
begin
  if actor.target = nil then
    exit;

  actor.target.dropitem := 0;
  actor.target.flags2_ex := actor.target.flags2_ex and not MF2_EX_CUSTOMDROPITEM;
end;

function P_ActorTarget(const actor: Pmobj_t): Pmobj_t;
begin
  if actor = nil then
  begin
    result := nil;
    exit;
  end;

  if actor.player = nil then
    result := actor.target
  else
  begin
    // Does the player aim at something that can be shot?
    P_BulletSlope(actor);
    result := linetarget;
  end;
end;

//
// A_GlobalEarthQuake (tics: integer);
//
procedure A_GlobalEarthQuake(actor: Pmobj_t);
var
  qtics: integer;
  i: integer;
begin
  if not P_CheckStateParams(actor, 1) then
    exit;

  qtics := actor.state.params.IntVal[0] * FRACUNIT;
  for i := 0 to MAXPLAYERS - 1 do
    if playeringame[i] then
    begin
      players[i].quaketics := qtics;
      players[i].quakeintensity := FRACUNIT;
    end;
end;

// A_SetMapStr(var: string; value1: string; [value2: string],...)
procedure A_SetMapStr(actor: Pmobj_t);
var
  s: string;
  i: integer;
begin
  if not P_CheckStateParams(actor) then
    exit;

  s := '';
  for i := 1 to actor.state.params.Count - 1 do
  begin
    s := s + actor.state.params.StrVal[i];
    if i < actor.state.params.Count - 1 then
      s := s + ' ';
  end;

  PS_SetMapStr(actor.state.params.StrVal[0], s);
end;

// A_SetWorldStr(var: string; value1: string; [value2: string],...)
procedure A_SetWorldStr(actor: Pmobj_t);
var
  s: string;
  i: integer;
begin
  if not P_CheckStateParams(actor) then
    exit;

  s := '';
  for i := 1 to actor.state.params.Count - 1 do
  begin
    s := s + actor.state.params.StrVal[i];
    if i < actor.state.params.Count - 1 then
      s := s + ' ';
  end;

  PS_SetWorldStr(actor.state.params.StrVal[0], s);
end;

// A_SetMapInt(var: string; value: integer);
procedure A_SetMapInt(actor: Pmobj_t);
begin
  if not P_CheckStateParams(actor, 2) then
    exit;

  PS_SetMapInt(actor.state.params.StrVal[0], actor.state.params.IntVal[1]);
end;

// A_SetWorldInt(var: string; value: integer);
procedure A_SetWorldInt(actor: Pmobj_t);
begin
  if not P_CheckStateParams(actor, 2) then
    exit;

  PS_SetWorldInt(actor.state.params.StrVal[0], actor.state.params.IntVal[1]);
end;

// A_SetMapFloat(var: string; value: float);
procedure A_SetMapFloat(actor: Pmobj_t);
begin
  if not P_CheckStateParams(actor, 2) then
    exit;

  PS_SetMapFloat(actor.state.params.StrVal[0], actor.state.params.FloatVal[1]);
end;

// A_SetWorldFloat(var: string; value: float);
procedure A_SetWorldFloat(actor: Pmobj_t);
begin
  if not P_CheckStateParams(actor, 2) then
    exit;

  PS_SetWorldFloat(actor.state.params.StrVal[0], actor.state.params.FloatVal[1]);
end;

//
// A_RandomGoto(state1, state2, ....)
//
procedure A_RandomGoto(actor: Pmobj_t);
var
  newstate: integer;
  idx: integer;
begin
  if not P_CheckStateParams(actor) then
    exit;

  idx := N_Random mod actor.state.params.Count;

  if not actor.state.params.IsComputed[idx] then
  begin
    newstate := P_GetStateFromName(actor, actor.state.params.StrVal[idx]);
    actor.state.params.IntVal[idx] := newstate;
  end
  else
    newstate := actor.state.params.IntVal[idx];

  P_SetMobjState(actor, statenum_t(newstate));
end;

procedure P_SetHealth(const mo: Pmobj_t; const h: integer);
var
  p: Pplayer_t;
begin
  if mo.health <= 0 then
    exit;

  if h <= 0 then
  begin
    P_DamageMobj(mo, nil, nil, 10000);
    exit;
  end;

  mo.health := h;
  p := mo.player;
  if p <> nil then
    p.health := h;
end;

procedure A_ResetHealth(actor: Pmobj_t);
begin
  P_SetHealth(actor, actor.info.spawnhealth);
end;

procedure A_SetHealth(actor: Pmobj_t);
begin
  if not P_CheckStateParams(actor, 1) then
    exit;

  P_SetHealth(actor, actor.state.params.IntVal[0]);
end;

procedure A_ResetTargetHealth(actor: Pmobj_t);
begin
  if actor.target <> nil then
    P_SetHealth(actor.target, actor.target.info.spawnhealth);
end;

procedure A_SetTargetHealth(actor: Pmobj_t);
begin
  if actor.target = nil then
    exit;

  if not P_CheckStateParams(actor, 1) then
    exit;

  P_SetHealth(actor.target, actor.state.params.IntVal[0]);
end;

procedure A_Recoil(actor: Pmobj_t);
var
  xymom: fixed_t;
  angle: angle_t;
begin
  if not P_CheckStateParams(actor, 1) then
    exit;

  xymom := actor.state.params.FixedVal[0];

  angle := (actor.angle + ANG180) shr ANGLETOFINESHIFT;
  actor.momx := actor.momx + FixedMul(xymom, finecosine[angle]);
  actor.momy := actor.momy + FixedMul(xymom, finesine[angle]);
end;

procedure A_SetSolid(actor: Pmobj_t);
begin
  actor.flags := actor.flags or MF_SOLID;
end;

procedure A_UnSetSolid(actor: Pmobj_t);
begin
  actor.flags := actor.flags and not MF_SOLID;
end;

procedure A_SetFloat(actor: Pmobj_t);
begin
  actor.flags := actor.flags or MF_FLOAT;
end;

procedure A_UnSetFloat(actor: Pmobj_t);
begin
  actor.flags := actor.flags and not (MF_FLOAT or MF_INFLOAT);
end;

//
// A_ScaleVelocity(scale: float)
// zDoom compatibility
//
procedure A_ScaleVelocity(actor: Pmobj_t);
var
  scale: fixed_t;
begin
  if not P_CheckStateParams(actor) then
    exit;

  scale := actor.state.params.FixedVal[0];

  actor.momx := FixedMul(actor.momx, scale);
  actor.momy := FixedMul(actor.momy, scale);
  actor.momz := FixedMul(actor.momz, scale);
end;

//
// A_ChangeVelocity(velx, vely, velz: float; flags: integer)
// zDoom compatibility
//
procedure A_ChangeVelocity(actor: Pmobj_t);
var
  vx, vy, vz: fixed_t;
  vx1, vy1: fixed_t;
  an: angle_t;
  sina, cosa: fixed_t;
  flags: integer;
  stmp: string;
  sc: TSCriptEngine;
  i: integer;
begin
  if not P_CheckStateParams(actor, 1, CSP_AT_LEAST) then
    exit;

  vx := actor.state.params.FixedVal[0];
  vy := actor.state.params.FixedVal[1];
  vz := actor.state.params.FixedVal[2];

  if not actor.state.params.IsComputed[3] then
  begin
    stmp := actor.state.params.StrVal[3];
    for i := 1 to Length(stmp) do
      if stmp[i] = '|' then
        stmp[i] := ' ';
    flags := 0;
    sc := TSCriptEngine.Create(stmp);
    while sc.GetString do
      flags := flags or (SC_EvalueateIntToken(sc._String, ['CVF_RELATIVE', 'CVF_REPLACE']) + 1);
    sc.Free;
    actor.state.params.IntVal[3] := flags;
  end
  else
    flags := actor.state.params.IntVal[3];

  if flags and 1 <> 0 then
  begin
    an := actor.angle shr ANGLETOFINESHIFT;
    sina := finesine[an];
    cosa := finecosine[an];
    vx1 := vx;
    vy1 := vy;
    vx := FixedMul(vx1, cosa) - FixedMul(vy1, sina);
    vy := FixedMul(vx1, sina) + FixedMul(vy1, cosa);
  end;

  if flags and 2 <> 0 then
  begin
    actor.momx := vx;
    actor.momy := vy;
    actor.momz := vz;
  end
  else
  begin
    actor.momx := actor.momx + vx;
    actor.momy := actor.momy + vy;
    actor.momz := actor.momz + vz;
  end;
end;

procedure A_SetPushFactor(actor: Pmobj_t);
begin
  if not P_CheckStateParams(actor, 1) then
    exit;

  actor.pushfactor := actor.state.params.FixedVal[0];
end;

procedure A_SetScale(actor: Pmobj_t);
begin
  if not P_CheckStateParams(actor, 1) then
    exit;

  actor.scale := actor.state.params.FixedVal[0];
end;

procedure A_SetGravity(actor: Pmobj_t);
begin
  if not P_CheckStateParams(actor, 1) then
    exit;

  actor.gravity := actor.state.params.FixedVal[0];
end;


procedure A_SetFloorBounce(actor: Pmobj_t);
begin
  actor.flags3_ex := actor.flags3_ex or MF3_EX_FLOORBOUNCE;
end;

procedure A_UnSetFloorBounce(actor: Pmobj_t);
begin
  actor.flags3_ex := actor.flags3_ex and not MF3_EX_FLOORBOUNCE;
end;

procedure A_SetCeilingBounce(actor: Pmobj_t);
begin
  actor.flags3_ex := actor.flags3_ex or MF3_EX_CEILINGBOUNCE;
end;

procedure A_UnSetCeilingBounce(actor: Pmobj_t);
begin
  actor.flags3_ex := actor.flags3_ex and not MF3_EX_CEILINGBOUNCE;
end;

procedure A_SetWallBounce(actor: Pmobj_t);
begin
  actor.flags3_ex := actor.flags3_ex or MF3_EX_WALLBOUNCE;
end;

procedure A_UnSetWallBounce(actor: Pmobj_t);
begin
  actor.flags3_ex := actor.flags3_ex and not MF3_EX_WALLBOUNCE;
end;

procedure A_GlowLight(actor: Pmobj_t);
const
  ACL_NONE = 0;
  ACL_WHITE = 1;
  ACL_RED = 2;
  ACL_GREEN = 3;
  ACL_BLUE = 4;
  ACL_YELLOW = 5;
var
  scolor: string;
begin
  if not P_CheckStateParams(actor, 1, CSP_AT_LEAST) then
    exit;

  if not actor.state.params.IsComputed[0] then
  begin
    scolor := strupper(strtrim(actor.state.params.StrVal[0]));
    if scolor = 'WHITE' then
      actor.state.params.IntVal[0] := ACL_WHITE
    else if scolor = 'RED' then
      actor.state.params.IntVal[0] := ACL_RED
    else if scolor = 'GREEN' then
      actor.state.params.IntVal[0] := ACL_GREEN
    else if scolor = 'BLUE' then
      actor.state.params.IntVal[0] := ACL_BLUE
    else if scolor = 'YELLOW' then
      actor.state.params.IntVal[0] := ACL_YELLOW
    else
      actor.state.params.IntVal[0] := ACL_NONE;
  end;

  actor.flags_ex := actor.flags_ex and not MF_EX_LIGHT;
  case actor.state.params.IntVal[0] of
    ACL_WHITE: actor.flags_ex := actor.flags_ex or MF_EX_WHITELIGHT;
    ACL_RED: actor.flags_ex := actor.flags_ex or MF_EX_REDLIGHT;
    ACL_GREEN: actor.flags_ex := actor.flags_ex or MF_EX_GREENLIGHT;
    ACL_BLUE: actor.flags_ex := actor.flags_ex or MF_EX_BLUELIGHT;
    ACL_YELLOW: actor.flags_ex := actor.flags_ex or MF_EX_YELLOWLIGHT;
  end;
end;

function P_TicsFromState(const st: Pstate_t): integer;
begin
  if st.flags_ex and MF_EX_STATE_RANDOM_SELECT <> 0 then
  begin
    if P_Random < 128 then
      result := st.tics
    else
      result := st.tics2;
  end
  else if st.flags_ex and MF_EX_STATE_RANDOM_RANGE <> 0 then
  begin
    if st.tics2 > st.tics then
      result := st.tics + P_Random mod (st.tics2 - st.tics + 1)
    else if st.tics2 < st.tics then
      result := st.tics + P_Random mod (st.tics - st.tics2 + 1)
    else
      result := st.tics;
  end
  else
    result := st.tics;
end;

const
  DEFTRACEANGLE = 15 * ANG1;

//
// A_TraceNearestPlayer(pct: integer, [maxturn: angle])
// pct -> propability
procedure A_TraceNearestPlayer(actor: Pmobj_t);
var
  pct: integer;
  exact: angle_t;
  dist: fixed_t;
  slope: fixed_t;
  dest: Pmobj_t;
  i: integer;
  nearest: integer;
  mindist: integer;
  maxturn: angle_t;
begin
  if not P_CheckStateParams(actor, 1, CSP_AT_LEAST) then
    exit;

  pct := actor.state.params.IntVal[0];
  if pct < P_Random then
    exit;

  dest := nil;
  nearest := MAXINT;

  for i := 0 to MAXPLAYERS - 1 do
    if playeringame[i] then
      if players[i].mo <> nil then
        if players[i].mo.health >= 0 then
        begin
          mindist := P_AproxDistance(players[i].mo.x - actor.x, players[i].mo.y - actor.y);
          if mindist < nearest then
          begin
            nearest := mindist;
            dest := players[i].mo;
          end;
        end;

  if dest = nil then
    exit;

  // change angle
  exact := R_PointToAngle2(actor.x, actor.y, dest.x, dest.y);

  if actor.state.params.Count >= 2 then
    maxturn := actor.state.params.IntVal[1] * ANG1
  else
    maxturn := DEFTRACEANGLE;

  if exact <> actor.angle then
  begin
    if exact - actor.angle > ANG180 then
    begin
      actor.angle := actor.angle - maxturn;
      if exact - actor.angle < ANG180 then
        actor.angle := exact;
    end
    else
    begin
      actor.angle := actor.angle + maxturn;
      if exact - actor.angle > ANG180 then
        actor.angle := exact;
    end;
  end;

  {$IFDEF FPC}
  exact := _SHRW(actor.angle, ANGLETOFINESHIFT);
  {$ELSE}
  exact := actor.angle shr ANGLETOFINESHIFT;
  {$ENDIF}
  actor.momx := FixedMul(actor.info.speed, finecosine[exact]);
  actor.momy := FixedMul(actor.info.speed, finesine[exact]);

  // change slope
  dist := P_AproxDistance(dest.x - actor.x, dest.y - actor.y);

  dist := dist div actor.info.speed;

  if dist < 1 then
    dist := 1;
  slope := (dest.z + 40 * FRACUNIT - actor.z) div dist;

  if slope < actor.momz then
    actor.momz := actor.momz - FRACUNIT div 8
  else
    actor.momz := actor.momz + FRACUNIT div 8;
end;

procedure A_ChangeFlag(actor: Pmobj_t);
var
  sflag: string;
  change: boolean;
  flg: LongWord;
  idx: integer;
begin
  if not P_CheckStateParams(actor, 2, CSP_AT_LEAST) then
    exit;

  sflag := strupper(actor.state.params.StrVal[0]);
  change := actor.state.params.BoolVal[1];

  idx := mobj_flags.IndexOf(sflag);
  if idx < 0 then
    idx := mobj_flags.IndexOf('MF_' + sflag);
  if idx >= 0 then
  begin
    flg := 1 shl idx;
    if change then
      actor.flags := actor.flags or flg
    else
      actor.flags := actor.flags and not flg;
    exit;
  end;

  {$IFDEF HERETIC_OR_HEXEN}
  idx := mobj_flags2.IndexOf(sflag);
  if idx < 0 then
    idx := mobj_flags2.IndexOf('MF2_' + sflag);
  if idx >= 0 then
  begin
    flg := 1 shl idx;
    if change then
      actor.flags2 := actor.flags2 or flg
    else
      actor.flags2 := actor.flags2 and not flg;
    exit;
  end;
  {$ENDIF}

  idx := mobj_flags_ex.IndexOf(sflag);
  if idx < 0 then
    idx := mobj_flags_ex.IndexOf('MF_EX_' + sflag);
  if idx >= 0 then
  begin
    flg := 1 shl idx;
    if change then
      actor.flags_ex := actor.flags_ex or flg
    else
      actor.flags_ex := actor.flags_ex and not flg;
    exit;
  end;

  idx := mobj_flags2_ex.IndexOf(sflag);
  if idx < 0 then
    idx := mobj_flags2_ex.IndexOf('MF2_EX_' + sflag);
  if idx >= 0 then
  begin
    flg := 1 shl idx;
    if change then
      actor.flags2_ex := actor.flags2_ex or flg
    else
      actor.flags2_ex := actor.flags2_ex and not flg;
    exit;
  end;

  idx := mobj_flags3_ex.IndexOf(sflag);
  if idx < 0 then
    idx := mobj_flags3_ex.IndexOf('MF3_EX_' + sflag);
  if idx >= 0 then
  begin
    flg := 1 shl idx;
    if change then
      actor.flags3_ex := actor.flags3_ex or flg
    else
      actor.flags3_ex := actor.flags3_ex and not flg;
    exit;
  end;

  idx := mobj_flags4_ex.IndexOf(sflag);
  if idx < 0 then
    idx := mobj_flags4_ex.IndexOf('MF4_EX_' + sflag);
  if idx >= 0 then
  begin
    flg := 1 shl idx;
    if change then
      actor.flags4_ex := actor.flags4_ex or flg
    else
      actor.flags4_ex := actor.flags4_ex and not flg;
    exit;
  end;

  idx := mobj_flags5_ex.IndexOf(sflag);
  if idx < 0 then
    idx := mobj_flags5_ex.IndexOf('MF5_EX_' + sflag);
  if idx >= 0 then
  begin
    flg := 1 shl idx;
    if change then
      actor.flags5_ex := actor.flags5_ex or flg
    else
      actor.flags5_ex := actor.flags5_ex and not flg;
    exit;
  end;

  idx := mobj_flags6_ex.IndexOf(sflag);
  if idx < 0 then
    idx := mobj_flags6_ex.IndexOf('MF6_EX_' + sflag);
  if idx >= 0 then
  begin
    flg := 1 shl idx;
    if change then
      actor.flags6_ex := actor.flags6_ex or flg
    else
      actor.flags6_ex := actor.flags6_ex and not flg;
    exit;
  end;
end;

procedure A_CheckFloor(actor: Pmobj_t);
var
  offset: integer;
begin
  if actor.z <= actor.floorz then
  begin
    offset := actor.info.deathstate;

    if actor.state.params <> nil then
      if actor.state.params.Count > 0 then
        offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[0]);

    if offset = actor.info.deathstate then
      A_Gravity(actor); // JVAL SOS

    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

procedure A_CheckCeiling(actor: Pmobj_t);
var
  offset: integer;
begin
  if not P_CheckStateParams(actor, 1) then
    exit;

  if actor.z >= actor.ceilingz then
  begin
    offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[0]);
    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

procedure A_StopSound(actor: Pmobj_t);
begin
  S_StopSound(actor);
end;

procedure A_JumpIfTargetOutsideMeleeRange(actor: Pmobj_t);
var
  offset: integer;
begin
  if not P_CheckStateParams(actor, 1) then
    exit;

  if not P_CheckMeleeRange(actor) then
  begin
    offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[0]);
    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

procedure A_JumpIfTargetInsideMeleeRange(actor: Pmobj_t);
var
  offset: integer;
begin
  if not P_CheckStateParams(actor, 1) then
    exit;

  if P_CheckMeleeRange(actor) then
  begin
    offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[0]);
    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

//
// A_JumpIfTracerCloser(distancetotarget: float, offset: integer)
//
procedure A_JumpIfTracerCloser(actor: Pmobj_t);
var
  dist: fixed_t;
  offset: integer;
begin
  if ismbf21 then
  begin
    A_JumpIfTracerCloserMBF21(actor);
    exit;
  end;

  if not P_CheckStateParams(actor, 2) then
    exit;

  // No tracer - no jump
  if actor.tracer = nil then
    exit;

  dist := actor.state.params.FixedVal[0];
  if P_AproxDistance(actor.x - actor.tracer.x, actor.y - actor.tracer.y) < dist then
  begin
    offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[1]);
    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

//
// A_SetMass(mass: integer)
//
procedure A_SetMass(actor: Pmobj_t);
begin
  if not P_CheckStateParams(actor, 1) then
    exit;

  actor.mass := actor.state.params.IntVal[0];
end;

//
// A_SetTargetMass(mass: integer)
//
procedure A_SetTargetMass(actor: Pmobj_t);
begin
  if not P_CheckStateParams(actor, 1) then
    exit;

  if actor.target = nil then
    exit;

  actor.target.mass := actor.state.params.IntVal[0];
end;

//
// A_SetTracerMass(mass: integer)
//
procedure A_SetTracerMass(actor: Pmobj_t);
begin
  if not P_CheckStateParams(actor, 1) then
    exit;

  if actor.tracer = nil then
    exit;

  actor.tracer.mass := actor.state.params.IntVal[0];
end;

//
// A_SetMasterMass(mass: integer)
//
procedure A_SetMasterMass(actor: Pmobj_t);
begin
  if not P_CheckStateParams(actor, 1) then
    exit;

  if actor.master = nil then
    exit;

  actor.master.mass := actor.state.params.IntVal[0];
end;

//
// A_CheckSight(offset: integer)
// Jumps to offset if no player can see this actor
//
procedure A_CheckSight(actor: Pmobj_t);
var
  i: integer;
  offset: integer;
begin
  if not P_CheckStateParams(actor, 1) then
    exit;

  for i := 0 to MAXPLAYERS - 1 do
    if playeringame[i] then
      if players[i].mo <> actor then
        if P_CheckSight(players[i].mo, actor) then
          exit;

  offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[0]);
  if @states[offset] <> actor.state then
    P_SetMobjState(actor, statenum_t(offset));
end;

//
// A_CheckSightOrRange(distance: float; offset: integer; [twodi: boolean=false])
// Jumps to offset if no player can see this actor or out of player range
//
procedure A_CheckSightOrRange(actor: Pmobj_t);
var
  i: integer;
  offset: integer;
  distance: fixed64_t;
  range: fixed64_t;
  twodi: boolean;
  dx, dy, dz: fixed64_t;
begin
  if not P_CheckStateParams(actor, 2, CSP_AT_LEAST) then
    exit;

  distance := actor.state.params.FixedVal[0];
  distance := FixedMul64(distance, distance);
  twodi := actor.state.params.BoolVal[2];

  for i := 0 to MAXPLAYERS - 1 do
    if playeringame[i] then
      if players[i].mo <> actor then
      begin
        dx := players[i].mo.x - actor.x;
        dy := players[i].mo.y - actor.y;
        if twodi then
        begin
          dz := players[i].mo.z - actor.z;
          range := FixedMul64(dx, dx) + FixedMul64(dy, dy) + FixedMul64(dz, dz);
        end
        else
          range := FixedMul64(dx, dx) + FixedMul64(dy, dy);
        if distance <= range then
          exit;
      end;

  for i := 0 to MAXPLAYERS - 1 do
    if playeringame[i] then
      if players[i].mo <> actor then
        if P_CheckSight(players[i].mo, actor) then
          exit;

  offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[1]);
  if @states[offset] <> actor.state then
    P_SetMobjState(actor, statenum_t(offset));
end;

//
// A_CheckRange(distance: float; offset: integer; [twodi: boolean=false])
// Jumps to offset if out of player range
//
procedure A_CheckRange(actor: Pmobj_t);
var
  i: integer;
  offset: integer;
  distance: fixed64_t;
  range: fixed64_t;
  twodi: boolean;
  dx, dy, dz: fixed64_t;
begin
  if not P_CheckStateParams(actor, 2, CSP_AT_LEAST) then
    exit;

  distance := actor.state.params.FixedVal[0];
  distance := FixedMul64(distance, distance);
  twodi := actor.state.params.BoolVal[2];

  for i := 0 to MAXPLAYERS - 1 do
    if playeringame[i] then
      if players[i].mo <> actor then
      begin
        dx := players[i].mo.x - actor.x;
        dy := players[i].mo.y - actor.y;
        if twodi then
        begin
          dz := players[i].mo.z - actor.z;
          range := FixedMul64(dx, dx) + FixedMul64(dy, dy) + FixedMul64(dz, dz);
        end
        else
          range := FixedMul64(dx, dx) + FixedMul64(dy, dy);
        if distance <= range then
          exit;
      end;

  offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[1]);
  if @states[offset] <> actor.state then
    P_SetMobjState(actor, statenum_t(offset));
end;

//
// A_CountdownArg(arg: integer; offset: integer);
//
procedure A_CountdownArg(actor: Pmobj_t);
var
  arg: integer;
  sarg: string;
  offset: integer;
begin
  if not P_CheckStateParams(actor, 2) then
    exit;

  if not actor.state.params.IsComputed[0] then
  begin
    sarg := strupper(actor.state.params.StrVal[0]);
    if sarg = 'C_ARG1' then
      actor.state.params.IntVal[0] := 0
    else if sarg = 'C_ARG2' then
      actor.state.params.IntVal[0] := 1
    else if sarg = 'C_ARG3' then
      actor.state.params.IntVal[0] := 2
    else if sarg = 'C_ARG4' then
      actor.state.params.IntVal[0] := 3
    else if sarg = 'C_ARG5' then
      actor.state.params.IntVal[0] := 4;
  end;

  arg := actor.state.params.IntVal[0];
  if not IsIntegerInRange(arg, 0, 4) then
    exit;

  if actor.args[arg] = 0 then
    Exit;

  Dec(actor.args[arg]);
  if actor.args[arg] = 0 then
  begin
    if actor.state.params.Count = 1 then
      offset := -1
    else
      offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[1]);
    if offset = -1 then
    begin
      if actor.flags and MF_MISSILE <> 0 then
      begin
        P_ExplodeMissile(actor);
        Exit;
      end
      else if actor.flags and MF_SHOOTABLE <> 0 then
      begin
        P_DamageMobj(actor, nil, nil, 10000);
        Exit;
      end
      else
      begin
        offset := actor.info.deathstate;
        if offset < 0 then
          offset := Ord(S_NULL);
      end;
    end;
    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

//
// A_SetArg(arg: integer; value: integer)
//
procedure A_SetArg(actor: Pmobj_t);
var
  arg: integer;
  sarg: string;
begin
  if not P_CheckStateParams(actor, 2) then
    exit;

  if not actor.state.params.IsComputed[0] then
  begin
    sarg := strupper(actor.state.params.StrVal[0]);
    if sarg = 'C_ARG1' then
      actor.state.params.IntVal[0] := 0
    else if sarg = 'C_ARG2' then
      actor.state.params.IntVal[0] := 1
    else if sarg = 'C_ARG3' then
      actor.state.params.IntVal[0] := 2
    else if sarg = 'C_ARG4' then
      actor.state.params.IntVal[0] := 3
    else if sarg = 'C_ARG5' then
      actor.state.params.IntVal[0] := 4;
  end;

  arg := actor.state.params.IntVal[0];
  if not IsIntegerInRange(arg, 0, 4) then
    exit;

  actor.args[arg] := actor.state.params.IntVal[1];
end;

//
// A_SetMasterArg(arg: integer; value: integer)
//
procedure A_SetMasterArg(actor: Pmobj_t);
var
  arg: integer;
  sarg: string;
begin
  if actor.master = nil then
    exit;
  if not P_CheckStateParams(actor, 2) then
    exit;

  if not actor.state.params.IsComputed[0] then
  begin
    sarg := strupper(actor.state.params.StrVal[0]);
    if sarg = 'C_ARG1' then
      actor.state.params.IntVal[0] := 0
    else if sarg = 'C_ARG2' then
      actor.state.params.IntVal[0] := 1
    else if sarg = 'C_ARG3' then
      actor.state.params.IntVal[0] := 2
    else if sarg = 'C_ARG4' then
      actor.state.params.IntVal[0] := 3
    else if sarg = 'C_ARG5' then
      actor.state.params.IntVal[0] := 4;
  end;

  arg := actor.state.params.IntVal[0];
  if not IsIntegerInRange(arg, 0, 4) then
    exit;

  actor.master.args[arg] := actor.state.params.IntVal[1];
end;

//
// A_SetTargetArg(arg: integer; value: integer)
//
procedure A_SetTargetArg(actor: Pmobj_t);
var
  arg: integer;
  sarg: string;
begin
  if actor.target = nil then
    exit;
  if not P_CheckStateParams(actor, 2) then
    exit;

  if not actor.state.params.IsComputed[0] then
  begin
    sarg := strupper(actor.state.params.StrVal[0]);
    if sarg = 'C_ARG1' then
      actor.state.params.IntVal[0] := 0
    else if sarg = 'C_ARG2' then
      actor.state.params.IntVal[0] := 1
    else if sarg = 'C_ARG3' then
      actor.state.params.IntVal[0] := 2
    else if sarg = 'C_ARG4' then
      actor.state.params.IntVal[0] := 3
    else if sarg = 'C_ARG5' then
      actor.state.params.IntVal[0] := 4;
  end;

  arg := actor.state.params.IntVal[0];
  if not IsIntegerInRange(arg, 0, 4) then
    exit;

  actor.target.args[arg] := actor.state.params.IntVal[1];
end;

//
// A_SetTracerArg(arg: integer; value: integer)
//
procedure A_SetTracerArg(actor: Pmobj_t);
var
  arg: integer;
  sarg: string;
begin
  if actor.tracer = nil then
    exit;
  if not P_CheckStateParams(actor, 2) then
    exit;

  if not actor.state.params.IsComputed[0] then
  begin
    sarg := strupper(actor.state.params.StrVal[0]);
    if sarg = 'C_ARG1' then
      actor.state.params.IntVal[0] := 0
    else if sarg = 'C_ARG2' then
      actor.state.params.IntVal[0] := 1
    else if sarg = 'C_ARG3' then
      actor.state.params.IntVal[0] := 2
    else if sarg = 'C_ARG4' then
      actor.state.params.IntVal[0] := 3
    else if sarg = 'C_ARG5' then
      actor.state.params.IntVal[0] := 4;
  end;

  arg := actor.state.params.IntVal[0];
  if not IsIntegerInRange(arg, 0, 4) then
    exit;

  actor.tracer.args[arg] := actor.state.params.IntVal[1];
end;

//
// A_SetSpecial(special: integer; [arg1, arg2, arg3, arg4, arg5: integer]);
//
procedure A_SetSpecial(actor: Pmobj_t);
var
  cnt: integer;
begin
  if not P_CheckStateParams(actor, 1, CSP_AT_LEAST) then
    exit;

  actor.special := actor.state.params.IntVal[0];

  cnt := actor.state.params.Count;
  if cnt > 1 then
  begin
    actor.args[0] := actor.state.params.IntVal[1];
    if cnt > 2 then
    begin
      actor.args[1] := actor.state.params.IntVal[2];
      if cnt > 3 then
      begin
        actor.args[2] := actor.state.params.IntVal[3];
        if cnt > 4 then
        begin
          actor.args[3] := actor.state.params.IntVal[4];
          if cnt > 5 then
            actor.args[4] := actor.state.params.IntVal[5];
        end;
      end;
    end;
  end;
end;

//
// A_CheckFlag(flag: string; offset: integer; [aaprt: AAPTR]);
//
procedure A_CheckFlag(actor: Pmobj_t);
var
  sflag: string;
  dojump: boolean;
  flg: LongWord;
  idx: integer;
  offset: integer;
  mo: Pmobj_t;
begin
  if not P_CheckStateParams(actor, 2, CSP_AT_LEAST) then
    exit;

  sflag := strupper(actor.state.params.StrVal[0]);

  dojump := false;

  mo := COPY_AAPTR(actor, actor.state.params.IntVal[2]);
  if mo = nil then
    exit;

  idx := mobj_flags.IndexOf(sflag);
  if idx < 0 then
    idx := mobj_flags.IndexOf('MF_' + sflag);
  if idx >= 0 then
  begin
    flg := 1 shl idx;
    dojump := mo.flags and flg <> 0;
  end;

  {$IFDEF HERETIC_OR_HEXEN}
  if not dojump then
  begin
    idx := mobj_flags2.IndexOf(sflag);
    if idx < 0 then
      idx := mobj_flags2.IndexOf('MF2_' + sflag);
    if idx >= 0 then
    begin
      flg := 1 shl idx;
      dojump := mo.flags2 and flg <> 0;
    end;
  end;
  {$ENDIF}

  if not dojump then
  begin
    idx := mobj_flags_ex.IndexOf(sflag);
    if idx < 0 then
      idx := mobj_flags_ex.IndexOf('MF_EX_' + sflag);
    if idx >= 0 then
    begin
      flg := 1 shl idx;
      dojump := mo.flags_ex and flg <> 0;
    end;
  end;

  if not dojump then
  begin
    idx := mobj_flags2_ex.IndexOf(sflag);
    if idx < 0 then
      idx := mobj_flags2_ex.IndexOf('MF2_EX_' + sflag);
    if idx >= 0 then
    begin
      flg := 1 shl idx;
      dojump := mo.flags2_ex and flg <> 0;
    end;
  end;

  if not dojump then
  begin
    idx := mobj_flags3_ex.IndexOf(sflag);
    if idx < 0 then
      idx := mobj_flags3_ex.IndexOf('MF3_EX_' + sflag);
    if idx >= 0 then
    begin
      flg := 1 shl idx;
      dojump := mo.flags3_ex and flg <> 0;
    end;
  end;

  if not dojump then
  begin
    idx := mobj_flags4_ex.IndexOf(sflag);
    if idx < 0 then
      idx := mobj_flags4_ex.IndexOf('MF4_EX_' + sflag);
    if idx >= 0 then
    begin
      flg := 1 shl idx;
      dojump := mo.flags4_ex and flg <> 0;
    end;
  end;

  if not dojump then
  begin
    idx := mobj_flags5_ex.IndexOf(sflag);
    if idx < 0 then
      idx := mobj_flags5_ex.IndexOf('MF5_EX_' + sflag);
    if idx >= 0 then
    begin
      flg := 1 shl idx;
      dojump := mo.flags5_ex and flg <> 0;
    end;
  end;

  if not dojump then
  begin
    idx := mobj_flags6_ex.IndexOf(sflag);
    if idx < 0 then
      idx := mobj_flags6_ex.IndexOf('MF6_EX_' + sflag);
    if idx >= 0 then
    begin
      flg := 1 shl idx;
      dojump := mo.flags6_ex and flg <> 0;
    end;
  end;

  if not dojump then
    exit;

  offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[1]);
  if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
end;

//
// A_SetAngle(angle: integer: [flags: integer]; [aaprt: AAPTR]);
//
procedure A_SetAngle(actor: Pmobj_t);
var
  mo: Pmobj_t;
  ang: angle_t;
  flags: integer;
begin
  if not P_CheckStateParams(actor, 1, CSP_AT_LEAST) then
    exit;

  mo := COPY_AAPTR(actor, actor.state.params.IntVal[2]);
  if mo = nil then
    exit;

  ang := ANG1 * actor.state.params.IntVal[0];
  flags := actor.state.params.IntVal[1];
  if flags = SPF_FORCECLAMP then
    mo.flags3_ex := mo.flags3_ex or MF3_EX_NORENDERINTERPOLATION
  else if flags = SPF_INTERPOLATE then
    mo.flags3_ex := mo.flags3_ex and not MF3_EX_NORENDERINTERPOLATION;

  mo.angle := ang;
end;

//
// A_SetUserVar(varname: string; value: integer)
// Note: If the variable does not exist we create a new one with the name given.
// In ZDoom displays an error message.
//
procedure A_SetUserVar(actor: Pmobj_t);
begin
  if not P_CheckStateParams(actor, 2) then
    exit;

  P_SetMobjCustomParam(actor, actor.state.params.StrVal[0], actor.state.params.IntVal[1]);
end;

//
// A_SetUserArray(varname: string; index: integer; value: integer)
// Note #1: If the variable does not exist we create a new one with the name given.
// Note #2: No bounds check, since the array is stored as a sparse array.
// Note #3: A variable and an array can share the same name
// Note #4: The name is not nessesary to start with "user_"
// In ZDoom displays an error message.
//
procedure A_SetUserArray(actor: Pmobj_t);
var
  arr: string;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  sprintf(arr, '%s[%d]', [actor.state.params.StrVal[0], actor.state.params.IntVal[1]]);
  P_SetMobjCustomParam(actor, arr, actor.state.params.IntVal[2]);
end;

//
// A_SetTics(tics: integer)
//
procedure A_SetTics(actor: Pmobj_t);
begin
  if not P_CheckStateParams(actor, 1) then
    exit;

  actor.tics := actor.state.params.IntVal[0];
end;

//
// A_DropItem(spawntype: string; amount: integer; chance: integer);
//
procedure A_DropItem(actor: Pmobj_t);
var
  mobj_no: integer;
  mo: Pmobj_t;
  propability: integer;
begin
  if not P_CheckStateParams(actor, 3) then
    exit;

  propability := actor.state.params.IntVal[0];
  if N_Random >= propability then
    exit;

  if actor.state.params.IsComputed[0] then
    mobj_no := actor.state.params.IntVal[0]
  else
  begin
    mobj_no := Info_GetMobjNumForName(actor.state.params.EvaluateStrVal[0]);
    actor.state.params.IntVal[0] := mobj_no;
  end;
  if mobj_no = -1 then
  begin
    I_Warning('A_DropItem(): Unknown item %s'#13#10, [actor.state.params.StrVal[0]]);
    exit;
  end;

  mo := P_SpawnMobj(actor.x, actor.y, actor.z, mobj_no);
  {$IFDEF HEXEN}
  mo.flags2 := mo.flags2 or MF2_DROPPED; // special versions of items
  {$ELSE}
  mo.flags := mo.flags or MF_DROPPED; // special versions of items
  {$ENDIF}
  // JVAL Dropped items fall down to floor.
  mo.z := mo.z + 32 * FRACUNIT;
  mo.momz := 4 * FRACUNIT;
  mo.momx := 64 * N_Random;
  mo.momy := 64 * N_Random;
  mo.angle := actor.angle;
end;

procedure P_DoDamage(const mo: Pmobj_t; const damage: integer);
begin
  if damage > 0 then
    P_DamageMobj(mo, nil, nil, damage)
  else if damage < 0 then
    P_SetHealth(mo, mo.health - damage);
end;

//
// A_DamageSelf(const damage: integer);
// JVAL: incomplete
//
procedure A_DamageSelf(actor: Pmobj_t);
var
  damage: integer;
begin
  if not P_CheckStateParams(actor, 1, CSP_AT_LEAST) then
    exit;

  damage := actor.state.params.IntVal[0];
  P_DoDamage(actor, damage);
end;

//
// A_DamageTarget(const damage: integer);
// JVAL: incomplete
//
procedure A_DamageTarget(actor: Pmobj_t);
var
  damage: integer;
begin
  if not P_CheckStateParams(actor, 1, CSP_AT_LEAST) then
    exit;

  if actor.target = nil then
    exit;

  damage := actor.state.params.IntVal[0];
  P_DoDamage(actor.target, damage);
end;

//
// A_DamageTracer(const damage: integer);
// JVAL: incomplete
//
procedure A_DamageTracer(actor: Pmobj_t);
var
  damage: integer;
begin
  if not P_CheckStateParams(actor, 1, CSP_AT_LEAST) then
    exit;

  if actor.tracer = nil then
    exit;

  damage := actor.state.params.IntVal[0];
  P_DoDamage(actor.tracer, damage);
end;

//
// A_DamageMaster(const damage: integer);
//
procedure A_DamageMaster(actor: Pmobj_t);
var
  damage: integer;
begin
  if not P_CheckStateParams(actor, 1, CSP_AT_LEAST) then
    exit;

  if actor.master = nil then
    exit;

  damage := actor.state.params.IntVal[0];
  P_DoDamage(actor.master, damage);
end;

//
// A_KillTarget
// JVAL: incomplete
//
procedure A_KillTarget(actor: Pmobj_t);
begin
  if actor.target = nil then
    exit;

  P_DamageMobj(actor.target, actor, actor, actor.target.health);
end;

//
// A_KillTracer
// JVAL: incomplete
//
procedure A_KillTracer(actor: Pmobj_t);
begin
  if actor.tracer = nil then
    exit;

  P_DamageMobj(actor.tracer, actor, actor, actor.tracer.health);
end;

//
// A_KillMaster
//
procedure A_KillMaster(actor: Pmobj_t);
begin
  if actor.master = nil then
    exit;

  P_DamageMobj(actor.master, actor, actor, actor.master.health);
end;

function P_DoRemoveThing(const mo: Pmobj_t; const flags: integer): boolean;
begin
  result := true;
  if flags and RMVF_EVERYTHING <> 0 then
    P_RemoveMobj(mo)
  else if (flags and RMVF_MISC <> 0) and not (Info_IsMonster(mo._type) and (mo.flags and MF_MISSILE <> 0)) then
    P_RemoveMobj(mo)
  else if Info_IsMonster(mo._type) and (flags and RMVF_NOMONSTERS = 0) then
    P_RemoveMobj(mo)
  else if (mo.flags and MF_MISSILE <> 0) and (flags and RMVF_MISSILES <> 0) then
    P_RemoveMobj(mo)
  else
    result := false;
end;

//
// A_RemoveTarget([flags: integer]);
// JVAL: incomplete
//
procedure A_RemoveTarget(actor: Pmobj_t);
begin
  if actor.target = nil then
    exit;

  if actor.target.player <> nil then // No players
    exit;

  P_DoRemoveThing(actor.target, actor.state.params.IntVal[0]);
end;

//
// A_RemoveTracer([flags: integer]);
// JVAL: incomplete
//
procedure A_RemoveTracer(actor: Pmobj_t);
begin
  if actor.tracer = nil then
    exit;

  if actor.tracer.player <> nil then // No players
    exit;

  P_DoRemoveThing(actor.tracer, actor.state.params.IntVal[0]);
end;

//
// A_RemoveMaster([flags: integer]);
// JVAL: incomplete
//
procedure A_RemoveMaster(actor: Pmobj_t);
begin
  if actor.master = nil then
    exit;

  if actor.master.player <> nil then // No players
    exit;

  P_DoRemoveThing(actor.master, actor.state.params.IntVal[0]);
end;

//
// A_Remove(aaprt: AAPTR; [flags: integer]);
// JVAL: incomplete
//
procedure A_Remove(actor: Pmobj_t);
var
  mo: Pmobj_t;
begin
  mo := COPY_AAPTR(actor, actor.state.params.IntVal[0]);
  if mo = nil then
    exit;

  P_DoRemoveThing(mo, actor.state.params.IntVal[1]);
end;

//
// A_SetFloatBobPhase(bob: integer)
//
procedure A_SetFloatBobPhase(actor: Pmobj_t);
var
  bob: integer;
begin
  if not P_CheckStateParams(actor, 1, CSP_AT_LEAST) then
    exit;

  bob := actor.state.params.IntVal[0];
  if IsIntegerInRange(bob, 0, FLOATBOBSIZE - 1) then
    actor.bob := bob;
end;

//
// A_Detonate
// killough 8/9/98: same as A_Explode, except that the damage is variable
//
procedure A_Detonate(actor: Pmobj_t);
begin
  P_RadiusAttack(actor, actor.target, actor.info.damage{$IFDEF HEXEN}, actor.info.damage, true{$ENDIF});
end;

procedure P_SetMobjRelativeState(const mo: Pmobj_t; const offset: integer);
var
  cur: integer;
begin
  cur := (integer(mo.state) - integer(states)) div SizeOf(state_t);
  P_SetMobjState(mo, statenum_t(cur + offset));
end;

procedure P_TransferFriendliness(const src, dest: Pmobj_t);
begin
  {$IFDEF STRIFE}
  if src.flags and MF_ALLY <> 0 then
    dest.flags := dest.flags or MF_ALLY
  else
    dest.flags := dest.flags and not MF_ALLY;
  {$ENDIF}
  if src.flags2_ex and MF2_EX_FRIEND <> 0 then
    dest.flags2_ex := dest.flags2_ex or MF2_EX_FRIEND
  else
    dest.flags2_ex := dest.flags2_ex and not MF2_EX_FRIEND;
end;

//
// killough 11/98
//
// The following were inspired by Len Pitre
//
// A small set of highly-sought-after code pointers
//
procedure A_Spawn(actor: Pmobj_t);
var
  mo: Pmobj_t;
begin
  if actor.state.misc1 > 0 then
  begin
    mo := P_SpawnMobj(actor.x, actor.y, actor.state.misc2 * FRACUNIT + actor.z, actor.state.misc1 - 1);
    if mo <> nil then
      P_TransferFriendliness(actor, mo);
  end;
end;

//
// A_Face
//
procedure A_Face(actor: Pmobj_t);
begin
  actor.angle := actor.angle + actor.state.misc1 * ANG1;
end;

//
// A_Scratch
//
procedure A_Scratch(actor: Pmobj_t);
begin
  if actor.target <> nil then
  begin
    A_FaceTarget(actor);
    if P_CheckMeleeRange(actor) then
    begin
      if actor.state.misc2 > 0 then
        S_StartSound(actor, actor.state.misc2);
      P_DamageMobj(actor.target, actor, actor, actor.state.misc1);
    end;
  end;
end;

//
// PlayerToId
//
function PlayerToId(const p: Pplayer_t): integer;
var
  i: integer;
begin
  for i := 0 to MAXPLAYERS - 1 do
    if p = @players[i] then
    begin
      result := i;
      exit;
    end;

  result := -1;
end;

//
// A_RandomJump
//
// [crispy] this is pretty much the only action pointer that makes sense for both mobj and pspr states
// JVAL: modified to hold both a player_t and a mobj_t in first parameter
procedure A_RandomJump(obj: pointer; psp: Ppspdef_t);
var
  player: Pplayer_t;
  mo: Pmobj_t;
  id: integer;
begin
  if obj = nil then
    exit;

  // [crispy] first, try to apply to pspr states
  // JVAL: Check if obj is a player_t
  player := obj;
  id := PlayerToId(player);
  if (psp <> nil) and (id >= 0) then
  begin
    if N_Random < psp.state.misc2 then
      P_SetPSprite(player, pdiff(psp, @player.psprites[0], SizeOf(pspdef_t)), statenum_t(psp.state.misc1));
    exit;
  end;

  // [crispy] second, apply to mobj states
  // JVAL: Check if obj is a mobj_t
  mo := obj;
  if @mo.thinker._function.acp1 = @P_MobjThinker then
  begin
    if N_Random < mo.state.misc2 then
      P_SetMobjState(mo, statenum_t(mo.state.misc1));
  end;
end;

{$IFNDEF HEXEN}
//
// A_LineEffect
//
procedure A_LineEffect(actor: Pmobj_t);
var
  player: player_t;
  oldplayer: Pplayer_t;
  junk: line_t;
begin
  if actor.flags3_ex and MF3_EX_LINEDONE <> 0 then            // Unless already used up
    exit;

  junk := lines[0];                                           // Fake linedef set to 1st
  junk.special := actor.state.misc1;                          // Linedef type
  if junk.special <> 0 then
  begin
    oldplayer := actor.player;                                // Remember player status
    player.health := 100;                                     // Alive player
    actor.player := @player;                                  // Fake player
    junk.tag := actor.state.misc2;                            // Sector tag for linedef
    if not P_UseSpecialLine(actor, @junk, 0) then             // Try using it
      P_CrossSpecialLinePtr(@junk, 0, actor);                 // Try crossing it
    if junk.special = 0 then                                  // If type cleared,
      actor.flags3_ex := actor.flags3_ex or MF3_EX_LINEDONE;  // no more for this thing
    actor.player := oldplayer;
  end;
end;
{$ENDIF}

procedure A_FlipSprite(actor: Pmobj_t);
begin
  actor.flags3_ex := actor.flags3_ex or MF3_EX_FLIPSPRITE;
end;

procedure A_RandomFlipSprite(actor: Pmobj_t);
var
  chance: integer;
begin
  if not P_CheckStateParams(actor, 1, CSP_AT_LEAST) then
    exit;

  chance := actor.state.params.IntVal[0];
  if chance < P_Random then
    actor.flags3_ex := actor.flags3_ex or MF3_EX_FLIPSPRITE;
end;

procedure A_NoFlipSprite(actor: Pmobj_t);
begin
  actor.flags3_ex := actor.flags3_ex and not MF3_EX_FLIPSPRITE;
end;

procedure A_RandomNoFlipSprite(actor: Pmobj_t);
var
  chance: integer;
begin
  if not P_CheckStateParams(actor, 1, CSP_AT_LEAST) then
    exit;

  chance := actor.state.params.IntVal[0];
  if chance < P_Random then
    actor.flags3_ex := actor.flags3_ex and not MF3_EX_FLIPSPRITE;
end;

//
// A_ChangeSpriteFlip(propability: integer)
//
procedure A_ChangeSpriteFlip(actor: Pmobj_t);
var
  ok: Boolean;
begin
  if actor.state.params = nil then
    ok := True
  else if actor.state.params.Count = 0 then
    ok := True
  else if actor.state.params.EvaluateStrVal[0] = 'TRUE' then
    ok := True
  else
    ok := N_Random < actor.state.params.IntVal[0];

  if not ok then
    Exit;

  if actor.flags3_ex or MF3_EX_FLIPSPRITE <> 0 then
    actor.flags3_ex := actor.flags3_ex and not MF3_EX_FLIPSPRITE
  else
    actor.flags3_ex := actor.flags3_ex or MF3_EX_FLIPSPRITE;
end;

//
//  A_CustomMeleeAttack(damage: integer, meleesound: string, misssound: string)
//
procedure A_CustomMeleeAttack(actor: Pmobj_t);
var
  damage: integer;
  sndidx: integer;
begin
  if not P_CheckStateParams(actor, 1, CSP_AT_LEAST) then
    exit;

  if actor.target = nil then
    exit;

  A_FaceTarget(actor);
  if P_CheckMeleeRange(actor) then
  begin
    if actor.state.params.IsComputed[1] then
      sndidx := actor.state.params.IntVal[1]
    else
    begin
      sndidx := S_GetSoundNumForName(actor.state.params.StrVal[1]);
      actor.state.params.IntVal[1] := sndidx;
    end;
    if sndidx > 0 then
      S_StartSound(actor, sndidx);
    damage := actor.state.params.IntVal[0];
    P_DamageMobj(actor.target, actor, actor, damage);
  end
  else
  begin
    if actor.state.params.IsComputed[2] then
      sndidx := actor.state.params.IntVal[2]
    else
    begin
      sndidx := S_GetSoundNumForName(actor.state.params.StrVal[2]);
      actor.state.params.IntVal[2] := sndidx;
    end;
    if sndidx > 0 then
      S_StartSound(actor, sndidx);
  end;
end;

//
//  A_CustomComboAttack(missiletype: string, spawnheight: integer, damage: integer, meleesound: string)
//
procedure A_CustomComboAttack(actor: Pmobj_t);
var
  damage: integer;
  sndidx: integer;
  mobj_no: integer;
  ang: angle_t;
  x, y, z: fixed_t;
  missile: Pmobj_t;
begin
  if not P_CheckStateParams(actor, 2, CSP_AT_LEAST) then
    exit;

  if actor.target = nil then
    exit;

  A_FaceTarget(actor);
  if P_CheckMeleeRange(actor) then
  begin
    if actor.state.params.IsComputed[3] then
      sndidx := actor.state.params.IntVal[3]
    else
    begin
      sndidx := S_GetSoundNumForName(actor.state.params.StrVal[3]);
      actor.state.params.IntVal[3] := sndidx;
    end;
    if sndidx > 0 then
      S_StartSound(actor, sndidx);
    damage := actor.state.params.IntVal[2];
    P_DamageMobj(actor.target, actor, actor, damage);
  end
  else
  begin
    if actor.state.params.IsComputed[0] then
      mobj_no := actor.state.params.IntVal[0]
    else
    begin
      mobj_no := Info_GetMobjNumForName(actor.state.params.EvaluateStrVal[0]);
      actor.state.params.IntVal[0] := mobj_no;
    end;
    if mobj_no = -1 then
      exit;

    ang := (actor.angle - ANG90) shr ANGLETOFINESHIFT;
    x := actor.x + 32 * finecosine[ang];
    y := actor.y + 32 * finesine[ang];
    z := actor.z + actor.state.params.FixedVal[1] - 32 * FRACUNIT;
    missile := P_SpawnMissileXYZ(x, y, z, actor, actor.target, mobj_no);
    if missile <> nil then
    begin
      if missile.flags_ex and MF_EX_SEEKERMISSILE <> 0 then
        missile.tracer := actor.target;
    end;
  end;
end;

//
//  A_SetRenderStyle(style: renderstyle_t, alpha: float)
//
procedure A_SetRenderStyle(actor: Pmobj_t);
begin
  if not P_CheckStateParams(actor, 1, CSP_AT_LEAST) then
    exit;

  actor.renderstyle := R_GetRenderstyleForName(actor.state.params.StrVal[0]);

  if actor.state.params.Count > 1 then
    actor.alpha := GetIntegerInRange(actor.state.params.FixedVal[1], 0, FRACUNIT);
end;

//
// A_FadeTo(targ: integer, ammount: integer, flags: integer)
//
procedure A_FadeTo(actor: Pmobj_t);
var
  targ: fixed_t;
  amount: fixed_t;
  flags: integer;
begin
  if not P_CheckStateParams(actor, 2, CSP_AT_LEAST) then
    exit;

  targ := actor.state.params.FixedVal[0];
  amount := actor.state.params.FixedVal[1];

  if actor.alpha > targ then
  begin
    actor.alpha := actor.alpha - amount;
    if actor.alpha < targ then
      actor.alpha := targ;
  end
  else if actor.alpha < targ then
  begin
    actor.alpha := actor.alpha + amount;
    if actor.alpha > targ then
      actor.alpha := targ;
  end;

  if actor.state.params.Count > 2 then
  begin
    if actor.state.params.BoolVal[2] then
      flags := FTF_REMOVE
    else
    begin
      flags := actor.state.params.IntVal[2];
      if flags and FTF_CLAMP <> 0 then
        actor.alpha := GetIntegerInRange(actor.alpha, 0, FRACUNIT);
    end;
    if (flags and FTF_REMOVE <> 0) and (actor.alpha = targ) then
      P_RemoveMobj(actor);
  end;
end;

//
// A_SetSize(newradius: integer, newheight: integer, testpos: boolean)
//
procedure A_SetSize(actor: Pmobj_t);
var
  newradius, newheight: fixed_t;
  oldradius, oldheight: fixed_t;
  testpos: boolean;
begin
  if not P_CheckStateParams(actor, 2, CSP_AT_LEAST) then
    exit;

  newradius := actor.state.params.IntVal[0];
  newheight := actor.state.params.IntVal[1];
  oldradius := actor.radius;
  oldheight := actor.height;
  if newradius >= 0 then
    actor.radius := newradius;
  if newheight >= 0 then
    actor.height := newheight;
  testpos := actor.state.params.BoolVal[2];
  if testpos then
    if not P_TestMobjLocation(actor) then
    begin
      actor.radius := oldradius;
      actor.height := oldheight;
    end;
end;

procedure P_CopyFriendliness(const originator, mo: Pmobj_t);
begin
  if Info_IsMonster(originator._type) then
  begin
    // If this is a monster transfer all friendliness information
    {$IFDEF STRIFE}
    mo.flags := (mo.flags and not MF_ALLY) or (originator.flags and MF_ALLY);
    {$ENDIF}
    mo.flags2_ex := (mo.flags2_ex and not MF2_EX_FRIEND) or (originator.flags2_ex and MF2_EX_FRIEND);
  end
  else if originator.player <> nil then
  begin
    // A player always spawns a monster friendly to him
    {$IFDEF STRIFE}
    mo.flags := mo.flags or MF_ALLY;
    {$ENDIF}
    mo.flags2_ex := mo.flags2_ex or MF2_EX_FRIEND;
  end;
end;

function P_RaiseActor(const thing, raiser: Pmobj_t): boolean;
var
  info: Pmobjinfo_t;
  oldheight: fixed_t;
  oldradius: fixed_t;
begin
  if thing = nil then
  begin
    result := false; // not a monster
    exit;
  end;

  if thing.flags and MF_CORPSE = 0 then
  begin
    result := false; // not a monster
    exit;
  end;

  if thing.info.raisestate = Ord(S_NULL) then
  begin
    result := false;
    exit;
  end;

  info := thing.info;
  thing.momx := 0;
  thing.momy := 0;

  // JVAL: Mass, gravity, pushfactor ??
  oldheight := thing.height;
  oldradius := thing.radius;

  thing.height := info.height;
  thing.radius := info.radius;

  if not P_CheckPosition(thing, thing.x, thing.y) then
  begin
    thing.height := oldheight;
    thing.radius := oldradius;
    result := false;
    exit;
  end;

  {$IFDEF DOOM_OR_STRIFE}
  S_StartSound(thing, Ord(sfx_slop));
  {$ENDIF}
  {$IFDEF HERETIC}
  S_StartSound(thing, Ord(sfx_respawn));
  {$ENDIF}
  {$IFDEF HEXEN}
  S_StartSound(thing, Ord(SFX_RESPAWN));
  {$ENDIF}

  P_SetMobjState(thing, statenum_t(info.raisestate));

  thing.flags := info.flags;
  {$IFDEF HERETIC_OR_HEXEN}
  thing.flags2 := info.flags2;
  {$ENDIF}
  thing.flags_ex := info.flags_ex;
  thing.flags2_ex := info.flags2_ex;
  thing.flags3_ex := info.flags3_ex;
  thing.flags4_ex := info.flags4_ex;
  thing.flags5_ex := info.flags5_ex;
  thing.flags6_ex := info.flags6_ex;

  if raiser <> nil then
    P_CopyFriendliness(raiser, thing);

  thing.health := info.spawnhealth;
  thing.target := nil;

  result := true;
end;

//
// A_RaiseMaster(copyfriendliness: boolean)
//
procedure A_RaiseMaster(actor: Pmobj_t);
var
  copy: boolean;
begin
  if actor.master = nil then
    exit;

  if actor.state.params <> nil then
    copy := actor.state.params.BoolVal[0] or (actor.state.params.IntVal[0] = 1)
  else
    copy := true;

  if copy then
    P_RaiseActor(actor.master, actor)
  else
    P_RaiseActor(actor.master, nil);
end;

//
// A_RaiseChildren(copyfriendliness: boolean)
//
procedure A_RaiseChildren(actor: Pmobj_t);
var
  copy: boolean;
  think: Pthinker_t;
  mo, friend: Pmobj_t;
begin
  if actor.state.params <> nil then
    copy := actor.state.params.BoolVal[0] or (actor.state.params.IntVal[0] = 1)
  else
    copy := true;

  if copy then
    friend := actor
  else
    friend := nil;

  think := thinkercap.next;
  while think <> @thinkercap do
  begin
    if @think._function.acp1 = @P_MobjThinker then
    begin
      mo := Pmobj_t(think);
      if mo.master = actor then
        P_RaiseActor(Pmobj_t(think), friend);
    end;
    think := think.next;
  end;
end;

//
// A_RaiseSiblings(copyfriendliness: boolean)
//
procedure A_RaiseSiblings(actor: Pmobj_t);
var
  copy: boolean;
  think: Pthinker_t;
  mo, friend: Pmobj_t;
begin
  if actor.master = nil then
    exit;

  if actor.state.params <> nil then
    copy := actor.state.params.BoolVal[0] or (actor.state.params.IntVal[0] = 1)
  else
    copy := true;

  if copy then
    friend := actor
  else
    friend := nil;

  think := thinkercap.next;
  while think <> @thinkercap do
  begin
    if @think._function.acp1 = @P_MobjThinker then
    begin
      mo := Pmobj_t(think);
      if mo <> actor then
        if mo.master = actor.master then
          P_RaiseActor(Pmobj_t(think), friend);
    end;
    think := think.next;
  end;
end;

//
// A_HealThing(amount: integer, max: integer)
//
procedure A_HealThing(actor: Pmobj_t);
var
  ammount: integer;
  mx: integer;
  p: Pplayer_t;
begin
  if not P_CheckStateParams(actor, 2, CSP_AT_LEAST) then
    exit;

  ammount := actor.state.params.IntVal[0];
  mx := actor.state.params.IntVal[1];

  if mx > actor.info.spawnhealth then
    mx := actor.info.spawnhealth;

  p := actor.player;

  if (mx = 0) or (actor.player = nil) then
  begin
    actor.health := actor.health + ammount;

    if actor.health > actor.info.spawnhealth then
      actor.health := actor.info.spawnhealth;
    if p <> nil then
      p.health := actor.health;
    exit;
  end
  else if mx = 1 then
    mx := {$IFDEF DOOM}p_soulspherehealth{$ELSE}100{$ENDIF};

  if actor.health < mx then
  begin
    actor.health := actor.health + ammount;
    if (actor.health > mx) and (mx > 0) then
      actor.health := mx;
    if p <> nil then
      p.health := actor.health;
  end;
end;

procedure P_DoAttack(const actor: Pmobj_t; const domelee, domissile: boolean;
  const meleedamage: integer; const meleesound: integer; const missiletype: integer;
  const missileheight: integer);
var
  damage: integer;
begin
  if actor.target = nil then
    exit;

  A_FaceTarget(actor);
  if domelee and (meleedamage > 0) and P_CheckMeleeRange(actor) then
  begin
    damage := (P_Random mod 8 + 1) * meleedamage;
    if meleesound > 0 then
      S_StartSound(actor, meleesound);
    P_DamageMobj(actor.target, actor, actor, damage);
  end
  else if domissile and (missiletype <> 0) then
    P_CustomMissile(actor, missiletype, missileheight, 0, 0, 0, 0);
end;

//
// A_BasicAttack(MeleeDamage: integer, MeleeSound: integer, MissileType: integer, MissileHeight: float)
//
procedure A_BasicAttack(actor: Pmobj_t);
var
  MeleeDamage: integer;
  MeleeSound: integer;
  MissileType: integer;
  MissileHeight: fixed_t;
begin
  if not P_CheckStateParams(actor, 4) then
    exit;

  MeleeDamage := actor.state.params.IntVal[0];

  if actor.state.params.IsComputed[1] then
    MeleeSound := actor.state.params.IntVal[0]
  else
  begin
    MeleeSound := S_GetSoundNumForName(actor.state.params.StrVal[1]);
    actor.state.params.IntVal[1] := MeleeSound;
  end;

  if actor.state.params.IsComputed[2] then
    MissileType := actor.state.params.IntVal[2]
  else
  begin
    MissileType := Info_GetMobjNumForName(actor.state.params.EvaluateStrVal[2]);
    actor.state.params.IntVal[2] := MissileType;
  end;

  MissileHeight := actor.state.params.FixedVal[3];

  P_Doattack(actor, MeleeDamage <> 0, MissileType <> -1, MeleeDamage, MeleeSound,
    MissileType, MissileHeight);
end;

function P_FloatSpeed(const actor: Pmobj_t): fixed_t;
begin
  if actor.info.floatspeed > 0 then
  begin
    result := actor.info.floatspeed;
    if result < 256 then
      result := result * FRACUNIT;
  end
  else
    result := FLOATSPEED;
end;

const
  TRACEANGLE2 = $c000000;

//
// A_Tracer2
//
procedure A_Tracer2(actor: Pmobj_t);
var
  exact: angle_t;
  dist: fixed_t;
  slope: fixed_t;
  dest: Pmobj_t;
begin
  // adjust direction
  dest := actor.tracer;

  if (dest = nil) or (dest.health <= 0) then
    exit;

  // change angle
  exact := R_PointToAngle2(actor.x, actor.y, dest.x, dest.y);

  if exact <> actor.angle then
  begin
    if exact - actor.angle > ANG180 then
    begin
      actor.angle := actor.angle - TRACEANGLE2;
      if exact - actor.angle < ANG180 then
        actor.angle := exact;
    end
    else
    begin
      actor.angle := actor.angle + TRACEANGLE2;
      if exact - actor.angle > ANG180 then
        actor.angle := exact;
    end;
  end;

  exact := actor.angle shr ANGLETOFINESHIFT;
  actor.momx := FixedMul(actor.info.speed, finecosine[exact]);
  actor.momy := FixedMul(actor.info.speed, finesine[exact]);

  if actor.flags_ex and (MF_EX_FLOORHUGGER or MF_EX_CEILINGHUGGER) = 0 then
  begin
    // change slope
    dist := P_AproxDistance(dest.x - actor.x, dest.y - actor.y);

    dist := dist div actor.info.speed;

    if dist < 1 then
      dist := 1;
    if dest.height >= 56 * FRACUNIT then
      slope := (dest.z + 40 * FRACUNIT - actor.z) div dist
    else
      slope := (dest.z + actor.height * 2 div 3 - actor.z) div dist;

    if slope < actor.momz then
      actor.momz := actor.momz - FRACUNIT div 8
    else
      actor.momz := actor.momz + FRACUNIT div 8;
  end;
end;

//
// A_MonsterRefire(prob: integer, offset: state_t)
//
procedure A_MonsterRefire(actor: Pmobj_t);
var
  prob: integer;
  offset: integer;
begin
  if not P_CheckStateParams(actor, 2) then
    exit;

  A_FaceTarget(actor);

  prob := actor.state.params.IntVal[0];
  if N_Random < prob then
    exit;

  if (actor.target = nil) or (actor.target.health <= 0) or not P_CheckSight(actor, actor.target) then
  begin
    offset := P_GetStateFromNameWithOffsetCheck(actor, actor.state.params.StrVal[1]);
    if @states[offset] <> actor.state then
      P_SetMobjState(actor, statenum_t(offset));
  end;
end;

//
// A_RearrangePointers(ptr_target: integer, ptr_master: integer, ptr_tracer: integer, flags: integer)
//
procedure A_RearrangePointers(actor: Pmobj_t);
var
  gettarget: Pmobj_t;
  getmaster: Pmobj_t;
  gettracer: Pmobj_t;
  ptr_target: integer;
  ptr_master: integer;
  ptr_tracer: integer;
  flags: integer;
begin
  if not P_CheckStateParams(actor, 3, CSP_AT_LEAST) then
    exit;

  gettarget := actor.target;
  getmaster := actor.master;
  gettracer := actor.tracer;

  ptr_target := actor.state.params.IntVal[0];
  ptr_master := actor.state.params.IntVal[1];
  ptr_tracer := actor.state.params.IntVal[2];
  flags := actor.state.params.IntVal[3];

  case ptr_target of // pick the new target
  AAPTR_MASTER:
    begin
      actor.target := getmaster;
      if flags and PTROP_UNSAFETARGET = 0 then
        VerifyTargetChain(actor);
    end;
  AAPTR_TRACER:
    begin
      actor.target := gettracer;
      if (flags and PTROP_UNSAFETARGET = 0) then
        VerifyTargetChain(actor);
    end;
  AAPTR_NULL:
    actor.target := nil;
    // THIS IS NOT "A_ClearTarget", so no other targeting info is removed
  end;

  // presently permitting non-monsters to set master
  case ptr_master of // pick the new master
  AAPTR_TARGET:
    begin
      actor.master := gettarget;
      if (flags and PTROP_UNSAFEMASTER = 0) then
        VerifyMasterChain(actor);
    end;
  AAPTR_TRACER:
    begin
      actor.master := gettracer;
      if (flags and PTROP_UNSAFEMASTER = 0) then
        VerifyMasterChain(actor);
    end;
  AAPTR_NULL:
    actor.master := nil;
  end;

  case ptr_tracer of // pick the new tracer
  AAPTR_TARGET:
    begin
      actor.tracer := gettarget;
    end; // no verification deemed necessary; the engine never follows a tracer chain(?)
  AAPTR_MASTER:
    begin
      actor.tracer := getmaster;
    end; // no verification deemed necessary; the engine never follows a tracer chain(?)
  AAPTR_NULL:
    actor.tracer := nil;
  end;
end;

//
// A_TransferPointer(ptr_source: integer, ptr_recipient: integer, ptr_sourcefield: integer, [ptr_recipientfield: integer], [flags: integer])
//
procedure A_TransferPointer(actor: Pmobj_t);
var
  source, recipient: Pmobj_t;
  ptr_source: integer;
  ptr_recipient: integer;
  ptr_sourcefield: integer;
  ptr_recipientfield: integer;
  flags: integer;
begin
  if not P_CheckStateParams(actor, 3, CSP_AT_LEAST) then
    exit;

  ptr_source := actor.state.params.IntVal[0];
  ptr_recipient := actor.state.params.IntVal[1];

  // Exchange pointers with actors to whom you have pointers (or with yourself, if you must)
  source := COPY_AAPTR(actor, ptr_source);
  recipient := COPY_AAPTR(actor, ptr_recipient); // pick an actor to store the provided pointer value
  if recipient = nil then
    exit;

  ptr_sourcefield := actor.state.params.IntVal[2];
  // convert source from dataprovider to data
  source := COPY_AAPTR(source, ptr_sourcefield);

  if source = recipient then
    source := nil;  // The recipient should not acquire a pointer to itself; will write nil

  ptr_recipientfield := actor.state.params.IntVal[3];
  if ptr_recipientfield = AAPTR_DEFAULT then
    ptr_recipientfield := ptr_sourcefield;  // If default: Write to same field as data was read from

  flags := actor.state.params.IntVal[4];
  ASSIGN_AAPTR(recipient, ptr_recipientfield, source, flags);
end;

var
  soundtargetex: Pmobj_t;

procedure P_RecursiveSoundEx(sec: Psector_t; soundblocks: integer; maxdist: fixed_t);
var
  i: integer;
  check: Pline_t;
  other: Psector_t;
begin
  // wake up all monsters in this sector
  if (sec.validcount = validcount) and
     (sec.soundtraversed <= soundblocks + 1) then
    exit; // already flooded

  sec.validcount := validcount;
  sec.soundtraversed := soundblocks + 1;

  if P_AproxDistance(soundtargetex.x - sec.soundorg.x, soundtargetex.y - sec.soundorg.y) > maxdist then
    exit;

  sec.soundtarget := soundtargetex;

  for i := 0 to sec.linecount - 1 do
  begin
    check := sec.lines[i];
    if check.flags and ML_TWOSIDED = 0 then
      continue;
    // JVAL: 20200407 - Avoid false ML_TWOSIDED flag
    if (check.sidenum[1] < 0) or (check.sidenum[0] < 0) then
      continue;

    P_LineOpening(check, false);

    if openrange <= 0 then
      continue; // closed door

    if sides[check.sidenum[0]].sector = sec then
      other := sides[check.sidenum[1]].sector
    else
      other := sides[check.sidenum[0]].sector;

    if check.flags and ML_SOUNDBLOCK <> 0 then
    begin
      if soundblocks = 0 then
        P_RecursiveSoundEx(other, 1, maxdist);
    end
    else
      P_RecursiveSoundEx(other, soundblocks, maxdist);
  end;
end;

procedure P_NoiseAlertEx(target: Pmobj_t; emmiter: Pmobj_t; const maxdist: fixed_t);
begin
  soundtargetex := target;
  inc(validcount);
  P_RecursiveSoundEx(Psubsector_t(emmiter.subsector).sector, 0, maxdist);
end;

//
// A_AlertMonsters(maxdist: integer, flags: integer)
//
procedure A_AlertMonsters(actor: Pmobj_t);
var
  target, emitter: Pmobj_t;
  maxdist: fixed_t;
  flags: integer;
begin
  if not P_CheckStateParams(actor, 3, CSP_AT_LEAST) then
    exit;

  target := nil;
  emitter := actor;

  maxdist := actor.state.params.FixedVal[0];
  flags := actor.state.params.IntVal[1];

  if (actor.player <> nil) or (flags and AMF_TARGETEMITTER <> 0) then
  begin
    target := actor;
  end
  else if (actor.target <> nil) and (flags and AMF_TARGETNONPLAYER <> 0) then
  begin
    target := actor.target;
  end
  else if (actor.target <> nil) and (actor.target.player <> nil) then
  begin
    target := actor.target;
  end;

  if flags and AMF_EMITFROMTARGET <> 0 then
    emitter := target;

  if (target <> nil) and (emitter <> nil) then
    P_NoiseAlertEx(target, emitter, maxdist);
end;

procedure P_LocalEarthQuake(const actor: Pmobj_t; const tics: integer; const intensity: fixed_t; const maxdist: fixed_t);
var
  i: integer;
  dist: fixed_t;
  frac: fixed_t;
  testintensity: fixed_t;
begin
  for i := 0 to MAXPLAYERS - 1 do
    if playeringame[i] then
    begin
      dist := P_AproxDistance(actor.x - players[i].mo.x, actor.y - players[i].mo.y);
      dist := P_AproxDistance(actor.z - players[i].mo.z, dist); // 3d distance
      if dist <= maxdist then
      begin
        if players[i].quaketics < tics then
          players[i].quaketics := tics;
        frac := FixedDiv(dist, maxdist) * (FINEANGLES div 4);
        testintensity := FixedMul(finecosine[frac shr ANGLETOFINESHIFT], intensity); // JVAL: 20200508 - Curved
        if players[i].quakeintensity < testintensity then
          players[i].quakeintensity := testintensity;
      end;
    end;
end;

//
// A_LocalEarthQuake(tics: integer; [intensity: float = 1.0]; [maxdist: float = MAXINT]);
//
procedure A_LocalEarthQuake(actor: Pmobj_t);
var
  tics: integer;
  intensity: integer;
  maxdist: fixed_t;
begin
  if not P_CheckStateParams(actor, 1, CSP_AT_LEAST) then
    exit;

  tics := actor.state.params.FixedVal[0];
  if actor.state.params.Count > 1 then
    intensity := actor.state.params.FixedVal[1]
  else
    intensity := FRACUNIT;
  if actor.state.params.Count > 2 then
    maxdist := actor.state.params.FixedVal[2]
  else
    maxdist := MAXINT;
  P_LocalEarthQuake(actor, tics, intensity, maxdist);
end;

//
// A_RemoveChildren([flags: integer]);
// JVAL: incomplete
//
procedure A_RemoveChildren(actor: Pmobj_t);
var
  flags: integer;
  think: Pthinker_t;
  mo: Pmobj_t;
begin
  if actor.state.params <> nil then
    flags := actor.state.params.IntVal[0]
  else
    flags := 0;

  think := thinkercap.next;
  while think <> @thinkercap do
  begin
    if @think._function.acp1 = @P_MobjThinker then
    begin
      mo := Pmobj_t(think);
      if mo.master = actor then
        P_DoRemoveThing(mo, flags);
    end;
    think := think.next;
  end;
end;

//
// A_RemoveSiblings([flags: integer]);
// JVAL: incomplete
//
procedure A_RemoveSiblings(actor: Pmobj_t);
var
  flags: integer;
  think: Pthinker_t;
  mo: Pmobj_t;
begin
  if actor.master = nil then
    exit;

  if actor.state.params <> nil then
    flags := actor.state.params.IntVal[0]
  else
    flags := 0;

  think := thinkercap.next;
  while think <> @thinkercap do
  begin
    if @think._function.acp1 = @P_MobjThinker then
    begin
      mo := Pmobj_t(think);
      if mo <> actor then
        if mo.master = actor.master then
          P_DoRemoveThing(mo, flags);
    end;
    think := think.next;
  end;
end;

//
// A_KillChildren
// JVAL: incomplete
//
procedure A_KillChildren(actor: Pmobj_t);
var
  think: Pthinker_t;
  mo: Pmobj_t;
begin
  think := thinkercap.next;
  while think <> @thinkercap do
  begin
    if @think._function.acp1 = @P_MobjThinker then
    begin
      mo := Pmobj_t(think);
      if mo.master = actor then
        P_DamageMobj(mo, actor, actor, mo.health);
    end;
    think := think.next;
  end;
end;

//
// A_KillSiblings
// JVAL: incomplete
//
procedure A_KillSiblings(actor: Pmobj_t);
var
  think: Pthinker_t;
  mo: Pmobj_t;
begin
  if actor.master = nil then
    exit;

  think := thinkercap.next;
  while think <> @thinkercap do
  begin
    if @think._function.acp1 = @P_MobjThinker then
    begin
      mo := Pmobj_t(think);
      if mo <> actor then
        if mo.master = actor.master then
          P_DamageMobj(mo, actor, actor, mo.health);
    end;
    think := think.next;
  end;
end;

//
// A_Weave(xyspeed: integer, zspeed: integer, xydist: float, zdist: float)
//
procedure A_Weave(actor: Pmobj_t);
var
  xyspeed: integer;
  zspeed: integer;
  xydist: fixed_t;
  zdist: fixed_t;
  newX, newY: fixed_t;
  weaveXY, weaveZ: integer;
  angle: angle_t;
  dist: fixed_t;
begin
  xyspeed := 2;
  zspeed := 2;
  xydist := 2 * FRACUNIT;
  zdist := FRACUNIT;
  if actor.state.params <> nil then
  begin
    if actor.state.params.Count >= 1 then
    begin
      xyspeed := actor.state.params.IntVal[0];
      if actor.state.params.Count >= 2 then
      begin
        zspeed := actor.state.params.IntVal[1];
        if actor.state.params.Count >= 3 then
        begin
          xydist := actor.state.params.FixedVal[2];
          if actor.state.params.Count >= 4 then
          begin
            zdist := actor.state.params.FixedVal[3];
          end;
        end;
      end;
    end;
  end;

  weaveXY := actor.WeaveIndexXY;
  weaveZ := actor.WeaveIndexZ;
  angle := (actor.angle + ANG90) shr ANGLETOFINESHIFT;

  dist := FixedMul(FloatBobOffsets[weaveXY], xydist);
  newX := actor.x - FixedMul(finecosine[angle], dist);
  dist := FixedMul(FloatBobOffsets[weaveZ], zdist);
  newY := actor.y - FixedMul(finesine[angle], dist);
  weaveXY := (weaveXY + xyspeed) and FLOATBOBMASK;
  dist := FixedMul(FloatBobOffsets[weaveXY], xydist);
  newX := newX - FixedMul(finecosine[angle], dist);
  dist := FixedMul(FloatBobOffsets[weaveZ], zdist);
  newY := newY - FixedMul(finesine[angle], dist);
  P_TryMove(actor, newX, newY);
  dist := FixedMul(FloatBobOffsets[weaveXY], zdist);
  actor.z := actor.z - dist;
  weaveZ := (weaveZ + zspeed) and FLOATBOBMASK;
  actor.z := actor.z + FloatBobOffsets[weaveZ];

  actor.WeaveIndexXY := weaveXY;
  actor.WeaveIndexZ := weaveZ;
end;

//
// A_SetWeaveIndexXY(weavexy: integer)
//
procedure A_SetWeaveIndexXY(actor: Pmobj_t);
begin
  if not P_CheckStateParams(actor, 1) then
    exit;

  actor.WeaveIndexXY := actor.state.params.IntVal[0] and FLOATBOBMASK;
end;

//
// A_SetWeaveIndexZ(weavez: integer)
//
procedure A_SetWeaveIndexZ(actor: Pmobj_t);
begin
  if not P_CheckStateParams(actor, 1) then
    exit;

  actor.WeaveIndexZ := actor.state.params.IntVal[0] and FLOATBOBMASK;
end;

//
// A_SetWeaveIndexes(weavexy: integer, weavez: integer)
//
procedure A_SetWeaveIndexes(actor: Pmobj_t);
begin
  if not P_CheckStateParams(actor, 2) then
    exit;

  actor.WeaveIndexXY := actor.state.params.IntVal[0] and FLOATBOBMASK;
  actor.WeaveIndexZ := actor.state.params.IntVal[1] and FLOATBOBMASK;
end;

procedure A_SetSpriteDX(actor: Pmobj_t);
begin
  if not P_CheckStateParams(actor, 1) then
    exit;

  actor.spriteDX := actor.state.params.FixedVal[0];
end;

procedure A_SetSpriteDY(actor: Pmobj_t);
begin
  if not P_CheckStateParams(actor, 1) then
    exit;

  actor.spriteDY := actor.state.params.FixedVal[0];
end;

//
// A_SetHeight(newheight: float)
//
procedure A_SetHeight(actor: Pmobj_t);
begin
  if not P_CheckStateParams(actor, 1) then
    exit;

  actor.height := actor.state.params.FixedVal[0];
end;

//
// A_SetFriction(newfriction: float)
//
procedure A_SetFriction(actor: Pmobj_t);
begin
  if not P_CheckStateParams(actor, 1) then
    exit;

  actor.friction := actor.state.params.FixedVal[0];
end;

//
//  A_PlayerHurtExplode(damage: integer; radius: integer);
//
procedure A_PlayerHurtExplode(actor: Pmobj_t);
var
  damage: integer;
  radius: fixed_t;
begin
  if not P_CheckStateParams(actor, 2, CSP_AT_LEAST) then
    exit;

  damage := actor.state.params.IntVal[0];
  radius := actor.state.params.IntVal[1];
  P_RadiusAttackPlayer(actor, actor.target, damage, radius);

  if actor.z <= actor.floorz then
    P_HitFloor(actor);
end;

//
//  A_SetPainChance(value: integer);
//
procedure A_SetPainChance(actor: Pmobj_t);
begin
  if not P_CheckStateParams(actor, 1, CSP_AT_LEAST) then
    exit;

  actor.painchance := actor.state.params.IntVal[0];
end;

//
// A_SetPushable
//
procedure A_SetPushable(actor: Pmobj_t);
begin
  {$IFDEF DOOM_OR_STRIFE}
  actor.flags2_ex := actor.flags2_ex or MF2_EX_PUSHABLE;
  {$ENDIF}
  {$IFDEF HERETIC_OR_HEXEN}
  actor.flags2 := actor.flags2 or MF2_PUSHABLE;
  {$ENDIF}
end;

//
// A_SetPushable
//
procedure A_UnSetPushable(actor: Pmobj_t);
begin
  {$IFDEF DOOM_OR_STRIFE}
  actor.flags2_ex := actor.flags2_ex and not MF2_EX_PUSHABLE;
  {$ENDIF}
  {$IFDEF HERETIC_OR_HEXEN}
  actor.flags2 := actor.flags2 and not MF2_PUSHABLE;
  {$ENDIF}
end;

//  A_MatchTargetZ(const zspeed, threshold, [maxmomz])
procedure A_MatchTargetZ(actor: Pmobj_t);
var
  speed: fixed_t;
  threshold: fixed_t;
  maxmomz: fixed_t;
begin
  if actor.target = nil then
    exit;

  if actor.state.params = nil then
  begin
    speed := FRACUNIT;
    threshold := FRACUNIT;
    maxmomz := actor.info.speed;
  end
  else
  begin
    if actor.state.params.Count > 0 then
    begin
      speed := actor.state.params.FixedVal[0];
      if speed = 0 then
        exit;
    end
    else
      speed := FRACUNIT;

    if actor.state.params.Count > 1 then
      threshold := actor.state.params.FixedVal[1]
    else
      threshold := FRACUNIT;

    if actor.state.params.Count > 2 then
      maxmomz := actor.state.params.FixedVal[2]
    else
      maxmomz := actor.info.speed;
  end;

  if maxmomz < 256 then
    maxmomz := maxmomz * FRACUNIT;

  if actor.z + actor.momz < actor.target.z - threshold then
  begin
    actor.momz := actor.momz + speed;
    if actor.momz > maxmomz then
      actor.momz := maxmomz;
    if actor.momz < 0 then
      actor.momz := 0;
  end
  else if actor.z + actor.momz > actor.target.z + threshold then
  begin
    actor.momz := actor.momz - speed;
    if actor.momz < -maxmomz then
      actor.momz := -maxmomz;
    if actor.momz > 0 then
      actor.momz := 0;
  end
  else
  begin
    actor.momz := actor.momz * 15 div 16;
    if actor.momz > maxmomz then
      actor.momz := maxmomz
    else if actor.momz < -maxmomz then
      actor.momz := -maxmomz;
  end;

  // JVAL: 20200421 - Do not slam to floor - ceiling
  if actor.z + actor.momz + actor.height >= actor.ceilingz then
    actor.momz := (actor.ceilingz - actor.z - actor.height) div 2
  else if actor.z + actor.momz <= actor.floorz then
    actor.momz := actor.floorz - actor.z;
end;

procedure A_SetInteractive(actor: Pmobj_t);
begin
  actor.flags2_ex := actor.flags2_ex or MF2_EX_INTERACTIVE;
end;

procedure A_UnSetInteractive(actor: Pmobj_t);
begin
  actor.flags2_ex := actor.flags2_ex and not MF2_EX_INTERACTIVE;
end;

function P_NearestPlayer(const mo: Pmobj_t): Pplayer_t;
var
  i: integer;
  nearest: fixed_t;
  dist: fixed_t;
begin
  result := nil;
  nearest := MAXINT;

  for i := 0 to MAXPLAYERS - 1 do
    if playeringame[i] then
      if (players[i].mo <> nil) and (players[i].mo <> mo) then
        if players[i].mo.health >= 0 then
        begin
          dist := P_AproxDistance(players[i].mo.x - mo.x, players[i].mo.y - mo.y);
          if dist < nearest then
          begin
            nearest := dist;
            result := @players[i];
          end;
        end;
end;

function P_CheckFlag(const mo: Pmobj_t; const aflag: string): boolean;
var
  sflag: string;
  flg: LongWord;
  m: boolean;
  idx: integer;
begin
  if mo = nil then
  begin
    result := false;
    exit;
  end;

  sflag := strtrim(strupper(aflag));
  if sflag = '' then
  begin
    result := false;
    exit;
  end;

  if sflag[1] = '+' then
  begin
    Delete(sflag, 1, 1);
    if sflag = '' then
    begin
      result := false;
      exit;
    end;
  end;

  m := sflag[1] = 'M';

  idx := -1;

  if m then
    idx := mobj_flags.IndexOf(sflag);
  if idx < 0 then
    idx := mobj_flags.IndexOf('MF_' + sflag);
  if idx >= 0 then
  begin
    flg := 1 shl idx;
    result := mo.flags and flg <> 0;
    exit;
  end;

  {$IFDEF HERETIC_OR_HEXEN}
  if m then
    idx := mobj_flags2.IndexOf(sflag);
  if idx < 0 then
    idx := mobj_flags2.IndexOf('MF2_' + sflag);
  if idx >= 0 then
  begin
    flg := 1 shl idx;
    result := mo.flags2 and flg <> 0;
    exit;
  end;
  {$ENDIF}

  if m then
    idx := mobj_flags_ex.IndexOf(sflag);
  if idx < 0 then
    idx := mobj_flags_ex.IndexOf('MF_EX_' + sflag);
  if idx >= 0 then
  begin
    flg := 1 shl idx;
    result := mo.flags_ex and flg <> 0;
    exit;
  end;

  if m then
    idx := mobj_flags2_ex.IndexOf(sflag);
  if idx < 0 then
    idx := mobj_flags2_ex.IndexOf('MF2_EX_' + sflag);
  if idx >= 0 then
  begin
    flg := 1 shl idx;
    result := mo.flags2_ex and flg <> 0;
    exit;
  end;

  if m then
    idx := mobj_flags3_ex.IndexOf(sflag);
  if idx < 0 then
    idx := mobj_flags3_ex.IndexOf('MF3_EX_' + sflag);
  if idx >= 0 then
  begin
    flg := 1 shl idx;
    result := mo.flags3_ex and flg <> 0;
    exit;
  end;

  if m then
    idx := mobj_flags4_ex.IndexOf(sflag);
  if idx < 0 then
    idx := mobj_flags4_ex.IndexOf('MF4_EX_' + sflag);
  if idx >= 0 then
  begin
    flg := 1 shl idx;
    result := mo.flags4_ex and flg <> 0;
    exit;
  end;

  if m then
    idx := mobj_flags5_ex.IndexOf(sflag);
  if idx < 0 then
    idx := mobj_flags5_ex.IndexOf('MF5_EX_' + sflag);
  if idx >= 0 then
  begin
    flg := 1 shl idx;
    result := mo.flags5_ex and flg <> 0;
    exit;
  end;

  if m then
    idx := mobj_flags6_ex.IndexOf(sflag);
  if idx < 0 then
    idx := mobj_flags6_ex.IndexOf('MF6_EX_' + sflag);
  if idx >= 0 then
  begin
    flg := 1 shl idx;
    result := mo.flags6_ex and flg <> 0;
    exit;
  end;

  result := false;
end;

function P_GetPlayerMeleeRange(const p: Pplayer_t): fixed_t;
begin
  if G_NeedsCompatibilityMode then
    result := {$IFDEF STRIFE}PLAYERMELEERANGE{$ELSE}MELEERANGE{$ENDIF}
  else
  begin
    result := p.mo.info.meleerange;
    if result = 0 then
      result := {$IFDEF STRIFE}PLAYERMELEERANGE{$ELSE}MELEERANGE{$ENDIF}
    else if result < FRACUNIT then
      result := result * FRACUNIT;
  end;
end;

procedure A_SetMonsterInfight(actor: Pmobj_t);
begin
  actor.flags2_ex := actor.flags2_ex or MF2_EX_DONTINFIGHTMONSTERS;
end;

procedure A_UnSetMonsterInfight(actor: Pmobj_t);
begin
  actor.flags2_ex := actor.flags2_ex and not MF2_EX_DONTINFIGHTMONSTERS;
end;

function P_CheckCustomMeleeRange(actor: Pmobj_t; mrange: integer): boolean;
var
  mo: Pmobj_t;
  dist: fixed_t;
begin
  mo := actor.target;
  if mo = nil then
  begin
    result := false;
    exit;
  end;

  // Friendly monsters do not attack each other
  if P_BothFriends(mo, actor) then
  begin
    result := false;
    exit;
  end;

  dist := P_AproxDistance(mo.x - actor.x, mo.y - actor.y);

  if dist >= mrange then
  begin
    result := false;
    exit;
  end;

  {$IFDEF DOOM}
  // JVAL: 20210207 - Added MF3_EX_MELEECHECKZ
  if actor.flags3_ex and MF3_EX_MELEECHECKZ <> 0 then
  {$ENDIF}
  begin
    if mo.z > actor.z + actor.height then
    begin // Target is higher than the attacker
      result := false;
      exit;
    end;

    if actor.z > mo.z + mo.height then
    begin // Attacker is higher
      result := false;
      exit;
    end;
  end;

  result := P_CheckSight(actor, actor.target);
end;

//----------------------------------------------------------------------------
//
// FUNC P_FaceMobj
//
// Returns 1 if 'source' needs to turn clockwise, or 0 if 'source' needs
// to turn counter clockwise.  'delta' is set to the amount 'source'
// needs to turn.
//
//----------------------------------------------------------------------------
function P_FaceMobj(source: Pmobj_t; target: Pmobj_t; var delta: angle_t): integer;
var
  diff: angle_t;
  angle1: angle_t;
  angle2: angle_t;
begin
  angle1 := source.angle;
  angle2 := R_PointToAngle2(source.x, source.y, target.x, target.y);
  if angle2 > angle1 then
  begin
    diff := angle2 - angle1;
    if diff > ANG180 then
    begin
      delta := ANGLE_MAX - diff;
      result := 0;
    end
    else
    begin
      delta := diff;
      result := 1;
    end;
  end
  else
  begin
    diff := angle1 - angle2;
    if diff > ANG180 then
    begin
      delta := ANGLE_MAX - diff;
      result := 1;
    end
    else
    begin
      delta := diff;
      result := 0;
    end;
  end;
end;

//
// mbf21: P_CheckFov
// Returns true if t2 is within t1's field of view.
// Not directly related to P_CheckSight, but often
// used in tandem.
//
// Adapted from Eternity, so big thanks to Quasar
//
function P_CheckFov(t1, t2: Pmobj_t; ffov: angle_t): boolean;
var
  angle, minang, maxang: angle_t;
begin
  angle := R_PointToAngle2(t1.x, t1.y, t2.x, t2.y);
  minang := t1.angle - ffov div 2;
  maxang := t1.angle + ffov div 2;

  if minang > maxang then
    result := (angle >= minang) or (angle <= maxang)
  else
    result := (angle >= minang) and (angle <= maxang);
end;

//
// mbf21: RoughBlockCheck
// [XA] adapted from Hexen -- used by P_RoughTargetSearch
//
function RoughBlockCheck(mo: Pmobj_t; index: integer; ffov: angle_t): Pmobj_t;
var
  mobj: Pmobj_t;
  link: Pblocklinkitem_t;
  i: integer;
begin
  link := @blocklinks[index];

  for i := 0 to link.size - 1 do
  begin
    mobj := link.links[i];

    // skip non-shootable actors
    if mobj.flags and MF_COUNTKILL = 0 then
      continue;

    // skip the projectile's owner
    if mobj = mo.target then
      continue;

    // skip actors on the same "team", unless infighting or deathmatching
    if mo.target <> nil then
      if P_BothFriends(mobj, mo.target) and (mobj <> mo.target.target) then
        continue;

    // skip actors outside of specified FOV
    if (ffov > 0) and not P_CheckFov(mo, mobj, ffov) then
      continue;

    // skip actors not in line of sight
    if not P_CheckSight(mo, mobj) then
      continue;

    // all good! return it.
    result := mobj;
    exit;
  end;

  // couldn't find a valid target
  result := nil;
end;

//
// P_RoughTargetSearch
//
// Searches though the surrounding mapblocks for monsters/players
//    distance is in MAPBLOCKUNITS

function P_RoughTargetSearch(mo: Pmobj_t; ffov: angle_t; distance: integer): Pmobj_t;
var
  blockX: integer;
  blockY: integer;
  startX, startY: integer;
  blockIndex: integer;
  firstStop: integer;
  secondStop: integer;
  thirdStop: integer;
  finalStop: integer;
  count: integer;
begin
  if internalblockmapformat then
  begin
    startX := MapBlockIntX(int64(mo.x) - int64(bmaporgx));
    startY := MapBlockIntY(int64(mo.y) - int64(bmaporgy));
  end
  else
  begin
    startX := MapBlockInt(mo.x - bmaporgx);
    startY := MapBlockInt(mo.y - bmaporgy);
  end;

  if (startX >= 0) and (startX < bmapwidth) and (startY >= 0) and (startY < bmapheight) then
  begin
    result := RoughBlockCheck(mo, startY * bmapwidth + startX, ffov);
    if result <> nil then
    begin // found a target right away
      exit;
    end;
  end;

  for count := 1 to distance do
  begin
    blockX := startX - count;
    blockY := startY - count;

    if blockY < 0 then
      blockY := 0
    else if blockY >= bmapheight then
      blockY := bmapheight - 1;

    if blockX < 0 then
      blockX := 0
    else if blockX >= bmapwidth then
      blockX := bmapwidth - 1;

    blockIndex := blockY * bmapwidth + blockX;
    firstStop := startX + count;
    if firstStop < 0 then
      continue;

    if firstStop >= bmapwidth then
      firstStop := bmapwidth - 1;

    secondStop := startY + count;
    if secondStop < 0 then
      continue;

    if secondStop >= bmapheight then
      secondStop := bmapheight - 1;

    thirdStop := secondStop * bmapwidth + blockX;
    secondStop := secondStop * bmapwidth + firstStop;
    firstStop := firstStop + blockY * bmapwidth;
    finalStop := blockIndex;

    // Trace the first block section (along the top)
    while blockIndex <= firstStop do
    begin
      result := RoughBlockCheck(mo, blockIndex, ffov);
      if result <> nil then
      begin
        exit;
      end;
      inc(blockIndex);
    end;

    // Trace the second block section (right edge)
    dec(blockIndex);
    while blockIndex <= secondStop do
    begin
      result := RoughBlockCheck(mo, blockIndex, ffov);
      if result <> nil then
      begin
        exit;
      end;
      blockIndex := blockIndex + bmapwidth;
    end;

    // Trace the third block section (bottom edge)
    blockIndex := blockIndex - bmapwidth;
    while blockIndex >= thirdStop do
    begin
      result := RoughBlockCheck(mo, blockIndex, ffov);
      if result <> nil then
      begin
        exit;
      end;
      dec(blockIndex);
    end;

    // Trace the final block section (left edge)
    inc(blockindex);
    while blockIndex > finalStop do
    begin
      result := RoughBlockCheck(mo, blockIndex, ffov);
      if result <> nil then
      begin
        exit;
      end;
      blockIndex := blockIndex - bmapwidth;
    end;
  end;
  result := nil;
end;

// MBF21

//
// P_ResolveMBF21Flags
// JVAL: Convert MBF21 flags to DelphiDoom flags
//
procedure P_ResolveMBF21Flags(const m: Pmobjinfo_t);
begin
  if m.mbf21bits and MF_MBF21_LOGRAV <> 0 then
  begin
    m.flags := m.flags and not MF_NOGRAVITY;
    {$IFDEF HERETIC_OR_HEXEN}
    m.flags2 := m.flags2 or MF2_LOGRAV;
    {$ENDIF}
    m.flags_ex := m.flags_ex or MF_EX_LOWGRAVITY;
    m.flags2_ex := m.flags2_ex and not MF2_EX_MEDIUMGRAVITY;
  end;

  if m.mbf21bits and MF_MBF21_SHORTMRANGE <> 0 then
  begin
    m.flags4_ex := m.flags4_ex or MF4_EX_SHORTMRANGE;
  end;

  if m.mbf21bits and MF_MBF21_DMGIGNORED <> 0 then
  begin
    m.flags4_ex := m.flags4_ex or MF4_EX_DMGIGNORED;
  end;

  if m.mbf21bits and MF_MBF21_NORADIUSDMG <> 0 then
  begin
    m.flags_ex := m.flags_ex or MF_EX_NORADIUSDMG;
  end;

  if m.mbf21bits and MF_MBF21_FORCERADIUSDMG <> 0 then
  begin
    m.flags4_ex := m.flags4_ex or MF4_EX_FORCERADIUSDMG;
  end;

  if m.mbf21bits and MF_MBF21_HIGHERMPROB <> 0 then
  begin
    m.flags4_ex := m.flags4_ex or MF4_EX_HIGHERMPROB;
  end;

  if m.mbf21bits and MF_MBF21_RANGEHALF <> 0 then
  begin
    m.flags4_ex := m.flags4_ex or MF4_EX_RANGEHALF;
  end;

  if m.mbf21bits and MF_MBF21_NOTHRESHOLD <> 0 then
  begin
    m.flags4_ex := m.flags4_ex or MF4_EX_NOTHRESHOLD;
  end;

  if m.mbf21bits and MF_MBF21_LONGMELEE <> 0 then
  begin
    m.flags4_ex := m.flags4_ex or MF4_EX_LONGMELEE;
  end;

  if m.mbf21bits and MF_MBF21_BOSS <> 0 then
  begin
    {$IFDEF HERETIC_OR_HEXEN}
    m.flags2 := m.flags2 or MF2_BOSS;
    {$ENDIF}
    m.flags_ex := m.flags_ex or MF_EX_BOSS;
  end;

  if m.mbf21bits and MF_MBF21_MAP07BOSS1 <> 0 then
  begin
    m.flags4_ex := m.flags4_ex or MF4_EX_MAP07BOSS1;
  end;

  if m.mbf21bits and MF_MBF21_MAP07BOSS2 <> 0 then
  begin
    m.flags4_ex := m.flags4_ex or MF4_EX_MAP07BOSS2;
  end;

  if m.mbf21bits and MF_MBF21_E1M8BOSS <> 0 then
  begin
    {$IFDEF DOOM}
    m.flags4_ex := m.flags4_ex or MF4_EX_E1M8BOSS;
    {$ENDIF}
  end;

  if m.mbf21bits and MF_MBF21_E2M8BOSS <> 0 then
  begin
    {$IFDEF DOOM}
    m.flags4_ex := m.flags4_ex or MF4_EX_E2M8BOSS;
    {$ENDIF}
  end;

  if m.mbf21bits and MF_MBF21_E3M8BOSS <> 0 then
  begin
    {$IFDEF DOOM}
    m.flags4_ex := m.flags4_ex or MF4_EX_E3M8BOSS;
    {$ENDIF}
  end;

  if m.mbf21bits and MF_MBF21_E4M6BOSS <> 0 then
  begin
    {$IFDEF DOOM}
    m.flags4_ex := m.flags4_ex or MF4_EX_E4M6BOSS;
    {$ENDIF}
  end;

  if m.mbf21bits and MF_MBF21_E4M8BOSS <> 0 then
  begin
    {$IFDEF DOOM}
    m.flags4_ex := m.flags4_ex or MF4_EX_E4M8BOSS;
    {$ENDIF}
  end;

  if m.mbf21bits and MF_MBF21_RIP <> 0 then
  begin
    {$IFDEF HERETIC_OR_HEXEN}
    m.flags2 := m.flags2 or MF2_RIP;
    {$ELSE}
    m.flags4_ex := m.flags4_ex or MF4_EX_RIP;
    {$ENDIF}
  end;

  if m.mbf21bits and MF_MBF21_FULLVOLSOUNDS <> 0 then
  begin
    m.flags2_ex := m.flags2_ex or MF2_EX_FULLVOLDEATH;
    m.flags2_ex := m.flags2_ex or MF2_EX_FULLVOLSEE;
  end;
end;

// mbf21: dehacked infighting groups
function P_InfightingImmune(target, source: Pmobj_t): boolean;
begin
  result :=  // not default behaviour, and same group
    (target.infighting_group <> IG_DEFAULT) and
    (target.infighting_group = source.infighting_group);
end;

// mbf21: dehacked projectile groups
function P_ProjectileImmune(target, source: Pmobj_t): boolean;
begin
  result :=
    ( // PG_GROUPLESS means no immunity, even to own species
      (target.projectile_group <> PG_GROUPLESS) or
      (target = source)
    ) and
    (
      ( // target type has default behaviour, and things are the same type
        (target.projectile_group = PG_DEFAULT) and
        (source._type = target._type)
      ) or
      ( // target type has special behaviour, and things have the same group
        (target.projectile_group <> PG_DEFAULT) and
        (target.projectile_group = source.projectile_group)
      )
    );
end;


// mbf21: dehacked splash groups

function P_SplashImmune(target, spot: Pmobj_t): boolean;
begin
  result := // not default behaviour and same group
    (target.splash_group <> SG_DEFAULT) and
    (target.splash_group = spot.splash_group);
end;


//
// P_CheckStateArgs
// JVAL: Check arguments for MBF21 codeprs
//
function P_CheckStateArgs(state: Pstate_t): boolean;
var
  deh_action: Pdeh_action_t;
  i: integer;
  tmpargs: array[0..MAX_STATE_ARGS - 1] of integer;
  sargs: string;
begin
  if state = nil then
  begin
    result := false;
    Exit;
  end;

  if state.flags_ex and MF_EX_STATE_ARGS_CHECKED <> 0 then
  begin
    result := state.flags_ex and MF_EX_STATE_ARGS_ERROR = 0;
    Exit;
  end;

  state.flags_ex := state.flags_ex or MF_EX_STATE_ARGS_CHECKED;

  deh_action := nil;
  for i := 0 to dehnumactions - 1 do
    if @deh_actions[i].action.acp1 = @state.action.acp1 then
      deh_action := @deh_actions[i];

  if deh_action = nil then
  begin
    I_Warning('P_CheckStateArgs(): Unregistered function found in state "%d"'#13#10, [(Integer(state) - Integer(states)) div SizeOf(state_t)]);
    state.flags_ex := state.flags_ex or MF_EX_STATE_ARGS_ERROR;
    result := false;
    exit;
  end;

  if state.params <> nil then
  begin
    if state.params.Count = deh_action.argcount then
    begin
      result := true;
      exit;
    end
    else if state.argsdefined <> 0 then
    begin
      if state.params.Count >= deh_action.argcount then
      begin
        I_Warning('P_CheckStateArgs(): Action has %d parameters, i.e. more than %d parameters in state "%d"'#13#10, [state.params.Count, deh_action.argcount, (Integer(state) - Integer(states)) div SizeOf(state_t)]);
        state.flags_ex := state.flags_ex or MF_EX_STATE_ARGS_ERROR;
        result := false;
        exit;
      end
      else
      begin
        I_Warning('P_CheckStateArgs(): Action has %d parameters, i.e. less than %d parameters in state "%d"'#13#10, [state.params.Count, deh_action.argcount, (Integer(state) - Integer(states)) div SizeOf(state_t)]);
        state.flags_ex := state.flags_ex or MF_EX_STATE_ARGS_ERROR;
        result := true;
        exit;
      end;
    end;
  end;

  if deh_action.argcount = 0 then
  begin
    result := true;
    exit;
  end;

  sargs := '';
  for i := 0 to deh_action.argcount - 1 do
  begin
    if state.argsdefined and (1 shl i) <> 0 then
      tmpargs[i] := state.args[i]
    else
      tmpargs[i] := deh_action.default_args[i];
    if i = 0 then
      sargs := itoa(tmpargs[i])
    else
      sargs := sargs + ', ' + itoa(tmpargs[i]);
  end;

  state.params := TCustomParamList.Create(sargs);
  result := state.params.Count = deh_action.argcount;
end;

//
// A_SpawnObject
// Basically just A_Spawn with better behavior and more args.
//   args[0]: Type of actor to spawn
//   args[1]: Angle (degrees, in fixed point), relative to calling actor's angle
//   args[2]: X spawn offset (fixed point), relative to calling actor
//   args[3]: Y spawn offset (fixed point), relative to calling actor
//   args[4]: Z spawn offset (fixed point), relative to calling actor
//   args[5]: X velocity (fixed point)
//   args[6]: Y velocity (fixed point)
//   args[7]: Z velocity (fixed point)
//
procedure A_SpawnObject(actor: Pmobj_t);
var
  typ, ofs_x, ofs_y, ofs_z, vel_x, vel_y, vel_z: integer;
  angle: Int64;
  an: angle_t;
  fan, dx, dy: integer;
  mo: Pmobj_t;
begin
  if not P_CheckStateArgs(actor.state) then
    exit;

  typ := actor.state.params.IntVal[0] - 1;
  if typ < 0 then
    Exit;
  angle := actor.state.params.MBF21FixedVal[1];
  ofs_x := actor.state.params.MBF21FixedVal[2];
  ofs_y := actor.state.params.MBF21FixedVal[3];
  ofs_z := actor.state.params.MBF21FixedVal[4];
  vel_x := actor.state.params.MBF21FixedVal[5];
  vel_y := actor.state.params.MBF21FixedVal[6];
  vel_z := actor.state.params.MBF21FixedVal[7];

  // calculate position offsets
  an := actor.angle + (angle * FRACUNIT) div 360;
  fan := an shr ANGLETOFINESHIFT;
  dx := FixedMul(ofs_x, finecosine[fan]) - FixedMul(ofs_y, finesine[fan]);
  dy := FixedMul(ofs_x, finesine[fan]) + FixedMul(ofs_y, finecosine[fan]);

  // spawn it, yo
  mo := P_SpawnMobj(actor.x + dx, actor.y + dy, actor.z + ofs_z, typ);
  if mo = nil then
    exit;

  // angle dangle
  mo.angle := an;

  // set velocity
  mo.momx := FixedMul(vel_x, finecosine[fan]) - FixedMul(vel_y, finesine[fan]);
  mo.momy := FixedMul(vel_x, finesine[fan]) + FixedMul(vel_y, finecosine[fan]);
  mo.momz := vel_z;
end;

//
// A_MonsterProjectile
// A parameterized monster projectile attack.
//   args[0]: Type of actor to spawn
//   args[1]: Angle (degrees, in fixed point), relative to calling actor's angle
//   args[2]: Pitch (degrees, in fixed point), relative to calling actor's pitch; approximated
//   args[3]: X/Y spawn offset, relative to calling actor's angle
//   args[4]: Z spawn offset, relative to actor's default projectile fire height
//
procedure A_MonsterProjectile(actor: Pmobj_t);
var
  typ, pitch, spawnofs_xy, spawnofs_z: integer;
  angle: Int64;
  mo: Pmobj_t;
  an: angle_t;
begin
  if not P_CheckStateArgs(actor.state) then
    exit;

  if actor.target = nil then
    exit;

  typ := actor.state.params.IntVal[0] - 1;
  if typ < 0 then
    exit;
  angle := actor.state.params.MBF21FixedVal[1];
  pitch := actor.state.params.MBF21FixedVal[2];
  spawnofs_xy := actor.state.params.MBF21FixedVal[3];
  spawnofs_z := actor.state.params.MBF21FixedVal[4];

  A_FaceTarget(actor);
  mo := P_SpawnMissile(actor, actor.target, typ);
  if mo = nil then
    exit;

  // adjust angle
  mo.angle := mo.angle + (angle * FRACUNIT) div 360;
  an := mo.angle shr ANGLETOFINESHIFT;
  mo.momx := FixedMul(mo.info.speed, finecosine[an]);
  mo.momy := FixedMul(mo.info.speed, finesine[an]);

  // adjust pitch (approximated, using Doom's ye olde
  // finetangent table; same method as monster aim)
  mo.momz := mo.momz + FixedMul(mo.info.speed, DegToSlope(pitch));

  // adjust position
  an := (actor.angle - ANG90) div ANGLETOFINEUNIT;
  mo.x := mo.x + FixedMul(spawnofs_xy, finecosine[an]);
  mo.y := mo.y + FixedMul(spawnofs_xy, finesine[an]);
  mo.z := mo.z + spawnofs_z;

  // always set the 'tracer' field, so this pointer
  // can be used to fire seeker missiles at will.
  mo.tracer := actor.target;
end;

//
// A_MonsterBulletAttack
// A parameterized monster bullet attack.
//   args[0]: Horizontal spread (degrees, in fixed point)
//   args[1]: Vertical spread (degrees, in fixed point)
//   args[2]: Number of bullets to fire; if not set, defaults to 1
//   args[3]: Base damage of attack (e.g. for 3d5, customize the 3); if not set, defaults to 3
//   args[4]: Attack damage modulus (e.g. for 3d5, customize the 5); if not set, defaults to 5
//
procedure A_MonsterBulletAttack(actor: Pmobj_t);
var
  hspread, vspread, numbullets, damagebase, damagemod: integer;
  aimslope, i, damage, angle, slope: integer;
begin
  if not P_CheckStateArgs(actor.state) then
    exit;

  if actor.target = nil then
    exit;

  hspread := actor.state.params.MBF21FixedVal[0];
  vspread := actor.state.params.MBF21FixedVal[1];
  numbullets := actor.state.params.IntVal[2];
  damagebase := actor.state.params.IntVal[3];
  damagemod := actor.state.params.IntVal[4];

  A_FaceTarget(actor);
  S_StartSound(actor, actor.info.attacksound);

  aimslope := P_AimLineAttack(actor, actor.angle, MISSILERANGE);

  for i := 0 to numbullets - 1 do
  begin
    damage := ((N_Random mod damagemod) + 1) * damagebase;
    angle := actor.angle + P_RandomHitscanAngle(hspread);
    slope := aimslope + P_RandomHitscanSlope(vspread);

    P_LineAttack(actor, angle, MISSILERANGE, slope, damage);
  end;
end;

//
// A_MonsterMeleeAttack
// A parameterized monster melee attack.
//   args[0]: Base damage of attack (e.g. for 3d8, customize the 3); if not set, defaults to 3
//   args[1]: Attack damage modulus (e.g. for 3d8, customize the 8); if not set, defaults to 8
//   args[2]: Sound to play if attack hits
//   args[3]: Range (fixed point); if not set, defaults to monster's melee range
//
procedure A_MonsterMeleeAttack(actor: Pmobj_t);
var
  damagebase, damagemod, hitsound, range: integer;
  damage: integer;
begin
  if not P_CheckStateArgs(actor.state) then
    exit;

  if actor.target = nil then
    exit;

  damagebase := actor.state.params.IntVal[0];
  damagemod := actor.state.params.IntVal[1];

  if actor.state.params.IsComputed[2] then
    hitsound := actor.state.params.IntVal[2]
  else
  begin
    hitsound := S_GetSoundNumForName(actor.state.params.StrVal[2]);
    actor.state.params.IntVal[2] := hitsound;
  end;

  range := actor.state.params.MBF21FixedVal[3];
  if range < 1024 then
    range := range * FRACUNIT;

  if range <= 0 then
  begin
    range := actor.info.meleerange;
    if range = 0 then
      range := MELEERANGE;
  end;

  range := range + actor.target.radius - 20 * FRACUNIT;

  A_FaceTarget(actor);
  if not P_CheckCustomMeleeRange(actor, range) then
    exit;

  if hitsound > 0 then
    S_StartSound(actor, hitsound);

  damage := (N_Random mod damagemod + 1) * damagebase;
  P_DamageMobj(actor.target, actor, actor, damage);
end;

//
// A_RadiusDamage
// A parameterized version of A_Explode. Friggin' finally. :P
//   args[0]: Damage (int)
//   args[1]: Radius (also int; no real need for fractional precision here)
//
procedure A_RadiusDamage(actor: Pmobj_t);
begin
  if not P_CheckStateArgs(actor.state) then
    exit;

  if actor.target = nil then
    exit;

  P_RadiusAttackEx(actor, actor.target, actor.state.params.IntVal[0], actor.state.params.IntVal[1]);
end;

//
// A_NoiseAlert
// Alerts nearby monsters (via sound) to the calling actor's target's presence.
//
procedure A_NoiseAlert(actor: Pmobj_t);
begin
  if actor.target = nil then
    exit;

  P_NoiseAlert(actor.target, actor);
end;

//
// mbf21: P_HealCorpse
// Check for ressurecting a body
//
var
  healtryx, healtryy: integer;
  healerobj: Pmobj_t;
  healcorpsehit: Pmobj_t;
  healtryradius: integer;

function PIT_HealCheck(thing: Pmobj_t): boolean;
var
  maxdist: integer;
  check: boolean;
begin
  if thing.flags and MF_CORPSE = 0 then
  begin
    result := true; // not a monster
    exit;
  end;

  if thing.tics <> -1 then
  begin
    result := true; // not lying still yet
    exit;
  end;

  if thing.info.raisestate = Ord(S_NULL) then
  begin
    result := true; // monster doesn't have a raise state
    exit;
  end;

  maxdist := thing.info.radius + healtryradius;

  if (abs(thing.x - healtryx) > maxdist) or
     (abs(thing.y - healtryy) > maxdist) then
  begin
    result := true; // not actually touching
    exit;
  end;

  healcorpsehit := thing;
  healcorpsehit.momx := 0;
  healcorpsehit.momy := 0;
  healcorpsehit.height := _SHL(healcorpsehit.height, 2);
  check := P_CheckPosition(healcorpsehit, healcorpsehit.x, healcorpsehit.y);
  healcorpsehit.height := _SHR2(healcorpsehit.height);

  if not check then
    result := true    // doesn't fit here
  else
    result := false;  // got one, so stop checking
end;

function P_HealCorpse(actor: Pmobj_t; radius: integer; healstate: integer; healsound: integer): boolean;
var
  xl, xh: integer;
  yl, yh: integer;
  bx, by: integer;
  info: Pmobjinfo_t;
  temp: Pmobj_t;
begin
  if actor.movedir <> Ord(DI_NODIR) then
  begin
    // check for corpses to raise
    healtryx := actor.x + actor.info.speed * xspeed[actor.movedir];
    healtryy := actor.y + actor.info.speed * yspeed[actor.movedir];

    if internalblockmapformat then
    begin
      xl := MapBlockIntX(int64(healtryx) - int64(bmaporgx) - MAXRADIUS * 2);
      xh := MapBlockIntX(int64(healtryx) - int64(bmaporgx) + MAXRADIUS * 2);
      yl := MapBlockIntY(int64(healtryy) - int64(bmaporgy) - MAXRADIUS * 2);
      yh := MapBlockIntY(int64(healtryy) - int64(bmaporgy) + MAXRADIUS * 2);
    end
    else
    begin
      xl := MapBlockInt(healtryx - bmaporgx - MAXRADIUS * 2);
      xh := MapBlockInt(healtryx - bmaporgx + MAXRADIUS * 2);
      yl := MapBlockInt(healtryy - bmaporgy - MAXRADIUS * 2);
      yh := MapBlockInt(healtryy - bmaporgy + MAXRADIUS * 2);
    end;

    healerobj := actor;
    healtryradius := radius;
    for bx := xl to xh do
    begin
      for by := yl to yh do
      begin
        // Call PIT_HealCheck to check
        // whether object is a corpse
        // that canbe raised.
        if not P_BlockThingsIterator(bx, by, PIT_HealCheck) then
        begin
          // got one!
          temp := actor.target;
          actor.target := healcorpsehit;
          A_FaceTarget(actor);
          actor.target := temp;

          P_SetMobjState(actor, statenum_t(healstate));
          if healsound > 0 then
            S_StartSound(healcorpsehit, healsound);
          info := healcorpsehit.info;

          P_SetMobjState(healcorpsehit, statenum_t(info.raisestate));

          // phares
          healcorpsehit.height := info.height; // fix Ghost bug
          healcorpsehit.radius := info.radius; // fix Ghost bug
          healcorpsehit.flags := info.flags;
          healcorpsehit.flags_ex := info.flags_ex;
          healcorpsehit.flags2_ex := info.flags2_ex;
          // Inherit friend flag
          if actor.flags2_ex and MF2_EX_FRIEND = 0 then
            healcorpsehit.flags2_ex := healcorpsehit.flags2_ex and not MF2_EX_FRIEND
          else
            healcorpsehit.flags2_ex := healcorpsehit.flags2_ex or MF2_EX_FRIEND;
          healcorpsehit.flags3_ex := info.flags3_ex;
          healcorpsehit.flags4_ex := info.flags4_ex;
          healcorpsehit.flags5_ex := info.flags5_ex;
          healcorpsehit.flags6_ex := info.flags6_ex;
          healcorpsehit.health := info.spawnhealth;
          healcorpsehit.target := nil;
          result := true;
          exit;
        end;
      end;
    end;
  end;

  result := false;
end;

//
// A_HealChase
// A parameterized version of A_VileChase.
//   args[0]: State to jump to on the calling actor when resurrecting a corpse
//   args[1]: Sound to play when resurrecting a corpse
//
procedure A_HealChase(actor: Pmobj_t);
var
  state, sound: integer;
begin
  if not P_CheckStateArgs(actor.state) then
    exit;

  if not actor.state.params.IsComputed[0] then
  begin
    state := P_GetStateFromName(actor, actor.state.params.StrVal[0]);
    actor.state.params.IntVal[0] := state;
  end
  else
    state := actor.state.params.IntVal[0];

  if actor.state.params.IsComputed[2] then
    sound := actor.state.params.IntVal[2]
  else
  begin
    sound := S_GetSoundNumForName(actor.state.params.StrVal[1]);
    actor.state.params.IntVal[1] := sound;
  end;

  if not P_HealCorpse(actor, actor.radius, state, sound) then
    A_Chase(actor);
end;

function P_SeekerMissileEx(actor: Pmobj_t; var tracer: Pmobj_t; const thresh, turnMax: angle_t;
  const centerseek: boolean): boolean;
var
  dir: integer;
  dist: integer;
  delta: angle_t;
  angle: angle_t;
  target: Pmobj_t;
  speed: fixed_t;
  h2: fixed_t;
begin
  target := tracer;
  speed := P_AproxDistance(actor.momx, actor.momy);
  if (target = nil) or (speed = 0) then
  begin
    result := false;
    exit;
  end;

  if target.flags and MF_SHOOTABLE = 0 then
  begin // Target died
    tracer := nil;
    result := false;
    exit;
  end;

  dir := P_FaceMobj(actor, target, delta);
  if delta > thresh then
  begin
    delta := delta shr 1;
    if delta > turnMax then
      delta := turnMax;
  end;

  if dir <> 0 then
  begin // Turn clockwise
    actor.angle := actor.angle + delta;
  end
  else
  begin // Turn counter clockwise
    actor.angle := actor.angle - delta;
  end;

  angle := actor.angle shr ANGLETOFINESHIFT;
  actor.momx := FixedMul(speed, finecosine[angle]);
  actor.momy := FixedMul(speed, finesine[angle]);
  if (actor.z + actor.height < target.z) or
     (target.z + target.height < actor.z) or
     centerseek then
  begin // Need to seek vertically
    dist := P_AproxDistance(target.x - actor.x, target.y - actor.y);
    dist := dist div speed;
    if dist < 1 then
      dist := 1;
    if centerseek then
      h2 := target.height div 2
    else
      h2 := 0;
    actor.momz := ((target.z + h2) - (actor.z + actor.height div 2)) div dist;
  end;
  result := true;
end;

//
// A_SeekTracer
// A parameterized seeker missile function.
//   args[0]: direct-homing threshold angle (degrees, in fixed point)
//   args[1]: maximum turn angle (degrees, in fixed point)
//
procedure A_SeekTracer(actor: Pmobj_t);
var
  threshold, maxturnangle: angle_t;
begin
  if not P_CheckStateArgs(actor.state) then
    exit;

  threshold := FixedToAngle(actor.state.params.MBF21FixedVal[0]);
  maxturnangle := FixedToAngle(actor.state.params.MBF21FixedVal[1]);

  P_SeekerMissileEx(actor, actor.tracer, threshold, maxturnangle, true);
end;

//
// A_FindTracer
// Search for a valid tracer (seek target), if the calling actor doesn't already have one.
//   args[0]: field-of-view to search in (degrees, in fixed point); if zero, will search in all directions
//   args[1]: distance to search (map blocks, i.e. 128 units)
//
procedure A_FindTracer(actor: Pmobj_t);
var
  ffov: angle_t;
  dist: integer;
begin
  if not P_CheckStateArgs(actor.state) then
    exit;

  if actor.tracer <> nil then
    exit;

  ffov := FixedToAngle(actor.state.params.MBF21FixedVal[0]);
  dist := actor.state.params.IntVal[1];

  actor.tracer := P_RoughTargetSearch(actor, ffov, dist);
end;

//
// A_ClearTracer
// Clear current tracer (seek target).
//
procedure A_ClearTracer(actor: Pmobj_t);
begin
  actor.tracer := nil;
end;

//
// A_JumpIfHealthBelow
// Jumps to a state if caller's health is below the specified threshold.
//   args[0]: State to jump to
//   args[1]: Health threshold
//
procedure A_JumpIfHealthBelow(actor: Pmobj_t);
var
  newstate, health: integer;
begin
  if not P_CheckStateArgs(actor.state) then
    exit;

  health := actor.state.params.IntVal[1];

  if actor.health < health then
  begin
    if not actor.state.params.IsComputed[0] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[0]);
      actor.state.params.IntVal[0] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[0];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

//
// A_JumpIfTargetInSight
// Jumps to a state if caller's target is in line-of-sight.
//   args[0]: State to jump to
//   args[1]: Field-of-view to check (degrees, in fixed point); if zero, will check in all directions
//
procedure A_JumpIfTargetInSight(actor: Pmobj_t);
var
  newstate: integer;
  ffov: angle_t;
begin
  if not P_CheckStateArgs(actor.state) then
    exit;

  if actor.target = nil then
    exit;

  ffov := FixedToAngle(actor.state.params.MBF21FixedVal[1]);

  // Check FOV first since it's faster
  if (ffov > 0) and not P_CheckFov(actor, actor.target, ffov) then
    exit;

  if P_CheckSight(actor, actor.target) then
  begin
    if not actor.state.params.IsComputed[0] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[0]);
      actor.state.params.IntVal[0] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[0];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

//
// A_JumpIfTargetCloser
// Jumps to a state if caller's target is closer than the specified distance.
//   args[0]: State to jump to
//   args[1]: Distance threshold
//
procedure A_JumpIfTargetCloser(actor: Pmobj_t);
var
  newstate: integer;
  distance: integer;
begin
  if not P_CheckStateArgs(actor.state) then
    exit;

  if actor.target = nil then
    exit;

  distance := actor.state.params.MBF21FixedVal[1];

  if distance > P_AproxDistance(actor.x - actor.target.x, actor.y - actor.target.y) then
  begin
    if not actor.state.params.IsComputed[0] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[0]);
      actor.state.params.IntVal[0] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[0];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

//
// A_JumpIfTracerInSight
// Jumps to a state if caller's tracer (seek target) is in line-of-sight.
//   args[0]: State to jump to
//   args[1]: Field-of-view to check (degrees, in fixed point); if zero, will check in all directions
//
procedure A_JumpIfTracerInSight(actor: Pmobj_t);
var
  newstate: integer;
  ffov: angle_t;
begin
  if not P_CheckStateArgs(actor.state) then
    exit;

  if actor.tracer = nil then
    exit;

  ffov := FixedToAngle(actor.state.params.MBF21FixedVal[1]);

  // Check FOV first since it's faster
  if (ffov > 0) and not P_CheckFov(actor, actor.tracer, ffov) then
    exit;

  if P_CheckSight(actor, actor.tracer) then
  begin
    if not actor.state.params.IsComputed[0] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[0]);
      actor.state.params.IntVal[0] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[0];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

//
// A_JumpIfTracerCloser
// Jumps to a state if caller's tracer (seek target) is closer than the specified distance.
//   args[0]: State to jump to
//   args[1]: Distance threshold (fixed point)
//
procedure A_JumpIfTracerCloserMBF21(actor: Pmobj_t);
var
  newstate: integer;
  distance: integer;
begin
  if not P_CheckStateArgs(actor.state) then
    exit;

  if actor.tracer = nil then
    exit;

  distance := actor.state.params.MBF21FixedVal[1];

  if distance > P_AproxDistance(actor.x - actor.tracer.x, actor.y - actor.tracer.y) then
  begin
    if not actor.state.params.IsComputed[0] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[0]);
      actor.state.params.IntVal[0] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[0];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

{$IFDEF HEXEN}
const
  MF_MBF21_DROPPED = $20000;
{$ENDIF}

{$IFDEF STRIFE}
const
  MF_MBF21_PICKUP = $800;
  MF_MBF21_SLIDE = $2000;
{$ENDIF}

procedure P_SetMBF21Flags(const m: Pmobj_t; const bits, mbf21bits: integer);
var
  istransparent: boolean;
  isfriend: boolean;
  isbouncy: boolean;
  istouchy: boolean;
  flags: integer;
begin
  istransparent := bits < 0;
  isfriend := bits and (1 shl 30) <> 0;
  isbouncy := bits and (1 shl 29) <> 0;
  istouchy := bits and (1 shl 28) <> 0;

  flags := bits and (
    MF_SPECIAL or
    MF_SOLID or
    MF_SHOOTABLE or
    MF_NOSECTOR or
    MF_NOBLOCKMAP or
    MF_AMBUSH or
    MF_JUSTHIT or
    MF_JUSTATTACKED or
    MF_SPAWNCEILING or
    MF_NOGRAVITY or
    MF_DROPOFF or
    {$IFNDEF STRIFE}
    MF_PICKUP or
    {$ENDIF}
    MF_NOCLIP or
    {$IFDEF DOOM}
    MF_SLIDE or
    {$ENDIF}
    {$IFDEF HERETIC_OR_HEXEN}
    MF_SLIDEONWALLS or
    {$ENDIF}
    MF_FLOAT or
    {$IFNDEF STRIFE}
    MF_TELEPORT or
    {$ENDIF}
    MF_MISSILE or
    {$IFNDEF HEXEN}
    MF_DROPPED or
    {$ENDIF}
    MF_SHADOW or
    MF_NOBLOOD or
    MF_CORPSE or
    MF_INFLOAT or
    MF_COUNTKILL or
    {$IFDEF DOOM_OR_HERETIC}
    MF_COUNTITEM or
    {$ENDIF}
    {$IFNDEF STRIFE}
    MF_SKULLFLY or
    {$ENDIF}
    MF_NOTDMATCH{$IFNDEF STRIFE} or
    MF_TRANSLATION or
    (MF_TRANSLATION * 2){$ENDIF});

  m.flags := m.flags or flags;

  {$IFDEF HEXEN}
  if flags and MF_MBF21_DROPPED <> 0 then
    m.flags2 := m.flags2 or MF2_DROPPED;
  {$ENDIF}

  {$IFDEF STRIFE}
  if flags and MF_MBF21_SLIDE <> 0 then
    m.flags3_ex := m.flags3_ex or MF3_EX_SLIDE;
  {$ENDIF}

  if istransparent then
    m.flags_ex := m.flags_ex or MF_EX_TRANSPARENT;
  if isfriend then
    m.flags2_ex := m.flags2_ex or MF2_EX_FRIEND;
  if isbouncy then
    m.flags3_ex := m.flags3_ex or MF3_EX_BOUNCE;

  if mbf21bits and MF_MBF21_LOGRAV <> 0 then
  begin
    m.flags := m.flags and not MF_NOGRAVITY;
    {$IFDEF HERETIC_OR_HEXEN}
    m.flags2 := m.flags2 or MF2_LOGRAV;
    {$ENDIF}
    m.flags_ex := m.flags_ex or MF_EX_LOWGRAVITY;
    m.flags2_ex := m.flags2_ex and not MF2_EX_MEDIUMGRAVITY;
  end;

  if mbf21bits and MF_MBF21_SHORTMRANGE <> 0 then
  begin
    m.flags4_ex := m.flags4_ex or MF4_EX_SHORTMRANGE;
  end;

  if mbf21bits and MF_MBF21_DMGIGNORED <> 0 then
  begin
    m.flags4_ex := m.flags4_ex or MF4_EX_DMGIGNORED;
  end;

  if mbf21bits and MF_MBF21_NORADIUSDMG <> 0 then
  begin
    m.flags_ex := m.flags_ex or MF_EX_NORADIUSDMG;
  end;

  if mbf21bits and MF_MBF21_FORCERADIUSDMG <> 0 then
  begin
    m.flags4_ex := m.flags4_ex or MF4_EX_FORCERADIUSDMG;
  end;

  if mbf21bits and MF_MBF21_HIGHERMPROB <> 0 then
  begin
    m.flags4_ex := m.flags4_ex or MF4_EX_HIGHERMPROB;
  end;

  if mbf21bits and MF_MBF21_RANGEHALF <> 0 then
  begin
    m.flags4_ex := m.flags4_ex or MF4_EX_RANGEHALF;
  end;

  if mbf21bits and MF_MBF21_NOTHRESHOLD <> 0 then
  begin
    m.flags4_ex := m.flags4_ex or MF4_EX_NOTHRESHOLD;
  end;

  if mbf21bits and MF_MBF21_LONGMELEE <> 0 then
  begin
    m.flags4_ex := m.flags4_ex or MF4_EX_LONGMELEE;
  end;

  if mbf21bits and MF_MBF21_BOSS <> 0 then
  begin
    {$IFDEF HERETIC_OR_HEXEN}
    m.flags2 := m.flags2 or MF2_BOSS;
    {$ENDIF}
    m.flags_ex := m.flags_ex or MF_EX_BOSS;
  end;

  if mbf21bits and MF_MBF21_MAP07BOSS1 <> 0 then
  begin
    m.flags4_ex := m.flags4_ex or MF4_EX_MAP07BOSS1;
  end;

  if mbf21bits and MF_MBF21_MAP07BOSS2 <> 0 then
  begin
    m.flags4_ex := m.flags4_ex or MF4_EX_MAP07BOSS2;
  end;

  if mbf21bits and MF_MBF21_E1M8BOSS <> 0 then
  begin
    {$IFDEF DOOM}
    m.flags4_ex := m.flags4_ex or MF4_EX_E1M8BOSS;
    {$ENDIF}
  end;

  if mbf21bits and MF_MBF21_E2M8BOSS <> 0 then
  begin
    {$IFDEF DOOM}
    m.flags4_ex := m.flags4_ex or MF4_EX_E2M8BOSS;
    {$ENDIF}
  end;

  if mbf21bits and MF_MBF21_E3M8BOSS <> 0 then
  begin
    {$IFDEF DOOM}
    m.flags4_ex := m.flags4_ex or MF4_EX_E3M8BOSS;
    {$ENDIF}
  end;

  if mbf21bits and MF_MBF21_E4M6BOSS <> 0 then
  begin
    {$IFDEF DOOM}
    m.flags4_ex := m.flags4_ex or MF4_EX_E4M6BOSS;
    {$ENDIF}
  end;

  if mbf21bits and MF_MBF21_E4M8BOSS <> 0 then
  begin
    {$IFDEF DOOM}
    m.flags4_ex := m.flags4_ex or MF4_EX_E4M8BOSS;
    {$ENDIF}
  end;

  if mbf21bits and MF_MBF21_RIP <> 0 then
  begin
    {$IFDEF HERETIC_OR_HEXEN}
    m.flags2 := m.flags2 or MF2_RIP;
    {$ELSE}
    m.flags4_ex := m.flags4_ex or MF4_EX_RIP;
    {$ENDIF}
  end;

  if mbf21bits and MF_MBF21_FULLVOLSOUNDS <> 0 then
  begin
    m.flags2_ex := m.flags2_ex or MF2_EX_FULLVOLDEATH;
    m.flags2_ex := m.flags2_ex or MF2_EX_FULLVOLSEE;
  end;
end;

procedure P_UnSetMBF21Flags(const m: Pmobj_t; const bits, mbf21bits: integer);
var
  istransparent: boolean;
  isfriend: boolean;
  isbouncy: boolean;
  istouchy: boolean;
  flags: integer;
begin
  istransparent := bits < 0;
  isfriend := bits and (1 shl 30) <> 0;
  isbouncy := bits and (1 shl 29) <> 0;
  istouchy := bits and (1 shl 28) <> 0;

  flags := bits and (
    MF_SPECIAL or
    MF_SOLID or
    MF_SHOOTABLE or
    MF_NOSECTOR or
    MF_NOBLOCKMAP or
    MF_AMBUSH or
    MF_JUSTHIT or
    MF_JUSTATTACKED or
    MF_SPAWNCEILING or
    MF_NOGRAVITY or
    MF_DROPOFF or
    {$IFNDEF STRIFE}
    MF_PICKUP or
    {$ENDIF}
    MF_NOCLIP or
    {$IFDEF DOOM}
    MF_SLIDE or
    {$ENDIF}
    {$IFDEF HERETIC_OR_HEXEN}
    MF_SLIDEONWALLS or
    {$ENDIF}
    MF_FLOAT or
    {$IFNDEF STRIFE}
    MF_TELEPORT or
    {$ENDIF}
    MF_MISSILE or
    {$IFNDEF HEXEN}
    MF_DROPPED or
    {$ENDIF}
    MF_SHADOW or
    MF_NOBLOOD or
    MF_CORPSE or
    MF_INFLOAT or
    MF_COUNTKILL or
    {$IFDEF DOOM_OR_HERETIC}
    MF_COUNTITEM or
    {$ENDIF}
    {$IFNDEF STRIFE}
    MF_SKULLFLY or
    {$ENDIF}
    MF_NOTDMATCH{$IFNDEF STRIFE} or
    MF_TRANSLATION or
    (MF_TRANSLATION * 2){$ENDIF});

  m.flags := m.flags and not flags;

  {$IFDEF HEXEN}
  if flags and MF_MBF21_DROPPED <> 0 then
    m.flags2 := m.flags2 and not MF2_DROPPED;
  {$ENDIF}

  {$IFDEF STRIFE}
  if flags and MF_MBF21_PICKUP <> 0 then
    m.flags3_ex := m.flags3_ex and not MF3_EX_SLIDE;
  {$ENDIF}

  if istransparent then
    m.flags_ex := m.flags_ex and not MF_EX_TRANSPARENT;
  if isfriend then
    m.flags2_ex := m.flags2_ex and not MF2_EX_FRIEND;
  if isbouncy then
    m.flags3_ex := m.flags3_ex and not MF3_EX_BOUNCE;

  if mbf21bits and MF_MBF21_LOGRAV <> 0 then
  begin
    m.flags := m.flags and not MF_NOGRAVITY;
    {$IFDEF HERETIC_OR_HEXEN}
    m.flags2 := m.flags2 and not MF2_LOGRAV;
    {$ENDIF}
    m.flags_ex := m.flags_ex and not MF_EX_LOWGRAVITY;
    m.flags2_ex := m.flags2_ex and not MF2_EX_MEDIUMGRAVITY;
  end;

  if mbf21bits and MF_MBF21_SHORTMRANGE <> 0 then
  begin
    m.flags4_ex := m.flags4_ex and not MF4_EX_SHORTMRANGE;
  end;

  if mbf21bits and MF_MBF21_DMGIGNORED <> 0 then
  begin
    m.flags4_ex := m.flags4_ex and not MF4_EX_DMGIGNORED;
  end;

  if mbf21bits and MF_MBF21_NORADIUSDMG <> 0 then
  begin
    m.flags_ex := m.flags_ex and not MF_EX_NORADIUSDMG;
  end;

  if mbf21bits and MF_MBF21_FORCERADIUSDMG <> 0 then
  begin
    m.flags4_ex := m.flags4_ex and not MF4_EX_FORCERADIUSDMG;
  end;

  if mbf21bits and MF_MBF21_HIGHERMPROB <> 0 then
  begin
    m.flags4_ex := m.flags4_ex and not MF4_EX_HIGHERMPROB;
  end;

  if mbf21bits and MF_MBF21_RANGEHALF <> 0 then
  begin
    m.flags4_ex := m.flags4_ex and not MF4_EX_RANGEHALF;
  end;

  if mbf21bits and MF_MBF21_NOTHRESHOLD <> 0 then
  begin
    m.flags4_ex := m.flags4_ex and not MF4_EX_NOTHRESHOLD;
  end;

  if mbf21bits and MF_MBF21_LONGMELEE <> 0 then
  begin
    m.flags4_ex := m.flags4_ex and not MF4_EX_LONGMELEE;
  end;

  if mbf21bits and MF_MBF21_BOSS <> 0 then
  begin
    {$IFDEF HERETIC_OR_HEXEN}
    m.flags2 := m.flags2 and not MF2_BOSS;
    {$ENDIF}
    m.flags_ex := m.flags_ex and not MF_EX_BOSS;
  end;

  if mbf21bits and MF_MBF21_MAP07BOSS1 <> 0 then
  begin
    m.flags4_ex := m.flags4_ex and not MF4_EX_MAP07BOSS1;
  end;

  if mbf21bits and MF_MBF21_MAP07BOSS2 <> 0 then
  begin
    m.flags4_ex := m.flags4_ex and not MF4_EX_MAP07BOSS2;
  end;

  if mbf21bits and MF_MBF21_E1M8BOSS <> 0 then
  begin
    {$IFDEF DOOM}
    m.flags4_ex := m.flags4_ex and not MF4_EX_E1M8BOSS;
    {$ENDIF}
  end;

  if mbf21bits and MF_MBF21_E2M8BOSS <> 0 then
  begin
    {$IFDEF DOOM}
    m.flags4_ex := m.flags4_ex and not MF4_EX_E2M8BOSS;
    {$ENDIF}
  end;

  if mbf21bits and MF_MBF21_E3M8BOSS <> 0 then
  begin
    {$IFDEF DOOM}
    m.flags4_ex := m.flags4_ex and not MF4_EX_E3M8BOSS;
    {$ENDIF}
  end;

  if mbf21bits and MF_MBF21_E4M6BOSS <> 0 then
  begin
    {$IFDEF DOOM}
    m.flags4_ex := m.flags4_ex and not MF4_EX_E4M6BOSS;
    {$ENDIF}
  end;

  if mbf21bits and MF_MBF21_E4M8BOSS <> 0 then
  begin
    {$IFDEF DOOM}
    m.flags4_ex := m.flags4_ex and not MF4_EX_E4M8BOSS;
    {$ENDIF}
  end;

  if mbf21bits and MF_MBF21_RIP <> 0 then
  begin
    {$IFDEF HERETIC_OR_HEXEN}
    m.flags2 := m.flags2 and not MF2_RIP;
    {$ELSE}
    m.flags4_ex := m.flags4_ex and not MF4_EX_RIP;
    {$ENDIF}
  end;

  if mbf21bits and MF_MBF21_FULLVOLSOUNDS <> 0 then
  begin
    m.flags2_ex := m.flags2_ex and not MF2_EX_FULLVOLDEATH;
    m.flags2_ex := m.flags2_ex and not MF2_EX_FULLVOLSEE;
  end;
end;

function P_CheckMBF21Flags(const m: Pmobj_t; const bits, mbf21bits: integer): boolean;
var
  istransparent: boolean;
  isfriend: boolean;
  isbouncy: boolean;
  istouchy: boolean;
  flags: integer;
begin
  istransparent := bits < 0;
  isfriend := bits and (1 shl 30) <> 0;
  isbouncy := bits and (1 shl 29) <> 0;
  istouchy := bits and (1 shl 28) <> 0;

  flags := bits and (
    MF_SPECIAL or
    MF_SOLID or
    MF_SHOOTABLE or
    MF_NOSECTOR or
    MF_NOBLOCKMAP or
    MF_AMBUSH or
    MF_JUSTHIT or
    MF_JUSTATTACKED or
    MF_SPAWNCEILING or
    MF_NOGRAVITY or
    MF_DROPOFF or
    {$IFNDEF STRIFE}
    MF_PICKUP or
    {$ENDIF}
    MF_NOCLIP or
    {$IFDEF DOOM}
    MF_SLIDE or
    {$ENDIF}
    {$IFDEF HERETIC_OR_HEXEN}
    MF_SLIDEONWALLS or
    {$ENDIF}
    MF_FLOAT or
    {$IFNDEF STRIFE}
    MF_TELEPORT or
    {$ENDIF}
    MF_MISSILE or
    {$IFNDEF HEXEN}
    MF_DROPPED or
    {$ENDIF}
    MF_SHADOW or
    MF_NOBLOOD or
    MF_CORPSE or
    MF_INFLOAT or
    MF_COUNTKILL or
    {$IFDEF DOOM_OR_HERETIC}
    MF_COUNTITEM or
    {$ENDIF}
    {$IFNDEF STRIFE}
    MF_SKULLFLY or
    {$ENDIF}
    MF_NOTDMATCH{$IFNDEF STRIFE} or
    MF_TRANSLATION or
    (MF_TRANSLATION * 2){$ENDIF});

  result := (m.flags and flags = flags);
  if not result then
    exit;

  {$IFDEF HEXEN}
  if flags and MF_MBF21_DROPPED <> 0 then
  begin
    result := m.flags2 and MF2_DROPPED <> 0;
    if not result then
      exit;
  end;
  {$ENDIF}

  {$IFDEF STRIFE}
  if flags and MF_MBF21_SLIDE <> 0 then
  begin
    result := m.flags3_ex and MF3_EX_SLIDE <> 0;
    if not result then
      exit;
  end;

  if flags and MF_MBF21_PICKUP <> 0 then
  begin
    result := m.player <> nil;
    if not result then
      exit;
  end;
  {$ENDIF}

  if istransparent then
  begin
    result := m.flags_ex and MF_EX_TRANSPARENT <> 0;
    if not result then
      exit;
  end;

  if isfriend then
  begin
    result := m.flags2_ex and MF2_EX_FRIEND <> 0;
    if not result then
      exit;
  end;

  if isbouncy then
  begin
    result := m.flags3_ex and MF3_EX_BOUNCE = MF3_EX_BOUNCE;
    if not result then
      exit;
  end;

  if mbf21bits and MF_MBF21_LOGRAV <> 0 then
  begin
    result :=
      (m.flags and MF_NOGRAVITY = 0) and
      {$IFDEF HERETIC_OR_HEXEN}
      (m.flags2 and MF2_LOGRAV <> 0) and
      {$ENDIF}
      (m.flags_ex and MF_EX_LOWGRAVITY <> 0) and
      (m.flags2_ex and MF2_EX_MEDIUMGRAVITY = 0);
    if not result then
      exit;
  end;

  if mbf21bits and MF_MBF21_SHORTMRANGE <> 0 then
  begin
    result := m.flags4_ex and MF4_EX_SHORTMRANGE <> 0;
    if not result then
      exit;
  end;

  if mbf21bits and MF_MBF21_DMGIGNORED <> 0 then
  begin
    result := m.flags4_ex and MF4_EX_DMGIGNORED <> 0;
    if not result then
      exit;
  end;

  if mbf21bits and MF_MBF21_NORADIUSDMG <> 0 then
  begin
    result := m.flags_ex and MF_EX_NORADIUSDMG <> 0;
    if not result then
      exit;
  end;

  if mbf21bits and MF_MBF21_FORCERADIUSDMG <> 0 then
  begin
    result := m.flags4_ex and MF4_EX_FORCERADIUSDMG <> 0;
    if not result then
      exit;
  end;

  if mbf21bits and MF_MBF21_HIGHERMPROB <> 0 then
  begin
    result := m.flags4_ex and MF4_EX_HIGHERMPROB <> 0;
    if not result then
      exit;
  end;

  if mbf21bits and MF_MBF21_RANGEHALF <> 0 then
  begin
    result := m.flags4_ex and MF4_EX_RANGEHALF <> 0;
    if not result then
      exit;
  end;

  if mbf21bits and MF_MBF21_NOTHRESHOLD <> 0 then
  begin
    result := m.flags4_ex and MF4_EX_NOTHRESHOLD <> 0;
    if not result then
      exit;
  end;

  if mbf21bits and MF_MBF21_LONGMELEE <> 0 then
  begin
    result := m.flags4_ex and MF4_EX_LONGMELEE <> 0;
    if not result then
      exit;
  end;

  if mbf21bits and MF_MBF21_BOSS <> 0 then
  begin
    result :=
      {$IFDEF HERETIC_OR_HEXEN}
      (m.flags2 and MF2_BOSS <> 0) and
      {$ENDIF}
      (m.flags_ex and MF_EX_BOSS <> 0);
    if not result then
      exit;
  end;

  if mbf21bits and MF_MBF21_MAP07BOSS1 <> 0 then
  begin
    result := m.flags4_ex and MF4_EX_MAP07BOSS1 <> 0;
    if not result then
      exit;
  end;

  if mbf21bits and MF_MBF21_MAP07BOSS2 <> 0 then
  begin
    result := m.flags4_ex and MF4_EX_MAP07BOSS2 <> 0;
    if not result then
      exit;
  end;

  if mbf21bits and MF_MBF21_E1M8BOSS <> 0 then
  begin
    {$IFDEF DOOM}
    result := m.flags4_ex and MF4_EX_E1M8BOSS <> 0;
    if not result then
      exit;
    {$ENDIF}
  end;

  if mbf21bits and MF_MBF21_E2M8BOSS <> 0 then
  begin
    {$IFDEF DOOM}
    result := m.flags4_ex and MF4_EX_E2M8BOSS <> 0;
    if not result then
      exit;
    {$ENDIF}
  end;

  if mbf21bits and MF_MBF21_E3M8BOSS <> 0 then
  begin
    {$IFDEF DOOM}
    result := m.flags4_ex and MF4_EX_E3M8BOSS <> 0;
    if not result then
      exit;
    {$ENDIF}
  end;

  if mbf21bits and MF_MBF21_E4M6BOSS <> 0 then
  begin
    {$IFDEF DOOM}
    result := m.flags4_ex and MF4_EX_E4M6BOSS <> 0;
    if not result then
      exit;
    {$ENDIF}
  end;

  if mbf21bits and MF_MBF21_E4M8BOSS <> 0 then
  begin
    {$IFDEF DOOM}
    result := m.flags4_ex and MF4_EX_E4M8BOSS <> 0;
    if not result then
      exit;
    {$ENDIF}
  end;

  if mbf21bits and MF_MBF21_RIP <> 0 then
  begin
    {$IFDEF HERETIC_OR_HEXEN}
    result := m.flags2 and MF2_RIP <> 0;
    {$ELSE}
    result := m.flags4_ex and MF4_EX_RIP <> 0;
    {$ENDIF}
    if not result then
      exit;
  end;

  if mbf21bits and MF_MBF21_FULLVOLSOUNDS <> 0 then
  begin
    result :=
      (m.flags2_ex and MF2_EX_FULLVOLDEATH <> 0) and
      (m.flags2_ex and MF2_EX_FULLVOLSEE <> 0);
  end;
end;

//
// A_JumpIfFlagsSet
// Jumps to a state if caller has the specified thing flags set.
//   args[0]: State to jump to
//   args[1]: Standard Flag(s) to check
//   args[2]: MBF21 Flag(s) to check
//
procedure A_JumpIfFlagsSet(actor: Pmobj_t);
var
  newstate: integer;
  bits, mbf21bits: integer;
begin
  if not P_CheckStateArgs(actor.state) then
    exit;

  bits := actor.state.params.IntVal[1];
  mbf21bits := actor.state.params.IntVal[2];

  if P_CheckMBF21Flags(actor, bits, mbf21bits) then
  begin
    if not actor.state.params.IsComputed[0] then
    begin
      newstate := P_GetStateFromName(actor, actor.state.params.StrVal[0]);
      actor.state.params.IntVal[0] := newstate;
    end
    else
      newstate := actor.state.params.IntVal[0];

    P_SetMobjState(actor, statenum_t(newstate));
  end;
end;

//
// A_AddFlags
// Adds the specified thing flags to the caller.
//   args[0]: Standard Flag(s) to add
//   args[1]: MBF21 Flag(s) to add
//
procedure A_AddFlags(actor: Pmobj_t);
var
  bits, mbf21bits: integer;
begin
  if not P_CheckStateArgs(actor.state) then
    exit;

  bits := actor.state.params.IntVal[0];
  mbf21bits := actor.state.params.IntVal[1];

  P_SetMBF21Flags(actor, bits, mbf21bits);
end;

//
// A_RemoveFlags
// Removes the specified thing flags from the caller.
//   args[0]: Flag(s) to remove
//   args[1]: MBF21 Flag(s) to remove
//
procedure A_RemoveFlags(actor: Pmobj_t);
var
  bits, mbf21bits: integer;
begin
  if not P_CheckStateArgs(actor.state) then
    exit;

  bits := actor.state.params.IntVal[0];
  mbf21bits := actor.state.params.IntVal[1];

  P_UnSetMBF21Flags(actor, bits, mbf21bits);
end;

//
// A_WeaponProjectile
// A parameterized player weapon projectile attack. Does not consume ammo.
//   args[0]: Type of actor to spawn
//   args[1]: Angle (degrees, in fixed point), relative to calling player's angle
//   args[2]: Pitch (degrees, in fixed point), relative to calling player's pitch; approximated
//   args[3]: X/Y spawn offset, relative to calling player's angle
//   args[4]: Z spawn offset, relative to player's default projectile fire height
//
procedure A_WeaponProjectile(player: Pplayer_t; psp: Ppspdef_t);
var
  typ, angle, pitch, spawnofs_xy, spawnofs_z: integer;
  mo: Pmobj_t;
  an: integer;
begin
  if psp = nil then
    exit;

  if not P_CheckStateArgs(psp.state) then
    exit;

  if psp.state.params.IntVal[0] = 0 then
    exit;

  typ := psp.state.params.IntVal[0] - 1;
  angle := psp.state.params.MBF21FixedVal[1];
  pitch := psp.state.params.MBF21FixedVal[2];
  spawnofs_xy := psp.state.params.MBF21FixedVal[3];
  spawnofs_z := psp.state.params.MBF21FixedVal[4];

  mo := P_SpawnPlayerMissile(player.mo, typ);
  if mo = nil then
    exit;

  // adjust angle
  if angle <> 0 then
    mo.angle := mo.angle + Round(angle / 360 * FRACUNIT);
  an := mo.angle div ANGLETOFINEUNIT;
  mo.momx := FixedMul(mo.info.speed, finecosine[an]);
  mo.momy := FixedMul(mo.info.speed, finesine[an]);

  // adjust pitch (approximated, using Doom's ye olde
  // finetangent table; same method as autoaim)
  mo.momz := mo.momz + FixedMul(mo.info.speed, DegToSlope(pitch));

  // adjust position
  an := (player.mo.angle - ANG90) div ANGLETOFINEUNIT;
  mo.x := mo.x + FixedMul(spawnofs_xy, finecosine[an]);
  mo.y := mo.y + FixedMul(spawnofs_xy, finesine[an]);
  mo.z := mo.z + spawnofs_z;

  // set tracer to the player's autoaim target,
  // so player seeker missiles prioritizing the
  // baddie the player is actually aiming at. ;)
  mo.tracer := linetarget;
end;

//
// A_WeaponBulletAttack
// A parameterized player weapon bullet attack. Does not consume ammo.
//   args[0]: Horizontal spread (degrees, in fixed point)
//   args[1]: Vertical spread (degrees, in fixed point)
//   args[2]: Number of bullets to fire; if not set, defaults to 1
//   args[3]: Base damage of attack (e.g. for 5d3, customize the 5); if not set, defaults to 5
//   args[4]: Attack damage modulus (e.g. for 5d3, customize the 3); if not set, defaults to 3
//
procedure A_WeaponBulletAttack(player: Pplayer_t; psp: Ppspdef_t);
var
  hspread, vspread, numbullets, damagebase, damagemod: integer;
  i, damage, angle, slope: integer;
begin
  if psp = nil then
    exit;

  if not P_CheckStateArgs(psp.state) then
    exit;

  hspread := psp.state.params.MBF21FixedVal[0];
  vspread := psp.state.params.MBF21FixedVal[1];
  numbullets := psp.state.params.IntVal[2];
  damagebase := psp.state.params.IntVal[3];
  damagemod := psp.state.params.IntVal[4];

  P_BulletSlope(player.mo);

  for i := 0 to numbullets - 1 do
  begin
    damage := (N_Random mod damagemod + 1) * damagebase;
    angle := player.mo.angle + P_RandomHitscanAngle(hspread);
    slope := bulletslope + P_RandomHitscanSlope(vspread);

    P_LineAttack(player.mo, angle, MISSILERANGE, slope, damage);
  end;
end;

//
// A_WeaponMeleeAttack
// A parameterized player weapon melee attack.
//   args[0]: Base damage of attack (e.g. for 2d10, customize the 2); if not set, defaults to 2
//   args[1]: Attack damage modulus (e.g. for 2d10, customize the 10); if not set, defaults to 10
//   args[2]: Berserk damage multiplier (fixed point); if not set, defaults to 1.0 (no change).
//   args[3]: Sound to play if attack hits
//   args[4]: Range (fixed point); if not set, defaults to player mobj's melee range
//
procedure A_WeaponMeleeAttack(player: Pplayer_t; psp: Ppspdef_t);
var
  damagebase, damagemod, zerkfactor, hitsound, range: integer;
  angle: angle_t;
  t, slope, damage: integer;
begin
  if psp = nil then
    exit;

  if not P_CheckStateArgs(psp.state) then
    exit;

  damagebase := psp.state.params.IntVal[0];
  damagemod := psp.state.params.IntVal[1];
  zerkfactor := psp.state.params.IntVal[2];
  range := psp.state.params.MBF21FixedVal[4];

  if range = 0 then
  begin
    range := player.mo.info.meleerange;
    if range = 0 then
      range := MELEERANGE;
  end;

  damage := (N_Random mod damagemod + 1) * damagebase;
  {$IFDEF DOOM_OR_STRIFE}
  if player.powers[Ord(pw_strength)] > 0 then
  {$ENDIF}
  {$IFDEF HERETIC}
  if player.powers[Ord(pw_weaponlevel2)] > 0 then
  {$ENDIF}
    damage := (damage * zerkfactor) * FRACUNIT;

  // slight randomization; weird vanillaism here. :P
  angle := player.mo.angle;

  t := N_Random;
  angle := angle + _SHL((t - N_Random), 18);

  // make autoaim prefer enemies
  slope := P_AimLineAttack(player.mo, angle, range, MF2_EX_FRIEND);
  if linetarget = nil then
    slope := P_AimLineAttack(player.mo, angle, range);

  // attack, dammit!
  P_LineAttack(player.mo, angle, range, slope, damage);

  // missed? ah, welp.
  if linetarget = nil then
    exit;

  // un-missed!
  if psp.state.params.IsComputed[3] then
    hitsound := psp.state.params.IntVal[3]
  else
  begin
    hitsound := S_GetSoundNumForName(psp.state.params.StrVal[3]);
    psp.state.params.IntVal[3] := hitsound;
  end;

  if hitsound > 0 then
    S_StartSound(player.mo, hitsound);

  // turn to face target
  player.mo.angle := R_PointToAngle2(player.mo.x, player.mo.y, linetarget.x, linetarget.y);
end;

//
// A_WeaponSound
// Plays a sound. Usable from weapons, unlike A_PlaySound
//   args[0]: ID of sound to play
//   args[1]: If 1, play sound at full volume (may be useful in DM?)
//
procedure A_WeaponSound(player: Pplayer_t; psp: Ppspdef_t);
var
  sndid: integer;
  fullsound: boolean;
begin
  if psp = nil then
    exit;

  if not P_CheckStateArgs(psp.state) then
    exit;

  if psp.state.params.IsComputed[0] then
    sndid := psp.state.params.IntVal[0]
  else
  begin
    sndid := S_GetSoundNumForName(psp.state.params.StrVal[0]);
    psp.state.params.IntVal[0] := sndid;
  end;

  if sndid > 0 then
  begin
    fullsound := psp.state.params.IntVal[0] <> 0;
    if fullsound then
      S_StartSound(nil, sndid)
    else
      S_StartSound(player.mo, sndid);
  end;
end;

//
// A_WeaponAlert
// Alerts monsters to the player's presence. Handy when combined with WPF_SILENT.
//
procedure A_WeaponAlert(player: Pplayer_t; psp: Ppspdef_t);
begin
  if psp = nil then
    exit;

  P_NoiseAlert(player.mo, player.mo);
end;

procedure P_SetPspritePtr(player: Pplayer_t; psp: Ppspdef_t; stnum: statenum_t);
var
  position: integer;
begin
  position := pdiff(psp, @player.psprites[0], SizeOf(pspdef_t));
  P_SetPsprite(player, position, stnum);
end;

//
// A_WeaponJump
// Jumps to the specified state, with variable random chance.
// Basically the same as A_RandomJump, but for weapons.
//   args[0]: State number
//   args[1]: Chance, out of 255, to make the jump
//
procedure A_WeaponJump(player: Pplayer_t; psp: Ppspdef_t);
begin
  if psp = nil then
    exit;

  if not P_CheckStateArgs(psp.state) then
    exit;

  if N_Random < psp.state.params.IntVal[1] then
    P_SetPspritePtr(player, psp, statenum_t(psp.state.params.IntVal[0]));
end;

//
// A_ConsumeAmmo
// Subtracts ammo from the player's "inventory". 'Nuff said.
//   args[0]: Amount of ammo to consume. If zero, use the weapon's ammo-per-shot amount.
//
procedure A_ConsumeAmmo(player: Pplayer_t; psp: Ppspdef_t);
var
  amount: integer;
  typ: integer;
  winf: Pweaponinfo_t;
  {$IFDEF HEXEN}
  i, i1, i2: integer;
  {$ENDIF}
begin
  if psp = nil then
    exit;

  if not P_CheckStateArgs(psp.state) then
    exit;

  // don't do dumb things, kids
  {$IFDEF DOOM_OR_STRIFE}
  winf := @weaponinfo[Ord(player.readyweapon)];
  typ := Ord(winf.ammo);
  if typ = Ord(am_noammo) then
	  exit;
  // use the weapon's ammo-per-shot amount if zero.
  // to subtract zero ammo, don't call this function. ;)
  amount := psp.state.params.IntVal[0];
  if amount <= 0 then
    amount := winf.ammopershot;
  {$ENDIF}
  {$IFDEF HERETIC}
  if player.powers[Ord(pw_weaponlevel2)] <> 0 then
    winf := @wpnlev2info[Ord(player.readyweapon)]
  else
    winf := @wpnlev1info[Ord(player.readyweapon)];
  typ := Ord(winf.ammo);
  if typ = Ord(am_noammo) then
	  exit;
  amount := psp.state.params.IntVal[0];
  if amount <= 0 then
  begin
    if (player.powers[Ord(pw_weaponlevel2)] <> 0) and (deathmatch = 0) then
      amount := WeaponAmmoUsePL2[Ord(player.readyweapon)]
    else
      amount := WeaponAmmoUsePL1[Ord(player.readyweapon)];
  end;
  {$ENDIF}
  {$IFDEF HEXEN}
  winf := @weaponinfo[Ord(player.readyweapon), Ord(player._class)];
  typ := Ord(winf.mana);
  if typ = Ord(MANA_NONE) then
	  exit;
  amount := psp.state.params.IntVal[0];
  if amount <= 0 then
    amount := WeaponManaUse[Ord(player._class), Ord(player.readyweapon)];
  {$ENDIF}

  {$IFDEF HEXEN}
  // subtract ammo, but don't let it get below zero
  if (typ = Ord(MANA_1)) or (typ = Ord(MANA_2)) then
  begin
    i1 := typ;
    i2 := typ;
  end
  else if typ = Ord(MANA_BOTH) then
  begin
    i1 := Ord(MANA_1);
    i2 := Ord(MANA_2);
  end
  else
    exit;
  for i := i1 to i2 do
    if player.mana[i] >= amount then
      player.mana[i] := player.mana[i] - amount
    else
      player.mana[i] := 0;
  {$ELSE}
  // subtract ammo, but don't let it get below zero
  if player.ammo[typ] >= amount then
    player.ammo[typ] := player.ammo[typ] - amount
  else
    player.ammo[typ] := 0;
  {$ENDIF}
end;

//
// A_CheckAmmo
// Jumps to a state if the player's ammo is lower than the specified amount.
//   args[0]: State to jump to
//   args[1]: Minimum required ammo to NOT jump. If zero, use the weapon's ammo-per-shot amount.
//
procedure A_CheckAmmo(player: Pplayer_t; psp: Ppspdef_t);
var
  amount: integer;
  typ: integer;
  winf: Pweaponinfo_t;
  {$IFDEF HEXEN}
  i, i1, i2: integer;
  {$ENDIF}
begin
  if psp = nil then
    exit;

  if not P_CheckStateArgs(psp.state) then
    exit;

  {$IFDEF DOOM_OR_STRIFE}
  winf := @weaponinfo[Ord(player.readyweapon)];
  typ := Ord(winf.ammo);
  if typ = Ord(am_noammo) then
	  exit;
  amount := psp.state.params.IntVal[1];
  if amount <= 0 then
    amount := winf.ammopershot;
  {$ENDIF}
  {$IFDEF HERETIC}
  if player.powers[Ord(pw_weaponlevel2)] <> 0 then
    winf := @wpnlev2info[Ord(player.readyweapon)]
  else
    winf := @wpnlev1info[Ord(player.readyweapon)];
  typ := Ord(winf.ammo);
  if typ = Ord(am_noammo) then
	  exit;
  amount := psp.state.params.IntVal[0];
  if amount <= 0 then
  begin
    if (player.powers[Ord(pw_weaponlevel2)] <> 0) and (deathmatch = 0) then
      amount := WeaponAmmoUsePL2[Ord(player.readyweapon)]
    else
      amount := WeaponAmmoUsePL1[Ord(player.readyweapon)];
  end;
  {$ENDIF}
  {$IFDEF HEXEN}
  winf := @weaponinfo[Ord(player.readyweapon), Ord(player._class)];
  typ := Ord(winf.mana);
  if typ = Ord(MANA_NONE) then
	  exit;
  amount := psp.state.params.IntVal[1];
  if amount <= 0 then
    amount := WeaponManaUse[Ord(player._class), Ord(player.readyweapon)];
  {$ENDIF}

  {$IFDEF HEXEN}
  if (typ = Ord(MANA_1)) or (typ = Ord(MANA_2)) then
  begin
    i1 := typ;
    i2 := typ;
  end
  else if typ = Ord(MANA_BOTH) then
  begin
    i1 := Ord(MANA_1);
    i2 := Ord(MANA_2);
  end
  else
    exit;
  for i := i1 to i2 do
    if player.mana[i] < amount then
    begin
      P_SetPspritePtr(player, psp, statenum_t(psp.state.params.IntVal[0]));
      break;
    end;
  {$ELSE}
  if player.ammo[typ] < amount then
    P_SetPspritePtr(player, psp, statenum_t(psp.state.params.IntVal[0]));
  {$ENDIF}
end;

//
// A_RefireTo
// Jumps to a state if the player is holding down the fire button
//   args[0]: State to jump to
//   args[1]: If nonzero, skip the ammo check
//
procedure A_RefireTo(player: Pplayer_t; psp: Ppspdef_t);
begin
  if psp = nil then
    exit;

  if not P_CheckStateArgs(psp.state) then
    exit;

  if ((psp.state.params.IntVal[1] <> 0) or P_CheckAmmo(player)) and
    (player.cmd.buttons and BT_ATTACK <> 0) and
    ((player.pendingweapon = wp_nochange) and (player.health > 0)) then
    P_SetPspritePtr(player, psp, statenum_t(psp.state.params.IntVal[0]));
end;

//
// A_GunFlashTo
// Sets the weapon flash layer to the specified state.
//   args[0]: State number
//   args[1]: If nonzero, don't change the player actor state
//
procedure A_GunFlashTo(player: Pplayer_t; psp: Ppspdef_t);
var
  pstate: integer;
begin
  if psp = nil then
    exit;

  if not P_CheckStateArgs(psp.state) then
    exit;

  if psp.state.params.IntVal[1] <> 0 then
  begin
    {$IFDEF DOOM_OR_HERETIC}
    pstate := Ord(S_PLAY_ATK2);
    {$ENDIF}
    {$IFDEF STRIFE}
    pstate := Ord(S_PLAY_06);
    {$ENDIF}
    {$IFDEF HEXEN}
    pstate := Ord(PStateAttack[Ord(player._class)]);
    {$ENDIF}
    P_SetMobjState(player.mo, statenum_t(pstate));
  end;

  P_SetPsprite(player, Ord(ps_flash), statenum_t(psp.state.params.IntVal[0]));
end;

//
// A_SetProjectileGroup(group: string);
//
procedure A_SetProjectileGroup(actor: Pmobj_t);
var
  group: integer;
begin
  if not P_CheckStateParams(actor, 1) then
    exit;

  group := Info_ProjectileGroupToInt(actor.state.params.StrVal[0]);
  if group <> IG_INVALID then
    actor.projectile_group := group;
end;

//
// A_SetInfightingGroup(group: string);
//
procedure A_SetInfightingGroup(actor: Pmobj_t);
var
  group: integer;
begin
  if not P_CheckStateParams(actor, 1) then
    exit;

  group := Info_InfightingGroupToInt(actor.state.params.StrVal[0]);
  if group <> IG_INVALID then
    actor.infighting_group := group;
end;

//
// A_SetSplashGroup(group: string);
//
procedure A_SetSplashGroup(actor: Pmobj_t);
var
  group: integer;
begin
  if not P_CheckStateParams(actor, 1) then
    exit;

  group := Info_SplashGroupToInt(actor.state.params.StrVal[0]);
  if group <> SG_INVALID then
    actor.splash_group := group;
end;

//
// A_Delayfire(tics: integer)
//
procedure A_Delayfire(player: Pplayer_t; psp: Ppspdef_t);
var
  tics: integer;
  state: Pstate_t;
  p: Pplayer_t;
begin
  if PlayerToId(player) >= 0 then
  begin
    p := player;
    state := psp.state;
  end
  else
  begin
    p := Pmobj_t(player).player;
    state := Pmobj_t(player).state;
  end;

  if p = nil then
    exit;

  if state.params = nil then
    tics := TICRATE
  else if state.params.Count < 1 then
    tics := TICRATE
  else
    tics := state.params.IntVal[0];

  p.nextfire := leveltime + tics;
end;

procedure A_SetTranslation(actor: Pmobj_t);
begin
  if not P_CheckStateArgs(actor.state) then
    exit;

  actor.translationname := actor.state.params.StrVal[0];
  R_InitMobjTranslation(actor);
end;

end.

