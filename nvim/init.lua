-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.opt.wrap = true
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 0
vim.api.nvim_create_user_command("SnapVisual", function()
  -- Get visual selection
  local _, ls, cs = unpack(vim.fn.getpos("'<"))
  local _, le, ce = unpack(vim.fn.getpos("'>"))
  local lines = vim.api.nvim_buf_get_lines(0, ls - 1, le, false)

  -- Recortar la primera y última línea según la selección
  if #lines == 0 then
    return
  end
  lines[1] = string.sub(lines[1], cs)
  if #lines > 1 then
    lines[#lines] = string.sub(lines[#lines], 1, ce)
  end

  -- Guardar a archivo temporal
  local tmpfile = "/tmp/nvim_snap_" .. os.time() .. ".ts"
  local file = io.open(tmpfile, "w")
  for _, l in ipairs(lines) do
    file:write(l .. "\n")
  end
  file:close()

  -- Ruta de salida
  local outpath = os.getenv("HOME") .. "/Pictures/code_snap_" .. os.time() .. ".png"

  -- Llamar a silicon
  local cmd = string.format("silicon %s --output %s --theme Dracula", tmpfile, outpath)
  os.execute(cmd)

  print("📸 Fragmento capturado en: " .. outpath)
end, { range = true })
