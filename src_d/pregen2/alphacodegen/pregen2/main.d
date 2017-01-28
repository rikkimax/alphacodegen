/**
 * Copyright:
 *    Richard Andrew Cattermole 2016
 * 
 * License:
 *    This software is dual licensed. All rights reserved.
 *    See https://github.com/rikkimax/alphacodegen/blob/master/LICENSE.md for more information.
 */
module alphacodegen.pregen2.main;
import std.stdio : writeln;
import alphacodegen.common.target.x86.register;
import alphacodegen.common.target.x86.instruction;
import alphacodegen.pregen2.target.x86.registers : genRegisterDCode;
import alphacodegen.pregen2.target.x86.instructions : genInstructionsDCode;
import alphacodegen.common.target.x86.encoding : encode;

void main() {
	writeln("# Target backends");
	writeln("## x86");

    writeln("### Generating D registers from markdown files");
    
    RegisterGroup[] registers = genRegisterDCode("src_d/generated/alphacodegen/targets/x86/registers.d", "alphacodegen.targets.x86.registers");
    
    writeln("Done!");
    writeln("### Generating markdown for instruction maps");

	InstructionGroup[] instructionGroups = genInstructionsDCode("src_d/generated/alphacodegen/targets/x86/instructions.d", "alphacodegen.targets.x86.instructions", cast(const)registers);

    writeln("Done!");

	writeln("# Lang spec");
	writeln("## Parsing C definition");

	writeln("Done!");
}
