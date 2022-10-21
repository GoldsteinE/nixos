require 'helpers'
require 'basic_options'

-- Installing packer.nvim
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system {
		'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path
	}
end

local packer = require 'packer'
packer.init {
	compile_path = fn.stdpath('data') .. '/packer_compiled.lua'
}
local use = packer.use

-- Package manager itself
use 'wbthomason/packer.nvim'
-- Fix CursorHold bug in Neovim
use 'antoinemadec/FixCursorHold.nvim'
-- Lua plugins writing helper
use 'bfredl/nvim-luadev'
-- Dark colorscheme
use {
	'GoldsteinE/vim-atom-dark',
	config = function()
		vim.cmd [[ colorscheme atom-dark ]]
	end
}
-- Custom syntaxes
use 'vito-c/jq.vim'
use {
	'cespare/vim-toml',
	branch = 'main',
}
use 'ekalinin/Dockerfile.vim'
use 'rhysd/vim-llvm'
use 'idris-hackers/idris-vim'
use 'elixir-editors/vim-elixir'
use 'rust-lang/rust.vim'
use 'lifepillar/pgsql.vim'
use 'LnL7/vim-nix'
use 'ziglang/zig.vim'
use { 'zetzit/vim', as = 'zz.vim' }
use 'elubow/cql-vim'
use 'baskerville/vim-sxhkdrc'
use 'BeneCollyridam/futhark-vim'
-- Read .editorconfig
use 'editorconfig/editorconfig-vim'
-- Status line
use {
	'itchyny/lightline.vim',
	requires = {
		{'ryanoasis/vim-devicons'},
		{'sainnhe/lightline_foobar.vim'},
		{'nvim-treesitter/nvim-treesitter'},
	},
	config = function() require('lightline_conf') end
}
-- Typing helpers
use 'tpope/vim-surround'
use 'tpope/vim-repeat'
use 'tpope/vim-abolish'
-- Fuzzy finder
use {
	'nvim-telescope/telescope.nvim',
	requires = {
		{'nvim-lua/popup.nvim'},
		{'nvim-lua/plenary.nvim'},
		{'kyazdani42/nvim-web-devicons'},
	},
	config = function() require('telescope_conf') end,
}
use 'nvim-telescope/telescope-symbols.nvim'
-- Terminal helper
use {
	'kassio/neoterm',
	config = function()
		vim.g.neoterm_default_mod = 'below'
		vim.g.neoterm_autoinsert = 1
	end
}
-- Sign column
use 'airblade/vim-gitgutter'
use {
	'kshenoy/vim-signature',
	config = function()
		vim.g.SignatureMarkTextHLDynamic = 1
		vim.g.SignatureMarkerTextHLDynamic = 1
	end,
}
-- Git helper
use {
	'tpope/vim-fugitive',
	config = function()
		vim.cmd [[ command! Gblame Git blame ]]
	end
}
use 'shumphrey/fugitive-gitlab.vim'
-- Easy HTML typing
use {
	'mattn/emmet-vim',
	config = function()
		vim.g.user_emmet_expandabbr_key = '<C-y>y'
	end,
}
-- Start page
use {
	'mhinz/vim-startify',
	config = function()
		vim.cmd [[
		function! StartifyEntryFormat()
			return 'WebDevIconsGetFileTypeSymbol(absolute_path) . "  " . entry_path'
		endfunction
		]]
	end
}
-- Internal NeoVim LSP configuration helper
use { 'neovim/nvim-lspconfig', config = function() require('lsp_conf') end }
-- LSP stub for non-LS languages
use {
	'jose-elias-alvarez/null-ls.nvim',
	requires = {
		{'nvim-lua/plenary.nvim'},
	},
	config = function()
		local null_ls = require 'null-ls'
		null_ls.setup {
			sources = {
				null_ls.builtins.diagnostics.shellcheck.with {
					runtime_condition = function()
						return vim.fn.executable('shellcheck') == 1
					end
				},
				null_ls.builtins.code_actions.shellcheck.with {
					runtime_condition = function()
						return vim.fn.executable('shellcheck') == 1
					end
				},
				null_ls.builtins.formatting.jq.with {
					runtime_condition = function()
						return vim.fn.executable('jq') == 1
					end,
				},
			}
		}
	end
}
-- Pretty LSP diagnostics
use {
	'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
	config = function()
		require('lsp_lines').setup()
	end
}
-- LSP progress
use {
	'j-hui/fidget.nvim',
	config = function() require('fidget').setup{} end
}
-- LSP UI
use {
	'stevearc/dressing.nvim',
	config = function() require('dressing').setup {
		input = {
			enabled = false,
		},
	} end,
}
use {
	'smjonas/inc-rename.nvim',
	config = function() require('inc_rename').setup{} end,
}
-- Completion engine
use {
	'hrsh7th/nvim-cmp',
	config = function() require('cmp_conf') end,
	requires = {
		'hrsh7th/vim-vsnip',
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-calc',
		'hrsh7th/cmp-nvim-lua',
		'kdheepak/cmp-latex-symbols',
	},
}
-- jq integration
use 'gennaro-tedesco/nvim-jqx'
-- GPG
use 'jamessan/vim-gnupg'
if executable('g++') or executable('clang++') then
	vim.g.treesitter_enabled = true
	-- TreeSitter-based syntax highlighting & text objects
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = function() require('treesitter_conf') end,
		requires = {
			"p00f/nvim-ts-rainbow",
		},
	}
	use 'nvim-treesitter/playground'
end
-- Screenshoting code
if executable('silicon') then
	use {
		'segeljakt/vim-silicon',
		config = function()
			vim.g.silicon = {
				theme = 'OneHalfDark',
				output = '/tmp/silicon-{time:%Y-%m-%d%H%M%S}.png',
				['pad-vert'] = 0,
				['pad-horiz'] = 0,
				['round-corner'] = false,
				['window-controls'] = false
			}
		end,
	}
end

dofile(fn.stdpath("data") .. "/packer_compiled.lua")

if packer_bootstrap then
	packer.sync()
end

require 'mappings'

autocmd('BufReadPre,FileReadPre', {
	group = augroup('S_SELF'),
	pattern = 'init.lua',
	callback = function()
		vim.opt.path = { vim.fn.getenv('HOME') .. '/.config/nvim/lua' }
		vim.opt.suffixesadd = { '.lua' }
	end,
})
