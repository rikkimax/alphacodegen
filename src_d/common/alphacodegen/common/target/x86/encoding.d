/**
 * Copyright:
 *    Richard Andrew Cattermole 2016
 * 
 * License:
 *    This software is dual licensed. All rights reserved.
 *    See https://github.com/rikkimax/alphacodegen/blob/master/LICENSE.md for more information.
 */
module alphacodegen.common.target.x86.encoding;
import std.bitmanip : bitfields;

/**
 * Abstraction that represents the x86 encoding process
 */
struct X86Encoding {
	///
	struct LegacyPrefixes {
		///
		mixin(bitfields!(
				bool, "operandSize", 1,
				bool, "addressSize", 1,
				bool, "lock", 1,
				bool, "rep", 1,
				bool, "repn", 1,
				uint, "_", 3));
	}
	
	///
	struct VEX_2Byte {
		import std.bitmanip;
		
		// byte 0
		// value is assumed
		
		// byte 1
		
		///
		mixin(bitfields!(
				bool, "R", 1, // ~: 1bit extension of ModRM.reg
				ubyte, "vvvv", 4, // source/destination register selector
				bool, "L", 1, // vector length specifier
				ubyte, "_", 2));
		
		// we can work out pp from prefixes
	}
	
	///
	struct VEX_XOP_3Byte {
		import std.bitmanip;
		
		// byte 0
		
		///
		bool isXOP;
		
		// byte 1
		
		///
		mixin(bitfields!(
				bool, "R", 1, // ~: 1bit extension of ModRM.reg
				bool, "X", 1, // ~: 1bit extension of SIB.index
				bool, "B", 1, // ~: 1bit extension of ModRM.regmod or SIB.base
				ubyte, "map_select", 5));
		
		// byte 2
		
		///
		mixin(bitfields!(
				bool, "W", 1, // operand size override or operand configuration for ymm/xmm based operations
				ubyte, "vvvv", 4, // source/destination register selector
				bool, "L", 1, // vector length specifier
				ubyte, "_", 2));
		
		// we can work out pp from prefixes
	}
	
	///
	struct REX {
		///
		bool B;
		///
		bool X;
		///
		bool R;
		///
		bool W;
	}
	
	///
	struct Base {
		//bool use3DNow;
		
		///
		bool useCodeMapSecondary;
		///
		bool useCodeMap38h;
		///
		bool useCodeMap3Ah;
		
		///
		bool useREX;
		///
		REX rexPrefix;
	}
	
	///
	struct ModRM {
		import std.bitmanip;
		
		///
		mixin(bitfields!(
				ubyte, "regmem", 3,
				ubyte, "reg", 3,
				ubyte, "mod", 2));
	}
	
	///
	struct SIB {
		import std.bitmanip;
		
		///
		mixin(bitfields!(
				ubyte, "base", 3,
				ubyte, "index", 3,
				ubyte, "scale", 2));
	}
	
	///
	LegacyPrefixes legacyPrefixes;
	///
	ubyte segmentOverride;
	
	/// picks vex2Byte
	bool useVEX_2Byte;
	/// picks vex_xop_3Byte
	bool useVEX_XOP_3Byte;
	
	/// Combined prefix encoding process logic (choose one)
	union {
		///
		VEX_2Byte vex2Byte;
		///
		VEX_XOP_3Byte vex_xop_3Byte;
		///
		Base base;
	}
	
	///
	ubyte opcode;
	
	///
	bool useModRM;
	///
	ModRM modRM;
	
	///
	bool useSIB;
	///
	SIB sib;
	
	/// combined displacement + immediate values total size
	ubyte amountOfDisplacementImmediate;
	/// combined displacement + immediate values
	ubyte[8] displacementImmediate;
}

/**
 * Encodes an x86 instruction into byte form
 * 
 * Will not do any logical analysis upon the input.
 * If it cannot perform the encoding, it will return 0.
 * 
 * Params:
 * 		from	=	Input data structure describing the instruction you want to encode
 * 		ret		=	The resulting encoded value
 * 
 * Returns:
 * 		The number of bytes used to encode the input or 0 is not possible.
 */
size_t encode(X86Encoding from, out ubyte[15] ret) {
	X86Encoding realData = from;
	ret = 0;
	
	size_t offset;
	
	ubyte vexPP = () {
		ubyte pp;
		
		if (realData.legacyPrefixes.operandSize) {
			pp = 1;
		} else if (realData.legacyPrefixes.rep) {
			pp = 2;
		} else if (realData.legacyPrefixes.repn) {
			pp = 3;
		}
		
		return pp;
	}();
	
	void add(ubyte v) {
		ret[offset] = v;
		offset++;
	}
	
	void performVEX2Byte() {
		realData.vex2Byte.R = !realData.vex2Byte.R;
		realData.vex2Byte.vvvv = ~realData.vex2Byte.vvvv;
		
		ret[offset] = 0xC5;
		ret[offset + 1] = cast(ubyte)(vexPP | (realData.vex2Byte.L << 2) | (realData.vex2Byte.vvvv << 3) | (realData.vex2Byte.R << 7));
		offset += 2;
	}
	
	//
	
	if (realData.useVEX_2Byte || realData.useVEX_XOP_3Byte) {
		if (realData.legacyPrefixes.operandSize) {
			realData.legacyPrefixes.operandSize = false;
		} else if (realData.legacyPrefixes.rep) {
			realData.legacyPrefixes.rep = false;
		} else if (realData.legacyPrefixes.repn) {
			realData.legacyPrefixes.repn = false;
		}
	}
	
	// apply the legacy prefix
	
	if (realData.legacyPrefixes.operandSize)
		add(0x66);
	if (realData.legacyPrefixes.addressSize)
		add(0x67);
	if (realData.legacyPrefixes.lock)
		add(0xF0);
	if (realData.legacyPrefixes.rep)
		add(0xF3);
	if (realData.legacyPrefixes.repn)
		add(0xF2);
	
	if (realData.segmentOverride > 0)
		add(realData.segmentOverride);
	
	//
	
	if (realData.useVEX_2Byte) {
		// make sure that vvvv is only 4 bits
		if ((realData.vex2Byte.vvvv & 0xF0) > 0)
			return 0;
		
		performVEX2Byte();
	} else if (realData.useVEX_XOP_3Byte) {
		bool turn2_X, turn2_B, turn2_W, turn2_mapselect;
		
		// make sure that vvvv is only 4 bits
		if ((realData.vex_xop_3Byte.vvvv & 0xF0) > 0)
			return 0;
		
		realData.vex_xop_3Byte.R = !realData.vex_xop_3Byte.R;
		realData.vex_xop_3Byte.X = !realData.vex_xop_3Byte.X;
		realData.vex_xop_3Byte.B = !realData.vex_xop_3Byte.B;
		realData.vex_xop_3Byte.vvvv = (~realData.vex_xop_3Byte.vvvv) & 0xF;
		
		turn2_X = realData.vex_xop_3Byte.X;
		turn2_B = realData.vex_xop_3Byte.B;
		turn2_W = !realData.vex_xop_3Byte.W;
		turn2_mapselect = realData.vex_xop_3Byte.map_select == 1;
		
		if (turn2_X && turn2_B && turn2_W && turn2_mapselect) {
			realData.useVEX_XOP_3Byte = false;
			realData.useVEX_2Byte = true;
			
			realData.vex2Byte.L = from.vex_xop_3Byte.L;
			realData.vex2Byte.vvvv = from.vex_xop_3Byte.vvvv;
			realData.vex2Byte.R = from.vex_xop_3Byte.R;
			
			performVEX2Byte();
		} else {
			ret[offset] = realData.vex_xop_3Byte.isXOP ? 0x8F : 0xC4;
			ret[offset + 1] = cast(ubyte)(realData.vex_xop_3Byte.map_select | (realData.vex_xop_3Byte.B << 5) |
				(realData.vex_xop_3Byte.X << 6) | (realData.vex_xop_3Byte.R << 7));
			ret[offset + 2] = cast(ubyte)(vexPP | (realData.vex_xop_3Byte.L << 2) |
				(realData.vex_xop_3Byte.vvvv << 3) | (realData.vex_xop_3Byte.W << 7));
			offset += 3;
		}
									} else {
										if (realData.base.useREX)
										add(0x40 | (realData.base.rexPrefix.B) | (realData.base.rexPrefix.X << 1) | (realData.base.rexPrefix.R << 2) | (realData.base.rexPrefix.W << 3));
									
									if (realData.base.useCodeMapSecondary) {
									add(0x0F);
								/+} else if (realData.base.use3DNow) {
			add(0x0F);
			add(0x0F);+/
		} else if (realData.base.useCodeMap38h) {
			add(0x0F);
			add(0x38);
		} else if (realData.base.useCodeMap3Ah) {
			add(0x0F);
			add(0x3A);
		}
	}
	
	//if (!realData.base.use3DNow)
	add(realData.opcode);
	
	// ModRM
	if (realData.useModRM) {
		add(cast(ubyte)(realData.modRM.regmem | (realData.modRM.reg << 3) | (realData.modRM.mod << 6)));
	}
	
	// SIB
	if (realData.useSIB) {
		add(cast(ubyte)(realData.sib.base | (realData.sib.index << 3) | (realData.sib.scale << 6)));
	}
	
	// okay so if 3dNow! is supported
	//  the whole displacement vs immediate value
	//  encoding process will need to change
	
	if (realData.amountOfDisplacementImmediate > 0) {
		foreach(i; 0 .. realData.amountOfDisplacementImmediate)
			add(realData.displacementImmediate[i]);
	}
	
	return offset;
}

private mixin template TestCase(string code, alias toCheck) {
	unittest {
		ubyte[15] result;
		X86Encoding from;
		
		mixin(code);
		
		auto gotLength = from.encode(result);
		assert(gotLength == toCheck.length);
		assert(result[0 .. toCheck.length] == cast(ubyte[])toCheck);
	}
}

// opcode
mixin TestCase!(q{
		from.opcode = 0x37;
	}, x"37");

// opcode + imm8
mixin TestCase!(q{
		from.opcode = 0xD5;
		from.amountOfDisplacementImmediate = 1;
		from.displacementImmediate[0] = 0x0A;
	}, x"D5 0A");

// opcode + imm16
mixin TestCase!(q{
		from.opcode = 0x15;
		
		from.legacyPrefix = X86Encoding.LegacyPrefixes.OperandSize;
		
		from.amountOfDisplacementImmediate = 2;
		from.displacementImmediate[0] = 0x00;
		from.displacementImmediate[1] = 0x01;
	}, x"66 15 00 01");

// opcode + imm32
mixin TestCase!(q{
		from.opcode = 0x15;
		
		from.amountOfDisplacementImmediate = 4;
		from.displacementImmediate[0] = 0x00;
		from.displacementImmediate[1] = 0x02;
		from.displacementImmediate[2] = 0x00;
		from.displacementImmediate[3] = 0x01;
	}, x"15 00 02 00 01");

// opcode + ModRM + imm8
mixin TestCase!(q{
		from.opcode = 0x80;
		
		from.useModRM = true;
		from.modRM.mod = 3;
		from.modRM.reg = 2;
		from.modRM.regmem = 1;
		
		from.amountOfDisplacementImmediate = 1;
		from.displacementImmediate[0] = 0x0A;
	}, x"80 d1 0A");

// opcode + ModRM + reg8
mixin TestCase!(q{
		from.opcode = 0x10;
		
		from.useModRM = true;
		from.modRM.mod = 3;
		from.modRM.reg = 1;
		from.modRM.regmem = 2;
	}, x"10 ca");

// opcode + ModRM + reg64
mixin TestCase!(q{
		from.opcode = 0x11;
		
		from.base.useREX = true;
		from.base.rexPrefix.W  = true;
		
		from.useModRM = true;
		from.modRM.mod = 3;
		from.modRM.reg = 1;
		from.modRM.regmem = 2;
	}, x"48 11 ca");

// opcode + vex3 + imm8
mixin TestCase!(q{
		from.opcode = 0xF5;
		
		from.legacyPrefix = X86Encoding.LegacyPrefixes.Rep;
		
		from.useVEX_XOP_3Byte = true;
		from.vex_xop_3Byte.map_select = 2;
		
		from.vex_xop_3Byte.vvvv = 3;
		from.vex_xop_3Byte.W = true;
		
		from.amountOfDisplacementImmediate = 1;
		from.displacementImmediate[0] = 0xc8;
	}, x"c4 e2 e2 f5 c8");