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

    vim.treesitter.language.register('markdown', 'mdx')

    local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
    parser_config.typst = {
      install_info = {
        url = "https://github.com/uben0/tree-sitter-typst",
        files = {"src/parser.c", "src/scanner.c"},
        requires_generate_from_grammar = false,
      },
    }

    vim.api.nvim_set_hl(0, '@markup.bold', { bold = true })
    vim.api.nvim_set_hl(0, '@markup.italic', { italic = true })
    vim.api.nvim_set_hl(0, '@markup.heading', { link = 'Title' })
    vim.api.nvim_set_hl(0, '@markup.list', { link = '@punctuation.special' })
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
