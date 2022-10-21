local function modified()
	if vim.opt.modified._value then
		return '+'
	else
		return ''
	end 
end
require('lualine').setup {
	options = { theme = 'wombat' },
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'filename'},
		lualine_c = {'branch', modified},
		lualine_x = {'fileformat', 'encoding', 'filetype'},
		lualine_y = {'progress'},
		lualine_z = {'location'},
	},
	inactive_sections = {
		lualine_a = {'filename'},
		lualine_b = {modified},
		lualine_c = {},
		lualine_x = {'filetype'},
		lualine_y = {'progress'},
		lualine_z = {'location'},
	},
	tabline = {
		lualine_a = {'tabs'},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
}
