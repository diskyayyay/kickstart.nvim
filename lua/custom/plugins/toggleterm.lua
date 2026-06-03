-- Toggleable floating terminal. Press <C-\> to pop a terminal in/out.
-- https://github.com/akinsho/toggleterm.nvim

vim.pack.add {
  { src = 'https://github.com/akinsho/toggleterm.nvim', version = vim.version.range '*' },
}

-- Wide nvim window -> smaller % (terminal already plenty wide).
-- Narrow nvim window -> larger % so terminal stays usable.
local WIDE_COLS = 150 -- threshold: >= this many cols counts as "wide"
local function vsplit_width()
  local ratio = vim.o.columns >= WIDE_COLS and 0.28 or 0.4
  return math.floor(vim.o.columns * ratio)
end

require('toggleterm').setup {
  open_mapping = [[<c-\>]],
  direction = 'vertical',
  size = function(term)
    if term.direction == 'vertical' then return vsplit_width() end
    return 15
  end,
  shell = 'powershell.exe -NoLogo',
}

-- Tmux-style terminal picker: <leader>tl lists all open terminals
vim.keymap.set('n', '<leader>tl', '<Cmd>TermSelect<CR>',
  { desc = '[T]erminal: [L]ist / switch' })

-- small bottom terminal
vim.keymap.set('n', '<leader>st', function()
  vim.cmd 'botright 5split | terminal'
  vim.bo.buflisted = false
  vim.cmd.startinsert()
end, { desc = '[S]mall [T]erminal at bottom' })

-- floating terminal
local Terminal = require('toggleterm.terminal').Terminal
local float_term = Terminal:new {
  direction = 'float',
  hidden = true,
  on_open = function(term)
    vim.keymap.set('t', '<Esc>', function() term:toggle() end, { buffer = term.bufnr })
    vim.keymap.set('n', '<Esc>', function() term:toggle() end, { buffer = term.bufnr })
  end,
}
vim.keymap.set('n', '<leader>tf', function() float_term:toggle() end,
  { desc = '[T]erminal: [F]loating' })

-- Re-resize any visible vertical toggleterm windows when nvim is resized
vim.api.nvim_create_autocmd('VimResized', {
  callback = function()
    local target = vsplit_width()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      if vim.bo[buf].filetype == 'toggleterm' then
        vim.api.nvim_win_set_width(win, target)
      end
    end
  end,
})

-- Terminal-mode escapes & window navigation (no need to close the terminal)
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = 'term://*',
  callback = function()
    vim.bo.buflisted = false
    local opts = { buffer = 0, silent = true }
    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], opts)
    -- Ctrl+h/j/k/l: jump straight to another window from terminal mode
    vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-w>h]], opts)
    vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-w>j]], opts)
    vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-w>k]], opts)
    vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-w>l]], opts)
  end,
})
