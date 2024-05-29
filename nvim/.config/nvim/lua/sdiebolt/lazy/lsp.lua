return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v3.x",
	dependencies = {
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
		'neovim/nvim-lspconfig',
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/nvim-cmp',
		'L3MON4D3/LuaSnip',
	},

	config = function()
		local lsp_zero = require("lsp-zero")

		lsp_zero.on_attach(function(client, bufnr)
			lsp_zero.default_keymaps({buffer = bufnr})
		end)

		require("mason").setup({})
		require("mason-lspconfig").setup({
			ensure_installed = {"rust_analyzer", "pyright", "lua_ls"},
			handlers = {
				function(server_name)
					require('lspconfig')[server_name].setup({})
				end,
			},
		})

		local cmp = require("cmp")
		cmp.setup({
			sources = {
				{name = "nvim_lsp"},
			},
			mapping = {
				["<C-p>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
				["<C-n>"] = cmp.mapping.select_next_item({ behavior = "select" }),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete({ }),
			},
		})
	end
}
