local lspconfig = require 'lspconfig'

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = false,
    -- virtual_text = {
	-- 	prefix = '',
	-- 	indent = 2,
	-- 	format = function(diagnostic) return string.format('// %s', diagnostic.message) end,
    -- },
	signs = false,
	severity_sort = true,
})

vim.diagnostic.config {
	virtual_text = false,
}

local function capabilities()
	return require('cmp_nvim_lsp').default_capabilities()
end

if executable('rust-analyzer') then
	lspconfig.rust_analyzer.setup{
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
	}
end

if executable('clangd') then
	lspconfig.clangd.setup{
		capabilities = capabilities(),
	}
end

if executable('pyright') then
	lspconfig.pyright.setup{
		capabilities = capabilities(),
	}
end

if executable('gopls') then
	lspconfig.gopls.setup{
		capabilities = capabilities(),
	}
end

if executable('typescript-language-server') then
	lspconfig.tsserver.setup {
		capabilities = capabilities(),
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
		}
	else
		lspconfig.hls.setup {
			capabilities = capabilities(),
		}
	end
end

if executable('rnix-lsp') then
	lspconfig.rnix.setup {
		capabilities = capabilities(),
	}
end
