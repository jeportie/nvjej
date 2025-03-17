-- File: ~/.config/nvim/lua/configs/lspconfig.lua
local base = require("nvchad.configs.lspconfig")
local lspconfig = require "lspconfig"

local lsp_servers = require("custom.lsp_servers")
local on_attach = base.on_attach
local capabilities = base.capabilities

-- lsps with default config
for _, lsp in ipairs(lsp_servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = base.on_init,
    capabilities = capabilities,
  }
end

lspconfig.clangd.setup {
  on_attach = function(client, bufnr)
	client.server_capabilities.signatureHelpProvider = false
	on_attach(client, bufnr)
   end,
   capabilities = capabilities,

}


-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }

