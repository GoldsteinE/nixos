local lspconfig = require 'lspconfig'

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = false,
	signs = false,
	severity_sort = true,
})

vim.diagnostic.config {
	virtual_text = false,
}

-- Disable lsp-lines in insert mode
local lsp_lines_helper = augroup('LspLinesHelper')
local last_lsp_lines_status = true
autocmd('InsertEnter', {
	group = lsp_lines_helper,
	pattern = "*",
	callback = function()
		last_lsp_lines_status = vim.diagnostic.config().virtual_lines
		vim.diagnostic.config {
			virtual_text = false,
			virtual_lines = false,
		}
		-- To update cursor position
		vim.cmd [[ normal "hl" ]]
	end
})
autocmd('InsertLeave', {
	group = lsp_lines_helper,
	pattern = "*",
	callback = function()
		vim.diagnostic.config {
			virtual_text = false,
			virtual_lines = last_lsp_lines_status,
		}
	end
})

local function capabilities()
	return require('cmp_nvim_lsp').default_capabilities()
end

local navic = require 'nvim-navic'
local function on_attach(client, bufnr)
	navic.attach(client, bufnr)

	-- Semantic tokens
	local hi = vim.api.nvim_set_hl
	hi(0, '@unsafe',   { underdashed = true })
	hi(0, '@trait',    { italic = true })
	hi(0, '@callable', { link = 'Function'})
end

if executable('rust-analyzer') then
	require('rust-tools').setup {
		tools = {
			inlay_hints = {
				parameter_hints_prefix = "← ",
				other_hints_prefix = ": ",
			},
			hover_actions = {
				border = "none",
			},
		},
		server = {
			settings = {
				["rust-analyzer"] = {
					cargo = {
						allFeatures = true,
					},
					completion = {
						autoimport = {
							enable = true,
						},
					},
					checkOnSave = {
						command = "clippy",
					},
					assist = {
						importMergeBehaviour = "crate",
						importPrefix = "by_crate",
					},
				},
			},
			capabilities = capabilities(),
			on_attach = on_attach,
		}
	}
end

if executable('clangd') then
	lspconfig.clangd.setup{
		capabilities = capabilities(),
		on_attach = on_attach,
	}
end

if executable('pyright') then
	lspconfig.pyright.setup{
		capabilities = capabilities(),
		on_attach = on_attach,
	}
end

if executable('gopls') then
	lspconfig.gopls.setup{
		capabilities = capabilities(),
		on_attach = on_attach,
	}
end

if executable('typescript-language-server') then
	lspconfig.tsserver.setup {
		capabilities = capabilities(),
		on_attach = on_attach,
	}
end

if executable('haskell-language-server') then
	if executable('fourmolu') then
		lspconfig.hls.setup {
			capabilities = capabilities(),
			settings = {
				haskell = {
					formattingProvider = "fourmolu",
				},
			},
			on_attach = on_attach,
		}
	else
		lspconfig.hls.setup {
			capabilities = capabilities(),
			on_attach = on_attach,
		}
	end
end

if executable('rnix-lsp') then
	lspconfig.rnix.setup {
		capabilities = capabilities(),
		on_attach = on_attach,
	}
end

if executable('elixir-ls') then
	lspconfig.elixirls.setup {
		cmd = { "elixir-ls" }
	}
end
