-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua

--@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "gruvchad",
}

-- M.mappings = require("custom.mappings")

M.nvdash = {
	load_on_startup = true,
    header = {
		"   ▄▄▄██▀▀▀▓█████ ▄▄▄██▀▀▀  ",
		"     ▒██   ▓█   ▀   ▒██     ",
		"     ░██   ▒███     ░██     ",
		"   ▓██▄██▓  ▒▓█  ▄▓██▄██▓   ",
		"    ▓███▒   ░▒████▒▓███▒    ",
		"    ▒▓▒▒░   ░░ ▒░ ░▒▓▒▒░    ",
		"    ▒ ░▒░    ░ ░  ░▒ ░▒░    ",
		"    ░ ░ ░      ░   ░ ░ ░    ",
		"    ░   ░      ░  ░░   ░    ",
		"                            ",
		"        🔥NVJej IDE🔥       ",
		"     Powered By  eovim    ",
		"                            ",
    },

    buttons = {
	  {	txt = "  Open New File", keys = "nn", cmd = "enew"},
	  {	txt = "  Show Neovim Tree", keys = "nt", cmd = "NvimTreeToggle"},
      { txt = "  Find File", keys = "ff", cmd = "Telescope find_files" },
      { txt = "  Recent Files", keys = "fo", cmd = "Telescope oldfiles" },
      { txt = "󰈭  Find Word", keys = "fw", cmd = "Telescope live_grep" },
      { txt = "󰼭  Type Practice", keys = "tp", cmd = "Typr" },
      { txt = "  Type Dashboard", keys = "td", cmd = "TyprStats" },
      { txt = "󱥚  Themes", keys = "th", cmd = ":lua require('nvchad.themes').open()" },
      { txt = "  Mappings", keys = "ch", cmd = "NvCheatsheet" },

      { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },

      {
        txt = function()
          local stats = require("lazy").stats()
          local ms = math.floor(stats.startuptime) .. " ms"
          return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
        end,
        hl = "NvDashFooter",
        no_gap = true,
      },

      { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
    },
}

-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
--}

return M
