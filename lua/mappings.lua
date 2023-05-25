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

vim.keymap.set({ "n" }, "<C-q>", ":wqa<CR>", { silent = true, desc = "Quit neovim" })
vim.keymap.set("n", "<Leader>ps", function()
	vim.cmd("PackerSync")
end)
vim.keymap.set("n", "<Leader>pc", function()
	vim.cmd([[ !rm ~/.config/nvim/plugin/packer_compiled.lua]])
	vim.cmd("PackerCompile")
end)

-- Move lines
vim.keymap.set({ "n", "v", "i" }, "<C-S-j>", function()
	vim.cmd("move+")
end, { silent = true })
vim.keymap.set({ "n", "v", "i" }, "<C-S-k>", function()
	vim.cmd("move-2")
end, { silent = true })

-- Exit terminal mode
vim.keymap.set({ "t" }, "<Esc>", [[<C-\><C-n>]])

-- Zen mode
vim.keymap.set("n", "<leader>ez", function()
	require("zen-mode").toggle()
end, { silent = true, desc = "Toggle zen mode" })
vim.keymap.set("n", "<leader>en", function()
	vim.cmd("NoNeckPain")
end, { silent = true, desc = "NNP: Toggle" })
vim.keymap.set("n", "<leader>e>", function()
	vim.cmd("NoNeckPainWidthUp")
end, { silent = true, desc = "NNP: Expand window" })
vim.keymap.set("n", "<leader>e<", function()
	vim.cmd("NoNeckPainWidthDown")
end, { silent = true, desc = "NNP: Shrink window" })

-- Fugitive toggle
local function showFugitiveGit()
	if vim.fn.FugitiveHead() ~= "" then
		vim.cmd([[
    Git
    " setlocal winfixwidth
    horizontal resize 20
    setlocal winfixwidth
	setlocal winfixheight
    setlocal nonumber
    setlocal norelativenumber
    ]])
	end
end

local function toggleFugitiveGit()
	if vim.fn.buflisted(vim.fn.bufname("fugitive:///*/.git//$")) ~= 0 then
		vim.cmd([[ execute ":bdelete" bufname('fugitive:///*/.git//$') ]])
	else
		showFugitiveGit()
	end
end
vim.keymap.set("n", "<F3>", toggleFugitiveGit, { desc = "Show fugitive" })

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


-- Symbols outline
vim.keymap.set({ "n" }, "<leader>so", function() vim.cmd[[SymbolsOutline]] end, { desc = "Show symbol outline", silent = true })
