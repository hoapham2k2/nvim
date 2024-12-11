local lsp_config = {}

-- Base configuration for all servers
local function make_base_config()
    return {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        flags = {
            debounce_text_changes = 150,
        },
    }
end

-- Language-specific server configurations
lsp_config.servers = {
    lua_ls = {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                },
            },
        },
    },
    omnisharp = {},
    omnisharp_mono = {},
}

-- Function to get server configuration
function lsp_config.get_config(server_name)
    local base_config = make_base_config()
    local server_config = lsp_config.servers[server_name] or {}

    return vim.tbl_deep_extend("force", base_config, server_config)
end

-- Add a new server configuration dynamically
function lsp_config.add_server(server_name, config)
    lsp_config.servers[server_name] = config
end

return lsp_config
