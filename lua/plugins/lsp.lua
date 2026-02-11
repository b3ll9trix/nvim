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
            -- Rust enhancements
            {
                "mrcjkb/rustaceanvim",
                version = "^5",
                lazy = false,
            },
        },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Diagnostic configuration
            vim.diagnostic.config({
                virtual_text = {
                    prefix = "●",
                    source = "if_many",
                },
                float = {
                    border = "rounded",
                    source = true,
                },
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
            })

            -- Diagnostic signs
            local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            -- On attach function for LSP keymaps and features
            local on_attach = function(client, bufnr)
                local opts = { buffer = bufnr, silent = true }

                -- Navigation
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
                vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Find references" }))
                vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "Go to type definition" }))

                -- Documentation
                vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
                vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature help" }))
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

            -- Mason-lspconfig setup
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "gopls",
                    "lua_ls",
                },
                automatic_installation = true,
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

            -- Rustaceanvim handles rust_analyzer automatically
            -- Configure it via vim.g.rustaceanvim
            vim.g.rustaceanvim = {
                tools = {
                    hover_actions = {
                        auto_focus = true,
                    },
                },
                server = {
                    on_attach = on_attach,
                    capabilities = capabilities,
                    default_settings = {
                        ["rust-analyzer"] = {
                            checkOnSave = true,
                            check = {
                                command = "clippy",
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
