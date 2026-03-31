-- Use NvChad's default LSP behaviour (uses new vim.lsp.config API for Neovim 0.11+)
local nvlsp = require "nvchad.configs.lspconfig"

nvlsp.defaults()

-- 1. Force the capabilities table structure to exist so the assignment doesn't fail silently
local caps = nvlsp.capabilities or vim.lsp.protocol.make_client_capabilities()
caps.textDocument = caps.textDocument or {}
caps.textDocument.completion = caps.textDocument.completion or {}
caps.textDocument.completion.completionItem = caps.textDocument.completion.completionItem or {}

-- 2. Hard-disable snippet support
caps.textDocument.completion.completionItem.snippetSupport = false
caps.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

-- 3. Reassign the firmly modified capabilities back to nvlsp
nvlsp.capabilities = caps

-- Full path to the folder where Ruby LSPs should be disabled
local scripts_dir = vim.fn.expand "~/dev/lia-boot/projects/scripts"

-- Get current working directory in full path
local cwd = vim.loop.cwd()

-- Define per-server options. terraformls is always enabled.
local servers = {
  terraformls = {},
  tflint = {},
  terraform = {},
  ts_ls = {},
  eslint = {},
}

-- Only enable ruby servers outside the scripts folder
if cwd ~= scripts_dir then
  servers.ruby_lsp = {
    -- Optional ruby_lsp config (e.g., disable pending migration warning)
    init_options = {
      addonSettings = {
        ["Ruby LSP Rails"] = {
          enablePendingMigrationsPrompt = false,
        },
      },
    },
  }

  servers.rubocop = {}
end

-- Apply NvChad defaults (on_attach, on_init, capabilities) to each server using new vim.lsp.config API
for name, opts in pairs(servers) do
  opts.on_attach = nvlsp.on_attach
  opts.on_init = nvlsp.on_init
  opts.capabilities = nvlsp.capabilities

  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end
