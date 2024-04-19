-- keymaps
vim.g.mapleader = " "

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move between windows
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)

-- Move between buffers
map('n', '<leader>h', ':bp<CR>', opts)
map('n', '<leader>l', ':bn<CR>', opts)

-- Move to the beginning/end of line
map('n', 'H', '^', opts)
map('n', 'L', '$', opts)

