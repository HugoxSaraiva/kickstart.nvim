-- Use spaces instead of tabs by default
vim.opt.expandtab = true

-- Tabs = 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- Language
-- Set default language to english
local os_utils = require 'custom.utils.os_utils'
local current_os = os_utils.get_os()
if current_os == 'Mac' then
  vim.api.nvim_exec2('language en_US', {})
elseif current_os == 'Linux' then
  vim.api.nvim_exec2('language en_US.utf8', {})
end

-- Adding sum command
vim.api.nvim_create_user_command('Sum', function(opts) require('custom.utils.math_utils').sum_lines(opts) end, {
  range = '%',
})
vim.keymap.set({ 'v' }, '<leader>gs', ':Sum<CR>', { desc = '[S]um selected lines' })

-- Yank relative path + line number
vim.keymap.set('n', '<leader>yp', function()
  local path = vim.fn.expand '%:.'
  local line = vim.fn.line '.'
  vim.fn.setreg('+', path .. ':' .. line)
end, { desc = '[Y]ank file [p]ath + line number' })

-- Yank absolute path + line number
vim.keymap.set('n', '<leader>yP', function()
  local path = vim.fn.expand '%:p'
  local line = vim.fn.line '.'
  vim.fn.setreg('+', path .. ':' .. line)
end, { desc = '[Y]ank absolute file [P]ath + line number' })

-- Tmux bindings
vim.keymap.set('n', '<C-h>', '<cmd> TmuxNavigateLeft<CR>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<cmd> TmuxNavigateRight<CR>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<cmd> TmuxNavigateDown<CR>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<cmd> TmuxNavigateUp<CR>', { desc = 'Move focus to the upper window' })

-- Keybinds to save file
vim.keymap.set('n', '<C-s>', ':w<CR>', { desc = 'Save file' })
vim.keymap.set('i', '<C-s>', '<ESC>:w<CR>a', { desc = 'Save file on insert mode' })
