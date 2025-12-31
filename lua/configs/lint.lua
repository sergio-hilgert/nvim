local ok, lint = pcall(require, "lint")
if not ok then
  return
end

-- Prefer Mason-installed tflint if it's not already on PATH
if lint.linters and lint.linters.tflint then
  local mason_tflint = vim.fn.stdpath("data") .. "/mason/bin/tflint"
  local resolved = vim.fn.exepath "tflint"

  lint.linters.tflint.cmd = (resolved ~= "" and resolved) or mason_tflint
end

lint.linters_by_ft = {
  terraform = { "tflint" },
  ["terraform-vars"] = { "tflint" },
}

local lint_augroup = vim.api.nvim_create_augroup("Lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = function()
    -- Runs linters configured for the current filetype
    lint.try_lint()
  end,
})

vim.api.nvim_create_user_command("Lint", function()
  lint.try_lint()
end, {})
