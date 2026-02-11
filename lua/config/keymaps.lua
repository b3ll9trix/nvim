-- Global keymaps (plugin-specific keymaps go in their plugin files)
-- NOTE: LSP keymaps are defined in lua/plugins/lsp.lua (on_attach function)
local keymap = vim.keymap.set

-- General
keymap("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
keymap("n", "<leader>W", "<cmd>wa<CR>", { desc = "Save all files" })
keymap("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
keymap("n", "<leader>Q", "<cmd>qa<CR>", { desc = "Quit all" })
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Window resize
keymap("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase height" })
keymap("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease height" })
keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease width" })
keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase width" })

-- Window splits
keymap("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Vertical split" })
keymap("n", "<leader>sh", "<cmd>split<CR>", { desc = "Horizontal split" })
keymap("n", "<leader>sc", "<cmd>close<CR>", { desc = "Close split" })
keymap("n", "<leader>se", "<C-w>=", { desc = "Equal splits" })

-- Buffer navigation
keymap("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
keymap("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
keymap("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
keymap("n", "<leader>bD", "<cmd>%bdelete|edit#|bdelete#<CR>", { desc = "Delete other buffers" })

-- Move lines
keymap("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
keymap("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "Move line up" })
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Stay in indent mode
keymap("v", "<", "<gv", { desc = "Indent left" })
keymap("v", ">", ">gv", { desc = "Indent right" })

-- Better paste
keymap("v", "p", '"_dP', { desc = "Paste without yanking" })

-- Keep cursor centered
keymap("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })
keymap("n", "n", "nzzzv", { desc = "Next search (centered)" })
keymap("n", "N", "Nzzzv", { desc = "Prev search (centered)" })

-- Quick fix list
keymap("n", "<leader>co", "<cmd>copen<CR>", { desc = "Open quickfix" })
keymap("n", "<leader>cc", "<cmd>cclose<CR>", { desc = "Close quickfix" })
keymap("n", "[q", "<cmd>cprev<CR>", { desc = "Previous quickfix" })
keymap("n", "]q", "<cmd>cnext<CR>", { desc = "Next quickfix" })

-- Formatting
keymap("n", "<leader>fm", function() require("conform").format({ async = true, lsp_fallback = true }) end, { desc = "Format" })

-- Toggle inlay hints (Neovim 0.10+)
keymap("n", "<leader>ih", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle inlay hints" })

