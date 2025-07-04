return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "jay-babu/mason-nvim-dap.nvim",
    "williamboman/mason.nvim",
  },

  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    require("mason").setup()
    require("mason-nvim-dap").setup({
      ensure_installed = { "codelldb" },
    })

    dap.adapters.codelldb = {
      type = "executable",
      command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
      name = "codelldb",
    }

    dapui.setup()

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    vim.keymap.set('n', "<leader>dt", dap.toggle_breakpoint, {})
    vim.keymap.set('n', "<leader>dc", dap.continue, {})
    vim.keymap.set("n", "<leader>dx", ":DapTerminate<CR>")
    vim.keymap.set("n", "<leader>do", ":DapStepOver<CR>")


    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = vim.fn.getcwd(),
        stopOnEntry = false,
        runInTerminal = false,
      },
    }

    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp
  end,
}
