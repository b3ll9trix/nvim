-- Autocommands
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Close some filetypes with 'q'
autocmd("FileType", {
    pattern = { "help", "qf", "lspinfo", "man" },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf })
    end,
})

-- Auto-reload files changed externally (by Claude, git, etc.)
autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
    desc = "Check for file changes and reload buffers",
    group = vim.api.nvim_create_augroup("auto-reload", { clear = true }),
    command = "checktime",
})

-- Autosave on focus lost, buffer leave, or leaving insert mode
autocmd({ "FocusLost", "BufLeave", "InsertLeave" }, {
    desc = "Autosave modified buffers",
    group = vim.api.nvim_create_augroup("autosave", { clear = true }),
    callback = function(event)
        local buf = event.buf
        if vim.bo[buf].modified and vim.bo[buf].buftype == "" and vim.fn.expand("%") ~= "" then
            vim.api.nvim_buf_call(buf, function()
                vim.cmd("silent! write")
            end)
        end
    end,
})

-- Show diagnostics in a float on hover
autocmd("CursorHold", {
    desc = "Show diagnostics float on hover",
    group = vim.api.nvim_create_augroup("diagnostic-float", { clear = true }),
    callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
    end,
})


-- Highlight word under cursor when idle
autocmd({ "CursorHold", "CursorHoldI" }, {
    desc = "Highlight word under cursor",
    group = vim.api.nvim_create_augroup("highlight-word", { clear = true }),
    callback = function()
        local current_word = vim.fn.expand("<cword>")
        if current_word ~= "" then
            pcall(vim.fn.matchadd, "Search", "\\V\\<" .. vim.fn.escape(current_word, "\\") .. "\\>", -1, 100)
        end
    end,
})

autocmd({ "CursorMoved", "CursorMovedI", "InsertEnter" }, {
    desc = "Clear highlight word under cursor",
    group = vim.api.nvim_create_augroup("clear-highlight-word", { clear = true }),
    callback = function()
        pcall(vim.fn.matchdelete, 100)
    end,
})

