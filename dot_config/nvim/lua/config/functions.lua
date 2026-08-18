vim.keymap.set("n", "j", function()
    return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true, desc = "Down (wrap-aware)" })
vim.keymap.set("n", "k", function()
    return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true, desc = "Up (wrap-aware)" })

vim.keymap.set("n", "<leader>yp", function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    print("file:", path)
end, { desc = "Copy full file path" })

vim.keymap.set("n", "<leader>td", function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })

vim.keymap.set("n", "<leader>th", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
end, { desc = "Toggle inlay hints" })

vim.keymap.set("n", "<leader>cha", function()
    vim.cmd(":w")
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

local function github_blob_url(line_start, line_end)
    local function run(cmd)
        local res = vim.system(cmd, { text = true }):wait()
        if res.code ~= 0 then
            return nil,
                vim.trim(
                    res.stderr ~= "" and res.stderr
                        or (res.stdout ~= "" and res.stdout or ("command failed: " .. table.concat(cmd, " ")))
                )
        end
        return vim.trim(res.stdout)
    end

    local remote, err = run({ "git", "remote", "get-url", "origin" })
    if not remote then
        return nil, err
    end

    local host, org_repo = remote:match("^git@([^:]+):(.+)$")
    if not host then
        host, org_repo = remote:match("^https?://([^/]+)/(.+)$")
    end
    if not host or not org_repo then
        return nil, "unrecognised remote url: " .. remote
    end
    org_repo = org_repo:gsub("%.git$", "")

    local sha, sha_err = run({ "git", "rev-parse", "HEAD" })
    if not sha then
        return nil, sha_err
    end

    local toplevel, top_err = run({ "git", "rev-parse", "--show-toplevel" })
    if not toplevel then
        return nil, top_err
    end

    local abs_path = vim.fn.expand("%:p")
    local rel_path = abs_path:sub(#toplevel + 2)

    local line_frag = ""
    if line_start then
        if line_end and line_end ~= line_start then
            line_frag = string.format("#L%d-L%d", line_start, line_end)
        else
            line_frag = string.format("#L%d", line_start)
        end
    end

    return string.format("https://%s/%s/blob/%s/%s%s", host, org_repo, sha, rel_path, line_frag)
end

local function copy_github_url(line_start, line_end)
    local url, err = github_blob_url(line_start, line_end)
    if not url then
        vim.notify(err, vim.log.levels.ERROR)
        return
    end
    vim.fn.setreg("+", url)
    vim.notify("Copied: " .. url, vim.log.levels.INFO)
end

vim.keymap.set("n", "<leader>yg", function()
    copy_github_url(vim.fn.line("."))
end, { desc = "Copy GitHub URL for current line" })

vim.keymap.set("v", "<leader>yg", function()
    vim.cmd("normal! \27")
    copy_github_url(vim.fn.line("'<"), vim.fn.line("'>"))
end, { desc = "Copy GitHub URL for selection" })
