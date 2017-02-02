/**
 * Copyright:
 *    Richard Andrew Cattermole 2016
 * 
 * License:
 *    This software is dual licensed. All rights reserved.
 *    See https://github.com/rikkimax/alphacodegen/blob/master/LICENSE.md for more information.
 */
module alphacodegen.pregen2.target.x86.instructions;
import alphacodegen.common.target.x86.segments;
import alphacodegen.common.target.x86.register;
import alphacodegen.common.target.x86.instruction;
import alphacodegen.pregen2.pegged_markdown;

InstructionGroup[] genInstructionsDCode(string outputFile, string moduleName, const RegisterGroup[] registers) {
	import std.file : write, append;
	
	auto instructions = getInstructions(registers);
	string instructionsConstant = genInstructionsConstants(instructions);
	
	write(outputFile, "// Auto generated, do not edit.
module " ~ moduleName ~ ";
import alphacodegen.common.targets.x86.instruction;

private alias EncodingType = InstructionEncoding.Type;
private import alphacodegen.common.targets.x86.encoding : X86Encoding;


/+bool findRegister(string name, out Register oreg) {
    foreach(reg; x86Registers) {
        Register match = reg.match(name);

        if (match.name !is null) {
            oreg = match;
            return true;
        }
    }

    return false;
}+/

");
	append(outputFile, instructionsConstant);
	
	return instructions;
}

InstructionGroup[] getInstructions(const RegisterGroup[] registers) {
    import std.file : dirEntries, SpanMode, readText;
    import core.memory : GC;

    InstructionGroup[] ret;

    GC.disable;

    foreach(fe; dirEntries("manuscript/targets/x86/instructions", SpanMode.breadth)) {
		if (fe.name == "introduction.md") {
			// ignore files we won't need
		} else {
    		readInstructions(registers, Markdown(readText(fe.name)), ret);
    		GC.collect;
		}
    }

	// need to process another file for noREXPrefixBut64Bit
	processOutNoREXPrefix(registers, ret, Markdown(readText("manuscript/targets/x86/encodingSizes.md")));

    GC.enable;
    return ret;
}

private {
    import pegged.peg : ParseTree;

	string genInstructionsConstants(InstructionGroup[] instructionGroups) {
		import std.conv : text;
		char[] ret;
		
		ret ~= "static immutable(InstructionGroup[]) x86Instructions = [\n";

		foreach(grp; instructionGroups) {
			ret ~= "\tInstructionGroup(\"" ~ grp.title ~ "\", [\n";

			foreach(var; grp.variations) {
				ret ~= "\t\tInstructionVariation(\n";

				ret ~= "\t\t\tInstructionMnemonic(";

				if (var.mnemonic.operands.length > 0) {
					ret ~= "\n\t\t\t\t\"" ~ var.mnemonic.name ~ "\", [\n";

					foreach(vmo; var.mnemonic.operands) {
						ret ~= "\t\t\t\t\t\"" ~ vmo ~ "\",\n";
					}

					ret.length--;
					ret[$-1] = '\n';
					ret ~= "\t\t\t\t]\n";
					ret ~= "\t\t\t), [\n";
				} else {
					ret ~= "\"" ~ var.mnemonic.name ~ "\"), [\n";
				}

				foreach(enc; var.encoding) {
					ret ~= "\t\t\t\tInstructionEncoding(";
					final switch(enc.type) {
						case InstructionEncoding.Type.ERROR:
							ret ~= "EncodingType.ERROR),\n";
							break;
						case InstructionEncoding.Type.Value:
							ret ~= "EncodingType.Value, " ~ enc.value.text ~ "),\n";
							break;
						case InstructionEncoding.Type.ModRM_Reg:
							ret ~= "EncodingType.ModRM_Reg, " ~ enc.value.text ~ "),\n";
							break;
						case InstructionEncoding.Type.ModRM_Reg_RegMem:
							ret ~= "EncodingType.ModRM_Reg_RegMem),\n";
							break;
						case InstructionEncoding.Type.Immediate:
							ret ~= "EncodingType.Immediate, " ~ enc.value.text ~ "),\n";
							break;
						case InstructionEncoding.Type.Section2WithDisplacement:
							ret ~= "EncodingType.Section2WithDisplacement, " ~ enc.size.text ~ "),\n";
							break;
						case InstructionEncoding.Type.Displacement:
							ret ~= "EncodingType.Displacement, " ~ enc.size.text ~ "),\n";
							break;
						case InstructionEncoding.Type.FloatingPointStackOperand:
							ret ~= "EncodingType.FloatingPointStackOperand, " ~ enc.value.text ~ "),\n";
							break;
						case InstructionEncoding.Type.ModRM_RegMem_NoRegister:
							ret ~= "EncodingType.ModRM_RegMem_NoRegister),\n";
							break;
						case InstructionEncoding.Type.RegisterEncodeOperand:
							ret ~= "EncodingType.RegisterEncodeOperand),\n";
							break;
						case InstructionEncoding.Type.VEXsource:
						case InstructionEncoding.Type.VEXdestination:
						case InstructionEncoding.Type.VEXcontrol:
							ret ~= "EncodingType." ~ enc.type.text ~ ",\n" ~
								"\t\t\t\t\tInstructionEncodingVEX(" ~
								enc.vexPrefix.operandSizeOverride.text ~ ", " ~
								enc.vexPrefix.rep.text ~ ", " ~ enc.vexPrefix.rep.text ~ ",\n";

							ret ~= "\t\t\t\t\t\t" ~ enc.vexPrefix.isXOP.text ~ ", " ~
								enc.vexPrefix.R.text ~ ", " ~
								enc.vexPrefix.X.text ~ ", " ~
								enc.vexPrefix.B.text ~ ", " ~
								enc.vexPrefix.map_select.text ~ ", " ~
								enc.vexPrefix.W.text ~ ", " ~
								enc.vexPrefix.vvvv.text ~ ", " ~
								enc.vexPrefix.L.text ~ ")),\n";
							break;
					}
				}

				if (var.encoding.length > 0) {
					ret.length--;
					ret[$-1] = '\n';
				}

				ret ~= "\t\t\t],\n";
				ret ~= "\t\t\t" ~ var.noREXPrefixBut64Bit.text ~ ",\n";

				// TODO: MORE STUFF

				ret ~= "\t\t), \n";
			}

			if (grp.variations.length > 0) {
				ret.length -= 2;
				ret[$-1] = '\n';
			}

			ret ~= "\t]),\n";
		}

		if (instructionGroups.length > 0) {
			ret.length -= 2;
			ret ~= "\n";
		}
		
		ret ~= "];\n";
		
		return cast(string)ret;
	}

	void readInstructions(const RegisterGroup[] registers, ParseTree root, ref InstructionGroup[] groups) {
        import std.conv : parse;

        string groupTitle;

        void tableHandler(ParseTree tableRoot) {
            ParseTree[] headers = tableRoot.children[0].children;
            assert(headers.length == 4 || headers.length == 5);
            
            ParseTree[] entries = tableRoot.children[1 .. $];
            
            if (entries.length == 0)
                return;
            
            foreach(row; entries) {
                assert(row.children.length == headers.length);

				size_t offset1 = row.children.length == 5 ? 1 : 0;

                string mnemonic = row.children[0].matches[0];
				string vexPrefix = row.children.length == 5 ? row.children[1].matches[0] : null;
				string opcode = row.children[1 + offset1].matches[0];
                string valid64Bit = row.children[2 + offset1].matches[0];
                string comment = row.children[3 + offset1].matches[0];

				// FIXME: do something with comment!
				// FIXME: strip the input!

                handleParsingInstruction(groups, registers, groupTitle, mnemonic, opcode, vexPrefix, valid64Bit);
            }
        }
        
        bool findTable(ParseTree parent) {
            import std.string : strip;

            if (parent.name == "Markdown.PipeTable") {
                tableHandler(parent);
                return true;
            } else if (groupTitle is null && parent.name == "Markdown.AtxHeading") {
                groupTitle = parent.matches[1].strip;

                return false;
            } else {
                foreach(child; parent.children) {
                    if (findTable(child))
                        return true;
                }
            }
            
            return false;
        }
        
        bool tableFound = findTable(root);
        
    }

	void handleParsingInstruction(ref InstructionGroup[] groups, const RegisterGroup[] registers, string groupTitle, string mnemonic, string opcode, string vexPrefix, string valid64Bit) {
        import std.array : split;
        import std.string : toLowerInPlace, indexOf;
        import std.conv : parse;

        // first split up mnemonic

        string[] mnemonics = split(mnemonic);
        string[] encoding = split(opcode);
		string[] vex_xop;

        char[20] temp;
        char[] temp2 = temp[];

		temp[] = ' ';
        temp[0 .. valid64Bit.length] = valid64Bit[];
        toLowerInPlace(temp2);

        bool requires64bit = temp[0 .. valid64Bit.length] == "requires";
        bool validIn64bit = temp[0 .. valid64Bit.length] == "valid" || requires64bit;
		
		if (vexPrefix !is null) {
			temp[] = ' ';
			temp[0 .. vexPrefix.length] = vexPrefix[];
			toLowerInPlace(temp2);

			if (temp[0 .. vexPrefix.length] != "invalid") {
				vex_xop = (cast(string)temp[0 .. vexPrefix.length]).split;
				assert(vex_xop.length == 2);
			}
		}

        foreach(ref mne; mnemonics) {
            if (mne[$-1] == ',')
                mne.length--;
        }

        foreach(ref enc; encoding) {
            if (enc[$-1] == ',')
                enc.length--;
        }

        InstructionGroup* theGroup;
        InstructionVariation ret;

        foreach(i, grp; groups) {
            if (grp.title == groupTitle) {
                theGroup = &(groups[i]);
                break;
            }
        }

        if (theGroup is null) {
            InstructionGroup tgi;
            tgi.title = groupTitle;
            groups ~= tgi;
            theGroup = &(groups[$-1]);
        }

		ret.mnemonic.name = mnemonics[0];
		mnemonics = mnemonics[1 .. $];
		ret.mnemonic.operands = mnemonics;

        // from this point on we don't care about the mnemonics
        //  encoding tells us everything we need to know
        // mnemonics is only really useful for humans
        //  so we'll store it anyway, but won't use/parse it

		if (vex_xop.length > 0) {
			InstructionEncoding instEnc;

			// TODO: which VEX or XOP is it?

			assert(vex_xop[0][$-3] == '.');
			assert(vex_xop[1].length == 11);

			string map_select_v = vex_xop[0][$-2 .. $];

			instEnc.vexPrefix.map_select = map_select_v.parse!ubyte(16);
			instEnc.vexPrefix.isXOP = instEnc.vexPrefix.map_select >= 8; // remember no maps above 10!

			foreach(c; vex_xop[0][0 .. $-3]) {
				switch(c) {
					case 'r':
						instEnc.vexPrefix.R = true;
						break;
					case 'x':
						instEnc.vexPrefix.X = true;
						break;
					case 'b':
						instEnc.vexPrefix.B = true;
						break;
					default:
						assert(0);
				}
			}

			// W.vvvv.L.pp

			assert(vex_xop[1][1] == '.');
			assert(vex_xop[1][6] == '.');
			assert(vex_xop[1][8] == '.');

			string t;

			if (vex_xop[1][2 .. 7] == "cntrl") {
				instEnc.type = InstructionEncoding.Type.VEXcontrol;
			} else if (vex_xop[1][2 .. 5] == "src") {
				instEnc.type = InstructionEncoding.Type.VEXsource;
				t = vex_xop[1][5 .. 7];
				instEnc.vexPrefix.vvvv = t.parse!ubyte(16);
			} else if (vex_xop[1][2 .. 5] == "dst") {
				instEnc.type = InstructionEncoding.Type.VEXdestination;
				t = vex_xop[1][5 .. 7];
				instEnc.vexPrefix.vvvv = t.parse!ubyte(16);
			} else assert(0);

			instEnc.vexPrefix.W = vex_xop[1][0] == '1';
			instEnc.vexPrefix.L = vex_xop[1][7] == '1';

			if (vex_xop[1][$-2 .. $] == "01") {
				instEnc.vexPrefix.operandSizeOverride = true;
			} else if (vex_xop[1][$-2 .. $] == "10") {
				instEnc.vexPrefix.rep = true;
			} else if (vex_xop[1][$-2 .. $] == "11") {
				instEnc.vexPrefix.repn = true;
			}

			ret.encoding ~= instEnc;
		}

		foreach(encI, enc; encoding) {
			InstructionEncoding instEnc;

			if (enc == "+rb") {
				instEnc.type = InstructionEncoding.Type.RegisterEncodeOperand;
				instEnc.value = 1;
			} else if (enc == "+rw") {
				instEnc.type = InstructionEncoding.Type.RegisterEncodeOperand;
				instEnc.value = 2;
			} else if (enc == "+rd") {
				instEnc.type = InstructionEncoding.Type.RegisterEncodeOperand;
				instEnc.value = 4;
			} else if (enc == "+rq") {
				instEnc.type = InstructionEncoding.Type.RegisterEncodeOperand;
				instEnc.value = 8;
			} else if (enc == "m64") {
				instEnc.type = InstructionEncoding.Type.ModRM_RegMem_NoRegister;
			} else if (enc.length == 2 && enc[0] == '+' && enc[1] >= '0' && enc[1] <= '7') {
				// +idigit
				// for REX.B or non REX prefix use non 64bit extension registers
				// for REX.B use 64bit extension registers

				instEnc.type = InstructionEncoding.Type.FloatingPointStackOperand;
				instEnc.value = cast(ubyte)(enc[1] - '0');
			} else if (enc == "cb") {
				// code offset immediate after opcode

				instEnc.type = InstructionEncoding.Type.Displacement;
				instEnc.size = 1;
			} else if (enc == "cw") {
				// code offset immediate after opcode

				instEnc.type = InstructionEncoding.Type.Displacement;
				instEnc.size = 2;
			} else if (enc == "cd") {
				// code offset immediate after opcode

				instEnc.type = InstructionEncoding.Type.Displacement;
				instEnc.size = 4;
			} else if (enc == "cp") {
				// code offset immediate after opcode

				instEnc.type = InstructionEncoding.Type.Displacement;
				instEnc.size = 6;
			} else if (enc == "cw:cw") {
				// code offset immediate after opcode

				instEnc.type = InstructionEncoding.Type.Section2WithDisplacement;
				instEnc.size = 2;
			} else if (enc == "cd:cw") {
				// code offset immediate after opcode

				instEnc.type = InstructionEncoding.Type.Section2WithDisplacement;
				instEnc.size = 4;
			} else if (enc == "ib") {
				// follows code offset if exists after opcode

				instEnc.type = InstructionEncoding.Type.Immediate;
				instEnc.size = 1;
			} else if (enc == "iw") {
				// follows code offset if exists after opcode

				instEnc.type = InstructionEncoding.Type.Immediate;
				instEnc.size = 2;
			} else if (enc == "id") {
				// follows code offset if exists after opcode

				instEnc.type = InstructionEncoding.Type.Immediate;
				instEnc.size = 4;
			} else if (enc == "iq") {
				// follows code offset if exists after opcode

				instEnc.type = InstructionEncoding.Type.Immediate;
				instEnc.size = 8;
			} else if (enc == "/r") {
				// /r
				// uses ModRM.reg + ModRM.regmem
				
				instEnc.type = InstructionEncoding.Type.ModRM_Reg_RegMem;
			} else if (enc.length == 2 && enc[0] == '/' && (enc[1] >= '0' && enc[1] <= '9')) {
				// /digit
				// store in ModRM.reg

				instEnc.type = InstructionEncoding.Type.ModRM_Reg;
				instEnc.value = cast(ubyte)(enc[1] - '0');
			} else if (enc.length == 2 &&
				((enc[0] >= '0' && enc[0] <= '9') || (enc[0] >= 'A' && enc[0] <= 'F')) &&
				((enc[1] >= '0' && enc[1] <= '9') || (enc[1] >= 'A' && enc[1] <= 'F'))) {
				// value

				instEnc.type = InstructionEncoding.Type.Value;
				instEnc.value = enc.parse!ubyte(16);
			}

			ret.encoding ~= instEnc;
        }

        theGroup.variations ~= ret;
    }

	bool isHexValue(T)(T[] value) {
		if (value.length == 0)
			return false;

		size_t offset = value[0] == '-' ? 1 : 0;

		if (offset == 1 && value.length == 1)
			return false;

		foreach(v; value[offset .. $]) {
			if (v >= 'a' && v <= 'f') {}
			else if (v >= 'A' && v <= 'F') {}
			else if (v >= '0' && v <= '9') {}
			else
				return false;
		}

		return true;
	}

	void processOutNoREXPrefix(const RegisterGroup[] registers, ref InstructionGroup[] groups, ParseTree root) {
		void handleEntry(string group, ParseTree filters) {
			InstructionGroup* theGroup;

			foreach(ref grp; groups) {
				if (grp.title == group) {
					theGroup = &grp;
					break;
				}
			}

			if (theGroup is null) {
				import std.stdio : writeln;
				writeln("FIXME: ", __MODULE__, ":processOutNoREXPrefix.handleEntry|", group);
				return;
			}

			// ok we have a group, now we need to know if we're subfiltering

			if (filters is ParseTree.init) {
				// set to all
				foreach(variation; theGroup.variations) {
					variation.noREXPrefixBut64Bit = true;
				}
			} else {
				foreach(child; filters.children) {
					if (child.name == "Markdown.ListBlock" && child.children.length > 2) {
						string theFilter = child.children[2].matches[0];
						// TODO: umm how exactly do we apply this filter????
						//variation.noREXPrefixBut64Bit = true;
					}
				}
			}
		}

		bool findTable(ParseTree parent) {
			if (parent.name == "Markdown.BulletList") {
				ParseTree[] children = parent.children;
				while(children.length > 0) {
					if (children.length > 1) {
						if (children[1].name == "Markdown.ListContinuationBlock") {
							handleEntry(children[0].input[children[0].begin .. children[0].end], children[1]);

							if (children.length > 2) {
								children = children[2 .. $];
								continue;
							} else
								break;
						}
					}

					handleEntry(children[0].input[children[0].begin .. children[0].end], ParseTree.init);

					if (children.length > 1) {
						children = children[1 .. $];
						continue;
					} else
						break;
				}

				return true;
			} else {
				foreach(child; parent.children) {
					if (findTable(child))
						return true;
				}
			}

			return false;
		}
		
		bool tablesFound = findTable(root);
	}
}
