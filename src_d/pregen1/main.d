/**
 * Copyright:
 *    Richard Andrew Cattermole 2016
 * 
 * License:
 *    This software is dual licensed. All rights reserved.
 *    See https://github.com/rikkimax/alphacodegen/blob/master/LICENSE.md for more information.
 */
module alphacodegen.pregen1.main;
import std.stdio :writeln;
import alphacodegen.pregen1.pegged_markdown_grammar;

void main() {
    writeln("Creating D grammar for markdown using pegged");
	createDMarkdownGrammar("src_d/pregen2/alphacodegen/pregen2/pegged_markdown.d", "alphacodegen.pregen2.pegged_markdown");
	createDMarkdownGrammar("src_d/generated/alphacodegen/pegged_markdown.d", "alphacodegen.pegged_markdown");
    writeln("Done!");
}
