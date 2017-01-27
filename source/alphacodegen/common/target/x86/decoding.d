module alphacodegen.common.target.x86.decoding;
import alphacodegen.common.target.x86.instruction : InstructionVariation, InstructionGroup, InstructionEncoding;
import alphacodegen.common.target.x86.encoding : X86Encoding;
import alphacodegen.common.target.x86.segments : Segment, findSegment;
import alphacodegen.common.utils : StaticDynamicArray;
import std.typecons : Nullable;

struct X86Decoded {
	const(InstructionVariation)* instruction;
	X86Encoding encoding;
}

struct X86Environment {
	enum Mode {
		/**
		 * real mode or virtual 8086
		 * Has access to 32bit registers (is 16bit) with address size override
		 */
		Real,
		/**
		 * protected mode or long compatibility mode
		 * Is 32bit.
		 */
		Protected,
		/**
		 * long mode
		 * Is 64bit.
		 */
		Long
	}

	Mode mode;
}

Nullable!X86Decoded decode()(ubyte[] from, X86Environment environment, const(InstructionGroup[]) instructionGroups=null) {
	if (instructionGroups is null) {
		version(Have_alphacodegen_generated) {
			import alphacodegen.generated.alphacodegen.targets.x86.instructions;
			instructionGroups = cast(const)x86Instructions;
		} else {
			// this assert is ok since this is a compilation problem.
			// aka is an exception to the way its suposed to be used.

			assert(0, "Need instructions to determine which instruction is being decoded");
		}
	}

	return performDecode(environment, from, instructionGroups);
}

private {
	Nullable!X86Decoded performDecode(X86Environment environment, ubyte[] from, const(InstructionGroup[]) instructionGroups) {
		X86Decoded ret;
		size_t offset;

		// decode legacy prefixes
	F1: foreach(i, b; from[offset .. $]) {
		S1: switch(b) {
				case 0x66:
					ret.encoding.legacyPrefixes.operandSize = true;
					break;
				case 0x67:
					ret.encoding.legacyPrefixes.addressSize = true;
					break;
				case 0xF0:
					ret.encoding.legacyPrefixes.lock = true;
					break;
				case 0xF3:
					ret.encoding.legacyPrefixes.rep = true;
					break;
				case 0xF2:
					ret.encoding.legacyPrefixes.repn = true;
					break;

				default:
					// if segment, pop it in
					Segment segment;

					if (findSegment(b, segment)) {
						ret.encoding.segmentOverride = b;
						break S1;
					}

					// otherwise end this foreach loop
					offset = i;
					break F1;
			}
		}

		if (from.length <= offset)
			return Nullable!X86Decoded.init;

		// decode VEX/XOP prefix
		if (from[offset] == 0xC5) {
			// 2 byte VEX
			ret.encoding.useVEX_2Byte = true;

			offset += 2;

			if (from.length <= offset)
				return Nullable!X86Decoded.init;
			ubyte vexB1 = from[offset - 1];

			ubyte vexPP = vexB1 & 3;
			if (vexPP == 1)
				ret.encoding.legacyPrefixes.operandSize = true;
			else if (vexPP == 2)
				ret.encoding.legacyPrefixes.rep = true;
			else if (vexPP == 3)
				ret.encoding.legacyPrefixes.repn = true;

			ret.encoding.vex2Byte.L = (vexB1 & 4) == 4;
			ret.encoding.vex2Byte.vvvv = cast(ubyte)~((vexB1 & 78) >> 3);
			ret.encoding.vex2Byte.R = (vexB1 & 128) == 0;
		} else if (from[offset] == 0xC4 || from[offset] == 0x8F) {
			// 3 byte VEX/XOP
			ret.encoding.useVEX_XOP_3Byte = true;
			ret.encoding.vex_xop_3Byte.isXOP = from[offset] == 0x8F;

			offset += 3;
			
			if (from.length <= offset)
				return Nullable!X86Decoded.init;

			ubyte vexB1 = from[offset - 2];
			ubyte vexB2 = from[offset - 1];

			ret.encoding.vex_xop_3Byte.map_select = vexB1 & 15;
			ret.encoding.vex_xop_3Byte.B = (vexB1 & 32) == 0;
			ret.encoding.vex_xop_3Byte.X = (vexB1 & 64) == 0;
			ret.encoding.vex_xop_3Byte.R = (vexB1 & 128) == 0;

			ubyte vexPP = vexB2 & 3;
			if (vexPP == 1)
				ret.encoding.legacyPrefixes.operandSize = true;
			else if (vexPP == 2)
				ret.encoding.legacyPrefixes.rep = true;
			else if (vexPP == 3)
				ret.encoding.legacyPrefixes.repn = true;

			ret.encoding.vex_xop_3Byte.L = (vexB2 & 4) == 4;
			ret.encoding.vex_xop_3Byte.vvvv = cast(ubyte)~((vexB2 & 78) >> 3);
			ret.encoding.vex_xop_3Byte.W = (vexB2 & 128) == 0;
		} else if ((from[offset] & 0x40) == 0x40) {
			// decode REX prefix
			ubyte rexB = from[offset];

			ret.encoding.base.useREX = true;
			ret.encoding.base.rexPrefix.B = (rexB & 1) == 1;
			ret.encoding.base.rexPrefix.X = (rexB & 2) == 2;
			ret.encoding.base.rexPrefix.R = (rexB & 4) == 4;
			ret.encoding.base.rexPrefix.W = (rexB & 8) == 8;

			offset++;
		} else if (from[offset] == 0x0F) {
			offset++;
			
			if (from.length <= offset)
				return Nullable!X86Decoded.init;

			if (from[offset] == 0x38) {
				ret.encoding.base.useCodeMap38h = true;
				offset++;
			} else if (from[offset] == 0x3A) {
				ret.encoding.base.useCodeMap3Ah = true;
				offset++;
			} else {
				ret.encoding.base.useCodeMapSecondary = true;
			}
		}

		// decode opcode
		
		if (from.length <= offset)
			return Nullable!X86Decoded.init;
		
		ret.encoding.opcode = from[offset];
		offset++;

		// find the instruction variation that we are

		ret.instruction = decideInstructionDecoder(environment, instructionGroups,
			from.length > offset ? from[offset .. $] : null, ret);

		if (ret.instruction is null)
			return Nullable!X86Decoded.init;

		//if (from.length <= offset)
		//	return Nullable!X86Decoded.init;

		// TODO: decode displacement/immeditate

		return Nullable!X86Decoded(ret);
	}

	alias EncodingType = InstructionEncoding.Type;

	const(InstructionVariation)* decideInstructionDecoder(X86Environment environment, const(InstructionGroup[]) instructionGroups, ubyte[] remainingBuffer, ref X86Decoded decoded) {

		foreach(grp; instructionGroups) {
		F2: foreach(ref var; grp.variations) {

				ubyte valueOffset, byteOffsetToImmediate, displacementLengthHint;
				bool valueHadHitPrefix, valueHadHitOpCode;
				X86Encoding.ModRM modRM;
				X86Encoding.SIB sib;

				if (var.noREXPrefixBut64Bit && environment.mode != X86Environment.Mode.Long) {
					continue F2;
				}

				foreach(enc; var.encoding) {
					final switch(enc.type) {
						case EncodingType.ERROR:
							continue F2;
							
						case EncodingType.Value:
							if (decoded.encoding.useVEX_2Byte || decoded.encoding.useVEX_XOP_3Byte) {
								if (valueOffset == 0 && decoded.encoding.opcode == enc.value) {
									valueHadHitOpCode = true;
								} else {
									if (byteOffsetToImmediate < remainingBuffer.length)
										continue F2;
									
									ubyte valueB = remainingBuffer[byteOffsetToImmediate];
									if (valueB != enc.value)
										continue F2;
									
									byteOffsetToImmediate++;
								}
							} else {
								if (valueOffset == 0 && decoded.encoding.base.useCodeMapSecondary) {
									valueHadHitPrefix = true;
								} else if (valueOffset == 1 && (decoded.encoding.base.useCodeMap38h || decoded.encoding.base.useCodeMap3Ah)) {
									valueHadHitPrefix = true;
								} else if (valueOffset == 2 && decoded.encoding.opcode == enc.value) {
									valueHadHitOpCode = true;
								} else {
									if (byteOffsetToImmediate < remainingBuffer.length)
										continue F2;

									ubyte valueB = remainingBuffer[byteOffsetToImmediate];
									if (valueB != enc.value)
										continue F2;

									byteOffsetToImmediate++;
								}
							}

							valueOffset++;
							break;

						case EncodingType.VEXcontrol:
							if (!decoded.encoding.useVEX_2Byte && !decoded.encoding.useVEX_XOP_3Byte)
								continue F2;

							// TODO
							break;

						case EncodingType.VEXdestination:
							if (!decoded.encoding.useVEX_2Byte && !decoded.encoding.useVEX_XOP_3Byte)
								continue F2;

							// TODO
							break;

						case EncodingType.VEXsource:
							if (!decoded.encoding.useVEX_2Byte && !decoded.encoding.useVEX_XOP_3Byte)
								continue F2;

							// TODO
							break;

						case EncodingType.ModRM_Reg:
						case EncodingType.ModRM_Reg_RegMem:
						case EncodingType.ModRM_RegMem_NoRegister:
							if (byteOffsetToImmediate < remainingBuffer.length)
								continue F2;
							ubyte modRMB = remainingBuffer[byteOffsetToImmediate];

							modRM.regmem = modRMB & 7;
							modRM.reg = cast(ubyte)((modRMB & 56) >> 3);
							modRM.mod = cast(ubyte)((modRMB & 200) >> 6);

							byteOffsetToImmediate++;

							// do we have SIB?
							if (environment.mode == X86Environment.Mode.Real) {
								// 16bit

								// general rules
								if (modRM.mod == 1 || modRM.mod == 2)
									displacementLengthHint = modRM.mod;
								else if (modRM.mod == 0 && modRM.regmem == 6)
									displacementLengthHint = 2;
								else
									displacementLengthHint = 0;

							} else if (environment.mode == X86Environment.Mode.Protected || environment.mode == X86Environment.Mode.Long) {
								// 32/64bit

								if (modRM.mod == 0 && modRM.regmem == 5) {
									// exceptions to the general rules
									displacementLengthHint = 4;
								} else if (modRM.mod != 3 && modRM.regmem == 4) {
									// exceptions of the exceptions to the general rules

									// decodes the SIB byte
									if (byteOffsetToImmediate < remainingBuffer.length)
										continue F2;
									ubyte sibB = remainingBuffer[byteOffsetToImmediate];
							
									sib.base = sibB & 7;
									sib.index = cast(ubyte)((sibB & 56) >> 3);
									sib.scale = cast(ubyte)((sibB & 192) >> 6);

									byteOffsetToImmediate++;
									
									if (sib.base == 5 && sib.index == 4) {
										if (modRM.mod == 2 || modRM.mod == 0)
											displacementLengthHint = 4;
										else if (modRM.mod == 1)
											displacementLengthHint = 1;
										else
											assert(0);
									} else {
										// exceptions to the general rules

										if (modRM.mod == 1)
											displacementLengthHint = 1;
										else if (modRM.mod == 2)
											displacementLengthHint = 4;
										else
											displacementLengthHint = 0;
									}

								} else {
									// general rules
									if (modRM.mod == 1)
										displacementLengthHint = 1;
									else if (modRM.mod == 2)
										displacementLengthHint = 4;
									else
										displacementLengthHint = 0;
								}
							}

							break;

						case EncodingType.Displacement:
						case EncodingType.Immediate:
						case EncodingType.Section2WithDisplacement:
						case EncodingType.RegisterEncodeOperand:
							// can't handle, its what I want to know right now
							break;

						case EncodingType.FloatingPointStackOperand:
							// I'm not too sure about these
							break;
					}
				}

				if (valueHadHitOpCode || (!valueHadHitPrefix && valueOffset > 0)) {
					continue F2;
				}

				decoded.encoding.useModRM = X86Encoding.ModRM.init != modRM;
				decoded.encoding.useSIB = X86Encoding.SIB.init != sib;

				decoded.encoding.modRM = modRM;
				decoded.encoding.sib = sib;

				// TODO: have we stored the displacement + immediate yet?

				return &var;
			}
		}

		return null;
	}
}