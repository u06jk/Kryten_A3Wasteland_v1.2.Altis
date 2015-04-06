/*
position,
radius,
milGroup,
weapon, 1-Mk18, 2=MXM
antiTank,
antiAir
*/

if (!isServer)exitWith{};

private ["_position","_radius","_milGroup","_validPos","_dir","_range","_pos","_unit","_weapon","_antiTank","_antiAir"];

_position = _this select 0;
_radius = _this select 1;
_milGroup = _this select 2;
_weapon = _this select 3;
_antiTank = _this select 4;
_antiAir = _this select 5;

_validPos = false;
while {!_validPos} do {
	_dir = random 360;
	_range = random _radius;
	_pos = [(_position select 0) + (sin _dir) * _range, (_position select 1) + (cos _dir) * _range, 0];
	
	if (!surfaceIsWater _pos) then {
		_validPos = true;
	};
};

_unit = _milGroup createUnit ["O_Soldier_A_F", _pos, [], 0, "NONE"];
_unit setPos _pos;

removeAllWeapons _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

_unit forceAddUniform "U_I_GhillieSuit";
_unit addVest "V_PlateCarrier1_rgr";
_unit addBackpack "B_Kitbag_mcamo";

switch (_weapon) do
{
	case (1):
	{
		_unit addMagazine "20Rnd_762x51_Mag";
		_unit addWeapon "srifle_EBR_ARCO_pointer_F";
		_unit addMagazine "20Rnd_762x51_Mag";
		_unit addMagazine "20Rnd_762x51_Mag";
		_unit addMagazine "20Rnd_762x51_Mag";
	};
	
	case (2):
	{
		_unit addMagazine "30Rnd_65x39_caseless_mag";
		_unit addWeapon "arifle_MXM_Hamr_pointer_F";
		_unit addMagazine "30Rnd_65x39_caseless_mag";
		_unit addMagazine "30Rnd_65x39_caseless_mag";
		_unit addMagazine "30Rnd_65x39_caseless_mag";
	};
};

if (_antiTank) then
{
	_unit addMagazine "Titan_AT";
	_unit addWeapon "launch_Titan_short_F";
	_unit addMagazine "Titan_AT";
	_unit addMagazine "Titan_AT";
};

if (_antiAir) then
{
	_unit addMagazine "Titan_AA";
	_unit addWeapon "launch_Titan_F";
	_unit addMagazine "Titan_AA";
	_unit addMagazine "Titan_AA";
};

_unit addPrimaryWeaponItem "acc_flashlight";
_unit enableGunLights "forceOn";
_unit addRating 1e11;
_unit spawn addMilCap;
_unit spawn refillPrimaryAmmo;

_unit