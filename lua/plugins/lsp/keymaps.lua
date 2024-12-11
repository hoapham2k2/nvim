local M = {}

-- Language-specific navigation handlers
local language_handlers = {
	cs = {
		definitions = function()
			return require("omnisharp_extended").lsp_definitions()
		end,
		references = function()
			return require("omnisharp_extended").telescope_lsp_references()
		end,
		implementations = function()
			return require("omnisharp_extended").telescope_lsp_implementation()
		end,
		type_definitions = function()
			return require("omnisharp_extended").telescope_lsp_type_definition()
		end,
	},
	-- Example for TypeScript/JavaScript
	typescript = {
		-- You can add TypeScript-specific handlers if needed
	},
	go = {
		-- Potential Go-specific handlers
	},
}

-- Generic fallback to Telescope if no language-specific handler
local function get_language_handler(filetype, handler_type)
	local handlers = language_handlers[filetype] or {}

	return handlers[handler_type]
		or function()
			local telescope_handlers = {
				definitions = require("telescope.builtin").lsp_definitions,
				references = require("telescope.builtin").lsp_references,
				implementations = require("telescope.builtin").lsp_implementations,
				type_definitions = require("telescope.builtin").lsp_type_definitions,
			}
			return telescope_handlers[handler_type]()
		end
end

function M.setup(event)
	local map = function(keys, func, desc, mode)
		mode = mode or "n"
		vim.keymap.set(mode, keys, func, {
			buffer = event.buf,
			desc = "LSP: " .. desc,
			silent = true,
		})
	end

	local filetype = vim.bo.filetype

	-- Dynamic LSP Navigation with Language-Specific Handlers
	map("gd", get_language_handler(filetype, "definitions"), "[G]oto [D]efinition")
	map("gr", get_language_handler(filetype, "references"), "[G]oto [R]eferences")
	map("gI", get_language_handler(filetype, "implementations"), "[G]oto [I]mplementation")
	map("<leader>D", get_language_handler(filetype, "type_definitions"), "Type [D]efinition")

	-- Standard LSP Keymaps (Language Agnostic)
	map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
	map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
	map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

	-- Diagnostic Navigation
	map("[d", vim.diagnostic.goto_prev, "Previous [D]iagnostic")
	map("]d", vim.diagnostic.goto_next, "Next [D]iagnostic")
	map("<leader>e", vim.diagnostic.open_float, "Show [E]rror Line")
	map("<leader>q", vim.diagnostic.setloclist, "Diagnostic [Q]uickfix List")

	-- Advanced Language Server Features
	local client = vim.lsp.get_client_by_id(event.data.client_id)
	if not client then
		return
	end

	-- Conditional Feature Support
	if client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
		local highlight_augroup = vim.api.nvim_create_augroup("lsp-document-highlight", { clear = true })

		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			buffer = event.buf,
			group = highlight_augroup,
			callback = vim.lsp.buf.document_highlight,
		})

		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
			buffer = event.buf,
			group = highlight_augroup,
			callback = vim.lsp.buf.clear_references,
		})
	end

	-- Inlay Hints Toggle
	if client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
		map("<leader>th", function()
			local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
			vim.lsp.inlay_hint.enable(not is_enabled, { bufnr = event.buf })

			vim.notify(string.format("Inlay Hints %s", is_enabled and "Disabled" or "Enabled"), vim.log.levels.INFO)
		end, "[T]oggle Inlay [H]ints")
	end

	-- Language Server Info
	if vim.fn.has("nvim-0.9") == 1 then
		map("K", vim.lsp.buf.hover, "Hover Documentation")
		map("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
	end
end

-- Function to extend language-specific handlers
function M.add_language_handler(language, handlers)
	language_handlers[language] = vim.tbl_deep_extend("force", language_handlers[language] or {}, handlers)
end

return M
