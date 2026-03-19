return {
    -- Mason (must load first)
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })
        end,
    },

    -- LSP Configuration
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "ray-x/lsp_signature.nvim",
        },
        config = function()
            local lsp = require("config.lsp")
            local capabilities = lsp.capabilities()
            local on_attach = lsp.on_attach

            -- Diagnostic configuration
            vim.diagnostic.config({
                virtual_text = false,
                float = {
                    border = "rounded",
                    source = true,
                },
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "❌",
                        [vim.diagnostic.severity.WARN] = "⚠️",
                        [vim.diagnostic.severity.HINT] = "💡",
                        [vim.diagnostic.severity.INFO] = "ℹ️",
                    },
                },
                underline = true,
                update_in_insert = false,
                severity_sort = true,
            })

            -- Mason-lspconfig setup
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "gopls",
                    "lua_ls",
                },
                automatic_installation = {
                    exclude = { "rust_analyzer" },
                },
                handlers = {
                    -- No-op default: we configure servers manually via vim.lsp.config
                    function(server_name) end,
                    -- Explicitly skip rust_analyzer (handled by rustaceanvim)
                    ["rust_analyzer"] = function() end,
                },
            })

            -- Configure LSPs using vim.lsp.config (Neovim 0.11+)
            -- Go LSP (gopls)
            vim.lsp.config.gopls = {
                cmd = { "gopls" },
                filetypes = { "go", "gomod", "gowork", "gotmpl" },
                root_markers = { "go.work", "go.mod", ".git" },
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                            shadow = true,
                            nilness = true,
                            unusedwrite = true,
                            useany = true,
                        },
                        staticcheck = true,
                        gofumpt = true,
                        usePlaceholders = false,
                        completeUnimported = true,
                        hints = {
                            assignVariableTypes = true,
                            compositeLiteralFields = true,
                            compositeLiteralTypes = true,
                            constantValues = true,
                            functionTypeParameters = true,
                            parameterNames = true,
                            rangeVariableTypes = true,
                        },
                    },
                },
            }

            -- Lua LSP (for Neovim config)
            vim.lsp.config.lua_ls = {
                cmd = { "lua-language-server" },
                filetypes = { "lua" },
                root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        diagnostics = { globals = { "vim" } },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = { enable = false },
                        hint = { enable = true },
                    },
                },
            }

            -- Enable the configured LSPs
            vim.lsp.enable({ "gopls", "lua_ls" })

        end,
    },

    -- Rust LSP (rustaceanvim manages rust-analyzer)
    {
        "mrcjkb/rustaceanvim",
        version = "^5",
        lazy = false,
        init = function()
            -- Use a function so config is resolved lazily when a Rust file opens
            vim.g.rustaceanvim = function()
                local lsp = require("config.lsp")
                return {
                    tools = {
                        hover_actions = {
                            auto_focus = true,
                        },
                    },
                    server = {
                        on_attach = lsp.on_attach,
                        capabilities = lsp.capabilities(),
                        default_settings = {
                            ["rust-analyzer"] = {
                                checkOnSave = true,
                                check = {
                                    command = "clippy",
                                },
                                cachePriming = {
                                    enable = false,
                                },
                                completion = {
                                    autoimport = { enable = true },
                                    postfix = { enable = true },
                                },
                                cargo = {
                                    allFeatures = true,
                                    loadOutDirsFromCheck = true,
                                },
                                procMacro = {
                                    enable = true,
                                },
                                inlayHints = {
                                    bindingModeHints = { enable = true },
                                    chainingHints = { enable = true },
                                    closingBraceHints = { enable = true },
                                    closureReturnTypeHints = { enable = "always" },
                                    lifetimeElisionHints = { enable = "always" },
                                    parameterHints = { enable = true },
                                    typeHints = { enable = true },
                                },
                            },
                        },
                    },
                }
            end
        end,
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "saadparwaiz1/cmp_luasnip",
            {
                "L3MON4D3/LuaSnip",
                version = "v2.*",
                build = "make install_jsregexp",
                dependencies = {
                    "rafamadriz/friendly-snippets",
                },
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load()
                end,
            },
            "onsails/lspkind.nvim",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            local lspkind = require("lspkind")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp", priority = 1000 },
                    { name = "luasnip", priority = 750 },
                    { name = "buffer", priority = 500 },
                    { name = "path", priority = 250 },
                }),
                formatting = {
                    format = lspkind.cmp_format({
                        mode = "symbol_text",
                        maxwidth = 50,
                        ellipsis_char = "...",
                        menu = {
                            nvim_lsp = "[LSP]",
                            luasnip = "[Snip]",
                            buffer = "[Buf]",
                            path = "[Path]",
                        },
                    }),
                },
                experimental = {
                    ghost_text = false,
                },
            })

            -- Cmdline completion
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
            })

            cmp.setup.cmdline("/", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })
        end,
    },

    -- Formatting
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    rust = { "rustfmt" },
                    go = { "goimports", "gofumpt" },
                    lua = { "stylua" },
                },
                format_on_save = {
                    lsp_fallback = true,
                    async = false,
                    timeout_ms = 1000,
                },
            })
        end,
    },

    -- Linting
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local lint = require("lint")
            lint.linters_by_ft = {
                go = { "golangcilint" },
            }
            vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
                callback = function()
                    lint.try_lint()
                end,
            })
        end,
    },
}
