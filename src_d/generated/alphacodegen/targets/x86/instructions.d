// Auto generated, do not edit.
module alphacodegen.target.x86.instructions;
import alphacodegen.common.target.x86.instruction;

private alias EncodingType = InstructionEncoding.Type;
private import alphacodegen.common.target.x86.encoding : X86Encoding;


bool findInstruction(string name, string argspec, out immutable(InstructionGroup)* group, out immutable(InstructionVariation)* variation) {
	import std.algorithm : splitter;

	foreach(ref grp; x86Instructions) {
	F2: foreach(ref var; grp.variations) {
			if (var.mnemonic.name != name)
				continue F2;

			auto specA = var.mnemonic.operands;
			foreach(arg; argspec.splitter(' ')) {
				if (specA.length == 0)
					continue F2;
				if (arg[$-1] == ',')
					arg = arg[0 .. $-1];
				if (specA[0] != arg) {
					// TODO: fuzzy search
					// e.g. registers eAX == EAX
					continue F2;
				}
			}

			group = &grp;
			variation = &var;
			return true;
		}
	}

	return false;
}

static immutable(InstructionGroup[]) x86Instructions = [
	InstructionGroup("ASCII Adjust After Addition", [
		InstructionVariation(
			InstructionMnemonic("AAA"), [
				InstructionEncoding(EncodingType.Value, 55)
			],
			false,
		)
	]),
	InstructionGroup("ASCII Adjust Before Division", [
		InstructionVariation(
			InstructionMnemonic("AAD"), [
				InstructionEncoding(EncodingType.Value, 213),
				InstructionEncoding(EncodingType.Value, 10)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"AAD", [
					"imm8"
				]
			), [
				InstructionEncoding(EncodingType.Value, 213),
				InstructionEncoding(EncodingType.Immediate, 1)
			],
			false,
		)
	]),
	InstructionGroup("ASCII Adjust After Multiply", [
		InstructionVariation(
			InstructionMnemonic("AAM"), [
				InstructionEncoding(EncodingType.Value, 212),
				InstructionEncoding(EncodingType.Value, 10)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"AAM", [
					"imm8"
				]
			), [
				InstructionEncoding(EncodingType.Value, 212),
				InstructionEncoding(EncodingType.Immediate, 1)
			],
			false,
		)
	]),
	InstructionGroup("ASCII Adjust After Subtraction", [
		InstructionVariation(
			InstructionMnemonic("AAS"), [
				InstructionEncoding(EncodingType.Value, 63)
			],
			false,
		)
	]),
	InstructionGroup("Add with Carry", [
		InstructionVariation(
			InstructionMnemonic(
				"ADC", [
					"AL",
					"imm8"
				]
			), [
				InstructionEncoding(EncodingType.Value, 20),
				InstructionEncoding(EncodingType.Immediate, 1)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"ADC", [
					"AX",
					"imm16"
				]
			), [
				InstructionEncoding(EncodingType.Value, 21),
				InstructionEncoding(EncodingType.Immediate, 2)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"ADC", [
					"EAX",
					"imm32"
				]
			), [
				InstructionEncoding(EncodingType.Value, 21),
				InstructionEncoding(EncodingType.Immediate, 4)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"ADC", [
					"RAX",
					"imm32"
				]
			), [
				InstructionEncoding(EncodingType.Value, 21),
				InstructionEncoding(EncodingType.Immediate, 4)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"ADC", [
					"reg/mem8",
					"imm8"
				]
			), [
				InstructionEncoding(EncodingType.Value, 128),
				InstructionEncoding(EncodingType.ModRM_Reg, 2),
				InstructionEncoding(EncodingType.Immediate, 1)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"ADC", [
					"reg/mem16",
					"imm16"
				]
			), [
				InstructionEncoding(EncodingType.Value, 129),
				InstructionEncoding(EncodingType.ModRM_Reg, 2),
				InstructionEncoding(EncodingType.Immediate, 2)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"ADC", [
					"reg/mem32",
					"imm32"
				]
			), [
				InstructionEncoding(EncodingType.Value, 129),
				InstructionEncoding(EncodingType.ModRM_Reg, 2),
				InstructionEncoding(EncodingType.Immediate, 4)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"ADC", [
					"reg/mem64",
					"imm32"
				]
			), [
				InstructionEncoding(EncodingType.Value, 129),
				InstructionEncoding(EncodingType.ModRM_Reg, 2),
				InstructionEncoding(EncodingType.Immediate, 4)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"ADC", [
					"reg/mem16",
					"imm8"
				]
			), [
				InstructionEncoding(EncodingType.Value, 131),
				InstructionEncoding(EncodingType.ModRM_Reg, 2),
				InstructionEncoding(EncodingType.Immediate, 1)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"ADC", [
					"reg/mem32",
					"imm8"
				]
			), [
				InstructionEncoding(EncodingType.Value, 131),
				InstructionEncoding(EncodingType.ModRM_Reg, 2),
				InstructionEncoding(EncodingType.Immediate, 1)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"ADC", [
					"reg/mem64",
					"imm8"
				]
			), [
				InstructionEncoding(EncodingType.Value, 131),
				InstructionEncoding(EncodingType.ModRM_Reg, 2),
				InstructionEncoding(EncodingType.Immediate, 1)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"ADC", [
					"reg/mem8",
					"reg8"
				]
			), [
				InstructionEncoding(EncodingType.Value, 16),
				InstructionEncoding(EncodingType.ModRM_Reg_RegMem)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"ADC", [
					"reg/mem16",
					"reg16"
				]
			), [
				InstructionEncoding(EncodingType.Value, 17),
				InstructionEncoding(EncodingType.ModRM_Reg_RegMem)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"ADC", [
					"reg/mem32",
					"reg32"
				]
			), [
				InstructionEncoding(EncodingType.Value, 17),
				InstructionEncoding(EncodingType.ModRM_Reg_RegMem)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"ADC", [
					"reg/mem64",
					"reg64"
				]
			), [
				InstructionEncoding(EncodingType.Value, 17),
				InstructionEncoding(EncodingType.ModRM_Reg_RegMem)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"ADC", [
					"reg8",
					"reg/mem8"
				]
			), [
				InstructionEncoding(EncodingType.Value, 18),
				InstructionEncoding(EncodingType.ModRM_Reg_RegMem)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"ADC", [
					"reg16",
					"reg/mem16"
				]
			), [
				InstructionEncoding(EncodingType.Value, 19),
				InstructionEncoding(EncodingType.ModRM_Reg_RegMem)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"ADC", [
					"reg32",
					"reg/mem32"
				]
			), [
				InstructionEncoding(EncodingType.Value, 19),
				InstructionEncoding(EncodingType.ModRM_Reg_RegMem)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"ADC", [
					"reg64",
					"reg/mem64"
				]
			), [
				InstructionEncoding(EncodingType.Value, 19),
				InstructionEncoding(EncodingType.ModRM_Reg_RegMem)
			],
			false,
		)
	]),
	InstructionGroup("Signed or Unsigned Add", [
		InstructionVariation(
			InstructionMnemonic(
				"ADD", [
					"AL",
					"imm8"
				]
			), [
				InstructionEncoding(EncodingType.Value, 4),
				InstructionEncoding(EncodingType.Immediate, 1)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"ADD", [
					"AX",
					"imm16"
				]
			), [
				InstructionEncoding(EncodingType.Value, 5),
				InstructionEncoding(EncodingType.Immediate, 2)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"ADD", [
					"EAX",
					"imm32"
				]
			), [
				InstructionEncoding(EncodingType.Value, 5),
				InstructionEncoding(EncodingType.Immediate, 4)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"ADD", [
					"RAX",
					"imm32"
				]
			), [
				InstructionEncoding(EncodingType.Value, 5),
				InstructionEncoding(EncodingType.Immediate, 4)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"ADD", [
					"reg/mem8",
					"imm8"
				]
			), [
				InstructionEncoding(EncodingType.Value, 128),
				InstructionEncoding(EncodingType.ModRM_Reg, 0),
				InstructionEncoding(EncodingType.Immediate, 1)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"ADD", [
					"reg/mem16",
					"imm16"
				]
			), [
				InstructionEncoding(EncodingType.Value, 129),
				InstructionEncoding(EncodingType.ModRM_Reg, 0),
				InstructionEncoding(EncodingType.Immediate, 2)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"ADD", [
					"reg/mem32",
					"imm32"
				]
			), [
				InstructionEncoding(EncodingType.Value, 129),
				InstructionEncoding(EncodingType.ModRM_Reg, 0),
				InstructionEncoding(EncodingType.Immediate, 4)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"ADD", [
					"reg/mem64",
					"imm32"
				]
			), [
				InstructionEncoding(EncodingType.Value, 129),
				InstructionEncoding(EncodingType.ModRM_Reg, 0),
				InstructionEncoding(EncodingType.Immediate, 4)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"ADD", [
					"reg/mem16",
					"imm8"
				]
			), [
				InstructionEncoding(EncodingType.Value, 131),
				InstructionEncoding(EncodingType.ModRM_Reg, 0),
				InstructionEncoding(EncodingType.Immediate, 1)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"ADD", [
					"reg/mem32",
					"imm8"
				]
			), [
				InstructionEncoding(EncodingType.Value, 131),
				InstructionEncoding(EncodingType.ModRM_Reg, 0),
				InstructionEncoding(EncodingType.Immediate, 1)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"ADD", [
					"reg/mem64",
					"imm8"
				]
			), [
				InstructionEncoding(EncodingType.Value, 131),
				InstructionEncoding(EncodingType.ModRM_Reg, 0),
				InstructionEncoding(EncodingType.Immediate, 1)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"ADD", [
					"reg/mem8",
					"reg8"
				]
			), [
				InstructionEncoding(EncodingType.Value, 0),
				InstructionEncoding(EncodingType.ModRM_Reg_RegMem)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"ADD", [
					"reg/mem16",
					"reg16"
				]
			), [
				InstructionEncoding(EncodingType.Value, 1),
				InstructionEncoding(EncodingType.ModRM_Reg_RegMem)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"ADD", [
					"reg/mem32",
					"reg32"
				]
			), [
				InstructionEncoding(EncodingType.Value, 1),
				InstructionEncoding(EncodingType.ModRM_Reg_RegMem)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"ADD", [
					"reg/mem64",
					"reg64"
				]
			), [
				InstructionEncoding(EncodingType.Value, 1),
				InstructionEncoding(EncodingType.ModRM_Reg_RegMem)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"ADD", [
					"reg8",
					"reg/mem8"
				]
			), [
				InstructionEncoding(EncodingType.Value, 2),
				InstructionEncoding(EncodingType.ModRM_Reg_RegMem)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"ADD", [
					"reg16",
					"reg/mem16"
				]
			), [
				InstructionEncoding(EncodingType.Value, 3),
				InstructionEncoding(EncodingType.ModRM_Reg_RegMem)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"ADD", [
					"reg32",
					"reg/mem32"
				]
			), [
				InstructionEncoding(EncodingType.Value, 3),
				InstructionEncoding(EncodingType.ModRM_Reg_RegMem)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"ADD", [
					"reg64",
					"reg/mem64"
				]
			), [
				InstructionEncoding(EncodingType.Value, 3),
				InstructionEncoding(EncodingType.ModRM_Reg_RegMem)
			],
			false,
		)
	]),
	InstructionGroup("Logical AND", [
		InstructionVariation(
			InstructionMnemonic(
				"AND", [
					"AL",
					"imm8"
				]
			), [
				InstructionEncoding(EncodingType.Value, 36),
				InstructionEncoding(EncodingType.Immediate, 1)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"AND", [
					"AX",
					"imm16"
				]
			), [
				InstructionEncoding(EncodingType.Value, 37),
				InstructionEncoding(EncodingType.Immediate, 2)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"AND", [
					"EAX",
					"imm32"
				]
			), [
				InstructionEncoding(EncodingType.Value, 37),
				InstructionEncoding(EncodingType.Immediate, 4)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"AND", [
					"RAX",
					"imm32"
				]
			), [
				InstructionEncoding(EncodingType.Value, 37),
				InstructionEncoding(EncodingType.Immediate, 4)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"AND", [
					"reg/mem8",
					"imm8"
				]
			), [
				InstructionEncoding(EncodingType.Value, 128),
				InstructionEncoding(EncodingType.ModRM_Reg, 4),
				InstructionEncoding(EncodingType.Immediate, 1)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"AND", [
					"reg/mem16",
					"imm16"
				]
			), [
				InstructionEncoding(EncodingType.Value, 129),
				InstructionEncoding(EncodingType.ModRM_Reg, 4),
				InstructionEncoding(EncodingType.Immediate, 2)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"AND", [
					"reg/mem32",
					"imm32"
				]
			), [
				InstructionEncoding(EncodingType.Value, 129),
				InstructionEncoding(EncodingType.ModRM_Reg, 4),
				InstructionEncoding(EncodingType.Immediate, 4)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"AND", [
					"reg/mem64",
					"imm32"
				]
			), [
				InstructionEncoding(EncodingType.Value, 129),
				InstructionEncoding(EncodingType.ModRM_Reg, 4),
				InstructionEncoding(EncodingType.Immediate, 4)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"AND", [
					"reg/mem16",
					"imm8"
				]
			), [
				InstructionEncoding(EncodingType.Value, 131),
				InstructionEncoding(EncodingType.ModRM_Reg, 4),
				InstructionEncoding(EncodingType.Immediate, 1)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"AND", [
					"reg/mem32",
					"imm8"
				]
			), [
				InstructionEncoding(EncodingType.Value, 131),
				InstructionEncoding(EncodingType.ModRM_Reg, 4),
				InstructionEncoding(EncodingType.Immediate, 1)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"AND", [
					"reg/mem64",
					"imm8"
				]
			), [
				InstructionEncoding(EncodingType.Value, 131),
				InstructionEncoding(EncodingType.ModRM_Reg, 4),
				InstructionEncoding(EncodingType.Immediate, 1)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"AND", [
					"reg/mem8",
					"reg8"
				]
			), [
				InstructionEncoding(EncodingType.Value, 32),
				InstructionEncoding(EncodingType.ModRM_Reg_RegMem)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"AND", [
					"reg/mem16",
					"reg16"
				]
			), [
				InstructionEncoding(EncodingType.Value, 33),
				InstructionEncoding(EncodingType.ModRM_Reg_RegMem)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"AND", [
					"reg/mem32",
					"reg32"
				]
			), [
				InstructionEncoding(EncodingType.Value, 33),
				InstructionEncoding(EncodingType.ModRM_Reg_RegMem)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"AND", [
					"reg/mem64",
					"reg64"
				]
			), [
				InstructionEncoding(EncodingType.Value, 50),
				InstructionEncoding(EncodingType.ModRM_Reg_RegMem)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"AND", [
					"reg8",
					"reg/mem8"
				]
			), [
				InstructionEncoding(EncodingType.Value, 34),
				InstructionEncoding(EncodingType.ModRM_Reg_RegMem)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"AND", [
					"reg16",
					"reg/mem16"
				]
			), [
				InstructionEncoding(EncodingType.Value, 35),
				InstructionEncoding(EncodingType.ModRM_Reg_RegMem)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"AND", [
					"reg32",
					"reg/mem32"
				]
			), [
				InstructionEncoding(EncodingType.Value, 35),
				InstructionEncoding(EncodingType.ModRM_Reg_RegMem)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"AND", [
					"reg64",
					"reg/mem64"
				]
			), [
				InstructionEncoding(EncodingType.Value, 35),
				InstructionEncoding(EncodingType.ModRM_Reg_RegMem)
			],
			false,
		)
	]),
	InstructionGroup("Logical And-Not", [
		InstructionVariation(
			InstructionMnemonic(
				"ANDN", [
					"reg32",
					"reg32",
					"reg/mem32"
				]
			), [
				InstructionEncoding(EncodingType.VEXsource,
					InstructionEncodingVEX(false, false, false,
						false, true, true, true, 2, false, 1, false)),
				InstructionEncoding(EncodingType.Value, 242),
				InstructionEncoding(EncodingType.ModRM_Reg_RegMem)
			],
			false,
		), 
		InstructionVariation(
			InstructionMnemonic(
				"ANDN", [
					"reg64",
					"reg64",
					"reg/mem64"
				]
			), [
				InstructionEncoding(EncodingType.VEXsource,
					InstructionEncodingVEX(false, false, false,
						false, true, true, true, 2, true, 1, false)),
				InstructionEncoding(EncodingType.Value, 242),
				InstructionEncoding(EncodingType.ModRM_Reg_RegMem)
			],
			false,
		)
	])
];
