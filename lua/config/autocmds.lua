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

-- Show diagnostics in a float on hover
autocmd("CursorHold", {
    desc = "Show diagnostics float on hover",
    group = vim.api.nvim_create_augroup("diagnostic-float", { clear = true }),
    callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
    end,
})

