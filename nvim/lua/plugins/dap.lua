-- This file contains the configuration for the nvim-dap plugin in Neovim.

return {
  {
    "mfussenegger/nvim-dap",
    recommended = true,
    desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",

    dependencies = {
      "rcarriga/nvim-dap-ui",
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = "mason.nvim",
        cmd = { "DapInstall", "DapUninstall" },
        opts = {
          handlers = {}, -- sets up dap in the predefined manner
        },
      },
    },

    keys = {
      { "<leader>d", "", desc = "+debug", mode = { "n", "v" } },
      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Breakpoint Condition",
      },
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },
      {
        "<leader>da",
        function()
          require("dap").continue({ before = get_args })
        end,
        desc = "Run with Args",
      },
      {
        "<leader>dC",
        function()
          require("dap").run_to_cursor()
        end,
        desc = "Run to Cursor",
      },
      {
        "<leader>dg",
        function()
          require("dap").goto_()
        end,
        desc = "Go to Line (No Execute)",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        "<leader>dj",
        function()
          require("dap").down()
        end,
        desc = "Down",
      },
      {
        "<leader>dk",
        function()
          require("dap").up()
        end,
        desc = "Up",
      },
      {
        "<leader>dl",
        function()
          require("dap").run_last()
        end,
        desc = "Run Last",
      },
      {
        "<leader>do",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        "<leader>dO",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        "<leader>dp",
        function()
          require("dap").pause()
        end,
        desc = "Pause",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.toggle()
        end,
        desc = "Toggle REPL",
      },
      {
        "<leader>ds",
        function()
          require("dap").session()
        end,
        desc = "Session",
      },
      {
        "<leader>dt",
        function()
          require("dap").terminate()
        end,
        desc = "Terminate",
      },
      {
        "<leader>dw",
        function()
          require("dap.ui.widgets").hover()
        end,
        desc = "Widgets",
      },
      {
        "<leader>du",
        function()
          require("dapui").toggle({})
        end,
        desc = "Dap UI",
      },
      {
        "<leader>de",
        function()
          require("dapui").eval()
        end,
        desc = "Eval",
        mode = { "n", "v" },
      },
    },

    config = function()
      local dap = require("dap")

      if LazyVim.has("mason-nvim-dap.nvim") then
        require("mason-nvim-dap").setup(LazyVim.opts("mason-nvim-dap.nvim"))
      end

      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      for name, sign in pairs(LazyVim.config.icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
          "Dap" .. name,
          { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
      end

      local vscode = require("dap.ext.vscode")
      local json = require("plenary.json")
      vscode.json_decode = function(str)
        return vim.json.decode(json.json_strip_comments(str))
      end

      if vim.fn.filereadable(".vscode/launch.json") == 1 then
        vscode.load_launchjs()
      end

      ---------------------------------------------------------------------------
      -- ENV loader (.env opcional y silencioso)
      ---------------------------------------------------------------------------
      local function load_env_variables()
        local variables = {}

        for k, v in pairs(vim.fn.environ()) do
          variables[k] = v
        end

        local env_file_path = vim.fn.getcwd() .. "/.env"
        if vim.fn.filereadable(env_file_path) == 1 then
          for line in io.lines(env_file_path) do
            local key, value = line:match("^([%w_]+)%s*=%s*(.+)$")
            if key and value then
              variables[key] = value
            end
          end
        end

        return variables
      end

      for _, config in pairs(dap.configurations.go or {}) do
        config.env = load_env_variables
      end

      ---------------------------------------------------------------------------
      -- JS / TS / Node (js-debug via mason) — SIN SOURCEMAPS
      ---------------------------------------------------------------------------
      local js_debug_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"

      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = { js_debug_path, "${port}" },
        },
      }

      for _, language in ipairs({
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
      }) do
        dap.configurations[language] = {
          {
            name = "Launch file (node)",
            type = "pwa-node",
            request = "launch",
            program = "${file}",
            cwd = "${workspaceFolder}",
            sourceMaps = false,
            protocol = "inspector",
            console = "integratedTerminal",
            env = load_env_variables,
          },
          {
            name = "Launch with bun",
            type = "pwa-node",
            request = "launch",
            runtimeExecutable = "bun",
            runtimeArgs = { "run" },
            program = "${file}",
            cwd = "${workspaceFolder}",
            sourceMaps = false,
            console = "integratedTerminal",
            env = load_env_variables,
          },
          {
            name = "Launch TS (bun + tsx)",
            type = "pwa-node",
            request = "launch",
            runtimeExecutable = "bun",
            runtimeArgs = { "x", "tsx" },
            program = "${file}",
            cwd = "${workspaceFolder}",
            sourceMaps = false,
            console = "integratedTerminal",
            env = load_env_variables,
          },
          {
            name = "Attach to Node process",
            type = "pwa-node",
            request = "attach",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
            env = load_env_variables,
          },
          {
            name = "Debug Jest (node)",
            type = "pwa-node",
            request = "launch",
            cwd = "${workspaceFolder}",
            runtimeExecutable = "node",
            runtimeArgs = {
              "./node_modules/.bin/jest",
              "--runInBand",
            },
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
            env = load_env_variables,
          },
          {
            name = "Debug Jest (bun)",
            type = "pwa-node",
            request = "launch",
            cwd = "${workspaceFolder}",
            runtimeExecutable = "bun",
            runtimeArgs = {
              "test",
              "--watch=false",
            },
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
            env = load_env_variables,
          },
          {
            name = "Debug Vitest (node)",
            type = "pwa-node",
            request = "launch",
            cwd = "${workspaceFolder}",
            runtimeExecutable = "node",
            runtimeArgs = {
              "--inspect-brk",
              "./node_modules/.bin/vitest",
              "run",
            },
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
            env = load_env_variables,
          },
          {
            name = "Debug Vitest (bun)",
            type = "pwa-node",
            request = "launch",
            cwd = "${workspaceFolder}",
            runtimeExecutable = "bun",
            runtimeArgs = {
              "--inspect-brk",
              "vitest",
              "run",
            },
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
            env = load_env_variables,
          },
        }
      end
    end,
  },

  -- DAP UI Configuration
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    opts = {},
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end
    end,
  },
}
