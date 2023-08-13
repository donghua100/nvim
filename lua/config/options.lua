vim.g.mapleader = " "




local opt = vim.opt

-- basic settings
opt.autoindent = true
opt.smartindent = true

opt.number = true
opt.relativenumber = false

opt.showmode = false
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.tabstop = 4       -- Number of spaces tabs count for
opt.shiftwidth = 4     -- Size of an indent
opt.expandtab = true   -- Use spaces instead of tabs
opt.shiftround = true


opt.hlsearch = false
opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true   -- Enable highlighting of the current line

opt.wildmenu = true
opt.completeopt = "menu,menuone,noselect"
-- opt.formatoptions = "jcroqlnt"

opt.termguicolors = true  -- True color support
opt.signcolumn = "yes"  -- Always show the signcolumn, otherwise it would shift the text each time



opt.autoread = true
opt.title = true


opt.swapfile = false
opt.backup = false
-- opt.undofile = true
-- opt.undolevels = 10000
opt.updatetime = 200
opt.mouse = "a"
opt.exrc = true

opt.splitright = true
opt.splitbelow = true

opt.grepformat = "%f:%l:%c:%m"
opt.wrap = false

opt.pumblend = 10  -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup

opt.scrolloff = 5 -- Lines of context
opt.sidescrolloff = 10 -- Columns of context


