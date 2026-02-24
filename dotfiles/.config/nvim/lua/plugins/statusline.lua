local function setup_lualine()
    local UpdateTabNames = vim.api.nvim_create_augroup('UpdateTabNames', { clear = true })
    vim.api.nvim_create_autocmd({'BufWinEnter', 'BufEnter', 'WinEnter'}, {
        group = UpdateTabNames,
        pattern = '*',
        callback = function()
            local function tabinfo(tabnr)
                local res = { nr = tabnr }
                res.win = vim.api.nvim_tabpage_get_win(tabnr)
                res.buf = vim.api.nvim_win_get_buf(res.win)
                res.buftype = vim.fn.getbufvar(res.buf, '&buftype')
                res.fullname = vim.api.nvim_buf_get_name(res.buf)
                res.shortname = vim.fn.fnamemodify(res.fullname, ':h:t') .. '/' .. vim.fn.fnamemodify(res.fullname, ':t')
                res.name = vim.fn.fnamemodify(res.fullname, ':t')
                return res
            end

            local tabs = vim.api.nvim_list_tabpages()
            for _, tabnr1 in ipairs(tabs) do
                local tab1 = tabinfo(tabnr1)
                local set = false
                for _, tabnr2 in ipairs(tabs) do
                    local tab2 = tabinfo(tabnr2)
                    if tab1.name == tab2.name and tab1.fullname ~= tab2.fullname and tab1.buftype == '' then
                        vim.api.nvim_tabpage_set_var(tab1.nr, 'tabname', tab1.shortname)
                        set = true
                    end
                end
                if not set then
                    pcall(function() vim.api.nvim_tabpage_del_var(tab1.nr, 'tabname') end)
                end
            end
        end
    })

    require('lualine').setup {
        sections = {
            lualine_a = {'mode'},
            lualine_b = {'filename'},
            lualine_c = {
                'branch',
            },
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
            lualine_y = {
                { 'filename', path = 1, file_status = false }
            },
            lualine_z = {},
        },
    }
end

return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'kyazdani42/nvim-web-devicons' },
        config = setup_lualine,
    }
}
