function lightline_filetype()
	return vim.fn.WebDevIconsGetFileTypeSymbol() .. ' ' .. vim.bo.filetype
end

vim.g.lightline = {
	colorscheme = 'wombat',
	separator = {
		left = vim.fn.nr2char(57520),
		right = vim.fn.nr2char(57522)
	},
	subseparator = {
		left = vim.fn.nr2char(57521),
		right = vim.fn.nr2char(57523)
	},
	active = {
		left = {
			{ 'mode', 'paste' },
			{ 'readonly', 'filename', 'modified', 'gitbranch' }
		}
	},
	component_function = {
		gitbranch = 'FugitiveHead',
	},
	component = {
		filetype = '%{v:lua.lightline_filetype()}',
	},
}
