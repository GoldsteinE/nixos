local function on_attach(client, bufnr)
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

    -- Semantic tokens
    local hi = vim.api.nvim_set_hl
    hi(0, '@callable', { link = 'Function'})
end

local function setup_lsp()
    local lspconfig = require 'lspconfig'

    vim.diagnostic.config {
        signs = false,
        underline = false,
        virtual_text = false,
        virtual_lines = true,
    }

    local map = vim.keymap.set
    map('n', '<leader>k', vim.lsp.buf.hover, { silent = true })
    map('n', '<leader>a', vim.lsp.buf.code_action, { silent = true })
    map('n', '<leader><space>', function() vim.lsp.buf.format { async = true } end, { silent = true })
    map('n', '<leader>s', function()
        vim.diagnostic.config {
            virtual_lines = not vim.diagnostic.config().virtual_lines,
        }
    end)
    map('n', ']e', function() vim.diagnostic.goto_next { float = false } end)
    map('n', '[e', function() vim.diagnostic.goto_prev { float = false } end)

    -- Disable lsp-lines and inlay hints in insert mode
    local lsp_lines_helper = vim.api.nvim_create_augroup('LspLinesHelper', {})
    local last_lsp_lines_status = true
    vim.api.nvim_create_autocmd('InsertEnter', {
        group = lsp_lines_helper,
        pattern = "*",
        callback = function()
            vim.lsp.inlay_hint.enable(false, { bufnr = 0 }) 
            last_lsp_lines_status = vim.diagnostic.config().virtual_lines
            vim.diagnostic.config {
                virtual_text = false,
                virtual_lines = false,
            }
            -- To update cursor position
            vim.cmd [[ normal "hl" ]]
        end
    })
    vim.api.nvim_create_autocmd('InsertLeave', {
        group = lsp_lines_helper,
        pattern = "*",
        callback = function()
            vim.lsp.inlay_hint.enable(true, { bufnr = 0 }) 
            vim.diagnostic.config {
                virtual_text = false,
                virtual_lines = last_lsp_lines_status,
            }
        end
    })

    local function capabilities()
        return require('cmp_nvim_lsp').default_capabilities()
    end

    if executable('rust-analyzer') then
        local rustc_source = nil
        if vim.env.RUSTC_SRC ~= nil then
            rustc_source = vim.env.RUSTC_SRC
        end

        local target_dir = true
        local default_target_dir = vim.fn.getenv('CARGO_TARGET_DIR')
        if default_target_dir ~= vim.v.null then
            target_dir = default_target_dir .. "/rust-analyzer"
        end

        vim.g.rustaceanvim = {
            server = {
                default_settings = {
                    ["rust-analyzer"] = {
                        cargo = {
                            allFeatures = true,
                            targetDir = target_dir,
                        },
                        completion = {
                            autoimport = {
                                enable = true,
                            },
                            termSearch = {
                                enable = true,
                            },
                        },
                        checkOnSave = {
                            command = "clippy",
                        },
                        assist = {
                            importMergeBehaviour = "crate",
                            importPrefix = "by_crate",
                        },
                        inlayHints = {
                            bindingModeHints = {
                                enable = true,
                            },
                            closureReturnTypeHints = {
                                enable = "always",
                            },
                            discriminantHints = {
                                enable = "always",
                            },
                            lifetimeElisionHints = {
                                enable = "skip_trivial",
                                useParameterNames = true,
                            },
                            rangeExclusiveHints = {
                                enable = true,
                            },
                            expressionAdjustmentHints = {
                                -- Currently broken: https://github.com/neovim/neovim/issues/29647
                                -- enable = "reborrow",
                                -- mode = "postfix",
                            },
                        },
                        procMacro = {
                            enable = true,
                        },
                        rustc = {
                            source = rustc_source,
                        },
                    },
                },
                on_attach = on_attach,
            }
        }
    end

    if executable('clangd') then
        lspconfig.clangd.setup{
            cmd = { "clangd", "--query-driver=c++" },
            capabilities = capabilities(),
            on_attach = on_attach,
        }
    end

    if executable('pyright') then
        lspconfig.pyright.setup{
            capabilities = capabilities(),
            on_attach = on_attach,
        }
    end

    if executable('gopls') then
        lspconfig.gopls.setup{
            capabilities = capabilities(),
            on_attach = on_attach,
        }
    end

    if executable('zls') then
        lspconfig.zls.setup{
            capabilities = capabilities(),
            on_attach = on_attach,
        }
    end

    if executable('typescript-language-server') then
        lspconfig.tsserver.setup {
            capabilities = capabilities(),
            on_attach = on_attach,
        }
    end

    if executable('haskell-language-server') then
        if executable('fourmolu') then
            lspconfig.hls.setup {
                capabilities = capabilities(),
                settings = {
                    haskell = {
                        formattingProvider = "fourmolu",
                    },
                },
                on_attach = on_attach,
            }
        else
            lspconfig.hls.setup {
                capabilities = capabilities(),
                on_attach = on_attach,
            }
        end
    end

    if executable('nixd') then
        lspconfig.nixd.setup {
            capabilities = capabilities(),
            on_attach = on_attach,
        }
    end

    if executable('elixir-ls') then
        lspconfig.elixirls.setup {
            cmd = { "elixir-ls" }
        }
    end

    if executable('astro-ls') then
        lspconfig.astro.setup{}
    end

    if executable('tinymist') then
        lspconfig.tinymist.setup{
            settings = {
                exportPdf = "onType",
                outputPath = "$root/out/$name",
                compileStatus = "enable",
            }
        }
    end
end

return {
    {
        'neovim/nvim-lspconfig',
        config = setup_lsp,
        dependencies = { 'mrcjkb/rustaceanvim' },
    },
    {
        'nvimtools/none-ls.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' }, 
        config = setup_null_ls,
    },
    {
        url = 'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
        config = function()
            require('lsp_lines').setup()
        end
    },
    {
        'j-hui/fidget.nvim',
        tag = 'legacy',
        config = function() require('fidget').setup{} end
    },
    {
        'stevearc/dressing.nvim',
        config = function() require('dressing').setup {
            input = {
                enabled = false,
            },
        } end,
    },
    {
        'saecki/live-rename.nvim',
        config = function()
            local live_rename = require 'live-rename'
            live_rename.setup {
                prepare_rename = true,
                request_timeout = 1500,
                keys = {
                    submit = {
                        { "n", "<cr>" },
                        { "v", "<cr>" },
                        { "i", "<cr>" },
                    },
                    cancel = {
                        { "n", "<esc>" },
                        { "n", "<C-c>" },
                        { "i", "<C-c>" },
                        { "v", "<C-c>" },
                    },
                },
            }
            vim.keymap.set('n', '<leader>nr', live_rename.rename)
            vim.keymap.set('n', '<leader>r', live_rename.map { insert = true })
            vim.keymap.set('n', '<leader>R', live_rename.map { insert = true, text = '' })
        end
    },
    -- Lean requires `on_attach` passed in `opts`.
    { 
      'Julian/lean.nvim',
      event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },
      dependencies = {
        'neovim/nvim-lspconfig',
        'nvim-lua/plenary.nvim',
      },
      opts = {
        lsp = {
          on_attach = on_attach,
        },
        mappings = true,
      }
    },
}
