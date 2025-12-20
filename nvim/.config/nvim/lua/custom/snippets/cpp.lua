require("luasnip.session.snippet_collection").clear_snippets("cpp")

local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("cpp", {
	s(
		"main",
		fmt(
			[[
#include <iostream>

int main() {{
    {}
    return 0;
}}
]],
			{
				i(0),
			}
		)
	),
})
