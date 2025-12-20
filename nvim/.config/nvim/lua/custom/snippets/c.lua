require("luasnip.session.snippet_collection").clear_snippets("c")

local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("c", {
	s(
		"main",
		fmt(
			[[
#include <stdio.h>

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
