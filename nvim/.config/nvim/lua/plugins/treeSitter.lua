return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "vim", "vimdoc", "lua", "make", "bash", "markdown", "markdown_inline",
        "c", "cpp", "asm",  "html", "css", "javascript", "go", "python", "java", "sql",
      },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
