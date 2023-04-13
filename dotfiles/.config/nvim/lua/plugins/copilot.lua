return {
    'github/copilot.vim',
    config = function()
        vim.g.copilot_no_tab_map = true
        vim.keymap.set('i','<A-Tab>', 'copilot#Accept("")', {
            remap = true,
            silent = true,
            script = true,
            expr = true,
        })
        vim.api.nvim_create_autocmd({'BufReadPre', 'BufNewFile'}, {
            pattern = '/home/goldstein/work/*',
            callback = function(arg)
                vim.b.copilot_enabled = false
            end,
        })
    end,
    lazy = true,
    cmd = 'Copilot',
}
