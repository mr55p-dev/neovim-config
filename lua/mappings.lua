-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set('n', '<leader>hh', function() vim.cmd'noh' end, { silent = true })


-- Keybinds for moving between splits
vim.keymap.set({ 'n', 'v', 't' }, '<C-h>', function() vim.cmd("wincmd h") end, { silent = true })
vim.keymap.set({ 'n', 'v', 't' }, '<C-j>', function() vim.cmd("wincmd j") end, { silent = true })
vim.keymap.set({ 'n', 'v', 't' }, '<C-k>', function() vim.cmd("wincmd k") end, { silent = true })
vim.keymap.set({ 'n', 'v', 't' }, '<C-l>', function() vim.cmd("wincmd l") end, { silent = true })

vim.keymap.set({ 'n' }, '<C-q>', function() vim.cmd'SaveSession' vim.cmd'wqa' end, { silent = true })
vim.keymap.set('n', '<Leader>ps', function() vim.cmd'PackerSync' end)
vim.keymap.set('n', '<Leader>pc', function() vim.cmd'PackerCompile' end)

-- Move lines
vim.keymap.set({ 'n', 'v', 'i' }, '<C-S-j>', function () vim.cmd("move+") end, { silent = true })
vim.keymap.set({ 'n', 'v', 'i' }, '<C-S-k>', function () vim.cmd("move-2") end, { silent = true })

-- Exit terminal mode
vim.keymap.set({ 't' }, '<Esc>', [[<C-\><C-n>]])

-- Zen mode
vim.keymap.set('n', 'zn', function() require("zen-mode").toggle() end, { silent = true })

-- notify
vim.keymap.set('n', "<Leader>nd", function () require("notify").dismiss() end)
