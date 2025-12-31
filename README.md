**This repo is supposed to used as config by NvChad users!**

- The main nvchad repo (NvChad/NvChad) is used as a plugin by this repo.
- So you just import its modules , like `require "nvchad.options" , require "nvchad.mappings"`
- So you can delete the .git from this repo ( when you clone it locally ) or fork it :)

# Credits

1) Lazyvim starter https://github.com/LazyVim/starter as nvchad's starter was inspired by Lazyvim's . It made a lot of things easier!

Done — I added “most-used” keymaps for your enabled Snacks modules in lua/mappings.lua.

I also enabled picker in your Snacks opts (in lua/plugins/init.lua) because Snacks gh requires picker to work.

Keymaps added

Git / GitHub
•  <leader>gg — LazyGit
•  <leader>gL — LazyGit log
•  <leader>gF — LazyGit log (current file)
•  <leader>gR — Open repo in browser (Snacks gitbrowse)
•  <leader>gB — Open branch in browser
•  <leader>gO — Open current file/selection lines in browser
•  <leader>gU — Open permalink URL in browser
•  <leader>gC — Open commit in browser

GitHub (needs gh installed + authenticated):
•  <leader>gi — GitHub issues (open)
•  <leader>gI — GitHub issues (all)
•  <leader>gp — GitHub PRs (open)
•  <leader>gP — GitHub PRs (all)

Snacks picker (fuzzy finder)
•  <leader>sp — All Snacks pickers
•  <leader>sf — Find files
•  <leader>sg — Grep
•  <leader>sb — Buffers
•  <leader>sh — Help
•  <leader>sD — Diagnostics picker

Scratch
•  <leader>. — Toggle scratch buffer
•  <leader>S — Select scratch buffer

Notifications
•  <leader>nh — Notification history
•  <leader>nd — Dismiss all notifications
•  <leader>nt — Test notification (vim.notify("snacks notify test"))

LSP references (“words”)
•  ]r — Next reference
•  [r — Previous reference

Toggles
•  <leader>ud — Toggle dim
•  <leader>uw — Toggle words (refs UI)
•  <leader>us — Toggle smooth scrolling
•  <leader>uD — Toggle diagnostics

Images
•  <leader>ih — Image hover (shows image at cursor in a float, if your terminal supports it)

Debug
•  <leader>dr — Run buffer/range (great for Lua scratch)
•  <leader>db — Backtrace
•  <leader>di — Inspect basic context (buf/ft/cwd)
•  <leader>dm — Metrics

Win/Layout demos (for testing)
•  <leader>wn — Open Neovim doc/news.txt in a float
•  <leader>wl — Toggle a small layout demo (scratch + news)
•  <leader>wM — Maximize that layout demo

How to test quickly
1. Restart Neovim
2. Run :checkhealth snacks
3. Try:
◦  <leader>gg (lazygit)
◦  <leader>gR (gitbrowse)
◦  <leader>nh (notifier history)
◦  <leader>. (scratch)

If you want, tell me whether you’d rather use Snacks picker instead of NvChad’s Telescope for the “core” keys (<leader>ff, <leader>fw, etc.), and I can remap those cleanly.
