module alphacodegen.common.utils;
import std.traits : isImplicitlyConvertible, isSomeChar;

/**
 * Simple find and replace with support for case sensistivity
 * 
 * Params:
 *      text            =   The text to work from
 *      oldText         =   The text to remove
 *      newText         =   The text to replace with
 *      caseSensitive   =   Replace 'i' when 'I' is specified. Default: true
 *      first           =   Only do one replacement. Default: false
 * 
 * Returns:
 *      A string with its oldText replaced with the newText
 */
pure string replace(string text, string oldText, string newText, bool caseSensitive = true, bool first = false) {
	import std.string : toLower;
	
	string ret, tempData;
	bool stop;
	foreach(char c; text) {
		if (tempData.length > oldText.length && !stop) {
			ret ~= tempData;
			tempData = "";
		}
		if (((oldText[0 .. tempData.length] != tempData && caseSensitive) || (oldText[0 .. tempData.length].toLower() != tempData.toLower() && !caseSensitive)) && !stop) {
			ret ~= tempData;
			tempData = "";
		}
		tempData ~= c;
		if (((tempData == oldText && caseSensitive) || (tempData.toLower() == oldText.toLower() && !caseSensitive)) && !stop) {
			ret ~= newText;
			tempData = "";
			stop = first;
		}
	}
	if (tempData != "") {
		ret ~= tempData;    
	}
	return ret;
}

/**
 * Static array of characters that can have a dynamic length
 */
struct StaticDynamicArray(T, size_t len) {
	///
	size_t length;
	///
	T[len] data;

	///
	invariant {
		import std.conv : text;
		assert(length <= len, "Length specified must adhere to 0 <= length < " ~ len.text);
	}

	///
	void opAssign(inout T[] from) {
		length = from.length;
		data[0 .. length] = from;
	}

	///
	void opOpAssign(string op)(inout T from) if (op == "~") {
		data[length] = from;
		length++;
	}

	///
	void opOpAssign(string op)(inout T[] from) if (op == "~") {
		data[length .. length + from.length] = from;
		length += from.length;
	}

	///
	T[] __self() {
		if (length == 0)
			return null;
		return data[0 .. length];
	}

	///
	enum maxLength = len;

	///
	alias __self this;
}

///
struct StringInputRange(Char) {
	private {
		size_t offset;
		const(Char)[] source;
	}
	
	///
	this(const(Char)[] source) {
		this.source = source;
	}
	
	@property {
		///
		bool empty() {
			return offset == source.length;
		}
		
		///
		char front() {
			return source[offset];
		}
	}

	///
	Char moveFront() {
		return front();
	}
	
	///
	void popFront() {
		offset++;
	}
	
	///
	int opApply(int delegate(Char) dg) @trusted {
		int result = 0;
		
		while(!empty) {
			result = dg(front);
			popFront;
			if (result)
				break;
		}
		return result;
	}
	
	///
	int opApply(int delegate(size_t i, Char) dg) @trusted {
		int result = 0;
		
		size_t i;
		while(!empty) {
			result = dg(i, front);
			popFront;
			if (result)
				break;
			i++;
		}
		return result;
	}
}

///
auto stringInputRange(Char)(const(Char)[] from) {
	return StringInputRange!Char(from);
}

size_t parseUnicodeValue(Char)(const(Char)[] from, Char[] dst) if (is(Char == dchar) || isImplicitlyConvertible!(Char, dchar)) { return parseUnicodeValue_!dchar(from, dst); }
size_t parseUnicodeValue(Char)(const(Char)[] from, Char[] dst) if (is(Char == wchar) || isImplicitlyConvertible!(Char, wchar)) { return parseUnicodeValue_!wchar(from, dst); }
size_t parseUnicodeValue(Char)(const(Char)[] from, Char[] dst) if (is(Char == char) || isImplicitlyConvertible!(Char, char)) { return parseUnicodeValue_!char(from, dst); }

private size_t parseUnicodeValue_(Char, From)(const(From)[] from, From[] dst) {
	import std.conv : to;
	assert(dst.length >= from.length);

	size_t i, j;

	while(i < from.length) {
		if (from[i] == '\\') {
			int base, length;

			switch(from[i + 1]) {
				case 'u':
					base = 16;
					length = 4;
					break;
				case 'U':
					base = 16;
					length = 8;
					break;
				case 'x':
					base = 16;
					length = 2;
					break;

				case 'r':
					dst[j] = '\r';
					i += 2;
					j++;
					continue;
				case 'n':
					dst[j] = '\n';
					i += 2;
					j++;
					continue;
				case 't':
					dst[j] = '\t';
					i += 2;
					j++;
					continue;
				case '0':
					dst[j] = '\0';
					i += 2;
					j++;
					continue;

				default:
					base = 8;
					length = 3;
					break;
			}

			if (i + length <= from.length) {
				static if (isSomeChar!From) {
					dst[j] = cast(Char)to!uint(from[i + 2 .. i + 2 + length], base);
				} else {
					dst[j] = from[i];

					Char[4] temp;
					foreach(k; 0 .. length) {
						temp[k] = from[i + 2 + k];
					}

					dst[j] = cast(Char)to!uint(temp[0 .. length], base);
				}

				i += length + 2;
				j++;
			} else
				assert(0);
		} else {
			dst[j] = from[i];
			i++;
			j++;
		}
	}

	return j;
}

///
ptrdiff_t escapeUnicodeValues(Char)(const(Char)[] from, Char[] dst) {
	import std.utf : decodeFront, encode, codeLength;
	import std.uni : isGraphical;

	size_t idx;

	bool output(dchar d, size_t len) {
		if (idx + len >= dst.length) {
			return true;
		}

		Char[dchar.sizeof / Char.sizeof] buf;

		try {
			buf.encode(d);
		} catch (Exception e) {
			return true;
		}

		dst[idx .. idx + len] = buf[0 .. len];
		idx += len;

		return false;
	}

	bool outputLiteral(dstring d) {
		foreach(c; d) {
			if (output(c, c.codeLength!Char))
				return true;
		}

		return false;
	}

	bool outputHex(ubyte v) {
		char[2] h = byteToHex(v);

		if (output(h[0], 1))
			return true;
		if (output(h[1], 1))
			return true;

		return false;
	}

	while(from.length > 0) {
		size_t len = from.length;
		dchar decoded = from.decodeFront;
		len -= from.length;

		if (decoded.isGraphical) {
			if (output(decoded, len))
				return -1;
		} else {
			switch(decoded) {
				case '\r':
					if (outputLiteral("\\r"d))
						return -1;
					break;
				case '\n':
					if (outputLiteral("\\n"d))
						return -1;
					break;
				case '\t':
					if (outputLiteral("\\t"d))
						return -1;
					break;
				case '\0':
					if (outputLiteral("\\0"d))
						return -1;
					break;

				default:
					if (len == 1) {
						if (outputLiteral("\\x"d))
							return -1;

						if (outputHex(cast(ubyte)decoded))
							return -1;
					} else if (len == 2) {
						if (outputLiteral("\\u"d))
							return -1;

						if (outputHex(cast(ubyte)decoded >> 8))
							return -1;
						if (outputHex(cast(ubyte)decoded))
							return -1;
					} else if (len > 2) {
						if (outputLiteral("\\U"d))
							return -1;

						if (outputHex(cast(ubyte)decoded >> 24))
							return -1;
						if (outputHex(cast(ubyte)decoded >> 16))
							return -1;
						if (outputHex(cast(ubyte)decoded >> 8))
							return -1;
						if (outputHex(cast(ubyte)decoded))
							return -1;
					}

					break;
			}
		}
	}

	return idx;
}

///
unittest {
	ptrdiff_t dstRet;
	dchar[80] dst;

	dstRet = escapeUnicodeValues("abcd"d, dst);
	assert(dstRet == 4);
	assert(cast(dstring)dst[0 .. dstRet] == "abcd"d);

	dstRet = escapeUnicodeValues("1\n4\t8"d, dst);
	assert(dstRet == 7);
	assert(cast(dstring)dst[0 .. dstRet] == "1\\n4\\t8"d);

	dstRet = escapeUnicodeValues("a\u1d89z"d, dst);
	assert(dstRet == 3);
	assert(cast(dstring)dst[0 .. dstRet] == "a\u1d89z"d);

	dstRet = escapeUnicodeValues("a\u009az"d, dst);
	assert(dstRet == 6);
	assert(cast(dstring)dst[0 .. dstRet] == "a\\x9Az"d);
}

///
char[2] byteToHex(ubyte v) @nogc @safe pure {
	const auto MAP = "0123456789ABCDEF";
	char[2] ret;

	ret[0] = MAP[v >> 4];
	ret[1] = MAP[v & 15];

	return ret;
}

///
unittest {
	assert(cast(string)4.byteToHex == "04");
	assert(cast(string)255.byteToHex == "FF");
}

const(char)[] removeUnicodeBOM(const(char)[] input) {
	if (input.length >= 3 && input[0 .. 3] == x"ef bb bf") {
		return input[3 .. $];
	} else {
		return input;
	}
}