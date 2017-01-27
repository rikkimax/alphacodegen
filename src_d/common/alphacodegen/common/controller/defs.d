/**
 * Copyright:
 *    Richard Andrew Cattermole 2016
 * 
 * License:
 *    This software is dual licensed. All rights reserved.
 *    See https://github.com/rikkimax/alphacodegen/blob/master/LICENSE.md for more information.
 */
module alphacodegen.commoncontroller.defs;
import alphacodegen.commonoptimisation.defs;
import alphacodegen.commonstorage.defs;
import alphacodegen.commontarget.defs;
import alphacodegen.commonoutput.defs;

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