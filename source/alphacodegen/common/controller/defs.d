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