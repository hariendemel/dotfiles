local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = augroup,
  callback = function()
    vim.hl.on_yank()
  end
})

vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Restore last cursor position",
  group = augroup,
  callback = function()
    if vim.o.diff then
      return
    end
    if vim.bo.buftype ~= "" then
      return
    end

    local last_pos = vim.api.nvim_buf_get_mark(0, '"')
    local last_line = vim.api.nvim_buf_line_count(0)

    local row = last_pos[1]
    if row < 1 or row > last_line then
      return
    end

    pcall(vim.api.nvim_win_set_cursor, 0, last_pos)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Enable wrap, linebreak and spellcheck specific files",
  group = augroup,
  pattern = { "markdown", "text", "gitcommit" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave", "WinLeave" }, {
  desc = "Auto save modified buffers (IntelliJ-style save on focus/buffer switch)",
  group = augroup,
  pattern = "*",
  callback = function()
    if vim.bo.modifiable
        and not vim.bo.readonly
        and vim.bo.buftype == ""
        and vim.api.nvim_buf_get_name(0) ~= ""
        and vim.fn.getcmdwintype() == ""
    then
      vim.b.autosave_in_progress = true
      vim.cmd("silent! update")
      vim.b.autosave_in_progress = false
    end
  end,
})
