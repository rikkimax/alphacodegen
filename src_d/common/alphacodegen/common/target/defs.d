/**
 * Copyright:
 *    Richard Andrew Cattermole 2016
 * 
 * License:
 *    This software is dual licensed. All rights reserved.
 *    See https://github.com/rikkimax/alphacodegen/blob/master/LICENSE.md for more information.
 */
module alphacodegen.common.target.defs;
import alphacodegen.common.bytecode.defs;
import alphacodegen.common.storage.defs;
import alphacodegen.common.optimisation.defs;
import alphacodegen.common.output.defs;

interface ITarget {
	@property {
		GetOptimisations allOptimisations();
	}

	void addOptimisation(IOptimisation optimisation);

	void generate(Symbol symbol, OutputAssembly destination);
	bool isValid(Symbol symbol);
	ulong instructionSize(Instruction instruction);
}