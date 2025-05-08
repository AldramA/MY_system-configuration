return {
  "Exafunction/codeium.vim",
  event = "BufEnter",
  config = function()
    -- Disable default bindings
    vim.g.codeium_disable_bindings = 1
    
    -- Set up custom keybindings
    vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Accept']() end, { expr = true })
    vim.keymap.set('i', '<C-j>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
    vim.keymap.set('i', '<C-k>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
    vim.keymap.set('i', '<C-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
  end,
}
