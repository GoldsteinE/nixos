local function setup_telescope()
    local builtin = require 'telescope.builtin'
    local actions = require 'telescope.actions'
    local previewers = require 'telescope.previewers'
    local telescope = require 'telescope'

    telescope.setup {
        defaults = {
            mappings = {
                i = {
                    ["<c-j>"] = actions.move_selection_next,
                    ["<c-k>"] = actions.move_selection_previous,
                }
            },
            file_previewer = previewers.vim_buffer_cat.new,
            grep_previewer = previewers.vim_buffer_vimgrep.new,
            qflist_previewer = previewers.vim_buffer_qflist.new
        }
    }
    telescope.load_extension 'undo'

    local map = vim.keymap.set
    map('n', '<leader>f', builtin.find_files)
    -- Not `g` because of ergonomics; `l` means `lines (in all files)`
    map('n', '<leader>l', builtin.live_grep)
    map('n', '<leader>L', builtin.grep_string)
    -- Lines in the current buffer
    map('n', '<leader>;', builtin.current_buffer_fuzzy_find)
    -- Buffers (useful after long go-to-definition chains)
    map('n', '<leader>b', builtin.buffers)
    -- LaTeX symbols
    map('i', '<c-x>', function() builtin.symbols { sources = {'math'} } end)
    -- Undo
    map('n', '<leader>u', '<cmd>Telescope undo<cr>')
    -- LSP definitions
    map('n', '<leader>d', builtin.lsp_definitions)
    -- LSP implementations
    map('n', '<leader>D', builtin.lsp_implementations)
    -- LSP type definitions
    map('n', '<leader>td', builtin.lsp_type_definitions)
    -- LSP references
    map('n', '<leader>gr', builtin.lsp_references)
    -- LSP symbols in the current document
    map('n', '<leader>gs', builtin.lsp_document_symbols)
    -- LSP symbols in the project
    map('n', '<leader>ws', builtin.lsp_workspace_symbols)
    -- LSP diagnostics in current buffer
    map('n', '<leader>e', function() builtin.diagnostics { bufnr = 0, severity_limit = "WARN" } end)
    -- All LSP diagnostics
    map('n', '<leader>E', function() builtin.diagnostics { severity_limit = "WARN" } end)
end

return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/popup.nvim',
        'nvim-lua/plenary.nvim',
        'kyazdani42/nvim-web-devicons',
        'nvim-telescope/telescope-symbols.nvim',
        'debugloop/telescope-undo.nvim',
    },
    config = setup_telescope,
}
