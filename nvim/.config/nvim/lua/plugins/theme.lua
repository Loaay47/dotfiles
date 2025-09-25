return {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        transparent_mode = true,
      })
      vim.cmd.colorscheme("gruvbox")

      -- Floating window tint logic
      local function is_floating_win(win_id)
        local cfg = vim.api.nvim_win_get_config(win_id)
        return cfg.relative ~= ""
      end

      vim.api.nvim_create_autocmd("WinEnter", {
        callback = function()
          if is_floating_win(0) then
            vim.api.nvim_set_hl(0, "Normal", { bg = "#353231" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#353231" })
          end
        end,
      })

      vim.api.nvim_create_autocmd("WinLeave", {
        callback = function()
          if is_floating_win(0) then
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
          end
        end,
      })
    end,
}
