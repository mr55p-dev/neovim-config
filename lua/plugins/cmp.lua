local M = {}

function M.setup()
	-- nvim-cmp setup
	local cmp = require 'cmp'
	local luasnip = require 'luasnip'

	cmp.setup {
	snippet = {
		expand = function(args)
		luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert {
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		-- ['<C-Space>'] = cmp.mapping.complete {},
		['<C-Space>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.abort()
			elseif cmp.visible then
				cmp.complete()
			else
				fallback()
			end
		end, { 'i', 's' }),
		-- ['<CR>'] = cmp.mapping.confirm {
		-- behavior = cmp.ConfirmBehavior.Replace,
		-- select = true,
		-- },
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.confirm { select = true }
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
		-- ['<ESC>'] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.abort()
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, { 'i', 's' })
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		-- { name = "buffer" },
		-- { name = "path" },
	},
	}
end

return M
