local function setup_treesitter()
    require 'nvim-treesitter.configs'.setup {
        ensure_installed = { "rust", "c", "cpp", "python", "toml", "query", "lua", "haskell" },
        highlight = {
            enable = true,
        },
        playground = {
            enable = true
        },
    }
end

if executable('g++') or executable('clang++') then
    return {
        {
            'nvim-treesitter/nvim-treesitter',
            build = ':TSUpdate',
            config = setup_treesitter,
        },
    }
else
    return {}
end
