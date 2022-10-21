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
-- Exit
map('n', '<Leader>q', function()
	if vim.opt.buftype:get() == 'terminal' then
		vim.fn.execute('q')
	elseif vim.w.terminal_window ~= nil then
		vim.fn.execute('w')
		vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-o>i', true, true, true))
	else
		vim.fn.execute('wq')
	end
end)

-- Copy/paste to/from system clipboard
if vim.fn.has('clipboard') ~= 0 then
	map({'n', 'x'}, 'gy', '"+y')
	map({'n', 'x'}, 'gp', '"+p')
end

-- nvim-luadev
local function register_luadev_mappings()
	map('n', '<Leader>ll', ':Luadev<CR>', { remap = true, silent = true, buffer = 0 })
	map('n', '<Leader>lr', '<Plug>(Luadev-RunLine)', { remap = true, buffer = 0 })
	map('x', '<Leader>lr', '<Plug>(Luadev-Run)', { remap = true, buffer = 0 })
	map('x', '<Leader>lw', '<Plug>(Luadev-RunWord)', { remap = true, buffer = 0 })
end

autocmd('FileType', {
	group = augroup('LuaDevMaps'),
	pattern = 'lua',
	callback = register_luadev_mappings,
})

autocmd('ModeChanged', {
	group = augroup('TerminalWindow'),
	pattern = '*:t',
	callback = function() vim.w.terminal_window = 1 end,
})

-- neoterm
map('n', '<Leader>tj', function() vim.fn.execute('bel ' .. vim.v.count ..' Ttoggle') end)
map('n', '<Leader>tl', function() vim.fn.execute('vert ' .. vim.v.count ..' Ttoggle') end)
map('n', '<Leader>tt', function() vim.fn.execute('tab ' .. vim.v.count ..' Ttoggle') end)
map('i', '<C-s>', '<C-o><Cmd>TREPLSendLine<CR>', { silent = true })
map('n', '<C-s>', '<Plug>(neoterm-repl-send-line)', { remap = true })
map({'n', 'x'}, '<Leader>s', '<Plug>(neoterm-repl-send)', { remap = true })
map('x', '<C-s>', '<Plug>(neoterm-repl-send)', { remap = true })

-- vsnip
map({'i', 's'}, '<M-Tab>', '<Plug>(vsnip-jump-next)', { remap = true })
map({'i', 's'}, '<M-l>', '<Plug>(vsnip-jump-next)', { remap = true })
map({'i', 's'}, '<M-h>', '<Plug>(vsnip-jump-prev)', { remap = true })

-- LSP
map('n', '<leader>r', ':IncRename ', { silent = true })
map('n', '<leader>k', vim.lsp.buf.hover, { silent = true })
map('n', '<leader>a', vim.lsp.buf.code_action, { silent = true })
map('n', '<leader><space>', function() vim.lsp.buf.format { async = true } end, { silent = true })

function _G.diff(cmd)
	local old_buf = vim.api.nvim_get_current_buf()
	local filename = vim.api.nvim_buf_get_name(old_buf)
	cmd[#cmd + 1] = filename
	cmd[#cmd + 1] = "/dev/stdin"

	local buf = vim.api.nvim_create_buf(false, true)
	if buf == 0 then
		error("failed to create buffer")
		return
	end
	vim.cmd [[ split ]]
	local win = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_buf(win, buf)
	local channel = vim.fn.termopen(cmd)
	if channel < 1 then
		error("failed to termopen()")
		return
	end
	vim.fn.chansend(channel, vim.api.nvim_buf_get_lines(old_buf, 0, -1, false))
	vim.fn.chanclose(channel, 'stdin')
end
