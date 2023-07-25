-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set("n", "<leader>hh", function()
	vim.cmd("noh")
end, { silent = true, desc = "Hide highlights" })

-- Keybinds for moving between splits
vim.keymap.set({ "n", "v", "t" }, "<C-h>", function()
	vim.cmd("wincmd h")
end, { silent = true })
vim.keymap.set({ "n", "v", "t" }, "<C-j>", function()
	vim.cmd("wincmd j")
end, { silent = true })
vim.keymap.set({ "n", "v", "t" }, "<C-k>", function()
	vim.cmd("wincmd k")
end, { silent = true })
vim.keymap.set({ "n", "v", "t" }, "<C-l>", function()
	vim.cmd("wincmd l")
end, { silent = true })

-- vim.keymap.set({ "n" }, "<C-q>", ":wqa<CR>", { silent = true, desc = "Quit neovim" })
vim.keymap.set("n", "<leader>L", "<cmd>Lazy<CR>", { silent = true, desc = "Open lazy" })

-- Move lines
vim.keymap.set({ "n", "v", "i" }, "<C-S-j>", function()
	vim.cmd("move+")
end, { silent = true })
vim.keymap.set({ "n", "v", "i" }, "<C-S-k>", function()
	vim.cmd("move-2")
end, { silent = true })

-- Terminal mode
vim.keymap.set({ "t" }, "<Esc>", [[<C-\><C-n>]])
vim.keymap.set("n", "<leader>tS", function()
	vim.cmd([[split | term]])
end, { silent = true, desc = "Open a terminal in a new split" })
vim.keymap.set("n", "<leader>ts", function()
	vim.cmd([[vsplit | term]])
end, { silent = true, desc = "Open a terminal in a new vsplit" })
vim.keymap.set("n", "<leader>tt", function()
	vim.cmd([[tabnew | term]])
end, { silent = true, desc = "Open a terminal in a new tab" })

-- Zen mode
vim.keymap.set("n", "gz", function()
	require("zen-mode").toggle()
end, { silent = true, desc = "Toggle zen mode" })

-- Sessions
vim.keymap.set("n", "<leader>Sw", function()
	vim.ui.input({ prompt = "Session name" }, function(input)
		require("mini.sessions").write(input)
	end)
end, { desc = "write session" })

vim.keymap.set("n", "<leader>Sr", function()
	vim.ui.input({ prompt = "Session name" }, function(input)
		require("mini.sessions").read(input)
	end)
end, { desc = "read session" })

-- Create new splits
vim.keymap.set({ "n" }, "<leader>js", function()
	vim.cmd([[vsplit]])
end, { desc = "Vertical split", silent = true })
vim.keymap.set({ "n" }, "<leader>jS", function()
	vim.cmd([[vsplit]])
end, { desc = "Vertical split", silent = true })

vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Wa", "wa", {})
vim.api.nvim_create_user_command("Q", "q", {})
vim.api.nvim_create_user_command("Qa", "qa", {})

vim.keymap.set("n", "<leader>y", [[<cmd>call nvim_feedkeys('"+y', 'n', v:false)<CR>]],
	{ silent = true, desc = "yank system register" })
vim.keymap.set("n", "<leader>p", [[<cmd>call nvim_feedkeys('"+p', 'n', v:false)<CR>]],
	{ silent = true, desc = "paste system register" })

vim.keymap.set("v", "p", function() vim.cmd[[norm "_d]]; vim.cmd[[norm p]] end, {})
