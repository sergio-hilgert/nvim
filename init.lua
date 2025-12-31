vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)



-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
vim.g.rails_projections = {
  ["app/controllers/*_controller.rb"] = {
    alternate = "spec/requests/{}_spec.rb",
  },
  ["spec/requests/*_spec.rb"] = {
    alternate = "app/controllers/{}_controller.rb",
  },
}

-- Function to convert Ruby file path to RSpec file path
local function ruby_to_rspec_path(ruby_path)
  -- Handle different file types and directories
  local rspec_path = ruby_path:gsub('/app/', '/spec/')

  -- Special case for controllers
  if ruby_path:match('/app/controllers/') then
    rspec_path = rspec_path:gsub('/controllers/', '/requests/'):gsub('_controller.rb$', '_spec.rb')
  else
    -- For other Ruby files
    rspec_path = rspec_path:gsub('.rb$', '_spec.rb')
  end

  return rspec_path
end

function parse_path(path_string, project_string)
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

-- Function to get the project name based on the environment variable
local function get_project_name()
  return os.getenv('PROJECT_NAME')
end

function open_split_terminal_with_auto_close(command)
  print(command)
  -- Save the current window ID
  local original_win = vim.api.nvim_get_current_win()

  -- Open the terminal in a split
  vim.cmd('split | terminal ' .. command)

  -- Get the terminal buffer number
  local term_buf = vim.api.nvim_get_current_buf()

  -- Set an autocommand to close the terminal buffer and restore focus to the original window
  vim.api.nvim_create_autocmd("TermClose", {
    buffer = term_buf,  -- Apply to the current terminal buffer only
    callback = function()
      -- Close the terminal buffer
      vim.api.nvim_buf_delete(term_buf, { force = true })
      -- Restore focus to the original window
      vim.api.nvim_set_current_win(original_win)
    end,
  })

  -- Optionally, enter insert mode in the terminal automatically
  vim.cmd('startinsert')
end

function open_newbuff_terminal_with_auto_close(command)
  print(command)
  vim.cmd('enew | terminal ' .. command)

  -- Get the terminal buffer number
  local term_buf = vim.api.nvim_get_current_buf()

  -- Set an autocommand to close the terminal buffer and restore focus to the original window
  vim.api.nvim_create_autocmd("TermClose", {
    buffer = term_buf,  -- Apply to the current terminal buffer only
    callback = function()
      vim.api.nvim_buf_delete(term_buf, { force = true })
    end,
  })

  -- Optionally, enter insert mode in the terminal automatically
  vim.cmd('startinsert')
end

-- Function to run RSpec for the current file and line inside Docker
function run_rspec(line_specific)
  local file = vim.fn.expand('%:p')  -- Get the full path of the current file
  local line = vim.fn.line('.')  -- Get the current cursor line number
  local file_name = vim.fn.fnamemodify(file, ':t')  -- Get the file name with extension
  local file_ext = vim.fn.fnamemodify(file, ':e')  -- Get the file extension
  local command

  -- Determine the project name from the environment variable
  local project_name = get_project_name()
  if not project_name then
    print('Could not determine the project name.')
    return
  end

  -- Docker Compose command prefix
  local docker_command = 'docker compose run --rm ' .. project_name .. ' '

  -- Check if the current file is an RSpec file by its name
  if file_name:match('_spec.rb$') then
    -- If it's an RSpec file, run RSpec on the current file and optionally the line
    local project_root = parse_path(file, project_name)
    local docker_file = '/app' .. project_root
    if line_specific then
      command = docker_command .. 'bundle exec rspec ' .. docker_file .. ':' .. line .. '; exec bash'
    else
      command = docker_command .. 'bundle exec rspec ' .. docker_file .. '; exec bash'
    end
  elseif file_ext == 'rb' then
    -- If it's a Ruby file, build the path to the corresponding RSpec file
    local rspec_file = ruby_to_rspec_path(file)
    local project_root = parse_path(rspec_file, project_name)
    local docker_file = '/app' .. project_root
    command = docker_command .. 'bundle exec rspec ' .. docker_file .. '; exec bash'
  else
    print('Current file is not a Ruby or RSpec file.')
    return
  end

  open_split_terminal_with_auto_close(command)
end

function run_rspec_parallel()
  local command

  -- Determine the project name from the environment variable
  local project_name = get_project_name()
  if not project_name then
    print('Could not determine the project name.')
    return
  end

  -- Docker Compose command prefix
  local docker_command = 'docker compose run --rm ' .. project_name .. ' '

  command = docker_command .. 'bash -c "bundle exec rails parallel:spec"' .. '; exec bash'

  open_split_terminal_with_auto_close(command)
end

function run_rubocop()
  local command

  -- Determine the project name from the environment variable
  local project_name = get_project_name()
  if not project_name then
    print('Could not determine the project name.')
    return
  end

  -- Docker Compose command prefix
  local docker_command = 'docker compose run --rm ' .. project_name .. ' '

  command = docker_command .. 'bundle exec rubocop -A' .. '; exec bash'

  open_split_terminal_with_auto_close(command)
end


function run_undercover()
  local command

  -- Determine the project name from the environment variable
  local project_name = get_project_name()
  if not project_name then
    print('Could not determine the project name.')
    return
  end

  -- Docker Compose command prefix
  local docker_command = 'docker compose run --rm ' .. project_name .. ' '

  command = docker_command .. 'bundle exec undercover -c origin/main' .. '; exec bash'

  open_split_terminal_with_auto_close(command)
end

function run_db_clear()
  local command

  -- Determine the project name from the environment variable
  local project_name = get_project_name()
  if not project_name then
    print('Could not determine the project name.')
    return
  end

  -- Docker Compose command prefix
  local docker_command = 'docker compose run --rm ' .. project_name .. ' '

  command = docker_command .. 'bash -c "RAILS_ENV=development bundle exec rails db:drop db:create db:migrate && RAILS_ENV=test bundle exec rails db:drop db:create db:migrate && bundle exec rails parallel:drop && bundle exec rails parallel:setup && bundle exec rails parallel:spec"' .. '; exec bash'

  open_split_terminal_with_auto_close(command)
end

function run_db_migrate()
  local command

  -- Determine the project name from the environment variable
  local project_name = get_project_name()
  if not project_name then
    print('Could not determine the project name.')
    return
  end

  -- Docker Compose command prefix
  local docker_command = 'docker compose run --rm ' .. project_name .. ' '

  command = docker_command .. 'bash -c "RAILS_ENV=development bundle exec rails db:migrate && RAILS_ENV=test bundle exec rails db:migrate"'

  open_split_terminal_with_auto_close(command)
end

function run_db_postgres()
  -- Determine the project name from the environment variable
  local project_name = get_project_name()
  if not project_name then
    print('Could not determine the project name.')
    return
  end

  -- Docker Compose command prefix
  local command = 'docker compose exec postgres15 psql -U postgres ' .. project_name:gsub('-', '_') .. '_development'

  open_split_terminal_with_auto_close(command)
end

function run_container_bash()
  -- Determine the project name from the environment variable
  local project_name = get_project_name()
  if not project_name then
    print('Could not determine the project name.')
    return
  end

  local docker_command = 'docker compose exec ' .. project_name .. ' '
  command = docker_command .. 'bash'

  open_split_terminal_with_auto_close(command)
end

function run_db_create(migration_name)
  local command

  if not migration_name or migration_name == "" then
    print("No migration name provided.")
    return
  end

  -- Determine the project name from the environment variable
  local project_name = get_project_name()
  if not project_name then
    print('Could not determine the project name.')
    return
  end

  -- Docker Compose command prefix
  local docker_command = 'docker compose run --rm ' .. project_name .. ' '

  command = docker_command .. 'bash -c "bundle exec rails g migration ' .. migration_name .. '"'

  open_split_terminal_with_auto_close(command)
end

-- Function to run RSpec on a specific file or folder inside Docker
function run_rspec_on_path(test_path)
  if not test_path or test_path == "" then
    print("No test path provided.")
    return
  end

  local project_name = get_project_name()
  if not project_name or project_name == "" then
    print('Project name is not set. Please set the PROJECT_NAME environment variable.')
    return
  end

  -- Check if the path is already a 'spec/' directory or convert it
  local modified_path
  if test_path:match("^spec/") then
    modified_path = test_path  -- Already in spec path
  else
    local rspec_path = test_path:gsub('/app/', '/spec/')
    if test_path:match('/app/controllers/') then
      rspec_path = rspec_path:gsub('/controllers/', '/requests/')
    end
    -- Use existing conversion function to convert Rails paths to spec paths
    modified_path = rspec_path
  end

  local project_root = parse_path(modified_path, project_name)
  local docker_file = '/app' .. project_root

  -- Docker Compose command to run RSpec
  local docker_command = 'docker compose run --rm ' .. project_name .. ' '
  local command = docker_command .. 'bundle exec rspec ' .. docker_file .. '; exec bash'

  open_newbuff_terminal_with_auto_close(command)
end

-- Function to run RSpec tests on the current directory
function run_rspec_on_current_directory()
  local directory_path = require'nvim-tree.lib'.get_node_at_cursor().absolute_path
  -- Check if the path is a directory or a specific file should be checked
  -- You can modify this logic based on specific requirements (e.g., check if it's a test file directory)
  if vim.fn.isdirectory(directory_path) == 1 then
    run_rspec_on_path(directory_path)
  else
    print("The path is not a directory or does not exist.")
  end
end

vim.api.nvim_create_user_command('RunRSpecCurrentDir', run_rspec_on_current_directory, {})

-- Create Neovim command for running RSpec
vim.api.nvim_create_user_command('RunRSpec', function()
  run_rspec(false)
end, {})

vim.api.nvim_create_user_command('RunRSpecLine', function()
  run_rspec(true)
end, {})

vim.api.nvim_create_user_command('RunRSpecParallel', function()
  run_rspec_parallel()
end, {})

vim.api.nvim_create_user_command('RunRubocopAutofix', function()
  run_rubocop()
end, {})

vim.api.nvim_create_user_command('RunUndercover', function()
  run_undercover()
end, {})

vim.api.nvim_create_user_command('RunDbClear', function()
  run_db_clear()
end, {})

vim.api.nvim_create_user_command('RunDbMigrate', function()
  run_db_migrate()
end, {})

vim.api.nvim_create_user_command('RunDbCreate', function()
  local migration_name = vim.fn.input('Enter migration name: ')
  run_db_create(migration_name)
end, {})

vim.api.nvim_create_user_command('RunDbPostgres', function()
  run_db_postgres()
end, {})

vim.api.nvim_create_user_command('RunContainerBash', function()
  run_container_bash()
end, {})

-- Rspec
vim.api.nvim_set_keymap('n', '<leader>rsa', ':RunRSpec<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>rsi', ':RunRSpecLine<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>rsp', ':RunRSpecParallel<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>rsc', ':RunRSpecCurrentDir<CR>', { noremap = true, silent = true })

-- Linters
vim.api.nvim_set_keymap('n', '<leader>rba', ':RunRubocopAutofix<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>rbu', ':RunUndercover<CR>', { noremap = true, silent = true })

-- Database
vim.api.nvim_set_keymap('n', '<leader>rdb', ':RunDbClear<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>rdm', ':RunDbMigrate<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>rdc', ':RunDbCreate<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>rdp', ':RunDbPostgres<CR>', { noremap = true, silent = true })

-- Container
vim.api.nvim_set_keymap('n', '<leader>rh', ':RunContainerBash<CR>', { noremap = true, silent = true })

vim.wo.relativenumber = false
vim.o.autoread = true
vim.opt.termguicolors = true
-- vim.opt.swapfile = false
vim.o.updatetime = 1000

vim.opt.list = true
vim.opt.listchars = {
  space = "·",
  tab = "→ ",
  trail = "•",
  extends = "⟩",
  precedes = "⟨",
}
vim.opt.wildignorecase = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- vim.o.lazyredraw   = true      -- skip redraw during complex operations :contentReference[oaicite:0]{index=0}
-- vim.o.ttyfast      = true      -- assume fast terminal to remove throttles :contentReference[oaicite:1]{index=1}
-- vim.o.synmaxcol    = 300       -- stop syntax parsing after 300 cols :contentReference[oaicite:2]{index=2}
-- vim.wo.cursorline  = false     -- disable cursorline (window‑local) :contentReference[oaicite:3]{index=3}
-- vim.wo.cursorcolumn= false     -- disable cursorcolumn (window‑local) :contentReference[oaicite:4]{index=4}
--
-- vim.opt.timeoutlen  = 300
-- vim.opt.ttimeoutlen = 50

-- vim.api.nvim_create_autocmd(
--   { "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" },
--   {
--     pattern = "*",
--     command = "if mode() != 'c' | checktime | endif",
--   }
-- )
--
-- vim.api.nvim_create_autocmd("TermOpen", {
--   pattern = "*",  -- Applies to all terminals
--   callback = function()
--     vim.wo.number = false  -- Disable line numbers
--     vim.wo.relativenumber = false  -- Disable relative line numbers
--     vim.bo.scrollback = 10000  -- Optional: Set scrollback buffer size
--   end,
-- })

vim.cmd([[
  autocmd TermOpen * startinsert
]])

vim.cmd([[
  autocmd TermClose * quit
]])
