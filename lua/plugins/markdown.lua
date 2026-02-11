-- Markdown support and preview
return {
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = ":call mkdp#util#install()",
        keys = {
            { "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", desc = "Toggle markdown preview" },
        },
        config = function()
            vim.g.mkdp_auto_start = 0
            vim.g.mkdp_auto_close = 1
            vim.g.mkdp_refresh_slow = 0
            vim.g.mkdp_browser = ""
            vim.g.mkdp_theme = "dark"
        end,
    },
}
