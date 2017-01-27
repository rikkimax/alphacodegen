module alphacodegen.commonoptimisation.defs;
import alphacodegen.commonbytecode.defs;
import alphacodegen.commonstorage.defs;
import semver;

interface IOptimisation {
	@property {
		string name();
		SemVer currentVersion();
		bool targetSpecific();
		bool enabled();
	}

	void enable();
	void optimise(Symbol);
}

struct GetOptimisations {
	import std.range : front, empty, popFront;
	private IOptimisation[] optimisations;

	this(IOptimisation[] optimisations...) {
		this.optimisations = optimisations;
	}

	@disable
	this(this);

	@property {
		IOptimisation front() {
			return optimisations.front;
		}

		bool empty() {
			return optimisations.empty;
		}
	}

	void popFront() {
		optimisations.popFront;
	}
}