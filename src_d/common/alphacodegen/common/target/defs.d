/**
 * Copyright:
 *    Richard Andrew Cattermole 2016
 * 
 * License:
 *    This software is dual licensed. All rights reserved.
 *    See https://github.com/rikkimax/alphacodegen/blob/master/LICENSE.md for more information.
 */
module alphacodegen.commontarget.defs;
import alphacodegen.commonbytecode.defs;
import alphacodegen.commonstorage.defs;
import alphacodegen.commonoptimisation.defs;
import alphacodegen.commonoutput.defs;

interface ITarget {
	@property {
		GetOptimisations allOptimisations();
	}

	void addOptimisation(IOptimisation optimisation);

	void generate(Symbol symbol, OutputAssembly destination);
	bool isValid(Symbol symbol);
	ulong instructionSize(Instruction instruction);
}