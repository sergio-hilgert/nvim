require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")

-- ============================================================================
-- Snacks keymaps
-- ============================================================================
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

-- ============================================================================
-- Ruby/Rails/RSpec/Docker Helper Functions
-- ============================================================================

-- Function to convert Ruby file path to RSpec file path
local function ruby_to_rspec_path(ruby_path)
  -- Handle different file types and directories
  local rspec_path = ruby_path:gsub("/app/", "/spec/")

  -- Special case for controllers
  if ruby_path:match("/app/controllers/") then
    rspec_path = rspec_path:gsub("/controllers/", "/requests/"):gsub("_controller.rb$", "_spec.rb")
  else
    -- For other Ruby files
    rspec_path = rspec_path:gsub(".rb$", "_spec.rb")
  end

  return rspec_path
end

local function parse_path(path_string, project_string)
  -- Escape any special characters in project_string
  local escaped_project_string = project_string:gsub("([^%w])", "%%%1")

  -- Find the start position of the escaped_project_string in path_string
  local start_pos, end_pos = path_string:find(escaped_project_string)

  -- Check if escaped_project_string was found
  if start_pos then
    -- Return the substring from the end position of escaped_project_string to the end of path_string
    return path_string:sub(end_pos + 1)
  else
    -- Return nil if escaped_project_string was not found
    return nil
  end
end

-- Function to convert a string to dash-case and lowercase
local function to_dash_case(str)
  if not str or str == "" then
    return str
  end

  -- Replace hyphens and spaces with dash
  local result = str:gsub("[-% ]", "-")

  -- Insert dash before uppercase letters and convert to lowercase
  -- e.g., "MyProjectName" -> "my-project-name"
  result = result:gsub("(%l)(%u)", "%1-%2")
  result = result:gsub("(%u)(%u%l)", "%1-%2")

  -- Convert to lowercase
  result = result:lower()

  -- Remove consecutive dash
  result = result:gsub("_+", "-")

  -- Remove leading/trailing dash
  result = result:gsub("^-+", ""):gsub("-+$", "")

  return result
end

-- Function to find the project root by looking for common markers
local function find_project_root()
  local markers = { ".git", "Gemfile", "docker-compose.yml", "docker-compose.yaml", ".ruby-version" }
  local current_file = vim.fn.expand("%:p:h") -- Get directory of current file
  local cwd = vim.fn.getcwd()

  -- Start from current file's directory or cwd
  local search_path = current_file ~= "" and current_file or cwd

  -- Walk up the directory tree looking for markers
  local path = search_path
  while path and path ~= "/" and path ~= "" do
    for _, marker in ipairs(markers) do
      local marker_path = path .. "/" .. marker
      if vim.fn.filereadable(marker_path) == 1 or vim.fn.isdirectory(marker_path) == 1 then
        return path
      end
    end
    -- Move up one directory
    path = vim.fn.fnamemodify(path, ":h")
  end

  -- Fallback to cwd if no marker found
  return cwd
end

-- Function to get the project name based on the environment variable or root folder
local function get_project_name()
  -- First, check if PROJECT_NAME env var is set
  local env_project_name = os.getenv("PROJECT_NAME")
  if env_project_name and env_project_name ~= "" then
    return env_project_name
  end

  -- Otherwise, detect from project root folder name
  local project_root = find_project_root()
  local project_name = vim.fn.fnamemodify(project_root, ":t") -- Get the folder name

  if project_name and project_name ~= "" then
    -- Convert to snake_case and lowercase
    return to_dash_case(project_name)
  end

  return nil
end

local function open_split_terminal_with_auto_close(command)
  print(command)
  -- Save the current window ID
  local original_win = vim.api.nvim_get_current_win()

  -- Open the terminal in a split
  vim.cmd("split | terminal " .. command)

  -- Get the terminal buffer number
  local term_buf = vim.api.nvim_get_current_buf()

  -- Set an autocommand to close the terminal buffer and restore focus to the original window
  vim.api.nvim_create_autocmd("TermClose", {
    buffer = term_buf, -- Apply to the current terminal buffer only
    callback = function()
      -- Close the terminal buffer
      vim.api.nvim_buf_delete(term_buf, { force = true })
      -- Restore focus to the original window
      vim.api.nvim_set_current_win(original_win)
    end,
  })

  -- Optionally, enter insert mode in the terminal automatically
  vim.cmd("startinsert")
end

local function open_newbuff_terminal_with_auto_close(command)
  print(command)
  vim.cmd("enew | terminal " .. command)

  -- Get the terminal buffer number
  local term_buf = vim.api.nvim_get_current_buf()

  -- Set an autocommand to close the terminal buffer and restore focus to the original window
  vim.api.nvim_create_autocmd("TermClose", {
    buffer = term_buf, -- Apply to the current terminal buffer only
    callback = function()
      vim.api.nvim_buf_delete(term_buf, { force = true })
    end,
  })

  -- Optionally, enter insert mode in the terminal automatically
  vim.cmd("startinsert")
end

-- Function to run RSpec for the current file and line inside Docker
local function run_rspec(line_specific)
  local file = vim.fn.expand("%:p") -- Get the full path of the current file
  local line = vim.fn.line(".") -- Get the current cursor line number
  local file_name = vim.fn.fnamemodify(file, ":t") -- Get the file name with extension
  local file_ext = vim.fn.fnamemodify(file, ":e") -- Get the file extension
  local command

  -- Determine the project name from the environment variable
  local project_name = get_project_name()
  print(project_name)
  if not project_name then
    print("Could not determine the project name.")
    return
  end

  -- Docker Compose command prefix
  local docker_command = "docker compose run --rm " .. project_name .. " "

  -- Check if the current file is an RSpec file by its name
  if file_name:match("_spec.rb$") then
    -- If it's an RSpec file, run RSpec on the current file and optionally the line
    local project_root = parse_path(file, project_name)
    local docker_file = "/app" .. project_root
    if line_specific then
      command = docker_command .. "bundle exec rspec " .. docker_file .. ":" .. line .. "; exec bash"
    else
      command = docker_command .. "bundle exec rspec " .. docker_file .. "; exec bash"
    end
  elseif file_ext == "rb" then
    -- If it's a Ruby file, build the path to the corresponding RSpec file
    local rspec_file = ruby_to_rspec_path(file)
    local project_root = parse_path(rspec_file, project_name)
    local docker_file = "/app" .. project_root
    command = docker_command .. "bundle exec rspec " .. docker_file .. "; exec bash"
  else
    print("Current file is not a Ruby or RSpec file.")
    return
  end

  open_split_terminal_with_auto_close(command)
end

local function run_rspec_parallel()
  local command

  -- Determine the project name from the environment variable
  local project_name = get_project_name()
  if not project_name then
    print("Could not determine the project name.")
    return
  end

  -- Docker Compose command prefix
  local docker_command = "docker compose run --rm " .. project_name .. " "

  command = docker_command .. 'bash -c "bundle exec rails parallel:spec"' .. "; exec bash"

  open_split_terminal_with_auto_close(command)
end

local function run_rubocop()
  local command

  -- Determine the project name from the environment variable
  local project_name = get_project_name()
  if not project_name then
    print("Could not determine the project name.")
    return
  end

  -- Docker Compose command prefix
  local docker_command = "docker compose run --rm " .. project_name .. " "

  command = docker_command .. "bundle exec rubocop -A" .. "; exec bash"

  open_split_terminal_with_auto_close(command)
end

local function run_undercover()
  local command

  -- Determine the project name from the environment variable
  local project_name = get_project_name()
  if not project_name then
    print("Could not determine the project name.")
    return
  end

  -- Docker Compose command prefix
  local docker_command = "docker compose run --rm " .. project_name .. " "

  command = docker_command .. "bundle exec undercover -c origin/main" .. "; exec bash"

  open_split_terminal_with_auto_close(command)
end

local function run_db_clear()
  local command

  -- Determine the project name from the environment variable
  local project_name = get_project_name()
  if not project_name then
    print("Could not determine the project name.")
    return
  end

  -- Docker Compose command prefix
  local docker_command = "docker compose run --rm " .. project_name .. " "

  local bash_commands = {
    "RAILS_ENV=development bundle exec rails db:drop db:create db:migrate",
    "RAILS_ENV=test bundle exec rails db:drop db:create db:migrate",
    "bundle exec rails parallel:drop",
    "bundle exec rails parallel:setup",
  }
  command = docker_command
    .. 'bash -c "' .. table.concat(bash_commands, " && ") .. '"'
    .. "; exec bash"

  open_split_terminal_with_auto_close(command)
end

local function run_db_migrate()
  local command

  -- Determine the project name from the environment variable
  local project_name = get_project_name()
  if not project_name then
    print("Could not determine the project name.")
    return
  end

  -- Docker Compose command prefix
  local docker_command = "docker compose run --rm " .. project_name .. " "

  command = docker_command
    .. 'bash -c "RAILS_ENV=development bundle exec rails db:migrate && RAILS_ENV=test bundle exec rails db:migrate"'

  open_split_terminal_with_auto_close(command)
end

local function run_db_postgres()
  -- Determine the project name from the environment variable
  local project_name = get_project_name()
  if not project_name then
    print("Could not determine the project name.")
    return
  end

  -- Docker Compose command prefix
  local command = "docker compose exec postgres15 psql -U postgres " .. project_name:gsub("-", "_") .. "_development"

  open_split_terminal_with_auto_close(command)
end

local function run_container_bash()
  -- Determine the project name from the environment variable
  local project_name = get_project_name()
  if not project_name then
    print("Could not determine the project name.")
    return
  end

  local docker_command = "docker compose exec " .. project_name .. " "
  local command = docker_command .. "bash"

  open_split_terminal_with_auto_close(command)
end

local function run_db_create(migration_name)
  local command

  if not migration_name or migration_name == "" then
    print("No migration name provided.")
    return
  end

  -- Determine the project name from the environment variable
  local project_name = get_project_name()
  if not project_name then
    print("Could not determine the project name.")
    return
  end

  -- Docker Compose command prefix
  local docker_command = "docker compose run --rm " .. project_name .. " "

  command = docker_command .. 'bash -c "bundle exec rails g migration ' .. migration_name .. '"'

  open_split_terminal_with_auto_close(command)
end

-- Function to run RSpec on a specific file or folder inside Docker
local function run_rspec_on_path(test_path)
  if not test_path or test_path == "" then
    print("No test path provided.")
    return
  end

  local project_name = get_project_name()
  if not project_name or project_name == "" then
    print("Project name is not set. Please set the PROJECT_NAME environment variable.")
    return
  end

  -- Check if the path is already a 'spec/' directory or convert it
  local modified_path
  if test_path:match("^spec/") then
    modified_path = test_path -- Already in spec path
  else
    local rspec_path = test_path:gsub("/app/", "/spec/")
    if test_path:match("/app/controllers/") then
      rspec_path = rspec_path:gsub("/controllers/", "/requests/")
    end
    -- Use existing conversion function to convert Rails paths to spec paths
    modified_path = rspec_path
  end

  local project_root = parse_path(modified_path, project_name)
  local docker_file = "/app" .. project_root

  -- Docker Compose command to run RSpec
  local docker_command = "docker compose run --rm " .. project_name .. " "
  local command = docker_command .. "bundle exec rspec " .. docker_file .. "; exec bash"

  open_newbuff_terminal_with_auto_close(command)
end

-- Function to run RSpec tests on the current directory
local function run_rspec_on_current_directory()
  local directory_path = require("nvim-tree.lib").get_node_at_cursor().absolute_path
  -- Check if the path is a directory or a specific file should be checked
  -- You can modify this logic based on specific requirements (e.g., check if it's a test file directory)
  if vim.fn.isdirectory(directory_path) == 1 then
    run_rspec_on_path(directory_path)
  else
    print("The path is not a directory or does not exist.")
  end
end

-- ============================================================================
-- User Commands
-- ============================================================================

vim.api.nvim_create_user_command("RunRSpecCurrentDir", run_rspec_on_current_directory, {})

vim.api.nvim_create_user_command("RunRSpec", function()
  run_rspec(false)
end, {})

vim.api.nvim_create_user_command("RunRSpecLine", function()
  run_rspec(true)
end, {})

vim.api.nvim_create_user_command("RunRSpecParallel", function()
  run_rspec_parallel()
end, {})

vim.api.nvim_create_user_command("RunRubocopAutofix", function()
  run_rubocop()
end, {})

vim.api.nvim_create_user_command("RunUndercover", function()
  run_undercover()
end, {})

vim.api.nvim_create_user_command("RunDbClear", function()
  run_db_clear()
end, {})

vim.api.nvim_create_user_command("RunDbMigrate", function()
  run_db_migrate()
end, {})

vim.api.nvim_create_user_command("RunDbCreate", function()
  local migration_name = vim.fn.input("Enter migration name: ")
  run_db_create(migration_name)
end, {})

vim.api.nvim_create_user_command("RunDbPostgres", function()
  run_db_postgres()
end, {})

vim.api.nvim_create_user_command("RunContainerBash", function()
  run_container_bash()
end, {})

-- ============================================================================
-- Ruby/Rails/RSpec Keymaps
-- ============================================================================

-- Rspec
map("n", "<leader>rsa", ":RunRSpec<CR>", { noremap = true, silent = true, desc = "RSpec: Run file" })
map("n", "<leader>rsi", ":RunRSpecLine<CR>", { noremap = true, silent = true, desc = "RSpec: Run line" })
map("n", "<leader>rsp", ":RunRSpecParallel<CR>", { noremap = true, silent = true, desc = "RSpec: Run parallel" })
map("n", "<leader>rsc", ":RunRSpecCurrentDir<CR>", { noremap = true, silent = true, desc = "RSpec: Run current dir" })

-- Rubocop and undercover
map("n", "<leader>rba", ":RunRubocopAutofix<CR>", { noremap = true, silent = true, desc = "Rubocop: Autofix" })
map("n", "<leader>rbu", ":RunUndercover<CR>", { noremap = true, silent = true, desc = "Undercover: Run" })

-- Database rails
map("n", "<leader>rdb", ":RunDbClear<CR>", { noremap = true, silent = true, desc = "Rails DB: Clear & rebuild" })
map("n", "<leader>rdm", ":RunDbMigrate<CR>", { noremap = true, silent = true, desc = "Rails DB: Migrate" })
map("n", "<leader>rdc", ":RunDbCreate<CR>", { noremap = true, silent = true, desc = "Rails DB: Create migration" })

-- Connect to postgres
map("n", "<leader>rdp", ":RunDbPostgres<CR>", { noremap = true, silent = true, desc = "Rails DB: Postgres console" })

-- Container
map("n", "<leader>rh", ":RunContainerBash<CR>", { noremap = true, silent = true, desc = "Docker: Container bash" })
