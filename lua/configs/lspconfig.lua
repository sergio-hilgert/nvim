-- Use NvChad's default LSP behaviour (uses new vim.lsp.config API for Neovim 0.11+)
local nvlsp = require "nvchad.configs.lspconfig"

nvlsp.defaults()

-- Full path to the folder where Ruby LSPs should be disabled
local scripts_dir = vim.fn.expand "~/dev/lia-boot/projects/scripts"

-- Get current working directory in full path
local cwd = vim.loop.cwd()

-- Define per-server options. terraformls is always enabled.
local servers = {
  terraformls = {},
  tflint = {},
  terraform = {}
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
