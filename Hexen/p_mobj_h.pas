//------------------------------------------------------------------------------
//
//  DelphiHexen is a source port of the game Hexen and it is
//  based on original Linux Doom as published by "id Software", on
//  Hexen source as published by "Raven" software and DelphiDoom
//  as published by Jim Valavanis.
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
// DESCRIPTION:
//  Map Objects, MObj, definition and handling.
//
//------------------------------------------------------------------------------
//  Site  : https://sourceforge.net/projects/delphidoom/
//------------------------------------------------------------------------------

{$I Doom32.inc}

unit p_mobj_h;

interface

uses
  m_fixed,
  info_h,
  doomdata,
  p_params,
  r_renderstyle,
  tables, // angle_t
  d_think; // We need the thinker_t stuff.

//
// NOTES: mobj_t
//
// mobj_ts are used to tell the refresh where to draw an image,
// tell the world simulation when objects are contacted,
// and tell the sound driver how to position a sound.
//
// The refresh uses the next and prev links to follow
// lists of things in sectors as they are being drawn.
// The sprite, frame, and angle elements determine which patch_t
// is used to draw the sprite if it is visible.
// The sprite and frame values are allmost allways set
// from state_t structures.
// The statescr.exe utility generates the states.h and states.c
// files that contain the sprite/frame numbers from the
// statescr.txt source file.
// The xyz origin point represents a point at the bottom middle
// of the sprite (between the feet of a biped).
// This is the default origin position for patch_ts grabbed
// with lumpy.exe.
// A walking creature will have its z equal to the floor
// it is standing on.
//
// The sound code uses the x,y, and subsector fields
// to do stereo positioning of any sound effited by the mobj_t.
//
// The play simulation uses the blocklinks, x,y,z, radius, height
// to determine when mobj_ts are touching each other,
// touching lines in the map, or hit by trace lines (gunshots,
// lines of sight, etc).
// The mobj_t->flags element has various bit flags
// used by the simulation.
//
// Every mobj_t is linked into a single sector
// based on its origin coordinates.
// The subsector_t is found with R_PointInSubsector(x,y),
// and the sector_t can be found with subsector->sector.
// The sector links are only used by the rendering code,
// the play simulation does not care about them at all.
//
// Any mobj_t that needs to be acted upon by something else
// in the play world (block movement, be shot, etc) will also
// need to be linked into the blockmap.
// If the thing has the MF_NOBLOCK flag set, it will not use
// the block links. It can still interact with other things,
// but only as the instigator (missiles will run into other
// things, but nothing can run into a missile).
// Each block in the grid is 128*128 units, and knows about
// every line_t that it contains a piece of, and every
// interactable mobj_t that has its origin contained.
//
// A valid mobj_t is a mobj_t that has the proper subsector_t
// filled in for its xy coordinates and is linked into the
// sector from which the subsector was made, or has the
// MF_NOSECTOR flag set (the subsector_t needs to be valid
// even if MF_NOSECTOR is set), and is linked into a blockmap
// block or has the MF_NOBLOCKMAP flag set.
// Links should only be modified by the P_[Un]SetThingPosition()
// functions.
// Do not change the MF_NO? flags while a thing is valid.
//
// Any questions?
//

//
// Misc. mobj flags
//

const
  // Call P_SpecialThing when touched.
  MF_SPECIAL = 1;
  // Blocks.
  MF_SOLID = 2;
  // Can be hit.
  MF_SHOOTABLE = 4;
  // Don't use the sector links (invisible but touchable).
  MF_NOSECTOR = 8;
  // Don't use the blocklinks (inert but displayable)
  MF_NOBLOCKMAP = 16;

  // Not to be activated by sound, deaf monster.
  MF_AMBUSH = 32;
  // Will try to attack right back.
  MF_JUSTHIT = 64;
  // Will take at least one step before attacking.
  MF_JUSTATTACKED = 128;
  // On level spawning (initial position),
  //  hang from ceiling instead of stand on floor.
  MF_SPAWNCEILING = 256;
  // Don't apply gravity (every tic),
  //  that is, object will float, keeping current height
  //  or changing it actively.
  MF_NOGRAVITY = 512;

  // Movement flags.
  // This allows jumps from high places.
  MF_DROPOFF = $400;
  // For players, will pick up items.
  MF_PICKUP = $800;
  // Player cheat. ???
  MF_NOCLIP = $1000;
  // Player: keep info about sliding along walls.
  MF_SLIDEONWALLS = $2000;
  // Allow moves to any height, no gravity.
  // For active floaters, e.g. cacodemons, pain elementals.
  MF_FLOAT = $4000;
  // Don't cross lines
  //   ??? or look at heights on teleport.
  MF_TELEPORT = $8000;
  // Don't hit same species, explode on block.
  // Player missiles as well as fireballs of various kinds.
  MF_MISSILE = $10000;
  // alternate fuzzy draw
  MF_ALTSHADOW = $20000;
  // Use fuzzy draw (shadow demons or spectres),
  //  temporary player invisibility powerup.
  MF_SHADOW = $40000;
  // Flag: don't bleed when shot (use puff),
  //  barrels and shootable furniture shall not bleed.
  MF_NOBLOOD = $80000;
  // Don't stop moving halfway off a step,
  //  that is, have dead bodies slide down all the way.
  MF_CORPSE = $100000;
  // Floating to a height for a move, ???
  //  don't auto float to target's height.
  MF_INFLOAT = $200000;

  // On kill, count this enemy object
  //  towards intermission kill total.
  // Happy gathering.
  MF_COUNTKILL = $400000;

  // A frozen corpse (for blasting)
  MF_ICECORPSE = $800000;

  // Special handling: skull in flight.
  // Neither a cacodemon nor a missile.
  MF_SKULLFLY = $1000000;

  // Don't spawn this object
  //  in death match mode (e.g. key cards).
  MF_NOTDMATCH = $2000000;

  // Player sprites in multiplayer modes are modified
  //  using an internal color lookup table for re-indexing.
  // If 0x4 0x8 or 0xc,
  //  use a translation table for player colormaps
  MF_TRANSLATION = $1c000000;
  // Hmm ???.
  MF_TRANSSHIFT = 26;

const
  MF2_LOGRAV = $00000001;           // alternate gravity setting

  MF2_WINDTHRUST = $00000002;       // gets pushed around by the wind
                                    // specials

  MF2_FLOORBOUNCE = $00000004;      // bounces off the floor

  MF2_BLASTED = $00000008;          // missile will pass through ghosts

  MF2_FLY = $00000010;              // fly mode is active

  MF2_FLOORCLIP = $00000020;        // if feet are allowed to be clipped

  MF2_SPAWNFLOAT = $00000040;       // spawn random float z

  MF2_NOTELEPORT = $00000080;       // does not teleport

  MF2_RIP = $00000100;              // missile rips through solid
                                    // targets

  MF2_PUSHABLE = $00000200;         // can be pushed by other moving
                                    // mobjs

  MF2_SLIDE = $00000400;            // slides against walls

  MF2_ONMOBJ = $00000800;           // mobj is resting on top of another
                                    // mobj

  MF2_PASSMOBJ = $00001000;         // Enable z block checking.  If on,
                                    // this flag will allow the mobj to
                                    // pass over/under other mobjs.

  MF2_CANNOTPUSH = $00002000;       // cannot push other pushable mobjs

  MF2_DROPPED = $00004000;          // a mobj's feet are now being cut

  MF2_BOSS = $00008000;             // mobj is a major boss

  MF2_FIREDAMAGE = $00010000;       // does fire damage

  MF2_NODMGTHRUST = $00020000;      // does not thrust target when
                                    // damaging

  MF2_TELESTOMP = $00040000;        // mobj can stomp another

  MF2_FLOATBOB = $00080000;         // use float bobbing z movement

  MF2_DONTDRAW = $00100000;         // don't generate a vissprite

  MF2_IMPACT = $00200000;            // an MF_MISSILE mobj can activate
                                     // SPAC_IMPACT

  MF2_PUSHWALL = $00400000;          // mobj can push walls

  MF2_MCROSS = $00800000;           // can activate monster cross lines

  MF2_PCROSS = $01000000;           // can activate projectile cross lines

  MF2_CANTLEAVEFLOORPIC = $02000000;// stay within a certain floor type

  MF2_NONSHOOTABLE = $04000000;     // mobj is totally non-shootable,
                                    // but still considered solid

  MF2_INVULNERABLE = $08000000;     // mobj is invulnerable

  MF2_DORMANT = $10000000;          // thing is dormant

  MF2_ICEDAMAGE = $20000000;        // does ice damage

  MF2_SEEKERMISSILE = $40000000;    // is a seeker (for reflection)

const
  // Sprite is transparent
  MF_EX_TRANSPARENT = 1;
  // Sprite emits white light
  MF_EX_WHITELIGHT = 2;
  // Sprite emits red light
  MF_EX_REDLIGHT = 4;
  // Sprite emits green light
  MF_EX_GREENLIGHT = 8;
  // Sprite emits blue light
  MF_EX_BLUELIGHT = $10;
  // Sprite emits yellow light
  MF_EX_YELLOWLIGHT = $20;
  // Compination of above flags
  MF_EX_LIGHT = MF_EX_WHITELIGHT or MF_EX_REDLIGHT or MF_EX_GREENLIGHT or MF_EX_BLUELIGHT or MF_EX_YELLOWLIGHT;
  MF_EX_STATE_MASK = MF_EX_LIGHT or MF_EX_TRANSPARENT;

  // State flags
  MF_EX_STATE_RANDOM_SELECT = $40;
  MF_EX_STATE_RANDOM_RANGE = $80;
  MF_EX_STATE_PARAMS_ERROR = $100;
  MF_EX_STATE_ARGS_CHECKED = $200;
  MF_EX_STATE_ARGS_ERROR = $400;

  // Float BOB
  MF_EX_FLOATBOB = $40;
  // No Radius Damage
  MF_EX_NORADIUSDMG = $80;
  // Half the damage
  MF_EX_FIRERESIST = $100;
  // Random see sound
  MF_EX_RANDOMSEESOUND = $200;
  // Random pain sound
  MF_EX_RANDOMPAINSOUND = $400;
  // Random attack sound
  MF_EX_RANDOMATTACKSOUND = $800;
  // Random death sound
  MF_EX_RANDOMDEATHSOUND = $1000;
  // Random active sound
  MF_EX_RANDOMACTIVESOUND = $2000;
  // Random customsound1
  MF_EX_RANDOMCUSTOMSOUND1 = $4000;
  // Random customsound2
  MF_EX_RANDOMCUSTOMSOUND2 = $8000;
  // Random customsound3
  MF_EX_RANDOMCUSTOMSOUND3 = $10000;
  // Custom Explosion (see A_Explode)
  MF_EX_CUSTOMEXPLODE = $20000;
  // The think is boss
  MF_EX_BOSS = $40000;
  // Missile stays on floor
  MF_EX_FLOORHUGGER = $80000;
  // Missile stays on ceiling
  MF_EX_CEILINGHUGGER = $100000;
  // Missile is a seeker
  MF_EX_SEEKERMISSILE = $200000;
  // Mobj spawn on random float z
  MF_EX_SPAWNFLOAT = $400000;
  // Don't hurt one's own kind with explosions
  MF_EX_DONTHURTSPECIES = $800000;
  // Low gravity
  MF_EX_LOWGRAVITY = $1000000;
  // Invulnerable
  MF_EX_INVULNERABLE = $2000000;
  // Random meleesound
  MF_EX_RANDOMMELEESOUND = $4000000;
  // Don't remove missile
  MF_EX_DONOTREMOVE = $8000000;
  // Thing is a ghost
  MF_EX_GHOST = $10000000;
  // Pass thru ghosts
  MF_EX_THRUGHOST = $20000000;
  // Monster can look all around, has eyes in the back
  MF_EX_LOOKALLAROUND = $40000000;

const
  // Medium gravity
  MF2_EX_MEDIUMGRAVITY = 1;
  // reflects missiles
  MF2_EX_REFLECTIVE = 2;
  // Monster walks away
  MF2_EX_FRIGHTENED = 4;
  // No Damage
  MF2_EX_NODAMAGE = 8;
  // Do not run scripts
  MF2_EX_DONTRUNSCRIPTS = $10;
  // Use precise spawnangle
  MF2_EX_PRECISESPAWNANGLE = $20;
  // Use custom dropitem
  MF2_EX_CUSTOMDROPITEM = $40;
  // From zDoom wiki:
  // Actors with this flag set will often (about 92% chance) decide to jump down
  // tall ledges to pursue their target, if said target is hostile
  MF2_EX_JUMPDOWN = $80;
  // Sound at full volume
  MF2_EX_FULLVOLACTIVE = $100;
  MF2_EX_FULLVOLDEATH = $200;
  MF2_EX_FULLVOLSEE = $400;
  MF2_EX_FULLVOLPAIN = $800;
  MF2_EX_FULLVOLATTACK = $1000;
  // Do not render shadow
  MF2_EX_DONOTRENDERSHADOW = $2000;
  // See invisible
  MF2_EX_SEEINVISIBLE = $4000;
  // Missile hurts same species
  MF2_EX_MISSILEHURTSPECIES = $8000;
  // No P_HitFloor call
  MF2_EX_NOHITFLOOR = $10000;
  // Actor can jump up
  MF2_EX_JUMPUP = $20000;
  // Does not block player
  MF2_EX_DONTBLOCKPLAYER = $40000;
  // Interactive mobj - can be set to interactstate
  MF2_EX_INTERACTIVE = $80000;
  // Just appeared
  MF2_EX_JUSTAPPEARED = $100000;
  // Don't return fire
  MF2_EX_DONTINFIGHTMONSTERS = $200000;
  // Friendly monsters
  MF2_EX_FRIEND = $400000;

const
  // Bounce on floor
  MF3_EX_FLOORBOUNCE = 1;
  // Bounce on ceiling
  MF3_EX_CEILINGBOUNCE = 2;
  // Bounce on walls
  MF3_EX_WALLBOUNCE = 4;
  // All bounce flags
  MF3_EX_BOUNCE = MF3_EX_FLOORBOUNCE or MF3_EX_CEILINGBOUNCE or MF3_EX_WALLBOUNCE;
  // No max move
  MF3_EX_NOMAXMOVE = 8;
  // No Crush
  MF3_EX_NOCRUSH = 16;
  // No render interpolation
  MF3_EX_NORENDERINTERPOLATION = 32;
  // Line Activate (MBF)
  MF3_EX_LINEDONE = 64;
  // Flip sprite
  MF3_EX_FLIPSPRITE = 128;
  // Half distance to missile
  MF3_EX_MISSILEMORE = $100;
  // 1/8th distance to missile
  MF3_EX_MISSILEEVENMORE = $200;
  // Missiles use alternate damage (Strife)
  MF3_EX_STRIFEDAMAGE = $400;
  // Continue on freeze console command
  MF3_EX_NOTIMEFREEZE = $800;
  // Not scared of frightening
  MF3_EX_NOFEAR = $1000;
  // Cause fear if targeted
  MF3_EX_CAUSEFEAR = $2000;
  // No actor collision
  MF3_EX_THRUACTORS = $4000;
  // No collision with same species (also inheritance)
  MF3_EX_THRUSPECIES = $8000;
  //  Can cross ML_BLOCKMONSTERS lines
  MF3_EX_NOBLOCKMONST = $10000;
  // Do not subject actor to player autoaim
  MF3_EX_NOTAUTOAIMED = $20000;
  // slide against walls alias
  MF3_EX_SLIDING = $40000;
  // Missiles use absolute damage
  MF3_EX_ABSOLUTEDAMAGE = $80000;
  // Do not fall to ground on death
  MF3_EX_NOGRAVITYDEATH = $100000;
  // Missile causes freeze damage
  MF3_EX_FREEZEDAMAGE = $200000;
  // Actor is not hurt by freeze damage missile
  MF3_EX_NOFREEZEDAMAGE = $400000;
  // Actor is hurt less by freeze damage missile
  MF3_EX_FREEZEDAMAGERESIST = $800000;
  // Missile causes flame damage
  MF3_EX_FLAMEDAMAGE = $1000000;
  // Actor is not hurt by flame damage missile
  MF3_EX_NOFLAMEDAMAGE = $2000000;

const
  // Actor is hurt less by flame damage missile
  MF4_EX_FLAMEDAMAGERESIST = 1;
  // No monster collision
  MF4_EX_THRUMONSTERS = 2;
  // Drop item in actual z
  MF4_EX_ABSOLUTEDROPITEMPOS = 4;
  // Can not step up
  MF4_EX_CANNOTSTEP = 8;
  // Can not drop off
  MF4_EX_CANNOTDROPOFF = $10;
  // Force radius damage
  MF4_EX_FORCERADIUSDMG = $20;
  // short missile range (14 * 64)
  MF4_EX_SHORTMRANGE = $40;
  // other things ignore its attacks
  MF4_EX_DMGIGNORED = $80;
  // higher missile attack probability
  MF4_EX_HIGHERMPROB = $100;
  // use half distance for missile attack probability
  MF4_EX_RANGEHALF = $200;
  // no targeting threshold
  MF4_EX_NOTHRESHOLD = $400;
  // long melee range
  MF4_EX_LONGMELEERANGE = $800;
  // Follow trace
  MF4_EX_TRACEDEFINED = $1000;
  // Tag 666 "boss" on map 7
  MF4_EX_MAP07BOSS1 = $2000;
  // Tag 667 "boss" on map 7
  MF4_EX_MAP07BOSS2 = $4000;
  // Tag 666 or 667 "boss" on map 7
  MF4_EX_MAP07BOSS = MF4_EX_MAP07BOSS1 or MF4_EX_MAP07BOSS2;
  // Self applying lighmap
  MF4_EX_SELFAPPLYINGLIGHT = $8000;
  // Full volume rip sound
  MF4_EX_FULLVOLRIP = $10000;
  // Random rip sound
  MF4_EX_RANDOMRIPSOUND = $20000;
  // Ignore full_sounds console variable and always finishes sounds
  MF4_EX_ALWAYSFINISHSOUND = $40000;
  // Ignore full_sounds console variable and never finishes sounds
  MF4_EX_NEVERFINISHSOUND = $80000;
  // Do not gib
  MF4_EX_DONTGIB = $100000;
  // Backing in melee attack
  MF4_EX_BACKINGMELEE = $200000;

type
// Map Object definition.
  Pmobj_t = ^mobj_t;
  mobj_t = record
    // List: thinker links.
    thinker: thinker_t;

    // Info for drawing: position.
    x: fixed_t;
    y: fixed_t;
    z: fixed_t;

    // More list: links in sector (if needed)
    snext: Pmobj_t;
    sprev: Pmobj_t;

    //More drawing info: to determine current sprite.
    angle: angle_t;     // orientation
    viewangle: angle_t; // JVAL Turn head direction
    sprite: integer;// used to find patch_t and flip value
    frame: integer; // might be ORed with FF_FULLBRIGHT

    // Interaction info, by BLOCKMAP.
    // Links in blocks (if needed).
    bnext: Pmobj_t;
    bprev: Pmobj_t;
    bpos: integer;
    bidx: integer;

    subsector: pointer; //Psubsector_t;

    // The closest interval over all contacted Sectors.
    floorz: fixed_t;
    ceilingz: fixed_t;
    floorpic: integer;  // contacted sec floorpic

    // For movement checking.
    radius: fixed_t;
    height: fixed_t;

    // Momentums, used to update position.
    momx: fixed_t;
    momy: fixed_t;
    momz: fixed_t;

    // If == validcount, already checked.
    validcount: integer;

    _type: integer;
    info: Pmobjinfo_t; // @mobjinfo[mobj.type]

    tics: integer; // state tic counter
    state: Pstate_t;
    damage: integer;
    flags: integer;
    flags2: integer;
    flags_ex: integer;    // JVAL extended flags (MF_EX_????)
    flags2_ex: integer;   // JVAL extended flags (MF2_EX_????)
    special1: integer;
    special2: integer;
    renderstyle: mobjrenderstyle_t;
    alpha: fixed_t;
    bob: integer;

    health: integer;

    // Movement direction, movement generation (zig-zagging).
    movedir: integer;   // 0-7
    movecount: integer; // when 0, select a new dir

    // Thing being chased/attacked (or NULL),
    // also the originator for missiles.
    target: Pmobj_t;

    // Reaction time: if non 0, don't attack yet.
    // Used by player to freeze a bit after teleporting.
    reactiontime: integer;

    // If >0, the target will be chased
    // no matter what (even if shot)
    threshold: integer;

    // Additional info record for player avatars only.
    // Only valid if type == MT_PLAYER
    player: pointer;  // Pplayer_t;

    // Player number last looked for.
    lastlook: integer;

    // For nightmare respawn.
    spawnpoint: mapthing_t;

    // Thing being chased/attacked for tracers.
    tracer: Pmobj_t;

    fastchasetics: integer;

    archiveNum: integer;  // Identity during archive
    tid: integer;      // thing identifier
    special: byte;    // special
    args: array[0..4] of byte;  // special arguments
    floorclip: fixed_t;

    // JVAL: Interpolation
    prevx: fixed_t;
    prevy: fixed_t;
    prevz: fixed_t;
    prevangle: angle_t;

    nextx: fixed_t;
    nexty: fixed_t;
    nextz: fixed_t;
    nextangle: angle_t;

    intrplcnt: LongWord;

    key: LongWord;

    // JVAL: User defined parameters (eg custom Inventory)
    customparams: Pmobjcustomparam_t;

    dropitem: integer;

    // version 205
    lightvalidcount: integer;
    scale: integer;
    pushfactor: integer;
    gravity: integer;
    flags3_ex: integer;  // JVAL extended flags (MF3_EX_????)
    flags4_ex: integer;  // JVAL extended flags (MF4_EX_????)
    rendervalidcount: integer;

    // version 206
    mass: integer;
    master: Pmobj_t;
    WeaveIndexXY: integer;
    WeaveIndexZ: integer;
    friction: integer;

    // version 207
    painchance: integer;
    spriteDX: integer;
    spriteDY: integer;
    flags5_ex: integer;  // JVAL extended flags (MF5_EX_????)
    flags6_ex: integer;  // JVAL extended flags (MF6_EX_????)
    playerfollowtime: integer;      // JVAL 20211224 - Dogs follow player
    tracefollowtimestamp: integer;  // JVAL 20211224 - Dogs follow player
    tracex: integer;
    tracey: integer;
    tracez: integer;
    // mbf21+
    infighting_group: integer;
    projectile_group: integer;
    splash_group: integer;
    strafecount: integer;
    bloodcolor: integer;
    translationname: string[8];
    translationtable: Pointer;
  end;
  Tmobj_tPArray = array[0..$FFFF] of Pmobj_t;
  Pmobj_tPArray = ^Tmobj_tPArray;

  Pmobj_t140 = ^mobj_t140;
  mobj_t140 = record
    // List: thinker links.
    thinker: thinker_t;

    // Info for drawing: position.
    x: fixed_t;
    y: fixed_t;
    z: fixed_t;

    // More list: links in sector (if needed)
    snext: Pmobj_t;
    sprev: Pmobj_t;

    //More drawing info: to determine current sprite.
    angle: angle_t;     // orientation
    viewangle: angle_t; // JVAL Turn head direction
    sprite: integer;    // used to find patch_t and flip value
    frame: integer;     // might be ORed with FF_FULLBRIGHT

    // Interaction info, by BLOCKMAP.
    // Links in blocks (if needed).
    bnext: Pmobj_t;
    bprev: Pmobj_t;
    bpos: integer;
    bidx: integer;

    subsector: pointer; // Psubsector_t;

    // The closest interval over all contacted Sectors.
    floorz: fixed_t;
    ceilingz: fixed_t;
    floorpic: integer;  // contacted sec floorpic

    // For movement checking.
    radius: fixed_t;
    height: fixed_t;

    // Momentums, used to update position.
    momx: fixed_t;
    momy: fixed_t;
    momz: fixed_t;

    // If == validcount, already checked.
    validcount: integer;

    _type: integer;
    info: Pmobjinfo_t; // @mobjinfo[mobj.type]

    tics: integer; // state tic counter
    state: Pstate_t;
    damage: integer;
    flags: integer;
    flags2: integer;
    flags_ex: integer;    // JVAL extended flags (MF_EX_????)
    flags2_ex: integer;   // JVAL extended flags (MF2_EX_????)
    special1: integer;
    special2: integer;
    renderstyle: mobjrenderstyle_t;
    alpha: fixed_t;
    bob: integer;

    health: integer;

    // Movement direction, movement generation (zig-zagging).
    movedir: integer; // 0-7
    movecount: integer; // when 0, select a new dir

    // Thing being chased/attacked (or NULL),
    // also the originator for missiles.
    target: Pmobj_t;

    // Reaction time: if non 0, don't attack yet.
    // Used by player to freeze a bit after teleporting.
    reactiontime: integer;

    // If >0, the target will be chased
    // no matter what (even if shot)
    threshold: integer;

    // Additional info record for player avatars only.
    // Only valid if type == MT_PLAYER
    player: pointer; //Pplayer_t;

    // Player number last looked for.
    lastlook: integer;

    // For nightmare respawn.
    spawnpoint: mapthing_t;

    // Thing being chased/attacked for tracers.
    tracer: Pmobj_t;

    fastchasetics: integer;

    archiveNum: integer;  // Identity during archive
    tid: integer;      // thing identifier
    special: byte;    // special
    args: array[0..4] of byte;  // special arguments
    floorclip: fixed_t;
  end;

  Pmobj_t141 = ^mobj_t141;
  mobj_t141 = record
    // List: thinker links.
    thinker: thinker_t;

    // Info for drawing: position.
    x: fixed_t;
    y: fixed_t;
    z: fixed_t;

    // More list: links in sector (if needed)
    snext: Pmobj_t;
    sprev: Pmobj_t;

    //More drawing info: to determine current sprite.
    angle: angle_t;     // orientation
    viewangle: angle_t; // JVAL Turn head direction
    sprite: integer;    // used to find patch_t and flip value
    frame: integer;     // might be ORed with FF_FULLBRIGHT

    // Interaction info, by BLOCKMAP.
    // Links in blocks (if needed).
    bnext: Pmobj_t;
    bprev: Pmobj_t;
    bpos: integer;
    bidx: integer;

    subsector: pointer; // Psubsector_t;

    // The closest interval over all contacted Sectors.
    floorz: fixed_t;
    ceilingz: fixed_t;
    floorpic: integer;  // contacted sec floorpic

    // For movement checking.
    radius: fixed_t;
    height: fixed_t;

    // Momentums, used to update position.
    momx: fixed_t;
    momy: fixed_t;
    momz: fixed_t;

    // If == validcount, already checked.
    validcount: integer;

    _type: integer;
    info: Pmobjinfo_t; // @mobjinfo[mobj.type]

    tics: integer; // state tic counter
    state: Pstate_t;
    damage: integer;
    flags: integer;
    flags2: integer;
    flags_ex: integer;    // JVAL extended flags (MF_EX_????)
    flags2_ex: integer;   // JVAL extended flags (MF2_EX_????)
    special1: integer;
    special2: integer;
    renderstyle: mobjrenderstyle_t;
    alpha: fixed_t;
    bob: integer;

    health: integer;

    // Movement direction, movement generation (zig-zagging).
    movedir: integer; // 0-7
    movecount: integer; // when 0, select a new dir

    // Thing being chased/attacked (or NULL),
    // also the originator for missiles.
    target: Pmobj_t;

    // Reaction time: if non 0, don't attack yet.
    // Used by player to freeze a bit after teleporting.
    reactiontime: integer;

    // If >0, the target will be chased
    // no matter what (even if shot)
    threshold: integer;

    // Additional info record for player avatars only.
    // Only valid if type == MT_PLAYER
    player: pointer; //Pplayer_t;

    // Player number last looked for.
    lastlook: integer;

    // For nightmare respawn.
    spawnpoint: mapthing_t;

    // Thing being chased/attacked for tracers.
    tracer: Pmobj_t;

    fastchasetics: integer;

    archiveNum: integer;  // Identity during archive
    tid: integer;      // thing identifier
    special: byte;    // special
    args: array[0..4] of byte;  // special arguments
    floorclip: fixed_t;

    // JVAL: Interpolation
    prevx: fixed_t;
    prevy: fixed_t;
    prevz: fixed_t;
    prevangle: angle_t;

    nextx: fixed_t;
    nexty: fixed_t;
    nextz: fixed_t;
    nextangle: angle_t;

    intrplcnt: LongWord;

    key: LongWord;

    // JVAL: User defined parameters (eg custom Inventory)
    customparams: Pmobjcustomparam_t;

  end;

  Pmobj_t204 = ^mobj_t204;
  mobj_t204 = record
    // List: thinker links.
    thinker: thinker_t;

    // Info for drawing: position.
    x: fixed_t;
    y: fixed_t;
    z: fixed_t;

    // More list: links in sector (if needed)
    snext: Pmobj_t;
    sprev: Pmobj_t;

    //More drawing info: to determine current sprite.
    angle: angle_t;     // orientation
    viewangle: angle_t; // JVAL Turn head direction
    sprite: integer;    // used to find patch_t and flip value
    frame: integer;     // might be ORed with FF_FULLBRIGHT

    // Interaction info, by BLOCKMAP.
    // Links in blocks (if needed).
    bnext: Pmobj_t;
    bprev: Pmobj_t;
    bpos: integer;
    bidx: integer;

    subsector: pointer; // Psubsector_t;

    // The closest interval over all contacted Sectors.
    floorz: fixed_t;
    ceilingz: fixed_t;
    floorpic: integer;  // contacted sec floorpic

    // For movement checking.
    radius: fixed_t;
    height: fixed_t;

    // Momentums, used to update position.
    momx: fixed_t;
    momy: fixed_t;
    momz: fixed_t;

    // If == validcount, already checked.
    validcount: integer;

    _type: integer;
    info: Pmobjinfo_t; // @mobjinfo[mobj.type]

    tics: integer; // state tic counter
    state: Pstate_t;
    damage: integer;
    flags: integer;
    flags2: integer;
    flags_ex: integer;    // JVAL extended flags (MF_EX_????)
    flags2_ex: integer;   // JVAL extended flags (MF2_EX_????)
    special1: integer;
    special2: integer;
    renderstyle: mobjrenderstyle_t;
    alpha: fixed_t;
    bob: integer;

    health: integer;

    // Movement direction, movement generation (zig-zagging).
    movedir: integer; // 0-7
    movecount: integer; // when 0, select a new dir

    // Thing being chased/attacked (or NULL),
    // also the originator for missiles.
    target: Pmobj_t;

    // Reaction time: if non 0, don't attack yet.
    // Used by player to freeze a bit after teleporting.
    reactiontime: integer;

    // If >0, the target will be chased
    // no matter what (even if shot)
    threshold: integer;

    // Additional info record for player avatars only.
    // Only valid if type == MT_PLAYER
    player: pointer; //Pplayer_t;

    // Player number last looked for.
    lastlook: integer;

    // For nightmare respawn.
    spawnpoint: mapthing_t;

    // Thing being chased/attacked for tracers.
    tracer: Pmobj_t;

    fastchasetics: integer;

    archiveNum: integer;  // Identity during archive
    tid: integer;      // thing identifier
    special: byte;    // special
    args: array[0..4] of byte;  // special arguments
    floorclip: fixed_t;

    // JVAL: Interpolation
    prevx: fixed_t;
    prevy: fixed_t;
    prevz: fixed_t;
    prevangle: angle_t;

    nextx: fixed_t;
    nexty: fixed_t;
    nextz: fixed_t;
    nextangle: angle_t;

    intrplcnt: LongWord;

    key: LongWord;

    // JVAL: User defined parameters (eg custom Inventory)
    customparams: Pmobjcustomparam_t;

    dropitem: integer;

  end;

  Pmobj_t205 = ^mobj_t205;
  mobj_t205 = record
    // List: thinker links.
    thinker: thinker_t;

    // Info for drawing: position.
    x: fixed_t;
    y: fixed_t;
    z: fixed_t;

    // More list: links in sector (if needed)
    snext: Pmobj_t;
    sprev: Pmobj_t;

    //More drawing info: to determine current sprite.
    angle: angle_t;     // orientation
    viewangle: angle_t; // JVAL Turn head direction
    sprite: integer;// used to find patch_t and flip value
    frame: integer; // might be ORed with FF_FULLBRIGHT

    // Interaction info, by BLOCKMAP.
    // Links in blocks (if needed).
    bnext: Pmobj_t;
    bprev: Pmobj_t;
    bpos: integer;
    bidx: integer;

    subsector: pointer; //Psubsector_t;

    // The closest interval over all contacted Sectors.
    floorz: fixed_t;
    ceilingz: fixed_t;
    floorpic: integer;  // contacted sec floorpic

    // For movement checking.
    radius: fixed_t;
    height: fixed_t;

    // Momentums, used to update position.
    momx: fixed_t;
    momy: fixed_t;
    momz: fixed_t;

    // If == validcount, already checked.
    validcount: integer;

    _type: integer;
    info: Pmobjinfo_t; // @mobjinfo[mobj.type]

    tics: integer; // state tic counter
    state: Pstate_t;
    damage: integer;
    flags: integer;
    flags2: integer;
    flags_ex: integer;    // JVAL extended flags (MF_EX_????)
    flags2_ex: integer;   // JVAL extended flags (MF2_EX_????)
    special1: integer;
    special2: integer;
    renderstyle: mobjrenderstyle_t;
    alpha: fixed_t;
    bob: integer;

    health: integer;

    // Movement direction, movement generation (zig-zagging).
    movedir: integer;   // 0-7
    movecount: integer; // when 0, select a new dir

    // Thing being chased/attacked (or NULL),
    // also the originator for missiles.
    target: Pmobj_t;

    // Reaction time: if non 0, don't attack yet.
    // Used by player to freeze a bit after teleporting.
    reactiontime: integer;

    // If >0, the target will be chased
    // no matter what (even if shot)
    threshold: integer;

    // Additional info record for player avatars only.
    // Only valid if type == MT_PLAYER
    player: pointer;  // Pplayer_t;

    // Player number last looked for.
    lastlook: integer;

    // For nightmare respawn.
    spawnpoint: mapthing_t;

    // Thing being chased/attacked for tracers.
    tracer: Pmobj_t;

    fastchasetics: integer;

    archiveNum: integer;  // Identity during archive
    tid: integer;      // thing identifier
    special: byte;    // special
    args: array[0..4] of byte;  // special arguments
    floorclip: fixed_t;

    // JVAL: Interpolation
    prevx: fixed_t;
    prevy: fixed_t;
    prevz: fixed_t;
    prevangle: angle_t;

    nextx: fixed_t;
    nexty: fixed_t;
    nextz: fixed_t;
    nextangle: angle_t;

    intrplcnt: LongWord;

    key: LongWord;

    // JVAL: User defined parameters (eg custom Inventory)
    customparams: Pmobjcustomparam_t;

    dropitem: integer;

    // version 205
    lightvalidcount: integer;
    scale: integer;
    pushfactor: integer;
    gravity: integer;
    flags3_ex: integer;  // JVAL extended flags (MF3_EX_????)
    flags4_ex: integer;  // JVAL extended flags (MF4_EX_????)
    rendervalidcount: integer;
  end;

  Pmobj_t206 = ^mobj_t206;
  mobj_t206 = record
    // List: thinker links.
    thinker: thinker_t;

    // Info for drawing: position.
    x: fixed_t;
    y: fixed_t;
    z: fixed_t;

    // More list: links in sector (if needed)
    snext: Pmobj_t;
    sprev: Pmobj_t;

    //More drawing info: to determine current sprite.
    angle: angle_t;     // orientation
    viewangle: angle_t; // JVAL Turn head direction
    sprite: integer;// used to find patch_t and flip value
    frame: integer; // might be ORed with FF_FULLBRIGHT

    // Interaction info, by BLOCKMAP.
    // Links in blocks (if needed).
    bnext: Pmobj_t;
    bprev: Pmobj_t;
    bpos: integer;
    bidx: integer;

    subsector: pointer; //Psubsector_t;

    // The closest interval over all contacted Sectors.
    floorz: fixed_t;
    ceilingz: fixed_t;
    floorpic: integer;  // contacted sec floorpic

    // For movement checking.
    radius: fixed_t;
    height: fixed_t;

    // Momentums, used to update position.
    momx: fixed_t;
    momy: fixed_t;
    momz: fixed_t;

    // If == validcount, already checked.
    validcount: integer;

    _type: integer;
    info: Pmobjinfo_t; // @mobjinfo[mobj.type]

    tics: integer; // state tic counter
    state: Pstate_t;
    damage: integer;
    flags: integer;
    flags2: integer;
    flags_ex: integer;    // JVAL extended flags (MF_EX_????)
    flags2_ex: integer;   // JVAL extended flags (MF2_EX_????)
    special1: integer;
    special2: integer;
    renderstyle: mobjrenderstyle_t;
    alpha: fixed_t;
    bob: integer;

    health: integer;

    // Movement direction, movement generation (zig-zagging).
    movedir: integer;   // 0-7
    movecount: integer; // when 0, select a new dir

    // Thing being chased/attacked (or NULL),
    // also the originator for missiles.
    target: Pmobj_t;

    // Reaction time: if non 0, don't attack yet.
    // Used by player to freeze a bit after teleporting.
    reactiontime: integer;

    // If >0, the target will be chased
    // no matter what (even if shot)
    threshold: integer;

    // Additional info record for player avatars only.
    // Only valid if type == MT_PLAYER
    player: pointer;  // Pplayer_t;

    // Player number last looked for.
    lastlook: integer;

    // For nightmare respawn.
    spawnpoint: mapthing_t;

    // Thing being chased/attacked for tracers.
    tracer: Pmobj_t;

    fastchasetics: integer;

    archiveNum: integer;  // Identity during archive
    tid: integer;      // thing identifier
    special: byte;    // special
    args: array[0..4] of byte;  // special arguments
    floorclip: fixed_t;

    // JVAL: Interpolation
    prevx: fixed_t;
    prevy: fixed_t;
    prevz: fixed_t;
    prevangle: angle_t;

    nextx: fixed_t;
    nexty: fixed_t;
    nextz: fixed_t;
    nextangle: angle_t;

    intrplcnt: LongWord;

    key: LongWord;

    // JVAL: User defined parameters (eg custom Inventory)
    customparams: Pmobjcustomparam_t;

    dropitem: integer;

    // version 205
    lightvalidcount: integer;
    scale: integer;
    pushfactor: integer;
    gravity: integer;
    flags3_ex: integer;  // JVAL extended flags (MF3_EX_????)
    flags4_ex: integer;  // JVAL extended flags (MF4_EX_????)
    rendervalidcount: integer;

    // version 206
    mass: integer;
    master: Pmobj_t;
    WeaveIndexXY: integer;
    WeaveIndexZ: integer;
    friction: integer;
  end;

var
  spawnrandommonsters: boolean = false;

implementation

end.

