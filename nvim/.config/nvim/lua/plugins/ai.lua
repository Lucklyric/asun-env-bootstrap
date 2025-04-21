return {
	{ "github/copilot.vim" },
	{
		"olimorris/codecompanion.nvim",
		enabled = true,
		dependencies = {
			{ "echasnovski/mini.nvim", version = "*" },
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
			"nvim-telescope/telescope.nvim", -- Optional: For using slash commands
			{ "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion", "Avante" } }, -- Optional: For prettier markdown rendering
			{ "stevearc/dressing.nvim", opts = {} }, -- Optional: Improves `vim.ui.select`
		},
		config = true,
		opts = {
			strategies = {
				chat = {
					adapter = "openai",
				},
				inline = {
					adapter = "openai",
				},
			},
			display = {
				diff = {
					provider = "default",
				},
			},
			adapters = {
				openai = function()
					return require("codecompanion.adapters").extend("openai", {
						schema = {
							model = {
								default = "gpt-4o",
							},
						},
					})
				end,
			},
		},
	},
	{
		"yetone/avante.nvim",
		enabled = true,
		event = "VeryLazy",
		lazy = false,
		version = false, -- set this if you want to always pull the latest change
		opts = {
			dual_boost = {
				enabled = false,
				first_provider = "openai",
				second_provider = "claude",
				prompt = "Based on the two reference outputs below, generate a response that incorporates elements from both but reflects your own judgment and unique perspective. Do not provide any explanation, just give the response directly. Reference Output 1: {{provider1_output}}, Reference Output 2: {{provider2_output}}",
				timeout = 60000, -- Timeout in milliseconds
			},
			debug = false,
			---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
			provider = "openai", -- Recommend using Claude
			auto_suggestions_provider = "openai", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
			openai = {
				endpoint = "https://api.openai.com/v1",
				model = "o3-mini",
				reasoning_effort = "high",
				timeout = 30000, -- Timeout in milliseconds
				max_tokens = 16000,
			},
			claude = {
				endpoint = "https://api.anthropic.com",
				model = "claude-3-7-sonnet-20250219",
				temperature = 0,
				max_tokens = 16000,
			},
			behaviour = {
				auto_suggestions = false, -- Experimental stage
				auto_set_highlight_group = true,
				auto_set_keymaps = true,
				auto_apply_diff_after_generation = false,
				support_paste_from_clipboard = false,
			},
			mappings = {
				--- @class AvanteConflictMappings
				diff = {
					ours = "co",
					theirs = "ct",
					all_theirs = "ca",
					both = "cb",
					cursor = "cc",
					next = "]x",
					prev = "[x",
				},
				suggestion = {
					accept = "<M-l>",
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},
				jump = {
					next = "]]",
					prev = "[[",
				},
				submit = {
					normal = "<CR>",
					insert = "<C-s>",
				},
				sidebar = {
					switch_windows = "<Tab>",
					reverse_switch_windows = "<S-Tab>",
				},
			},
			hints = { enabled = true },
			windows = {
				---@type 'right' | "left" | "top" | "bottom"
				position = "right", -- the position of the sidebar
				wrap = true, -- similar to vim.o.wrap
				width = 30, -- default % based on available width
				sidebar_header = {
					align = "center", -- left, center, right for title
					rounded = true,
				},
			},
			highlights = {
				---@type AvanteConflictHighlights
				diff = {
					current = "DiffText",
					incoming = "DiffAdd",
				},
			},
			--- @class AvanteConflictUserConfig
			diff = {
				autojump = true,
				---@type string | fun(): any
				list_opener = "copen",
			},
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua", -- for providers='copilot'
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
			{
				-- Make sure to set this up properly if you have lazy=true
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante", "codecompanion" },
				},
				ft = { "markdown", "Avante", "codecompanion" },
			},
			{ "mzlogin/vim-markdown-toc" },
		},
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main",
		dependencies = {
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		config = function(_, opts)
			local chat = require("CopilotChat")
			opts = {
				debug = false, -- Enable debug logging
				proxy = nil, -- [protocol://]host[:port] Use this proxy
				allow_insecure = false, -- Allow insecure server connections
				model = "gpt-4o", -- GPT model to use, 'gpt-3.5-turbo' or 'gpt-4'
				temperature = 0.1, -- GPT temperature
			}
			chat.setup(opts)
		end,
	},
}
