-- REPL cell-send
vim.pack.add { 'https://github.com/Vigemus/iron.nvim' }

local iron = require('iron.core')
local view = require('iron.view')

local function ipython_cmd()
  local cwd = vim.fn.getcwd()
  local candidates = {
    cwd .. '/venv/Scripts/ipython.exe',
    cwd .. '/.venv/Scripts/ipython.exe',
    cwd .. '/venv/bin/ipython',
    cwd .. '/.venv/bin/ipython',
  }
  for _, p in ipairs(candidates) do
    if vim.fn.executable(p) == 1 then return { p, '--no-autoindent' } end
  end
  return { 'ipython', '--no-autoindent' }
end

iron.setup {
  config = {
    scratch_repl = true,
    repl_definition = {
      python = {
        command = ipython_cmd,
        format = require('iron.fts.common').bracketed_paste_python,
      },
    },
    repl_open_cmd = view.split.vertical.botright(0.4),
  },
  keymaps = {
    send_motion = '<leader>rc',
    visual_send = '<leader>rc',
    send_file = '<leader>rf',
    send_line = '<leader>rl',
    send_paragraph = '<leader>rp',
    send_until_cursor = '<leader>ru',
    send_mark = '<leader>rm',
    mark_motion = '<leader>rmc',
    mark_visual = '<leader>rmc',
    remove_mark = '<leader>rmd',
    cr = '<leader>r<cr>',
    interrupt = '<leader>r<space>',
    exit = '<leader>rq',
    clear = '<leader>rx',
  },
  ignore_blank_lines = true,
}

vim.keymap.set('n', '<leader>rs', '<Cmd>IronRepl<CR>', { desc = '[R]EPL [S]tart' })
vim.keymap.set('n', '<leader>rr', '<Cmd>IronRestart<CR>', { desc = '[R]EPL [R]estart' })
vim.keymap.set('n', '<leader>rh', '<Cmd>IronHide<CR>', { desc = '[R]EPL [H]ide' })
