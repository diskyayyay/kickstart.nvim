-- Toggleable floating terminal. Press <C-\> to pop a terminal in/out.
-- https://github.com/akinsho/toggleterm.nvim

vim.pack.add {
  { src = 'https://github.com/akinsho/toggleterm.nvim', version = vim.version.range '*' },
}

require('toggleterm').setup {
  open_mapping = [[<c-\>]],
  direction = 'vertical',
  size = function(term)
    if term.direction == 'vertical' then
      return math.floor(vim.o.columns * 0.4)
    end
    return 15
  end,
  shell = 'powershell.exe -NoLogo',
}

-- Tmux-style terminal picker: <leader>tl lists all open terminals
vim.keymap.set('n', '<leader>tl', '<Cmd>TermSelect<CR>',
  { desc = '[T]erminal: [L]ist / switch' })

-- Terminal-mode escapes & window navigation (no need to close the terminal)
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = 'term://*',
  callback = function()
    local opts = { buffer = 0, silent = true }
    -- jk or <Esc> exits terminal mode (back to normal mode, terminal stays open)
    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], opts)
    -- Ctrl+h/j/k/l: jump straight to another window from terminal mode
    vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-w>h]], opts)
    vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-w>j]], opts)
    vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-w>k]], opts)
    vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-w>l]], opts)
  end,
})
