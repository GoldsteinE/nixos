local map = vim.keymap.set

-- Exit insert mode with `jk`
map('i', 'jk', '<Esc>')
-- Do the same in terminal mode
map('t', 'jk', '<C-\\><C-N>')
-- Make & work in visual mode
map('x', '&', '<Cmd>s<Up><CR>')
-- Repeat the last macro
map('n', 'Q', '@@')
-- Repurpose `s` for deletion without clobbering clipboard
map('n', 's', '"_d"')
-- Move between windows with gw
map('n', 'gwh', '<C-w>h')
map('n', 'gwj', '<C-w>j')
map('n', 'gwk', '<C-w>k')
map('n', 'gwl', '<C-w>l')
-- Open a new tab at the same place
map('n', '<Leader>T', '<Cmd>tab spl<CR>')

-- Copy/paste to/from system clipboard
if vim.fn.has('clipboard') ~= 0 then
    map({'n', 'x'}, 'gy', '"+y')
    map({'n', 'x'}, 'gp', '"+p')
end
