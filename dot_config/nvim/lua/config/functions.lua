vim.keymap.set("n", "j", function()
  return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true, desc = "Down (wrap-aware)" })
vim.keymap.set("n", "k", function()
  return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true, desc = "Up (wrap-aware)" })

vim.keymap.set("n", "<leader>pa", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  print("file:", path)
end, { desc = "Copy full file path" })

vim.keymap.set("n", "<leader>td", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })

vim.keymap.set("n", "<leader>cha", function()
  vim.cmd(':w')
  local path = vim.fn.expand("%:p")
  vim.system({ "chezmoi", "add", path }, { text = true }, function(res)
    if res.code == 0 then
      vim.notify(res.stdout ~= "" and res.stdout or ("chezmoi add ok:\n" .. path), vim.log.levels.INFO)
    else
      local msg = (res.stderr ~= "" and res.stderr or res.stdout or "chezmoi add failed")
      vim.notify(msg .. "\n(exit code: " .. res.code .. ")", vim.log.levels.ERROR)
    end
  end)
end, { desc = "chezmoi add current file" })
