/**
 * Copyright:
 *    Richard Andrew Cattermole 2016
 * 
 * License:
 *    This software is dual licensed. All rights reserved.
 *    See https://github.com/rikkimax/alphacodegen/blob/master/LICENSE.md for more information.
 */
module alphacodegen.commonstorage.defs;
import alphacodegen.commonbytecode.defs;
import alphacodegen.commontarget.defs;

interface IStorage {
	void setDefaultTarget(ITarget target);

	/**
	 * If target is null, use the one provided by setDefaultTarget.
	 * 
	 * Returns:
	 *    A new symbol if name is not already in use.
	 *    If in use and defined, will return null.
	 *    If in use but not defined (getOrCreateSymbolStartLabel versus newSymbol)
	 *     it will return a new symbol.
	 */
	Symbol newSymbol(string name, ITarget target=null);

	/**
	 * If target is null, use the one provided by setDefaultTarget.
	 * 
	 * Returns:
	 *     SymbolV.start
	 *     where SymbolV.name == name
	 *     otherwise null
	 */
	Label getSymbolStartLabel(string name, ITarget target=null);

	/**
	 * If not already in existance, it will create an extern symbol.
	 * 
	 * If target is null, use the one provided by setDefaultTarget.
	 */
	Label getOrCreateSymbolStartLabel(string name, ITarget target=null);

	/**
	 * If target is null, use the one provided by setDefaultTarget.
	 * 
	 * If not already in existance, it will return null;
	 * If null, when used with IRCondition_J_* will result in false except for equals with both nulls.
	 */
	Label getTargetConstantStartLabel(string name, ITarget target=null);
	/**
	 * Sets a target specific constant for a name
	 * 
	 * If target is null, use the one provided by setDefaultTarget.
	 */
	Label setTargetConstant(string name, TargetConstant value, ITarget target=null);

	protected {
		Instruction startInstructionFor(Symbol symbol);
		Instruction endInstructionFor(Symbol symbol);
		ubyte[] dataFor(Symbol symbol);

		void startInstructionFor(Symbol symbol, Instruction instruction);
		void endInstructionFor(Symbol symbol, Instruction instruction);
		void dataFor(Symbol symbol, ubyte[] data);

		/// Allocates an instruction for a symbol
		Instruction allocateInstructionFor(Symbol symbol);
		/// Deallocates an instruction for a symbol, so it can be reused
		void deallocateInstructionFor(Symbol symbol, Instruction instruction);
	}
}

alias Symbol = SymbolV*;

/**
 * If you muck up the calling convention at this level,
 *  its your own fault.
 */
struct SymbolV {
	private {
		IStorage storage;
		ITarget target_;
	}

	@disable
	this(this);

	invariant {
		// evil, lets prevent non-storage owned symbols!
		assert(storage !is null);
	}

	Label start, end;
	string name;
	Locality locality;

	/**
	 * If any instruction is set to raw at the beguinning of the commit process
	 *  then that symbol cannot be inlined.
	 */
	bool canInline;

	enum Locality {
		/// defines something
		Define,
		/// defines something, and must be exposed (e.g. for dlsym)
		DefineAndExport,
		/// externally defined
		Extern
	}

	@property {
		Instruction startInstruction() { return storage.startInstructionFor(&this); }
		Instruction endInstruction() { return storage.endInstructionFor(&this); }
		const(ubyte[]) data() { return cast(const(ubyte[]))storage.dataFor(&this); }

		void startInstruction(Instruction start) { storage.startInstructionFor(&this, start); }
		void endInstruction(Instruction end) { storage.endInstructionFor(&this, end); }
		void data(ubyte[] data) { storage.dataFor(&this, data); }

		/**
		 * If you have other symbols which has the same instructions just different target,
		 *  feel free to use the instruction here for it.
		 */
		Instruction allocateInstruction() { return storage.allocateInstructionFor(&this); }
		void deallocateInstruction(Instruction instruction) { storage.deallocateInstructionFor(&this, instruction); }

		ITarget target() { return target_; }
	}
}

struct TargetConstant {
align(1):
	bool isArray;

	union {
		struct {
			ubyte constantLength;
			ubyte[21] constant;
		}

		struct {
			ubyte[] array;
		}
	}
}