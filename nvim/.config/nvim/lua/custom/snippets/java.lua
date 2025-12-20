require("luasnip.session.snippet_collection").clear_snippets("java")

local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local f = ls.function_node

ls.add_snippets("java", {
	s(
		"class",
		fmt(
			[[
public class {} {}{{
    {}
}}
]],
			{
				f(function()
					return vim.fn.expand("%:t:r")
				end, {}),
				i(1),
				i(0),
			}
		)
	),
})
