return {
    -- 1. Package Manager Core
    {
        "mason-org/mason.nvim", -- Note: Correct GitHub user is williamboman
        cmd = "Mason",
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        }
    },

    -- 2. Bridge between Mason and Lspconfig
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = { "lua_ls", "clangd", "ols", "slang_server" },
        },
    },

    -- 3. Core LSP Config & Server Initialization
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
        },
        config = function()
            -- 1. Modify or configure specific servers using core Neovim configuration API
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" }
                        },
                    },
                },
            })
            vim.lsp.config('ols', {
                cmd = { 'ols' },
                filetypes = { 'odin' },
                root_markers = { 'ols.json', '.git' },
                init_options = {
                    checker_args = "-vet -strict-style -debug",
                    enable_semantic_tokens = true,
                    enable_fake_methods = true,
                    enable_inlay_hints_params = true,
                    enable_inlay_hints_default_params = true,
                    enable_inlay_hints_implicit_return = true,
                    enable_inlay_hints_optional_result = true,
                    enable_snippets = true,
                    --enable_checker_only_saved = false,
                   collections = {
                        {name = "shared", path = vim.fn.expand('$HOME/source/odin_lang') },
                        {name = "libs", path = '/libs'}
                   },
                },
            })
            vim.lsp.config('slang_server', {
                cmd = {'slangd'},
                filetypes = {'slang'},
                root_markers = {'.git', 'slang.toml', 'shaders'}
            })



            vim.lsp.enable({ "lua_ls", "clangd", "ols", "slang_server"})


        end
    }
}
