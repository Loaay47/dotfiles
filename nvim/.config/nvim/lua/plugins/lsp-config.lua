return {
  { "williamboman/mason.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mason").setup()
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "clangd", "cmake", "lua_ls",
          "html", "cssls", "ts_ls", "marksman", "pyright", "asm_lsp",
        },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local function attach_keymap(_, bufnr)
        local opts = { buffer = bufnr, remap = false }
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "<leader>cn", vim.lsp.buf.code_action, opts)
      end

      -- Lua
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = attach_keymap,
      })

      -- C/C++
      lspconfig.clangd.setup({
        cmd = { "clangd", "--offset-encoding=utf-16" },
        capabilities = capabilities,
        on_attach = attach_keymap,
      })

      -- CMake
      lspconfig.cmake.setup({
        capabilities = capabilities,
        on_attach = attach_keymap,
      })

      -- go
      lspconfig.gopls.setup({
        capabilities = capabilities,
        on_attach = attach_keymap,
      })

      -- HTML
      lspconfig.html.setup({
        capabilities = capabilities,
        on_attach = attach_keymap,
      })

      -- CSS
      lspconfig.cssls.setup({
        capabilities = capabilities,
        on_attach = attach_keymap,
      })

      -- ASM
      lspconfig.asm_lsp.setup({
        capabilities = capabilities,
        on_attach = attach_keymap,
      })

      -- JavaScript / TypeScript
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false
        end,
      })

      vim.diagnostic.config({
        virtual_text = true, -- Show inline text
        signs = true,         -- Show signs in the gutter
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
          border = "rounded", -- Style for floating window
          source = "always",  -- Show where the diagnostic came from
          header = "",
          prefix = "",
        },
      })
    end,
  },
}
