return {
    -- Colorscheme
    {
        'GoldsteinE/vim-atom-dark',
        config = function()
            -- vim.cmd [[ colorscheme atom-dark ]]
        end
    },
    'rktjmp/lush.nvim',
    {
        'EdenEast/nightfox.nvim',
        config = function()
            vim.cmd [[ colorscheme nightfox ]]
            vim.cmd [[ hi @text.literal gui=NONE ]]
        end,
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        -- Correct ordering
        dependencies = {
            'EdenEast/nightfox.nvim',
        },
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
    'shumphrey/fugitive-gitlab.vim',
    -- Easy HTML typing
    {
        'mattn/emmet-vim',
        config = function()
            vim.g.user_emmet_expandabbr_key = '<C-y>y'
        end,
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
    -- GPG
    'jamessan/vim-gnupg',
    -- Global search & replace
    'nvim-pack/nvim-spectre',

    { dir = "/home/goldstein/pets/nvim-issue-helper" },
}
