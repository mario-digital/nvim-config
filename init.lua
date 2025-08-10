require("mario.core")
require("mario.lazy")

-- Ensure Alpha opens on startup when no files are specified
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  once = true,
  callback = function()
    if vim.fn.argc() == 0 and vim.fn.line2byte("$") == -1 then
      vim.cmd("Alpha")
    end
  end,
})