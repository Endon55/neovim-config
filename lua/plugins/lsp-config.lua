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
                -- Run ols in its own scope so an OOM kill/limit hits only ols, not nvim
                cmd = { 'systemd-run', '--user', '--scope', '-q',
                        '-p', 'MemoryHigh=700M', '-p', 'MemoryMax=1G', 'ols' },
                filetypes = { 'odin' },
                root_markers = { 'ols.json', '.git' },
                init_options = {
                    checker_args = "",
                    enable_semantic_tokens = true,
                    enable_fake_methods = true,
                    enable_checker_workspace_diagnostics = false,
                    enable_checker_only_saved = true,
                    enable_snippets = true,
                   collections = {
                        {name = "libs", path = './libs'}
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
