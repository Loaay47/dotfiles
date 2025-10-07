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
          "clangd", "cmake", -- lua_ls
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

      -- Lua
      -- lspconfig.lua_ls.setup({ capabilities = capabilities })

      -- C/C++
      lspconfig.clangd.setup({
        cmd = { "clangd", "--offset-encoding=utf-16" },
        capabilities = capabilities,
      })

      -- CMake
      lspconfig.cmake.setup({ capabilities = capabilities })

      -- go
      lspconfig.gopls.setup({ capabilities = capabilities })

      -- HTML
      lspconfig.html.setup({ capabilities = capabilities })

      -- CSS
      lspconfig.cssls.setup({ capabilities = capabilities })

      -- ASM
      lspconfig.asm_lsp.setup({ capabilities = capabilities })
      local orig = vim.lsp.handlers["window/showMessage"]
      vim.lsp.handlers["window/showMessage"] = function(err, result, ctx, config)
        local client = vim.lsp.get_client_by_id(ctx.client_id)
        if client and client.name == "asm_lsp" then
          if result and result.message:match("No .asm%-lsp.toml config file found") then
            return -- swallow just this warning
          end
        end
        return orig(err, result, ctx, config)
      end

      -- JavaScript / TypeScript
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false -- optional
        end,
      })

    -- Java (jdtls loads manually)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function()
          local jdtls = require("jdtls")
          local root_markers = { ".git", "mvnw", "gradlew", "pom.xml" }
          local root_dir = require("jdtls.setup").find_root(root_markers)

          if root_dir == nil then
            vim.notify("JDTLS: Root directory not found", vim.log.levels.WARN)
            return
          end

          local home = os.getenv("HOME")
          local workspace_dir = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

          jdtls.start_or_attach({
            cmd = { "jdtls", "-configuration", workspace_dir, "-data", workspace_dir },
            root_dir = root_dir,
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
            settings = {
              java = {},
            },
            init_options = {
              bundles = {},
            },
          })
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

      -- 🔧 Keymaps
      local map = vim.keymap.set
      map("n", "K", vim.lsp.buf.hover, { desc = "Show documentation" })
      map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
      -- map("n", "gt", vim.lsp.buf.type_definition, { desc = "Type definition" })
      map("n", "<leader>cn", vim.lsp.buf.code_action, { desc = "Code action" })
    end,
  },
}
