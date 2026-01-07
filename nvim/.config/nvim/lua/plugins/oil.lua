return {
    "stevearc/oil.nvim",
    lazy = false,
    opts = {},
    -- icons pack
    -- dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()
        require("oil").setup({
            delete_to_trash = true,
            columns = {
                "permissions",
                "size",
                "mtime",
            },
            keymaps = {
                ["g?"] = { "actions.show_help", mode = "n" },
                ["<CR>"] = "actions.select",
                ["<C-c>"] = { "actions.close", mode = "n" },
                ["-"] = { "actions.parent", mode = "n" },
                ["_"] = { "actions.open_cwd", mode = "n" },
                ["`"] = { "actions.cd", mode = "n" },
                ["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
                ["gs"] = { "actions.change_sort", mode = "n" },
                ["go"] = "actions.open_external",
                ["g."] = { "actions.toggle_hidden", mode = "n" },
                ["g\\"] = { "actions.toggle_trash", mode = "n" },
            },
            use_default_keymaps = false,
            win_options = {
                -- Displays the path at the top
                winbar = "    %{v:lua.require('oil').get_current_dir()}",
            },
            view_options = {
                show_hidden = true,
                is_always_hidden = function(name, bufnr)
                    return name == ".."
                end,
            },
        })
    end,
}
