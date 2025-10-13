return {
  "frabjous/knap",
  enabled = false,
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
}
