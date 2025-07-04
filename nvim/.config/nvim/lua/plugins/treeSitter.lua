return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "c", "cpp", "lua", "make", "bash", "html", "css",
        "javascript", "tsx", "typescript", "vue", "java", "markdown", "python",
      },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
