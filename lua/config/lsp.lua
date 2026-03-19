-- Shared LSP helpers (used by lspconfig and rustaceanvim)
local M = {}

function M.capabilities()
    return require("cmp_nvim_lsp").default_capabilities()
end

function M.on_attach(client, bufnr)
    local opts = { buffer = bufnr, silent = true }

    -- Signature help as you type
    require("lsp_signature").on_attach({
        bind = true,
        handler_opts = { border = "rounded" },
        hint_enable = false,
        hi_parameter = "LspSignatureActiveParameter",
        toggle_key = "<C-k>",
        toggle_key_flip_floatwin_setting = true,
    }, bufnr)

    -- Navigation
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
    vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Find references" }))
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "Go to type definition" }))

    -- Documentation
    vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
    vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature help" }))

    -- Workspace
    vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, vim.tbl_extend("force", opts, { desc = "Workspace symbols" }))
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, vim.tbl_extend("force", opts, { desc = "Add workspace folder" }))
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, vim.tbl_extend("force", opts, { desc = "Remove workspace folder" }))

    -- Code actions
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
    vim.keymap.set("v", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))

    -- Diagnostics
    vim.keymap.set("n", "<leader>ds", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Show diagnostics" }))
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
    vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, vim.tbl_extend("force", opts, { desc = "Diagnostics to loclist" }))

    -- Enable inlay hints if supported (Neovim 0.10+)
    if client.supports_method("textDocument/inlayHint") then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end

    -- Code lens support
    if client.supports_method("textDocument/codeLens") then
        vim.lsp.codelens.refresh()
        vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
            buffer = bufnr,
            callback = function()
                vim.lsp.codelens.refresh()
            end,
        })
    end
end

return M
