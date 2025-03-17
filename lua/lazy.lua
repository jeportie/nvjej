return {
	{ -- This plugin
		"Zeioth/makeit.nvim",
		cmd = { "MakeitOpen", "MakeitToggleResults", "MakeitRedo" },
		dependencies = { "stevearc/overseer.nvim" },
		opts = {},
	},
	{ -- The task runner we use
		"stevearc/overseer.nvim",
		commit = "400e762648b70397d0d315e5acaf0ff3597f2d8b",
		cmd = { "MakeitOpen", "MakeitToggleResults", "MakeitRedo" },
		opts = {
			task_list = {
				direction = "bottom",
				min_height = 25,
				max_height = 25,
				default_detail = 1
			},
		},
	},
	{ -- This plugin
		"Zeioth/compiler.nvim",
		cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
		dependencies = { "stevearc/overseer.nvim", "nvim-telescope/telescope.nvim" },
		opts = {},
	},
	{ -- The task runner we use
		"stevearc/overseer.nvim",
		commit = "6271cab7ccc4ca840faa93f54440ffae3a3918bd",
		cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
		opts = {
			task_list = {
				direction = "bottom",
				min_height = 25,
				max_height = 25,
				default_detail = 1
			},
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				signature = {
					enabled = false,
				},
			},
			routes = {
				{
					filter = { find = "No information available" },
					opts = { skip = true },
				},
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
	{ "nvzone/volt", lazy = true },
	{
		"nvzone/typr",
		dependencies = "nvzone/volt",
		opts = {},
		cmd = { "Typr", "TyprStats" },
	},
	{
		"nvzone/menu",
		lazy = false, -- load always
		keys = {
			{ "<C-t>", function() require("menu").open("default") end, desc = "Open menu (keyboard)" },
			{
				"<RightMouse>",
				function()
					require("menu.utils").delete_old_menus()
					vim.cmd.exec '"normal! \\<RightMouse>"'
					local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
					local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"
					require("menu").open(options, { mouse = true })
				end,
				desc = "Open menu (mouse)"
			},
		},
	},
	{
		"nvzone/minty",
		cmd = { "Shades", "Huefy" },
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
		opts = {
			provider = "openai",
			openai = {
				endpoint = "https://api.openai.com/v1",
				model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
				timeout = 30000, -- timeout in milliseconds
				temperature = 0, -- adjust if needed
				max_tokens = 4096,
				-- reasoning_effort = "high" -- only supported for reasoning models (o1, etc.)
			},
		},
		build = "make",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"echasnovski/mini.pick", -- for file_selector provider mini.pick
			"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
			"hrsh7th/nvim-cmp",     -- autocompletion for avante commands and mentions
			"ibhagwan/fzf-lua",     -- for file_selector provider fzf
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua", -- for providers='copilot'
			{
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						use_absolute_path = true,
					},
				},
			},
			{
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	},
	{
		"simrat39/symbols-outline.nvim",
		cmd = "SymbolsOutline", -- load when the command is used
		keys = {
			{ "<leader>so", "<cmd>SymbolsOutline<CR>", desc = "Toggle Symbols Outline" },
		},
		config = function()
			require("symbols-outline").setup({
				auto_preview = false,
				symbols = {
					File = { icon = "", hl = "TSURI" },
					Module = { icon = "󰕳", hl = "TSNamespace" },
					Namespace = { icon = "", hl = "TSNamespace" },
					Package = { icon = "", hl = "TSNamespace" },
					Class = { icon = "", hl = "TSType" },
					Method = { icon = "", hl = "TSMethod" },
					Property = { icon = "", hl = "TSMethod" },
					Field = { icon = "", hl = "TSField" },
					Constructor = { icon = "", hl = "TSConstructor" },
					Enum = { icon = "", hl = "TSType" },
					Interface = { icon = "", hl = "TSType" },
					Function = { icon = "", hl = "TSFunction" },
					Variable = { icon = "", hl = "TSConstant" },
					Constant = { icon = "", hl = "TSConstant" },
					String = { icon = "", hl = "TSString" },
					Number = { icon = "", hl = "TSNumber" },
					Boolean = { icon = "", hl = "TSBoolean" },
					Array = { icon = "", hl = "TSConstant" },
					Object = { icon = "", hl = "TSType" },
					Key = { icon = "", hl = "TSType" },
					Null = { icon = "", hl = "TSType" },
					EnumMember = { icon = "", hl = "TSField" },
					Struct = { icon = "", hl = "TSType" },
					Event = { icon = "", hl = "TSType" },
					Operator = { icon = "", hl = "TSOperator" },
					TypeParameter = { icon = "", hl = "TSParameter" },
				},
			})
		end,
	},
	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",                -- loads when an LSP client attaches (requires lazy.nvim 2023‑July‑9 or later)
		ft = { "c", "cpp", "lua", "rust", "go" }, -- loads when one of these filetypes is opened
		dependencies = {
			"nvim-tree/nvim-web-devicons",  -- optional, for icons in UI
			"neovim/nvim-lspconfig",        -- ensures lspsaga is a dependency of your LSP setup
			"nvim-treesitter/nvim-treesitter", -- optional, for better UI integration
		},
		config = function()
			require("lspsaga").setup({
				-- Your lspsaga configuration options go here.
			})
		end,
	},
	{
		"42Paris/42header",
		keys = {
			{ "<F1>", "<cmd>Stdheader<CR>", desc = "Insert 42 Header" },
		},
		config = function()
			vim.cmd([[
        let g:user42 = 'jeportie'
        let g:mail42 = 'jeportie@student.42.fr'
      ]])
		end,
	},
	{
		"jeportie/NorminetteRun",
		keys = {
			{ "<F12>", "<cmd>NorminetteRun<CR>", desc = "Run Norminette" },
		},
		config = function()
			-- Default state: enabled (1) means auto-check on save is active.
			vim.g.norminette42 = 1

			-- Create a user command to toggle auto-checking.
			vim.api.nvim_create_user_command("Norminette42", function(opts)
				local arg = opts.args
				if arg == "0" or arg == "1" then
					vim.g.norminette42 = tonumber(arg)
					print("Norminette42 auto-check set to " .. vim.g.norminette42)
				else
					print("Usage: :Norminette42 <0|1>")
				end
			end, { nargs = 1 })

			-- Automatically run NorminetteRun on file save if toggle is enabled.
			vim.api.nvim_create_autocmd("BufWritePost", {
				callback = function()
					if vim.g.norminette42 == 1 then
						vim.cmd("NorminetteRun")
					end
				end,
			})
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"jonarrien/telescope-cmdline.nvim",
		},
		keys = {
			{ "Q",                "<cmd>Telescope cmdline<cr>", desc = "Cmdline" },
			{ "<leader><leader>", "<cmd>Telescope cmdline<cr>", desc = "Cmdline" },
		},
		opts = {
			extensions = {
				cmdline = {
					-- your plugin settings here
				},
			},
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("cmdline")
		end,
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter"
		},
	},
	{
		"rcarriga/nvim-dap-ui",
		event = "VeryLazy",
		dependencies = "mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup() -- Initialize the UI components

			-- Open dap-ui when debugging starts
			dap.listeners.after["event_initialized"]["dapui_config"] = function()
				dapui.open()
			end
			-- Close dap-ui when debugging ends
			dap.listeners.before["event_terminated"]["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before["event_exited"]["dapui_config"] = function()
				dapui.close()
			end
		end
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		event = "VeryLazy",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		opts = {
			handlers = {}
		},
	},
	{
		"mfussenegger/nvim-dap",
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "VeryLazy",
		opts = function()
			return require("custom.configs.null-ls")
		end,
	},
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			local lsp_servers = require("custom.lsp_servers")
			require("mason").setup({
				ui = {
					icons = {
						package_installed   = "",
						package_pending     = "",
						package_uninstalled = "",
					},
				},
			})
			require("mason-lspconfig").setup({
				ensure_installed = lsp_servers,
				automatic_installation = true, -- Automatically install missing LSP servers
			})
		end,
	}
}
