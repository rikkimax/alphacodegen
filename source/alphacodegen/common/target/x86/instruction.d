module alphacodegen.common.target.x86.instruction;
import alphacodegen.common.target.x86.register : Register;
import alphacodegen.common.target.x86.segments : Segment;

struct InstructionGroup {
    string title;
    InstructionVariation[] variations;
}

struct InstructionVariation {
	InstructionMnemonic mnemonic;
	InstructionEncoding[] encoding;

	// not primary file (encodingSizes.md have exceptions based upon group + variation mnemonic operands)
	bool noREXPrefixBut64Bit;
}

struct InstructionMnemonic {
	string name;
	string[] operands;
}

struct InstructionEncoding {
	this(Type type, ubyte v=0) {
		this.type = type;
		this.value = v;
	}

	this(Type type, InstructionEncodingVEX vex) {
		this.type = type;
		this.vexPrefix = vex;
	}

	enum Type {
		/// Should not be hit!
		ERROR,
		/// Not immediate value, raw additive byte
		Value,
		/// specifies what goes into ModRM.reg but also enables ModRM.regmem (requirement)
		ModRM_Reg,
		/// specifies that two args goes into ModRM (reg + mem in reg)
		ModRM_Reg_RegMem,
		/// value
		Immediate,

		/// has [size] number of displacement bytes with 2 more for segment
		Section2WithDisplacement,
		/// [size] number of displacement bytes
		Displacement,

		/// ST(value)
		FloatingPointStackOperand,
		/// m64 (for register to memory only)
		ModRM_RegMem_NoRegister,

		/// 
		RegisterEncodeOperand,

		///
		VEXsource,
		///
		VEXdestination,
		///
		VEXcontrol,
	}

	Type type;

	union {
		ubyte value;
		ubyte size;
		InstructionEncodingVEX vexPrefix;
	}
}

// FIXME: should not be called VEX (is for VEX/XOP)
struct InstructionEncodingVEX {
	import alphacodegen.common.target.x86.encoding : X86Encoding;
	import std.bitmanip;

	this(bool operandSizeOverride, bool rep, bool repn, bool isXOP,
		bool R, bool X, bool B, ubyte map_select,
		bool W, ubyte vvvv, bool L) {
		
		vexPrefix.isXOP = isXOP;
		vexPrefix.R = R;
		vexPrefix.X = X;
		vexPrefix.B = B;
		vexPrefix.map_select = map_select;
		vexPrefix.W = W;
		vexPrefix.vvvv = vvvv;
		vexPrefix.L = L;

		this.operandSizeOverride = operandSizeOverride;
		this.rep = rep;
		this.repn = repn;
	}

	/// vvvv contains the digit specified in the form W.vvvv.L.pp if any
	/// see the type to determine what it means
	X86Encoding.VEX_XOP_3Byte vexPrefix;
	alias vexPrefix this;

	///
	mixin(bitfields!(
			bool, "operandSizeOverride", 1,
			bool, "rep", 1,
			bool, "repn", 1,
			ubyte, "_", 5));
}