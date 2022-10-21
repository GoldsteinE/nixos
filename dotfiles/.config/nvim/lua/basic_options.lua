local o = vim.opt

-- Allow backspace everywhere
o.backspace = { 'indent', 'eol', 'start' }
-- Show 100 columns width limit
o.colorcolumn = { 100 }
-- Show tab completion window
o.completeopt = { 'menuone', 'noinsert', 'noselect' }
-- Invisible split separators
o.fillchars = { vert = ' ' }
-- Explicit folding
o.foldmethod = 'marker'
-- Enable RGB colors
o.termguicolors = true
-- Disable |-like cursor
o.guicursor = { }
-- Hide abandoned buffers
o.hidden = true
-- Preview s/// changes
o.inccommand = 'nosplit'
-- Ignore case if search string is all-lowercase
o.ignorecase = true
o.smartcase = true
-- Read `vim:` modelines
o.modeline = true
-- Enable mouse support
o.mouse = 'a'
-- Do not show `--MODE--` in the bottom line
o.showmode = false
-- Show both line numbers AND relative numbers
o.number = true
o.relativenumber = true
-- Set tab width to 4
o.tabstop = 4
o.shiftwidth = 4
-- Display tabs
o.listchars = { tab = '| ' }
o.list = true
-- More intuitive split directions
o.splitbelow = true
o.splitright = true
-- Allow NeoVim to set terminal title
o.title = true
-- Enable undo persistence
o.undofile = true
-- Tell NeoVim that <Leader> is space
vim.g.mapleader = ' '

-- Enable search highlight while in incsearch and disable it afterwards
vim.cmd [[ augroup VimIncsearchHl ]]
vim.cmd [[ autocmd! ]]
vim.cmd [[ autocmd CmdlineEnter [/\?] set hlsearch ]]
vim.cmd [[ autocmd CmdlineLeave [/\?] set nohlsearch ]]
vim.cmd [[ augroup END ]]
