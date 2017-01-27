module alphacodegen.commonoutput.defs;
import alphacodegen.commonstorage.defs;

interface ITargetOutput {
	@property {
		bool requriesNoPatches();
		const(ubyte[]) linkedOutput();
	}

	void addSymbol(Symbol);
	void link();
}

interface OutputAssembly {
	void put(ubyte[] bytes...);
}

final class OutputAssemblyAppender : OutputAssembly {
	import std.array : appender;
	auto values = appender!(ubyte[])();
	
	void put(ubyte[] bytes...) {
		values ~= bytes;
	}
	
	@property {
		ubyte[] data() { return values.data; }
	}
}

final class OutputAssemblyCounter : OutputAssembly {
	size_t counter;
	
	void put(ubyte[] bytes...) {
		counter += bytes.length;
	}
}