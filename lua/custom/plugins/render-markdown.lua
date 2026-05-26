-- In-buffer markdown rendering: styled headings, bullets, code blocks, tables.
-- https://github.com/MeanderingProgrammer/render-markdown.nvim

vim.pack.add {
  { src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim', version = vim.version.range '*' },
}

require('render-markdown').setup {
  -- Always render the cursor line too (don't un-render to show raw markdown).
  anti_conceal = { enabled = false },
}

vim.keymap.set('n', '<leader>mp', '<Cmd>RenderMarkdown toggle<CR>',
  { desc = '[M]arkdown [P]review toggle' })
