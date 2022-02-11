-- Essentials
require("settings")
require("keymappings")
require("plugins")
require("autocommands")

-- Theme
require("colorscheme")

-- Plugins config
require("plugins.nvim-tree")
require("plugins.telescope")
require("plugins.autopairs")
require("plugins.treesitter")
require("plugins.comment")
require("plugins.gitsigns")
require("plugins.bufferline")
require("plugins.lualine")
require("plugins.alpha")
require("plugins.impatient")
require("plugins.indentline")
require("plugins.project")
require("plugins.toggleterm")
require("plugins.whichkey")
require("plugins.nvim-gps")

-- Completions
require("plugins.cmp")

-- LSP
require("lsp.config")
