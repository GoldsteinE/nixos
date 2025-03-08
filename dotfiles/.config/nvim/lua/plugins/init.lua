return {
    -- Colorscheme
    {
        'cdmill/neomodern.nvim',
        config = function()
            local neomodern = require('neomodern')
            neomodern.setup {
                code_style = {
                    comments = "none",
                },
                ui = {
                    diagnostics = {
                        background = false,
                    },
                },
                highlights = {
                    ['@lsp.mod.unsafe.rust'] = { fmt = 'underdashed' },
                    ['@lsp.typemod.method.trait.rust'] = { fmt = 'italic' },
                    ['@lsp.typemod.function.defaultLibrary'] = { fg = 'none' },
                    -- ['@lsp.mod.callable.rust'] = { link = 'Function' },
                },
            }
            neomodern.load()
        end
    },
    -- Typing helpers
    {
        'kylechui/nvim-surround',
        config = function() require('nvim-surround').setup() end,
    },
    'tpope/vim-abolish',
    -- Sign column
    { 'airblade/vim-gitgutter', branch = 'main' },
    {
        'kshenoy/vim-signature',
        config = function()
            vim.g.SignatureMarkTextHLDynamic = 1
            vim.g.SignatureMarkerTextHLDynamic = 1
        end,
    },
    -- Git helper
    {
        'tpope/vim-fugitive',
        config = function()
            vim.cmd [[ command! Gblame Git blame ]]
        end
    },
    -- Start page
    {
        'mhinz/vim-startify',
        dependencies = {'ryanoasis/vim-devicons'},
        config = function()
            vim.g.startify_change_to_dir = 0
            vim.g.startify_change_to_vcs_root = 1
            vim.cmd [[
            function! StartifyEntryFormat()
                return 'WebDevIconsGetFileTypeSymbol(absolute_path) . "  " . entry_path'
            endfunction
            ]]
        end
    },
    -- Global search & replace
    {
        'nvim-pack/nvim-spectre',
        cmd = "Spectre",
    },
}
