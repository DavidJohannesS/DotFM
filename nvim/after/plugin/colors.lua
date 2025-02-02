-- Define your color function
function ColorMeow(color)
    color = color or "rose-pine"
    vim.cmd.colorscheme(color)
    -- Uncomment these if you want transparent backgrounds
     vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- Call the color function first
ColorMeow()

