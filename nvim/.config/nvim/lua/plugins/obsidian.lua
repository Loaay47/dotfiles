return{
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    workspaces = {
      { name = "vault", path = "~/vault" },
    },
  },
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        vim.opt.conceallevel = 2
        vim.opt.concealcursor = "nc"
      end,
    })
  end,
}

