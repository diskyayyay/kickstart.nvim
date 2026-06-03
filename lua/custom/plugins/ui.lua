-- UI: bufferline (top tabs) + lualine (pretty statusline)
-- https://github.com/akinsho/bufferline.nvim
-- https://github.com/nvim-lualine/lualine.nvim

vim.pack.add {
  { src = 'https://github.com/akinsho/bufferline.nvim', version = vim.version.range '*' },
  'https://github.com/nvim-lualine/lualine.nvim',
}

require('bufferline').setup {
  options = {
    diagnostics = 'nvim_lsp',
    show_buffer_close_icons = true,
    show_close_icon = false,
    separator_style = 'slant',
    offsets = {
      { filetype = 'neo-tree', text = 'File Explorer', text_align = 'center', separator = true },
    },
  },
}

require('lualine').setup {
  options = {
    theme = 'auto',
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    globalstatus = true,
  },
}

-- Cycle buffers with the bufferline (in addition to your existing th/tl)
vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', { desc = 'Next buffer (bufferline)' })
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', { desc = 'Prev buffer (bufferline)' })

-- pick tab
vim.keymap.set('n', '<leader>p', '<Cmd>BufferLinePick<CR>', { desc = 'Pick tab' })

-- close tab
vim.keymap.set('n', '<leader>x', function() require('mini.bufremove').delete(0, false) end,
  { desc = 'Close buffer (keep window)' })
