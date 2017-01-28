// Auto generated, do not edit.
module alphacodegen.targets.x86.registers;
import alphacodegen.common.targets.x86.register;

bool findRegister(string name, out Register oreg) {
    foreach(reg; x86Registers) {
        Register match = reg.match(name);

        if (match.name !is null) {
            oreg = match;
            return true;
        }
    }

    return false;
}

static immutable(RegisterGroup[]) x86Registers = [
	RegisterGroup(
		Register("AL", 0, false, false, false,
			EncodeAs(0, 0, 0, 0, true, true, false, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("AH", 0, false, false, false,
			EncodeAs(0, 4, 0, 0, true, false, false, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(4, 4, 5,
						true, true, true, true),
					EncodeForMODRM_SIB(1, 4, 5,
						true, true, true, true),
					EncodeForMODRM_SIB(4, 4, 5,
						true, true, true, true),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("AX", 0, false, false, false,
			EncodeAs(0, 0, 0, 0, true, true, false, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("eAX", 0, false, false, false,
			EncodeAs(0, 0, 0, 0, true, true, false, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("rAX", 0, false, false, false,
			EncodeAs(0, 0, 0, 0, true, true, false, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		)
	),
	RegisterGroup(
		Register("BL", 0, false, false, false,
			EncodeAs(3, 3, 3, 0, true, true, false, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("BH", 0, false, false, false,
			EncodeAs(3, 7, 0, 0, true, false, false, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("BX", 0, false, false, false,
			EncodeAs(3, 3, 3, 0, true, true, false, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("eBX", 0, false, false, false,
			EncodeAs(3, 3, 3, 0, true, true, false, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("rBX", 0, false, false, false,
			EncodeAs(3, 3, 3, 0, true, true, false, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		)
	),
	RegisterGroup(
		Register("CL", 0, false, false, false,
			EncodeAs(1, 1, 1, 0, true, true, false, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("CH", 0, false, false, false,
			EncodeAs(1, 5, 0, 0, true, false, false, [
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("CX", 0, false, false, false,
			EncodeAs(1, 1, 1, 0, true, true, false, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("eCX", 0, false, false, false,
			EncodeAs(1, 1, 1, 0, true, true, false, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("rCX", 0, false, false, false,
			EncodeAs(1, 1, 1, 0, true, true, false, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		)
	),
	RegisterGroup(
		Register("DL", 0, false, false, false,
			EncodeAs(2, 2, 2, 0, true, true, false, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("DH", 0, false, false, false,
			EncodeAs(2, 6, 0, 0, true, false, false, [
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("DX", 0, false, false, false,
			EncodeAs(2, 2, 2, 0, true, true, false, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("eDX", 0, false, false, false,
			EncodeAs(2, 2, 2, 0, true, true, false, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("rDX", 0, false, false, false,
			EncodeAs(2, 2, 2, 0, true, true, false, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		)
	),
	RegisterGroup(
		Register("SIL", 0, false, true, false,
			EncodeAs(6, 0, 6, 0, false, true, false, [
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register.init,
		Register("SI", 0, false, false, false,
			EncodeAs(6, 6, 6, 0, true, true, false, [
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("eSI", 0, false, false, false,
			EncodeAs(6, 6, 6, 0, true, true, false, [
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("rSI", 0, false, false, false,
			EncodeAs(6, 6, 6, 0, true, true, false, [
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		)
	),
	RegisterGroup(
		Register("DIL", 0, false, true, false,
			EncodeAs(7, 0, 7, 0, false, true, false, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register.init,
		Register("DI", 0, false, false, false,
			EncodeAs(7, 7, 7, 0, true, true, false, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("eDI", 0, false, false, false,
			EncodeAs(7, 7, 7, 0, true, true, false, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("rDI", 0, false, false, false,
			EncodeAs(7, 7, 7, 0, true, true, false, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		)
	),
	RegisterGroup(
		Register("BPL", 0, false, true, false,
			EncodeAs(5, 0, 5, 0, false, true, false, [
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register.init,
		Register("BP", 0, false, false, false,
			EncodeAs(5, 5, 5, 0, true, true, false, [
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("eBP", 0, false, false, false,
			EncodeAs(5, 5, 5, 0, true, true, false, [
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("rBP", 0, false, false, false,
			EncodeAs(5, 5, 5, 0, true, true, false, [
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		)
	),
	RegisterGroup(
		Register("SPL", 0, false, true, false,
			EncodeAs(4, 0, 4, 0, false, true, false, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(4, 4, 5,
						true, true, true, true),
					EncodeForMODRM_SIB(1, 4, 5,
						true, true, true, true),
					EncodeForMODRM_SIB(4, 4, 5,
						true, true, true, true),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register.init,
		Register("SP", 0, false, false, false,
			EncodeAs(4, 4, 4, 0, true, true, false, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(4, 4, 5,
						true, true, true, true),
					EncodeForMODRM_SIB(1, 4, 5,
						true, true, true, true),
					EncodeForMODRM_SIB(4, 4, 5,
						true, true, true, true),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("eSP", 0, false, false, false,
			EncodeAs(4, 4, 4, 0, true, true, false, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(4, 4, 5,
						true, true, true, true),
					EncodeForMODRM_SIB(1, 4, 5,
						true, true, true, true),
					EncodeForMODRM_SIB(4, 4, 5,
						true, true, true, true),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("rSP", 0, false, false, false,
			EncodeAs(4, 4, 4, 0, true, true, false, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(4, 4, 5,
						true, true, true, true),
					EncodeForMODRM_SIB(1, 4, 5,
						true, true, true, true),
					EncodeForMODRM_SIB(4, 4, 5,
						true, true, true, true),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		)
	),
	RegisterGroup(
		Register("r8B", 0, false, false, true,
			EncodeAs(8, 0, 0, 0, false, false, true, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register.init,
		Register("r8W", 0, false, false, true,
			EncodeAs(8, 0, 0, 0, false, false, true, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("r8D", 0, false, false, true,
			EncodeAs(8, 0, 0, 0, false, false, true, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("r8", 0, false, false, true,
			EncodeAs(8, 0, 0, 0, false, false, true, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		)
	),
	RegisterGroup(
		Register("r9B", 0, false, false, true,
			EncodeAs(9, 0, 0, 3, false, false, true, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register.init,
		Register("r9W", 0, false, false, true,
			EncodeAs(9, 0, 0, 3, false, false, true, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("r9D", 0, false, false, true,
			EncodeAs(9, 0, 0, 3, false, false, true, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("r9", 0, false, false, true,
			EncodeAs(9, 0, 0, 3, false, false, true, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		)
	),
	RegisterGroup(
		Register("r10B", 0, false, false, true,
			EncodeAs(10, 0, 0, 1, false, false, true, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register.init,
		Register("r10W", 0, false, false, true,
			EncodeAs(10, 0, 0, 1, false, false, true, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("r10D", 0, false, false, true,
			EncodeAs(10, 0, 0, 1, false, false, true, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("r10", 0, false, false, true,
			EncodeAs(10, 0, 0, 1, false, false, true, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		)
	),
	RegisterGroup(
		Register("r11B", 0, false, false, true,
			EncodeAs(11, 0, 0, 2, false, false, true, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register.init,
		Register("r11W", 0, false, false, true,
			EncodeAs(11, 0, 0, 2, false, false, true, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("r11D", 0, false, false, true,
			EncodeAs(11, 0, 0, 2, false, false, true, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("r11", 0, false, false, true,
			EncodeAs(11, 0, 0, 2, false, false, true, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		)
	),
	RegisterGroup(
		Register("r12B", 0, false, false, true,
			EncodeAs(12, 0, 0, 4, false, false, true, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(4, 4, 5,
						true, true, true, true),
					EncodeForMODRM_SIB(1, 4, 5,
						true, true, true, true),
					EncodeForMODRM_SIB(4, 4, 5,
						true, true, true, true),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register.init,
		Register("r12W", 0, false, false, true,
			EncodeAs(12, 0, 0, 4, false, false, true, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(4, 4, 5,
						true, true, true, true),
					EncodeForMODRM_SIB(1, 4, 5,
						true, true, true, true),
					EncodeForMODRM_SIB(4, 4, 5,
						true, true, true, true),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("r12D", 0, false, false, true,
			EncodeAs(12, 0, 0, 4, false, false, true, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(4, 4, 5,
						true, true, true, true),
					EncodeForMODRM_SIB(1, 4, 5,
						true, true, true, true),
					EncodeForMODRM_SIB(4, 4, 5,
						true, true, true, true),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("r12", 0, false, false, true,
			EncodeAs(12, 0, 0, 4, false, false, true, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(4, 4, 5,
						true, true, true, true),
					EncodeForMODRM_SIB(1, 4, 5,
						true, true, true, true),
					EncodeForMODRM_SIB(4, 4, 5,
						true, true, true, true),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		)
	),
	RegisterGroup(
		Register("r13B", 0, false, false, true,
			EncodeAs(13, 0, 0, 5, false, false, true, [
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register.init,
		Register("r13W", 0, false, false, true,
			EncodeAs(13, 0, 0, 5, false, false, true, [
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("r13D", 0, false, false, true,
			EncodeAs(13, 0, 0, 5, false, false, true, [
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("r13", 0, false, false, true,
			EncodeAs(13, 0, 0, 5, false, false, true, [
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		)
	),
	RegisterGroup(
		Register("r14B", 0, false, false, true,
			EncodeAs(14, 0, 0, 6, false, false, true, [
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register.init,
		Register("r14W", 0, false, false, true,
			EncodeAs(14, 0, 0, 6, false, false, true, [
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("r14D", 0, false, false, true,
			EncodeAs(14, 0, 0, 6, false, false, true, [
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("r14", 0, false, false, true,
			EncodeAs(14, 0, 0, 6, false, false, true, [
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		)
	),
	RegisterGroup(
		Register("r15B", 0, false, false, true,
			EncodeAs(15, 0, 0, 7, false, false, true, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register.init,
		Register("r15W", 0, false, false, true,
			EncodeAs(15, 0, 0, 7, false, false, true, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("r15D", 0, false, false, true,
			EncodeAs(15, 0, 0, 7, false, false, true, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		),
		Register("r15", 0, false, false, true,
			EncodeAs(15, 0, 0, 7, false, false, true, [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(2, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
				], [
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false),
					EncodeForMODRM_SIB(1, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(4, 0, 0,
						false, true, false, false),
					EncodeForMODRM_SIB(0, 0, 0,
						false, false, false, false)
				]
			)
		)
	)
];
