return {
	{ "nvim-neotest/nvim-nio" },
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
	{ "nvzone/volt",          lazy = true },
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
		version = false, -- set this to "*" to always pull the latest release version, or false for latest code changes.
		opts = {
			provider = "openai",
			openai = {
				endpoint = "https://api.openai.com/v1",
				model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
				timeout = 30000, -- in milliseconds
				temperature = 0,
				max_tokens = 4096,
				-- reasoning_effort = "high", -- if needed for reasoning models
			},
			system_prompt = function()
				local hub = require("mcphub").get_hub_instance()
				return hub:get_active_servers_prompt()
			end,
			custom_tools = function()
				return {
					require("mcphub.extensions.avante").mcp_tool(),
				}
			end,
			-- add any other avante configuration options below
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
						drag_and_drop = { insert_mode = true },
						use_absolute_path = true,
					},
				},
			},
			{
				"MeanderingProgrammer/render-markdown.nvim",
				opts = { file_types = { "markdown", "Avante" } },
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
		"Civitasv/cmake-tools.nvim",
		event = "VeryLazy",
		opts = {}
		-- opts = (function()
		-- 	local sysname = vim.loop.os_uname().sysname
		-- 	local is_win = sysname == "Windows_NT"
		-- 	return {
		-- 		cmake_command = "cmake", -- specify cmake command path
		-- 		ctest_command = "ctest", -- specify ctest command path
		-- 		cmake_use_preset = true,
		-- 		cmake_regenerate_on_save = true, -- auto generate when saving CMakeLists.txt
		-- 		cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
		-- 		cmake_build_options = {},
		-- 		-- support macro expansion: ${kit}, ${kitGenerator}, ${variant:xx}
		-- 		cmake_build_directory = function()
		-- 			if is_win then
		-- 				return "build\\${variant:buildType}"
		-- 			end
		-- 			return "build/${variant:buildType}"
		-- 		end,
		-- 		cmake_soft_link_compile_commands = true,
		-- 		cmake_compile_commands_from_lsp = false,
		-- 		cmake_kits_path = nil,
		-- 		cmake_variants_message = {
		-- 			short = { show = true },
		-- 			long = { show = true, max_length = 40 },
		-- 		},
		-- 		cmake_dap_configuration = { -- debug settings for cmake
		-- 			name = "cpp",
		-- 			type = "codelldb",
		-- 			request = "launch",
		-- 			stopOnEntry = false,
		-- 			runInTerminal = true,
		-- 			console = "integratedTerminal",
		-- 		},
		-- 		cmake_executor = {
		-- 			name = "quickfix",
		-- 			opts = {},
		-- 			default_opts = {
		-- 				quickfix = {
		-- 					show = "always",
		-- 					position = "belowright",
		-- 					size = 10,
		-- 					encoding = "utf-8",
		-- 					auto_close_when_success = true,
		-- 				},
		-- 				toggleterm = {
		-- 					direction = "float",
		-- 					close_on_exit = false,
		-- 					auto_scroll = true,
		-- 					singleton = true,
		-- 				},
		-- 				overseer = {
		-- 					new_task_opts = {
		-- 						strategy = {
		-- 							"toggleterm",
		-- 							direction = "horizontal",
		-- 							auto_scroll = true,
		-- 							quit_on_exit = "success"
		-- 						}
		-- 					},
		-- 					on_new_task = function(task)
		-- 						require("overseer").open({ enter = false, direction = "right" })
		-- 					end,
		-- 				},
		-- 				terminal = {
		-- 					name = "Main Terminal",
		-- 					prefix_name = "[CMakeTools]: ",
		-- 					split_direction = "horizontal",
		-- 					split_size = 11,
		-- 					single_terminal_per_instance = true,
		-- 					single_terminal_per_tab = true,
		-- 					keep_terminal_static_location = true,
		-- 					auto_resize = true,
		-- 					start_insert = false,
		-- 					focus = false,
		-- 					do_not_add_newline = false,
		-- 				},
		-- 			},
		-- 		},
		-- 		cmake_runner = {
		-- 			name = "terminal",
		-- 			opts = {},
		-- 			default_opts = {
		-- 				quickfix = {
		-- 					show = "always",
		-- 					position = "belowright",
		-- 					size = 10,
		-- 					encoding = "utf-8",
		-- 					auto_close_when_success = true,
		-- 				},
		-- 				toggleterm = {
		-- 					direction = "float",
		-- 					close_on_exit = false,
		-- 					auto_scroll = true,
		-- 					singleton = true,
		-- 				},
		-- 				overseer = {
		-- 					new_task_opts = {
		-- 						strategy = {
		-- 							"toggleterm",
		-- 							direction = "horizontal",
		-- 							auto_scroll = true,
		-- 							quit_on_exit = "success"
		-- 						}
		-- 					},
		-- 					on_new_task = function(task)
		-- 						-- Optional: define a callback if needed
		-- 					end,
		-- 				},
		-- 				terminal = {
		-- 					name = "Main Terminal",
		-- 					prefix_name = "[CMakeTools]: ",
		-- 					split_direction = "horizontal",
		-- 					split_size = 11,
		-- 					single_terminal_per_instance = true,
		-- 					single_terminal_per_tab = true,
		-- 					keep_terminal_static_location = true,
		-- 					auto_resize = true,
		-- 					start_insert = false,
		-- 					focus = false,
		-- 					do_not_add_newline = false,
		-- 				},
		-- 			},
		-- 		},
		-- 		cmake_notifications = {
		-- 			runner = { enabled = true },
		-- 			executor = { enabled = true },
		-- 			spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
		-- 			refresh_rate_ms = 100,
		-- 		},
		-- 		cmake_virtual_text_support = true,
		-- 	}
		-- end)(),
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
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"hrsh7th/nvim-cmp",
		opts = function(_, opts)
			opts.sources = opts.sources or {}
			table.insert(opts.sources, {
				name = "lazydev",
				group_index = 0, -- set group index to 0 to skip loading LuaLS completions
			})
		end,
	},
	{
		'numToStr/Comment.nvim',
		opts = {
			-- add any options here
		}
	},
	{
		"ravitemer/mcphub.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
		},
		-- cmd = "MCPHub", -- lazily start the hub when `MCPHub` is called
		build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
		config = function()
			require("mcphub").setup({
				-- Required options
				port = 3000,                          -- Port for MCP Hub server
				config = vim.fn.expand("~/.mcp/mcpservers.json"), -- Absolute path to config file

				-- Optional options
				on_ready = function(hub)
					-- Called when hub is ready
				end,
				on_error = function(err)
					-- Called on errors
				end,
				log = {
					level = vim.log.levels.WARN,
					to_file = false,
					file_path = nil,
					prefix = "MCPHub"
				},
			})
		end
	},
}
