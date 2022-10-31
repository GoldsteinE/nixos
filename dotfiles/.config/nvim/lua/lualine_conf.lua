require('lualine').setup {
	options = { theme = "seoul256" },
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'filename'},
		lualine_c = {'branch'},
		lualine_x = {'fileformat', 'encoding', 'filetype'},
		lualine_y = {'progress'},
		lualine_z = {'location'},
	},
	inactive_sections = {
		lualine_a = {'filename'},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {'filetype'},
		lualine_y = {'progress'},
		lualine_z = {'location'},
	},
	tabline = {
		lualine_a = {
			{
				'tabs',
				mode = 2,
				max_length = vim.o.columns,
			}
		},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
}
