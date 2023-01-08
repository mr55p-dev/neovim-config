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


