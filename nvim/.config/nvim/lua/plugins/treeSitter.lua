return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "c", "cpp", "lua", "make", "bash", "html", "css", "vimdoc",
        "javascript", "java", "markdown", "python", "go",
      },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
