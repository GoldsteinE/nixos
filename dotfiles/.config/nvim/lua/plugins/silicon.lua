if executable('silicon') then
    return {
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
else
    return {}
end
