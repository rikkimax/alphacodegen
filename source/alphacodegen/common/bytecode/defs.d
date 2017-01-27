module alphacodegen.commonbytecode.defs;
import std.bitmanip : bitfields;

alias Instruction = InstructionV*;

struct InstructionV {
align(1):
	Opcode opcode; // 32, 32
	LabelV label; // size_t * 24 + 8, 104, 200

	union {
		InstructionRawData rawData; // 216
		Operand[4] operands;        // 48 * 4
	}

	Instruction* previous, next;

	size_t numberOfOperands() {
		import std.algorithm : map, sum;

		if (opcode == Opcode.Error || opcode == Opcode.Raw)
			return 0;

		return operands[0 .. operands.length]
			.map!(a => a.type != Operand.Type.Unused ? 1 : 0)
			.sum;
	}
}

struct Opcode {
align(1):
	mixin(bitfields!(
			bool, "isTargetInternal", 1,
			bool, "isTargetable",     1,
			uint, "id",               30));

	this(bool isTargetInternal, bool isTargetable, uint id) {
		this.isTargetInternal = isTargetInternal;
		this.isTargetable = isTargetable;
		this.id = id;
	}

	enum {
		Error           = Opcode(false, false,   0x0),
		Raw             = Opcode(false, false,   0x1),

		/**
		 * on true jump to...
		 * <condition> <value1> <value2> <jump>
		 * 
		 * Multiple_Conditions:
		 *     branch1: A ?? B && C ?? D
		 *     default: !branch1
		 * 
		 *     ---
		 *     cnd1: IRCondition_J_* <condition> <value1> <value2> cnd2
		 *     IRCondition_J default
		 *     cnd2: IRCondition_J_* <condition> <value1> <value2> branch1
		 * 
		 *     default:
		 * 
		 *     branch1: IRCondition_End
		 *     
		 *     IRCondition_End
		 *     ---
		 * 
		 *     branch1: A ?? B || C ?? D
		 *     default !branch1
		 *  
		 *     ---
		 *     cnd1: IRCondition_J_* <condition> <value1> <value2> branch1
		 *     cnd2: IRCondition_J_* <condition> <value1> <value2> branch1
		 * 
		 *     default:
		 * 
		 *     branch1: IRCondition_End
		 * 
		 *     IRCondition_End
		 *     ---
		 * 
		 * Multiple_Branches:
		 *    branch1 A ?? B
		 *    branch2 C ?? D
		 *    default: !branch1 && !branch2
		 * 
		 *    When using multiple conditions as well, jump to the next branch condition instead of default.
		 * 
		 *    ---
		 *    brc1:
		 *    IRCondition_J_* <condition> <value1> <value2> branch1
		 *    brc2:
		 *    IRCondition_J_* <condition> <value1> <value2> branch2
		 *    default:
		 * 
		 *    branch1: IRCondition_End
		 * 
		 *    branch2: IRCondition_End
		 * 
		 *    IRCondition_End
		 *    ---
		 */
		IRCondition_J_T = Opcode(false, false,   0x2),
		/**
		 * on false jump to...
		 * <condition> <value1> <value2> <jump>
         *
		 * See_Also:
		 *     IRCondition_J_T
		 */
		IRCondition_J_F = Opcode(false, false,   0x3),
		/**
		 * always jump to...
		 * <jump>
		 */
		IRCondition_J   = Opcode(false, false,   0x4),
		/**
		 * at end of condition code add this
		 * 
		 * When used with multiple inline branches do not emit this multiple times unless required to end emitting.
		 * 
		 * ---
		 * IRCondition_J_* <condition> <value1> <value2> branch1
		 * IRCondition_J default
		 * 
		 * // pre
		 * 
		 * branch1: IRCondition_J_* <condition> <value1> <value2> branch2
		 * IRCondition_J branch3
		 * branch2:
		 * // true
		 * 
		 * 
		 * IRCondition_J branch4
		 * branch3:
		 * // false
		 * 
		 * 
		 * branch4:
		 * // post
		 * 
		 * default: IRCondition_End
		 * ---
		 * 
		 * This is equivalent to the D code:
		 * 
		 * ---
		 * static if (<condition>) {
		 *    // pre
		 * 
		 *    static if (<condition>) {
		 *        // true
		 *    } else {
		 *        // false
		 *    }
		 * 
		 *    // post
		 * }
		 * ---
		 */
		IRCondition_End = Opcode(false, false,   0x5),
	}

	bool opEquals(const Opcode other) {
		return isTargetInternal == other.isTargetInternal &&
			isTargetable == other.isTargetable &&
			id == other.id;
	}
}

struct InstructionRawData {
align(1):
	ubyte[94] values;              // 94, 94
	ushort[12] toPatchOffsets;     // 12 * 2, 24
	Label[12] toPatchDestination; // 12 * size_t, 48, 96
	ubyte numToPatch, numOfValues; // 2, 2
	// 93, 133

	static if (size_t.sizeof == 4) {
		private const ubyte[48] _;
	} else static if (size_t.sizeof == 8) {
	}
}

alias Label = LabelV*;

struct LabelV {
align(1):
	Label*[24] pointsToUs;

	mixin(bitfields!(
			bool,  "beenPatched", 1,
			ulong, "offset",      63));
}

struct Operand {
align(1):
	Type type;              // 32, 32

	union {
		Label label;       // size_t, 4, 8

		ulong constant;     // 8, 8
		ubyte[8] raw_value; // 8, 8
	}

	/// 8, 16, 32, 64, 128, 256, 512
	ushort numberOfBits;    // 2, 2

	// 38, 42

	static if (size_t.sizeof == 4) {
		private const ubyte[10] _;
	} else static if (size_t.sizeof == 8) {
		private const ubyte[6] _;
	}

	struct Type {
	align(1):
		mixin(bitfields!(
				bool, "isTargetInternal", 1,
				bool, "isTargetable",     1,
				uint, "id",               30));
		
		this(bool isTargetInternal, bool isTargetable, uint id) {
			this.isTargetInternal = isTargetInternal;
			this.isTargetable = isTargetable;
			this.id = id;
		}
		
		enum {
			Unused          = Type(false, false, 0x0),
			Label           = Type(false, false, 0x1),
			Constant        = Type(false, false, 0x2),

			IRCondition_LT  = Type(false, false, 0x3),
			IRCondition_GT  = Type(false, false, 0x4),
			IRCondition_LTE = Type(false, false, 0x5),
			IRCondition_GTE = Type(false, false, 0x6),
			IRCondition_E   = Type(false, false, 0x7),
		}
		
		bool opEquals(const Type other) {
			return isTargetInternal == other.isTargetInternal &&
				isTargetable == other.isTargetable &&
				id == other.id;
		}
	}
}