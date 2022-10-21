require 'nvim-treesitter.configs'.setup {
	ensure_installed = { "rust", "c", "cpp", "python", "toml", "query", "lua", "haskell" },
	highlight = {
		enable = true,
		-- Broken, waiting for https://github.com/nvim-telescope/telescope.nvim/issues/2155
		-- custom_captures = {
		-- 	["include"] = "Keyword",
		-- 	["attribute_item.meta_item.identifier"] = "PreProc"
		-- }
	},
	playground = {
		enable = true
	},
	rainbow = {
		disable = true,
		colors = {
			"#86007D",
			"#0000F9",
			"#008018",
			"#FFFF41",
			"#FFA52C",
			"#FF0018",
		},
	},
}
