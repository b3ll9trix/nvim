-- Set leader keys before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Load config modules
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Load plugins from lua/plugins/*.lua
require("lazy").setup("plugins", {
    change_detection = {
        notify = false, -- Don't notify on config changes
    },
})
