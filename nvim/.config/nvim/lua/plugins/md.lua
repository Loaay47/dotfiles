return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "craftzdog/solarized-osaka.nvim",
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.icons",
    },
    event = "BufReadPre",
    priority = 1200,
    opts = {
      latex = { enabled = true },
    },
    config = function()
      local colors = require("solarized-osaka.colors").setup()

      -- Define header background colors
      local header_bg_colors = {
        colors.cyan900, -- Header 6 background
        colors.blue900, -- Header 4 background
        colors.red900, -- Header 1 background
        colors.yellow700, -- Header 2 background
        colors.red700, -- Header 4 background
        colors.blue500, -- Header 4 background
      }

      -- Define header foreground color
      local header_fg = colors.base2

      -- Set up highlights dynamically for Markdown headers
      for i, bg in ipairs(header_bg_colors) do
        vim.api.nvim_set_hl(0, "MarkdownHeader" .. i, {
          fg = header_fg,
          bg = bg,
          bold = false,
        })
      end

      require("render-markdown").setup {
        heading = {
          sign = true,
          icons = { "➊ ", "➋ ", "➌ ", "➍ ", "➎ ", "➏ "},
          backgrounds = {
            "MarkdownHeader1",
            "MarkdownHeader2",
            "MarkdownHeader3",
            "MarkdownHeader4",
            "MarkdownHeader5",
            "MarkdownHeader6",
          },
        },
      }
      -- 💡 FIX: Disable Treesitter highlighting for markdown to prevent extmark errors
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          -- vim.cmd("TSBufDisable highlight")
        end,
      })
    end,
  },
  {
    "frabjous/knap",
    config = function()
      local function setup_knap()
        vim.g.knap_settings = {
          mdoutputext = "pdf",
          mdtopdf = "pandoc %docroot% -o %outputfile%",
          --mdtopdfviewerlaunch = "evince %outputfile%",
          mdtopdfviewerlaunch = "zathura --fork %outputfile%",
          -- mdtopdfviewerrefresh = "none",
          mdtopdfviewerrefresh = "kill %processID% && zathura %outputfile%",
          delay = 100,
          -- Use buffer as stdin to avoid file conflicts
          mdtopdfbufferasstdin = true,
        }

        local knap = require "knap"

        -- Create autocommand group for markdown-specific settings
        local markdown_group = vim.api.nvim_create_augroup("MarkdownSettings", { clear = true })

        -- Define keybindings and settings for Markdown files
        vim.api.nvim_create_autocmd("FileType", {
          group = markdown_group,
          pattern = "markdown",
          callback = function()
            local buf = vim.api.nvim_get_current_buf()

            -- F4: Toggle preview with manual save
            vim.keymap.set("n", "<F4>", function()
              -- Save current buffer before previewing
              vim.cmd "write"
              knap.toggle_autopreviewing()
            end, { buffer = buf, desc = "Toggle Markdown Preview" })

            -- F5: Generate PDF once
            vim.keymap.set("n", "<F5>", function()
              vim.cmd "write"
              knap.forward_jump()
            end, { buffer = buf, desc = "Generate PDF Once" })

            -- F6: Close preview
            vim.keymap.set(
              "n",
              "<F6>",
              function() knap.close_viewer() end,
              { buffer = buf, desc = "Close PDF Preview" }
            )

            -- Disable automatic preview on save for this buffer
            vim.b.render_markdown_disable_auto = true
          end,
        })
      end

      setup_knap()
    end,
    ft = { "markdown" },
  },
}


