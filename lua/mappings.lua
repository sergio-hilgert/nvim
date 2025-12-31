require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")

-- Snacks keymaps
local function with_snacks(cb)
  return function()
    local ok, Snacks = pcall(require, "snacks")
    if not ok then
      return
    end
    cb(Snacks)
  end
end

local function snacks_enabled(mod)
  local ok, Snacks = pcall(require, "snacks")
  if not ok then
    return false
  end
  return Snacks.config[mod] and Snacks.config[mod].enabled
end

-- lazygit
map("n", "<leader>gg", with_snacks(function(S)
  S.lazygit.open()
end), { desc = "Git: LazyGit" })

map("n", "<leader>gL", with_snacks(function(S)
  S.lazygit.log()
end), { desc = "Git: LazyGit log" })

map("n", "<leader>gF", with_snacks(function(S)
  S.lazygit.log_file()
end), { desc = "Git: LazyGit log (file)" })

-- gitbrowse
map("n", "<leader>gR", with_snacks(function(S)
  S.gitbrowse.open({ what = "repo" })
end), { desc = "Git: Browse repo" })

map("n", "<leader>gB", with_snacks(function(S)
  S.gitbrowse.open({ what = "branch" })
end), { desc = "Git: Browse branch" })

map({ "n", "x" }, "<leader>gO", with_snacks(function(S)
  S.gitbrowse.open({ what = "file" })
end), { desc = "Git: Browse file (lines)", silent = true })

map({ "n", "x" }, "<leader>gU", with_snacks(function(S)
  S.gitbrowse.open({ what = "permalink" })
end), { desc = "Git: Browse permalink URL", silent = true })

map("n", "<leader>gC", with_snacks(function(S)
  S.gitbrowse.open({ what = "commit" })
end), { desc = "Git: Browse commit" })

-- picker (Snacks fuzzy finder)
map("n", "<leader>sp", with_snacks(function(S)
  S.picker()
end), { desc = "Snacks: Pickers" })

map("n", "<leader>sf", with_snacks(function(S)
  S.picker.files()
end), { desc = "Snacks: Find files" })

map("n", "<leader>sg", with_snacks(function(S)
  S.picker.grep()
end), { desc = "Snacks: Grep" })

map("n", "<leader>sb", with_snacks(function(S)
  S.picker.buffers()
end), { desc = "Snacks: Buffers" })

map("n", "<leader>sh", with_snacks(function(S)
  S.picker.help()
end), { desc = "Snacks: Help" })

map("n", "<leader>sD", with_snacks(function(S)
  S.picker.diagnostics()
end), { desc = "Snacks: Diagnostics" })

-- GitHub (requires `gh` + Snacks picker enabled)
map("n", "<leader>gi", with_snacks(function(S)
  if not snacks_enabled("picker") then
    vim.notify("Snacks picker is disabled; enable `picker` to use Snacks GitHub.")
    return
  end
  S.picker.gh_issue()
end), { desc = "GitHub Issues (open)" })

map("n", "<leader>gI", with_snacks(function(S)
  if not snacks_enabled("picker") then
    vim.notify("Snacks picker is disabled; enable `picker` to use Snacks GitHub.")
    return
  end
  S.picker.gh_issue({ state = "all" })
end), { desc = "GitHub Issues (all)" })

map("n", "<leader>gp", with_snacks(function(S)
  if not snacks_enabled("picker") then
    vim.notify("Snacks picker is disabled; enable `picker` to use Snacks GitHub.")
    return
  end
  S.picker.gh_pr()
end), { desc = "GitHub PRs (open)" })

map("n", "<leader>gP", with_snacks(function(S)
  if not snacks_enabled("picker") then
    vim.notify("Snacks picker is disabled; enable `picker` to use Snacks GitHub.")
    return
  end
  S.picker.gh_pr({ state = "all" })
end), { desc = "GitHub PRs (all)" })

-- scratch
map("n", "<leader>.", with_snacks(function(S)
  S.scratch()
end), { desc = "Scratch: Toggle" })

map("n", "<leader>S", with_snacks(function(S)
  S.scratch.select()
end), { desc = "Scratch: Select" })

-- notifier/notify
map("n", "<leader>nh", with_snacks(function(S)
  S.notifier.show_history()
end), { desc = "Notify: History" })

map("n", "<leader>nd", with_snacks(function(S)
  S.notifier.hide() -- hide all
end), { desc = "Notify: Dismiss all" })

map("n", "<leader>nt", function()
  vim.notify("snacks notify test")
end, { desc = "Notify: Test" })

-- words (LSP references)
map("n", "]r", with_snacks(function(S)
  S.words.jump(1)
end), { desc = "References: next" })

map("n", "[r", with_snacks(function(S)
  S.words.jump(-1)
end), { desc = "References: prev" })

-- toggles (uses Snacks.toggle + which-key integration)
map("n", "<leader>ud", with_snacks(function(S)
  S.toggle.dim()
end), { desc = "Toggle: Dim" })

map("n", "<leader>uw", with_snacks(function(S)
  S.toggle.words()
end), { desc = "Toggle: LSP refs (words)" })

map("n", "<leader>us", with_snacks(function(S)
  S.toggle.scroll()
end), { desc = "Toggle: Smooth scroll" })

map("n", "<leader>uD", with_snacks(function(S)
  S.toggle.diagnostics()
end), { desc = "Toggle: Diagnostics" })

-- image
map("n", "<leader>ih", with_snacks(function(S)
  S.image.hover()
end), { desc = "Image: Hover" })

-- debug
map("n", "<leader>dr", with_snacks(function(S)
  S.debug.run()
end), { desc = "Debug: Run buffer/range" })

map("n", "<leader>db", with_snacks(function(S)
  S.debug.backtrace()
end), { desc = "Debug: Backtrace" })

map("n", "<leader>di", with_snacks(function(S)
  S.debug.inspect({
    buf = vim.api.nvim_get_current_buf(),
    ft = vim.bo.filetype,
    cwd = vim.fn.getcwd(),
  })
end), { desc = "Debug: Inspect context" })

map("n", "<leader>dm", with_snacks(function(S)
  S.debug.metrics()
end), { desc = "Debug: Metrics" })

-- win/layout demo
local snacks_layout_demo

map("n", "<leader>wn", with_snacks(function(S)
  local file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1]
  S.win({
    file = file,
    title = "Neovim News",
    width = 0.8,
    height = 0.8,
    enter = true,
    border = "rounded",
    wo = { wrap = false },
  })
end), { desc = "Snacks.win: Neovim news" })

map("n", "<leader>wl", with_snacks(function(S)
  if snacks_layout_demo and snacks_layout_demo:valid() then
    snacks_layout_demo:close()
    snacks_layout_demo = nil
    return
  end

  local news = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1]

  local left = S.win({
    title = "Scratch",
    show = false,
    border = "rounded",
    minimal = false,
    bo = { buftype = "", bufhidden = "hide", swapfile = false },
    text = {
      "# Scratch",
      "",
      "- Use <leader>. to toggle your persistent scratch buffer",
      "- Use <leader>S to select scratch buffers",
    },
  })

  local right = S.win({
    title = "News",
    show = false,
    border = "rounded",
    wo = { wrap = false },
    file = news,
  })

  snacks_layout_demo = S.layout.new({
    wins = { left = left, right = right },
    layout = {
      box = "horizontal",
      width = 0.9,
      height = 0.8,
      border = false,
      { win = "left", width = 0.35 },
      { win = "right" },
    },
  })
end), { desc = "Snacks.layout: Toggle demo" })

map("n", "<leader>wM", with_snacks(function(_)
  if snacks_layout_demo and snacks_layout_demo:valid() then
    snacks_layout_demo:maximize()
  else
    vim.notify("Open the layout first with <leader>wl")
  end
end), { desc = "Snacks.layout: Maximize demo" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
