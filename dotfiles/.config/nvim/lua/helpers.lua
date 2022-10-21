function _G.executable(command)
	return vim.fn.executable(command) ~= 0
end

function _G.augroup(name, opts)
	if opts == nil then
		opts = {}
	end
	return vim.api.nvim_create_augroup(name, opts)
end
_G.autocmd = vim.api.nvim_create_autocmd
