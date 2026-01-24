return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

      -- GDB adapter for C/C++/Rust
      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
      }

      -- Configurations for C/C++/Rust
      dap.configurations.c = {
        {
          name = "Launch",
          type = "gdb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/", "file")
          end,
          args = {},
          cwd = "${workspaceFolder}",
          stopAtBeginningOfMainSubprogram = false,
        },
        {
          name = "Select and attach to process",
          type = "gdb",
          request = "attach",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/", "file")
          end,
          pid = function()
            local name = vim.fn.input("Executable name (filter): ")
            return require("dap.utils").pick_process({ filter = name })
          end,
          cwd = "${workspaceFolder}",
        },
        {
          name = "Attach to gdbserver :1234",
          type = "gdb",
          request = "attach",
          target = "localhost:1234",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/", "file")
          end,
          cwd = "${workspaceFolder}",
        },
      }
      dap.configurations.cpp = dap.configurations.c
      dap.configurations.rust = dap.configurations.c

      -- Browser adapters using mason installed tools
      local mason_path = vim.fn.stdpath("data") .. "/mason/packages"
      local chrome_adapter = mason_path .. "/chrome-debug-adapter/out/src/chromeDebug.js"
      local firefox_adapter = mason_path .. "/firefox-debug-adapter/dist/adapter.bundle.js"

      -- Chrome adapter
      if vim.fn.filereadable(chrome_adapter) == 1 then
        dap.adapters.chrome = {
          type = "executable",
          command = "node",
          args = { chrome_adapter },
        }
      end

      -- Firefox adapter
      if vim.fn.filereadable(firefox_adapter) == 1 then
        dap.adapters.firefox = {
          type = "executable",
          command = "node",
          args = { firefox_adapter },
        }
      end

      -- Configurations for JavaScript/TypeScript in browsers
      dap.configurations.javascript = {
        {
          type = "chrome",
          request = "launch",
          name = "Launch with Brave",
          runtimeExecutable = "/usr/bin/brave",
          runtimeArgs = { "--remote-debugging-port=9222" },
          url = "http://localhost:3000",
          webRoot = "${workspaceFolder}",
          sourceMaps = true,
          protocol = "inspector",
        },
        {
          type = "chrome",
          request = "attach",
          name = "Attach to Brave",
          port = 9222,
          webRoot = "${workspaceFolder}",
          sourceMaps = true,
          protocol = "inspector",
        },
      }

      dap.configurations.javascriptreact = dap.configurations.javascript
      dap.configurations.typescript = dap.configurations.javascript
      dap.configurations.typescriptreact = dap.configurations.javascript

      -- Firefox configuration
      dap.configurations.firefox = {
        {
          name = "Debug with Firefox",
          type = "firefox",
          request = "launch",
          reAttach = true,
          url = "http://localhost:3000",
          webRoot = "${workspaceFolder}",
          firefoxExecutable = "/usr/bin/firefox",
        },
      }
    end,
  },
}
