local function setup_neoterm()
    vim.g.neoterm_default_mod = 'below'
    vim.g.neoterm_autoinsert = 1

    local map = vim.keymap.set
    map('n', '<Leader>tj', function() vim.fn.execute('bel ' .. vim.v.count ..' Ttoggle') end)
    map('n', '<Leader>tl', function() vim.fn.execute('vert ' .. vim.v.count ..' Ttoggle') end)
    map('n', '<Leader>tt', function() vim.fn.execute('tab ' .. vim.v.count ..' Ttoggle') end)
    map('i', '<C-s>', '<C-o><Cmd>TREPLSendLine<CR>', { silent = true })
    map('n', '<C-s>', '<Plug>(neoterm-repl-send-line)', { remap = true })
    map({'n', 'x'}, '<Leader>s', '<Plug>(neoterm-repl-send)', { remap = true })
    map('x', '<C-s>', '<Plug>(neoterm-repl-send)', { remap = true })
end

return {
    { 'kassio/neoterm', config = setup_neoterm },
}
