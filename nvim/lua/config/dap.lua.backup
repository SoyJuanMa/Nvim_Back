local dap = require("dap")

dap.configurations.javascript = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch JS file",
    program = "${file}",
    cwd = "${workspaceFolder}",
    runtimeExecutable = "node",
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
  },
}

dap.configurations.typescript = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch TS file",
    program = "${file}",
    cwd = "${workspaceFolder}",
    runtimeExecutable = "node",
    sourceMaps = true,
    protocol = "inspector",
    outFiles = { "${workspaceFolder}/dist/**/*.js" },
    console = "integratedTerminal",
  },
}
