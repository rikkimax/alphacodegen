/**
 * Copyright:
 *    Richard Andrew Cattermole 2016
 * 
 * License:
 *    This software is dual licensed. All rights reserved.
 *    See https://github.com/rikkimax/alphacodegen/blob/master/LICENSE.md for more information.
 */
module alphacodegen.common.controller.defs;
import alphacodegen.common.optimisation.defs;
import alphacodegen.common.storage.defs;
import alphacodegen.common.target.defs;
import alphacodegen.common.output.defs;

interface IController {
	@property {
		GetOptimisations allOptimisations();
		IStorage storage();
		ITarget defaultTarget();
		ITargetOutput targetOutput();
	}

	void addOptimisation(IOptimisation optimisation);
	void setDefaultTarget(ITarget target);

}