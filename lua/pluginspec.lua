local editor = require('plugins.editor')
local interface = require('plugins.interface')
local application = require('plugins.application')
local ts = require('plugins.treesitter')
local git = require('plugins.git')
local terminal = require('plugins.terminal')
local telescope = require('plugins.telescope')
local cmp = require('plugins.cmp')
local lsp = require('plugins.lsp')
local ft_plugins = require("plugins.ft_plugins")

return function(use)
	use 'wbthomason/packer.nvim' -- Package manager

	-- Color schemes
  use { 'shaunsingh/nord.nvim', config=function() vim.cmd'colorscheme nord' end } -- Nord theme
	use { 'mjlbach/onedark.nvim', disabled=true } -- Theme inspired by Atom

 
  -- Application
	use { 'rmagatti/auto-session', config=application.autosession }
	use { 'djoshea/vim-autoread' } -- Auto-reload files from disk
	use { 'sindrets/winshift.nvim', config=application.winshift.setup, keys=application.winshift.keys, event="WinEnter" } -- Winshift
  use { 'glepnir/dashboard-nvim', config=application.dashboard } 

	-- Editor pane
	use { 'numToStr/Comment.nvim', keys={ { 'v', 'gc' }, 'gc' }, config=editor.comment } -- "gc" to comment visual regions/lines
	use { 'tpope/vim-sleuth', disable=true } -- Detect tabstop and shiftwidth automatically
	use { 'windwp/nvim-autopairs', tag='*', event='InsertEnter', config=editor.autopairs } -- Automatic bracket pairing
	use { 'kylechui/nvim-surround', tag='*', event='BufReadPost', config=editor.surround } -- We love this one
	use { 'phaazon/hop.nvim', branch = 'v2', keys=editor.hop.keys, config=editor.hop.config } -- hop
	use { 'abecodes/tabout.nvim', tag='*', event="InsertEnter", requires={ 'nvim-treesitter' }, config=editor.tabout } -- Tabout for getting out of autopairs
	use { 'dnlhc/glance.nvim', config=editor.glance, event="BufReadPost" } -- Glance window for code

	-- Interface
	use { 'nvim-lualine/lualine.nvim', tag="*", config=interface.lualine } -- Fancier statusline
	use { 'lukas-reineke/indent-blankline.nvim', event="BufReadPost", config=interface.blankline } -- Add indentation guides on blank lines
	use { 'gorbit99/codewindow.nvim', keys={ "<Leader>mm" }, config=interface.codewindow } -- Code minimap
	use 'kshenoy/vim-signature' -- Marks in the gutter
	use { 'petertriho/nvim-scrollbar', config=function() require('scrollbar').setup() end } -- Scrollbar
  use { 'alvarosevilla95/luatab.nvim', requires='kyazdani42/nvim-web-devicons', config=function() require('luatab').setup() end } -- Tabline
	use { 's1n7ax/nvim-window-picker', tag = 'v1.*', config = function() require'window-picker'.setup() end, }

  -- Neotree
  local neotree_requires = { "nvim-lua/plenary.nvim", 'kyazdani42/nvim-web-devicons', 'MunifTanjim/nui.nvim', 's1n7ax/nvim-window-picker' }
	use { 'nvim-neo-tree/neo-tree.nvim', branch = 'v2.x', config=interface.neotree, requires=neotree_requires }
  
  -- Git
	use { 'tpope/vim-fugitive', keys={ '<Leader>gg' }, cmd='Git', config=git.fugitive } -- Git commands in nvim
	use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' }, config=git.gitsigns } 

  -- Telescope
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires={ 'nvim-lua/plenary.nvim' }, keys=telescope.keys, config=telescope.setup, cmd='Telescope' }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run='make', cond=vim.fn.executable "make" == 1 }

  -- Terminal
	use { 'voldikss/vim-floaterm', keys=terminal.floatterm.keys, config=terminal.floatterm.setup, cmd="Floatterm" } -- This one is interesting, like toggleterm but floating
	use { 'akinsho/toggleterm.nvim', tag = '*', keys={ [[<C-\>]] }, config=terminal.toggleterm } -- Popup terminal buffer

	-- Treesitter
	use { 'nvim-treesitter/nvim-treesitter', tag = '*', event='BufReadPost', config=ts.config, run=':TSUpdate'} -- Highlight, edit, and navigate code
	use { 'nvim-treesitter/nvim-treesitter-textobjects', after = { 'nvim-treesitter' } } -- Additional textobjects for treesitter

	-- LSP
	use { 'neovim/nvim-lspconfig', config=lsp.config } -- Collection of configurations for built-in LSP client
	use { 'williamboman/mason.nvim' } -- Manage external editor tooling i.e LSP servers
	use { 'williamboman/mason-lspconfig.nvim' } -- Automatically install language servers to stdpath
	use { 'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu' }

	-- CMP
  use { 'hrsh7th/nvim-cmp', requires = { 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path' }, config=cmp.setup } -- Autocompletion
	use { 'L3MON4D3/LuaSnip', requires = { 'saadparwaiz1/cmp_luasnip' } } -- Snippet Engine and Snippet Expansion

	-- FT-specific
	use { 'ellisonleao/glow.nvim', ft={ "markdown" }, config=ft_plugins.glow } -- Markdown syntax control

  -- IDE
	-- use { 'EthanJWright/vs-tasks.nvim',
	-- 	requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' } } -- IDE tasks
	-- use 'mfussenegger/nvim-dap' -- Debug adapter protocol
	-- use { 'mfussenegger/nvim-dap-python', requires = 'mfussenegger/nvim-dap'} -- Debug support for python, requires debugpy

  -- Neorg
	-- use { 'nvim-neorg/neorg', disabled=true requires = 'nvim-lua/plenary.nvim', run = ':Neorg sync-parsers' } -- neorg, might be fun

  if is_bootstrap then
    require('packer').sync()
  end
end
