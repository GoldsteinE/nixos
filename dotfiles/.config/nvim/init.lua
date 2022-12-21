require 'basic_options'
require 'mappings'

-- Used in a lot of places later
function _G.executable(command)
    return vim.fn.executable(command) ~= 0
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)
require('lazy').setup('plugins')

vim.api.nvim_create_autocmd('BufReadPre,FileReadPre', {
    group = vim.api.nvim_create_augroup('S_SELF', {}),
    pattern = 'init.lua',
    callback = function()
        vim.opt.path = { vim.fn.getenv('HOME') .. '/.config/nvim/lua' }
        vim.opt.suffixesadd = { '.lua' }
    end,
})
