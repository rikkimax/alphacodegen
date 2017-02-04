/**
 * Copyright:
 *    Richard Andrew Cattermole 2016
 * 
 * License:
 *    This software is dual licensed. All rights reserved.
 *    See https://github.com/rikkimax/alphacodegen/blob/master/LICENSE.md for more information.
 */
module alphacodegen.pregen2.target.x86.registers;
import alphacodegen.pregen2.pegged_markdown;
import alphacodegen.common.target.x86.register;

RegisterGroup[] genRegisterDCode(string outputFile, string moduleName) {
    import std.file : write, append;
    
	auto registers = getRegisters("manuscript/targets/x86/registers.md", "manuscript/targets/x86/modrm_sib_encoding.md");
    string registerConstant = genRegisterConstants(registers);
    
    write(outputFile, "// Auto generated, do not edit.
module " ~ moduleName ~ ";
import alphacodegen.common.target.x86.register;

bool findRegister(string name, out Register oreg) {
    foreach(reg; x86Registers) {
        Register match = reg.match(name);

        if (match.name !is null) {
            oreg = match;
            return true;
        }
    }

    return false;
}

");
    append(outputFile, registerConstant);

    return registers;
}

RegisterGroup[] getRegisters(string fromRegisterFile, string fromModRMSIBEncodingFile) {
    import std.file : readText;
	RegisterGroup[] ret;

	genRegisters(Markdown(readText(fromRegisterFile)), ret);
	parseModRMSIB(Markdown(readText(fromModRMSIBEncodingFile)), ret);

    return ret;
}

string genRegisterConstants(RegisterGroup[] registers) {
    import std.conv : text;
    char[] ret;
    
	ret ~= "static immutable(RegisterGroup[]) x86Registers = [\n";
    
	void doReg(Register reg) {
		if (reg.name != "") {
			ret ~= "\t\tRegister(\"" ~ reg.name ~ "\", " ~
					reg.size.text ~ ", " ~ reg.isHigh8.text ~ ", " ~
					reg.requiresREX.text ~ ", " ~ reg.bit64Only.text ~ ",\n" ~
					"\t\t\tEncodeAs(" ~ reg.encodeAs.byDefault.text ~ ", " ~
					reg.encodeAs.withoutREX.text ~ ", " ~
					reg.encodeAs.withREX_B0.text ~ ", " ~
					reg.encodeAs.withREX_B1.text ~ ", " ~
					reg.encodeAs.validWithoutREX.text ~ ", " ~
					reg.encodeAs.validWithREX_B0.text ~ ", " ~
					reg.encodeAs.validWithREX_B1.text ~ ", [\n";

			void doEncodeAsSIB(EncodeForMODRM_SIB v) {
				ret ~= "\t\t\t\t\tEncodeForMODRM_SIB(" ~
					v.displacementLength.text ~ ", " ~
					v.index.text ~ ", " ~
					v.base.text ~ ",\n" ~
					"\t\t\t\t\t\t" ~
					v.useSIB.text ~ ", " ~
					v.validDisplacement.text ~ ", " ~
					v.useIndex.text ~ ", " ~
					v.useBase.text ~ "),\n";
			}

			foreach(sib; reg.encodeAs.arch16ModRM_SIB)
				doEncodeAsSIB(sib);
			ret ~= "\t\t\t\t], [\n";
			foreach(sib; reg.encodeAs.arch32_64ModRM_SIB)
				doEncodeAsSIB(sib);
			ret[$-2] = '\n';
			ret[$-1] = '\t';
			ret ~= "\t\t\t]\n";
			ret ~= "\t\t\t)\n";
			ret ~= "\t\t),\n";
		} else {
			ret ~= "\t\tRegister.init,\n";
		}
	}

    foreach(register; registers) {
		ret ~= "\tRegisterGroup(\n";
		doReg(register.low8);
		doReg(register.high8);
		doReg(register.bit16);
		doReg(register.bit32);
		doReg(register.bit64);

		ret.length--;
		ret[$-1] = '\n';
		ret ~= "\t),\n";
    }
    
    if (registers.length > 0) {
        ret.length -= 2;
        ret ~= "\n";
    }
    
    ret ~= "];\n";
    
    return cast(string)ret;
}

private {
    import pegged.peg : ParseTree;
    
	void genRegisters(ParseTree root, out RegisterGroup[] dst) {
        import std.conv : parse;
		ubyte whichTable;

        void mainTableHandler(ParseTree tableRoot) {
            ParseTree[] headers = tableRoot.children[0].children;
            assert(headers.length == 8);
            
            ParseTree[] entries = tableRoot.children[1 .. $];
            
            if (entries.length == 0)
                return;
            
            foreach(row; entries) {
                assert(row.children.length == 8);

                string encodeAs = row.children[0].matches[0];
                string low8, high8;
                string bit16, bit32, bit64;
                string low8RequiresREX, only64bit;

                low8 = row.children[1].matches[0];
                high8 = row.children[2].matches[0];

                bit16 = row.children[3].matches[0];
                bit32 = row.children[4].matches[0];
                bit64 = row.children[5].matches[0];

                low8RequiresREX = row.children[6].matches[0];
                only64bit = row.children[7].matches[0];

				RegisterGroup toStore;

                assert(encodeAs.length == 3);
                encodeAs = encodeAs[2 .. 3];
                ubyte defaultEncodeAs = parse!ubyte(encodeAs, 16);

				bool bit64Only = only64bit == "Yes";

                toStore.low8.name = low8 == "Invalid" ? "" : low8;
				toStore.low8.encodeAs.byDefault = defaultEncodeAs;
				toStore.low8.requiresREX = low8RequiresREX == "Yes";
				toStore.low8.bit64Only = bit64Only;

				toStore.high8.name = high8 == "Invalid" ? "" : high8;
				toStore.high8.encodeAs.byDefault = defaultEncodeAs;
				toStore.high8.bit64Only = bit64Only;

				toStore.bit16.name = bit16 == "Invalid" ? "" : bit16;
				toStore.bit16.encodeAs.byDefault = defaultEncodeAs;
				toStore.bit16.bit64Only = bit64Only;

				toStore.bit32.name = bit32 == "Invalid" ? "" : bit32;
				toStore.bit32.encodeAs.byDefault = defaultEncodeAs;
				toStore.bit32.bit64Only = bit64Only;

				toStore.bit64.name = bit64 == "Invalid" ? "" : bit64;
				toStore.bit64.encodeAs.byDefault = defaultEncodeAs;
				toStore.bit64.bit64Only = bit64Only;

                dst ~= toStore;
            }
        }
        
		void auxEncodingTableHandler(ParseTree tableRoot) {
			ParseTree[] headers = tableRoot.children[0].children;
			assert(headers.length == 5);
			
			ParseTree[] entries = tableRoot.children[1 .. $];
			
			if (entries.length == 0)
				return;

			foreach(row; entries) {
				assert(row.children.length == 5);

				string encodeAs = row.children[0].matches[0];
				string rb, rw, rd, rq;

				rb = row.children[1].matches[0];
				rw = row.children[2].matches[0];
				rd = row.children[3].matches[0];
				rq = row.children[4].matches[0];

				assert(encodeAs.length == 3);
				encodeAs = encodeAs[2 .. 3];
				ubyte encodeAsVal = parse!ubyte(encodeAs, 16);

				foreach(ref regGrp; dst) {
					void doReg(string rv) {
						Register* reg = cast(Register*)regGrp.matchRef(rv);

						if (reg !is null) {
							if (whichTable == 1) {
								reg.encodeAs.validWithoutREX = true;
								reg.encodeAs.withoutREX = encodeAsVal;
							} else if (whichTable == 2) {
								reg.encodeAs.validWithREX_B0 = true;
								reg.encodeAs.withREX_B0 = encodeAsVal;
							} else if (whichTable == 3) {
								reg.encodeAs.validWithREX_B1 = true;
								reg.encodeAs.withREX_B1 = encodeAsVal;
							}
						}
					}

					doReg(rb);
					doReg(rw);
					doReg(rd);
					doReg(rq);
				}
			}
		}

		// there are four tables we need to handle the usage of
		// first is the general table of registers
		// second, third and fourth are related to encoding
        bool findTable(ParseTree parent) {
            if (parent.name == "Markdown.PipeTable") {
                if (whichTable == 0)
					mainTableHandler(parent);
				else
					auxEncodingTableHandler(parent);

				whichTable++;
                return whichTable == 4;
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

	void parseModRMSIB(ParseTree root, RegisterGroup[] dst) {
		import std.conv : parse;
		ubyte whichHeading, whichTable;

		void generalTableHandler(ParseTree tableRoot) {
			ParseTree[] headers = tableRoot.children[0].children;
			assert(headers.length == 3);
			
			ParseTree[] entries = tableRoot.children[1 .. $];
			
			if (entries.length == 0)
				return;
			
			foreach(row; entries) {
				assert(row.children.length == 3);

				bool is32_64BitVariation = row.children[0].matches[0] == "32/64";
				ubyte mod = row.children[1].matches[0].parse!ubyte(2);
				bool haveDisplacement = row.children[2].matches[0] != "Invalid";
				ubyte displacementLength = haveDisplacement ? row.children[2].matches[0].parse!ubyte(10) : 0;

				foreach(ref regGrp; dst) {
					void doReg(Register* reg) {
						if (reg !is null) {
							if (is32_64BitVariation) {
								reg.encodeAs.arch32_64ModRM_SIB[mod].validDisplacement = haveDisplacement;
								reg.encodeAs.arch32_64ModRM_SIB[mod].displacementLength = displacementLength;
							} else {
								reg.encodeAs.arch16ModRM_SIB[mod].validDisplacement = haveDisplacement;
								reg.encodeAs.arch16ModRM_SIB[mod].displacementLength = displacementLength;
							}
						}
					}

					doReg(&regGrp.low8);
					doReg(&regGrp.high8);
					doReg(&regGrp.bit16);
					doReg(&regGrp.bit32);
					doReg(&regGrp.bit64);
				}
			}
		}

		void negatoryTableHandler(ParseTree tableRoot) {
			ParseTree[] headers = tableRoot.children[0].children;
			assert(headers.length == 5);
			
			ParseTree[] entries = tableRoot.children[1 .. $];
			
			if (entries.length == 0)
				return;
			
			foreach(row; entries) {
				assert(row.children.length == 5);
				
				bool is32_64BitVariation = row.children[0].matches[0] == "32/64";
				ubyte regMem = row.children[1].matches[0].parse!ubyte(2);
				ubyte mod = row.children[2].matches[0].parse!ubyte(2);
				bool haveDisplacement = row.children[3].matches[0] != "Invalid";
				ubyte displacementLength = haveDisplacement ? row.children[3].matches[0].parse!ubyte(10) : 0;
				string displacementCalculation = row.children[4].matches[0];
				
				foreach(ref regGrp; dst) {
					void doReg(Register* reg) {
						if (reg !is null) {
							if (reg.encodeAs.validWithoutREX && reg.encodeAs.withoutREX == regMem ||
								reg.encodeAs.validWithREX_B0 && reg.encodeAs.withREX_B0 == regMem ||
								reg.encodeAs.validWithREX_B1 && reg.encodeAs.withREX_B1 == regMem) {
								
								if (is32_64BitVariation) {
									reg.encodeAs.arch32_64ModRM_SIB[mod].validDisplacement = haveDisplacement;
									reg.encodeAs.arch32_64ModRM_SIB[mod].displacementLength = displacementLength;
								} else {
									reg.encodeAs.arch16ModRM_SIB[mod].validDisplacement = haveDisplacement;
									reg.encodeAs.arch16ModRM_SIB[mod].displacementLength = displacementLength;
								}
							}
						}
					}
					
					doReg(&regGrp.low8);
					doReg(&regGrp.high8);
					doReg(&regGrp.bit16);
					doReg(&regGrp.bit32);
					doReg(&regGrp.bit64);
				}
			}
		}

		void exceptionTableHandler1(ParseTree tableRoot) {
			ParseTree[] headers = tableRoot.children[0].children;
			assert(headers.length == 4);
			
			ParseTree[] entries = tableRoot.children[1 .. $];
			
			if (entries.length == 0)
				return;
			
			foreach(row; entries) {
				assert(row.children.length == 4);

				bool is32_64BitVariation = row.children[0].matches[0] == "32/64";
				ubyte regMem = row.children[1].matches[0].parse!ubyte(2);
				ubyte mod = row.children[2].matches[0].parse!ubyte(2);
				bool haveDisplacement = row.children[3].matches[0] != "Invalid";
				ubyte displacementLength = haveDisplacement ? row.children[3].matches[0].parse!ubyte(10) : 0;

				foreach(ref regGrp; dst) {
					void doReg(Register* reg) {
						if (reg !is null) {
							if (reg.encodeAs.validWithoutREX && reg.encodeAs.withoutREX == regMem ||
								reg.encodeAs.validWithREX_B0 && reg.encodeAs.withREX_B0 == regMem ||
								reg.encodeAs.validWithREX_B1 && reg.encodeAs.withREX_B1 == regMem) {

								if (is32_64BitVariation) {
									reg.encodeAs.arch32_64ModRM_SIB[mod].validDisplacement = haveDisplacement;
									reg.encodeAs.arch32_64ModRM_SIB[mod].displacementLength = displacementLength;
									reg.encodeAs.arch32_64ModRM_SIB[mod].useSIB = true;
								} else {
									reg.encodeAs.arch16ModRM_SIB[mod].validDisplacement = haveDisplacement;
									reg.encodeAs.arch16ModRM_SIB[mod].displacementLength = displacementLength;
									reg.encodeAs.arch16ModRM_SIB[mod].useSIB = true;
								}
							}
						}
					}
					
					doReg(&regGrp.low8);
					doReg(&regGrp.high8);
					doReg(&regGrp.bit16);
					doReg(&regGrp.bit32);
					doReg(&regGrp.bit64);
				}
			}
		}

		void exceptionTableHandler2(ParseTree tableRoot) {
			ParseTree[] headers = tableRoot.children[0].children;
			assert(headers.length == 5);
			
			ParseTree[] entries = tableRoot.children[1 .. $];
			
			if (entries.length == 0)
				return;
			
			foreach(row; entries) {
				assert(row.children.length == 5);
				
				bool is32_64BitVariation = row.children[0].matches[0] == "32/64";
				ubyte regMem = row.children[1].matches[0].parse!ubyte(2);
				ubyte mod = row.children[2].matches[0].parse!ubyte(2);
				bool haveDisplacement = row.children[3].matches[0] != "Invalid";
				ubyte displacementLength = haveDisplacement ? row.children[3].matches[0].parse!ubyte(10) : 0;
				string displacementCalculation = row.children[4].matches[0];

				// assumption SIB.index = 100
				// assumption SIB.base = 101

				foreach(ref regGrp; dst) {
					void doReg(Register* reg) {
						if (reg !is null) {
							if (reg.encodeAs.validWithoutREX && reg.encodeAs.withoutREX == regMem ||
								reg.encodeAs.validWithREX_B0 && reg.encodeAs.withREX_B0 == regMem ||
								reg.encodeAs.validWithREX_B1 && reg.encodeAs.withREX_B1 == regMem) {
								
								if (is32_64BitVariation) {
									reg.encodeAs.arch32_64ModRM_SIB[mod].validDisplacement = haveDisplacement;
									reg.encodeAs.arch32_64ModRM_SIB[mod].displacementLength = displacementLength;
									reg.encodeAs.arch32_64ModRM_SIB[mod].useSIB = true;
									reg.encodeAs.arch32_64ModRM_SIB[mod].useBase = true;
									reg.encodeAs.arch32_64ModRM_SIB[mod].useIndex = true;
									reg.encodeAs.arch32_64ModRM_SIB[mod].index = 0b100;
									reg.encodeAs.arch32_64ModRM_SIB[mod].base = 0b101;
								} else {
									reg.encodeAs.arch16ModRM_SIB[mod].validDisplacement = haveDisplacement;
									reg.encodeAs.arch16ModRM_SIB[mod].displacementLength = displacementLength;
									reg.encodeAs.arch16ModRM_SIB[mod].useSIB = true;
									reg.encodeAs.arch32_64ModRM_SIB[mod].useBase = true;
									reg.encodeAs.arch32_64ModRM_SIB[mod].useIndex = true;
									reg.encodeAs.arch32_64ModRM_SIB[mod].index = 0b100;
									reg.encodeAs.arch32_64ModRM_SIB[mod].base = 0b101;
								}
							}
						}
					}
					
					doReg(&regGrp.low8);
					doReg(&regGrp.high8);
					doReg(&regGrp.bit16);
					doReg(&regGrp.bit32);
					doReg(&regGrp.bit64);
				}
			}
		}

		// first find the second header in file then deal with the tables
		// there are two tables we need to handle the usage of
		// first is general use cases
		// second is the exception(1) and third is exception(2)
		bool findTable(ParseTree parent) {
			if (whichHeading == 2 && parent.name == "Markdown.PipeTable") {
				if (whichTable == 0)
					generalTableHandler(parent);
				else if (whichTable == 1)
					negatoryTableHandler(parent);
				else if (whichTable == 2)
					exceptionTableHandler1(parent);
				else
					exceptionTableHandler2(parent);
				
				whichTable++;
				return whichTable == 4;
			} else {
				if (parent.name == "Markdown.Heading") {
					whichHeading++;
				}

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
