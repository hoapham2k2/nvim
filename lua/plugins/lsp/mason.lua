return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		require("mason").setup()

		local ensure_installed = {
			-- Add your language servers and tools here
			"lua_ls",
			"stylua",
		}

		require("mason-tool-installer").setup({
			ensure_installed = ensure_installed,
		})
	end,
}
