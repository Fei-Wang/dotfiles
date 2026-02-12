return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "swift" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        sourcekit = {},
      },
    },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "mmllr/neotest-swift-testing",
    },
    opts = {
      adapters = {
        ["neotest-swift-testing"] = {},
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      local dap = require("dap")
      if not dap.adapters.lldb then
        local lldb_dap_path = vim.fn.trim(vim.fn.system("xcrun -f lldb-dap"))
        dap.adapters.lldb = {
          type = "executable",
          command = lldb_dap_path, -- adjust as needed, must be absolute path
          name = "lldb",
        }
      end

      dap.configurations.swift = {
        {
          name = "Launch file",
          type = "lldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
    end,
  },
}
