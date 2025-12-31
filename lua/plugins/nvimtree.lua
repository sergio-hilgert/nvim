return {
  "nvim-tree/nvim-tree.lua",
  opts = {
    -- Sorting options
    sort = {
      sorter = "name", -- Sort files alphabetically by name
      folders_first = true, -- Show folders before files
    },

    -- Tree window appearance
    view = {
      width = 35, -- Width of the tree window in columns
      side = "left", -- Position tree on the left side
      number = false, -- Don't show line numbers
      relativenumber = false, -- Don't show relative line numbers
      signcolumn = "yes", -- Show sign column for git/diagnostics icons
    },

    -- How files and folders are displayed
    renderer = {
      group_empty = true, -- Compact folders that only contain a single folder
      highlight_git = "name", -- Highlight file names based on git status
      highlight_opened_files = "name", -- Highlight names of opened files
      highlight_modified = "name", -- Highlight names of modified files
      indent_markers = {
        enable = true, -- Show indent guide lines
      },
      icons = {
        show = {
          file = true, -- Show file icons
          folder = true, -- Show folder icons
          folder_arrow = true, -- Show folder expand/collapse arrows
          git = true, -- Show git status icons
          modified = true, -- Show modified indicator
          diagnostics = true, -- Show diagnostic icons
        },
      },
    },

    -- Git integration
    git = {
      enable = true, -- Enable git integration
      ignore = false, -- Do NOT ignore files listed in .gitignore
      show_on_dirs = true, -- Show git status on directories
      show_on_open_dirs = true, -- Show git status on open directories
      timeout = 500, -- Git command timeout in ms
    },

    -- LSP diagnostics integration
    diagnostics = {
      enable = true, -- Show LSP diagnostics in the tree
      show_on_dirs = true, -- Show diagnostics on parent directories
      show_on_open_dirs = true, -- Show diagnostics on open directories
    },

    -- Modified files indicator
    modified = {
      enable = true, -- Show indicator for unsaved files
      show_on_dirs = true, -- Show on directories with modified children
      show_on_open_dirs = true, -- Show on open directories
    },

    -- File/folder filtering
    filters = {
      dotfiles = false, -- Show dotfiles (files starting with .)
      git_ignored = false, -- Show git-ignored files
      custom = {}, -- Custom patterns to hide (empty = show all)
    },

    -- Auto-focus current file in tree
    update_focused_file = {
      enable = true, -- Enable auto-focus feature
      update_root = {
        enable = false, -- Don't change root when file is outside tree
      },
    },

    -- Actions and behaviors
    actions = {
      open_file = {
        quit_on_open = false, -- Keep tree open when opening a file
        resize_window = true, -- Resize tree window when opening files
        window_picker = {
          enable = true, -- Enable window picker for opening files
        },
      },
      expand_all = {
        exclude = { ".git", "node_modules", "vendor", ".terraform" }, -- Skip these on expand all
      },
    },

    -- File system watchers for auto-refresh
    filesystem_watchers = {
      enable = true, -- Enable file system watching
      debounce_delay = 50, -- Delay before refreshing after changes
      ignore_dirs = { -- Directories to ignore for better performance
        "/.git",
        "/node_modules",
        "/vendor",
        "/.terraform",
        "/tmp",
        "/log",
        "/storage",
        "/.next",
        "/dist",
        "/build",
        "/target",
      },
    },

    -- Sync tree across tabs
    tab = {
      sync = {
        open = true, -- Open tree in new tabs if it was open
        close = true, -- Close tree in all tabs when closed
      },
    },
  },
}
