/**
 * Copyright:
 *    Richard Andrew Cattermole 2016
 * 
 * License:
 *    This software is dual licensed. All rights reserved.
 *    See https://github.com/rikkimax/alphacodegen/blob/master/LICENSE.md for more information.
 */
module alphacodegen.common.target.x86.register;

struct RegisterGroup {
	Register low8, high8;
	Register bit16, bit32, bit64;

	Register match(string match) const {
		const Register* ret = matchRef(match);
		if (ret is null)
			return Register.init;
		else
			return cast()*ret;
	}

	const(Register*) matchRef(string against) const {
        import std.string : toLowerInPlace;

		Register ret;

        char[60] temp;
        temp[] = ' ';

        assert(against.length <= 10);
        temp[0 .. against.length] = against[];

		temp[10 .. 10 + low8.name.length] = low8.name;
		temp[20 .. 20 + high8.name.length] = high8.name[];
		temp[30 .. 30 + bit16.name.length] = bit16.name[];
		temp[40 .. 40 + bit32.name.length] = bit32.name[];
		temp[50 .. 50 + bit64.name.length] = bit64.name[];

        char[] temp2 = cast(char[])temp;
        toLowerInPlace(temp2);

		if (temp[0 .. against.length] == temp[10 .. 10 + low8.name.length]) {
			return &low8;
		} else if (temp[0 .. against.length] == temp[20 .. 20 + high8.name.length]) {
			return &high8;
		} else if (temp[0 .. against.length] == temp[30 .. 30 + bit16.name.length]) {
			return &bit16;
		} else if (temp[0 .. against.length] == temp[40 .. 40 + bit32.name.length]) {
			return &bit32;
		} else if (temp[0 .. against.length] == temp[50 .. 50 + bit64.name.length]) {
			return &bit64;
        }

        return null;
    }
}

struct Register {
	string name;
	ubyte size;
	bool isHigh8, requiresREX, bit64Only;

	EncodeAs encodeAs;
}

enum ModRM_MOD {
	Zero = 0b00,
	One = 0b01,
	Two = 0b10,
	Three = 0b11
}

struct EncodeAs {
	// for most uses
	ubyte byDefault;
	// +rb, +rw, +rd, +rq
	ubyte withoutREX, withREX_B0, withREX_B1;
	bool validWithoutREX, validWithREX_B0, validWithREX_B1;

	EncodeForMODRM_SIB[__traits(allMembers, ModRM_MOD).length] arch16ModRM_SIB, arch32_64ModRM_SIB;
}

struct EncodeForMODRM_SIB {
	ubyte displacementLength, index, base;
	bool useSIB, validDisplacement, useIndex, useBase;
}