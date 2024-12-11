return { -- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	opts = {
		ensure_installed = {
			"c",
			"c_sharp",
			"lua",
			"luadoc",
		},
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
	},
}
