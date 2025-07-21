return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        transparent_mode = true,
      })
    end,
  },
  {
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      require("onedark").setup({
        style = "dark", -- options: dark, darker, cool, deep, warm, warmer, light
        transparent = true, -- optional: integrates with picom transparency
      })
      -- vim.cmd("colorscheme onedark") -- Uncomment to set as default
    end,
  },
}
