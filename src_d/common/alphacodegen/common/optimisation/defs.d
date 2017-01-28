/**
 * Copyright:
 *    Richard Andrew Cattermole 2016
 * 
 * License:
 *    This software is dual licensed. All rights reserved.
 *    See https://github.com/rikkimax/alphacodegen/blob/master/LICENSE.md for more information.
 */
module alphacodegen.common.optimisation.defs;
import alphacodegen.common.bytecode.defs;
import alphacodegen.common.storage.defs;
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