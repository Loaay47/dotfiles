return {
  "tpope/vim-fugitive",
  config = function()
    local group = vim.api.nvim_create_augroup("Luca_fugitive", { clear = true })

    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = "fugitive",
      callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        local opts = { buffer = bufnr, noremap = true, silent = true }

        -- push
        vim.keymap.set("n", "<leader>p", function()
          vim.cmd("Git push")
        end, opts)

        -- pull with rebase
        vim.keymap.set("n", "<leader>P", function()
          vim.cmd("Git pull --rebase")
        end, opts)

        -- start a :Git push -u origin <branch> command (leaves you in command-line to type branch)
        vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts)
      end,
    })
    --[[ vim.keymap.set("n", "gj", "<cmd>diffget //2<CR>")
    vim.keymap.set("n", "gk", "<cmd>diffget //3<CR>") ]]
  end,
}

