/**
 * Copyright:
 *    Richard Andrew Cattermole 2016
 * 
 * License:
 *    This software is dual licensed. All rights reserved.
 *    See https://github.com/rikkimax/alphacodegen/blob/master/LICENSE.md for more information.
 */
module alphacodegen.common.emitpoint.defs;
import alphacodegen.common.storage.defs;

/// A point in time that takes all that you give it and even gives you something back!
interface IEmitPoint {
	void addSymbol(Symbol symbol);
	ubyte[] finalize();
}

interface IEmitJIT : IEmitPoint {
	void reset();
	void finalize();

	void* opIndex(size_t symbolOffset);
	void* opIndex(string symbolName);
}

interface IEmitObjectFile : IEmitPoint {
}