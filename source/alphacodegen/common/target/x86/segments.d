module alphacodegen.common.target.x86.segments;

struct Segment {
	string name, loweredName;
	ubyte encodeAs;

	this(string name, ubyte encodeAs) {
		import std.string : toLower;

		this.name = name;
		this.encodeAs = encodeAs;
		this.loweredName = name.toLower;
	}
}

bool findSegment(string name, out Segment oseg) {
	import std.string : toLowerInPlace;

	if (name.length != 2)
		return false;

	char[2] nameb;
	nameb = name[0 .. 2];
	char[] nameb2 = cast(char[])nameb[0 .. 2];
	nameb2.toLowerInPlace;

	string namet = cast(string)nameb;

	foreach(seg; segments) {
		if (seg.loweredName == namet) {
			oseg = seg;
			return true;
		}
	}

	return false;
}

bool findSegment(ubyte encodedAs, out Segment oseg) {
	foreach(seg; segments) {
		if (seg.encodeAs == encodedAs) {
			oseg = seg;
			return true;
		}
	}
	
	return false;
}

static immutable(Segment[]) segments = [
	Segment("CS", 0x2E),
	Segment("DS", 0x3E),
	Segment("ES", 0x26),
	Segment("FS", 0x64),
	Segment("GS", 0x65),
	Segment("SS", 0x36)
];