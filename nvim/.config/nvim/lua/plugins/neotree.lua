return {
  "nvim-neo-tree/neo-tree.nvim",
  enabled = false,
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    -- Disable netrw
    vim.g.loaded_netrw = nil
    vim.g.loaded_netrwPlugin = nil

    require("neo-tree").setup({
      close_if_last_window = true,
      filesystem = {
        hijack_netrw_behavior = "open_default", -- or "disabled" if you don’t want auto-open
      },
      window = {
        position = "right",
        width = 25, -- 👈 Set your desired width here
      },
    })

    -- Quit Neovim when the last window closes
    vim.api.nvim_create_autocmd("WinClosed", {
      pattern = "*",
      callback = function()
        if #vim.api.nvim_tabpage_list_wins(0) == 1 then
          if #vim.fn.getbufinfo({ buflisted = 1 }) == 0 then
            vim.cmd("quit")
          end
        end
      end,
    })

    -- Optional: Open Neotree on startup
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        require("neo-tree.command").execute({ action = "show" })
      end,
    })
  end,
}
