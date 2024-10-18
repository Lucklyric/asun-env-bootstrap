return {
	{ "github/copilot.vim" },
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		version = false, -- set this if you want to always pull the latest change
		opts = {
			---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
			provider = "openai", -- Recommend using Claude
			auto_suggestions_provider = "openai", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
			openai = {
				endpoint = "https://api.openai.com/v1",
				model = "gpt-4o",
				timeout = 30000, -- Timeout in milliseconds
				temperature = 0,
				max_tokens = 4096,
				["local"] = false,
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
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
			{ "mzlogin/vim-markdown-toc" },
		},
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		config = function(_, opts)
			local prompts = require("CopilotChat.prompts")
			local chat = require("CopilotChat")
			local select = require("CopilotChat.select")
			opts = {
				debug = false, -- Enable debug logging
				proxy = nil, -- [protocol://]host[:port] Use this proxy
				allow_insecure = false, -- Allow insecure server connections
				model = "gpt-4o", -- GPT model to use, 'gpt-3.5-turbo' or 'gpt-4'
				temperature = 0.1, -- GPT temperature

				system_prompt = prompts.COPILOT_INSTRUCTIONS, -- System prompt to use
				question_header = "## User ", -- Header to use for user questions
				answer_header = "## Copilot ", -- Header to use for AI answers
				error_header = "## Error ", -- Header to use for errors
				separator = "───", -- Separator to use in chat

				show_folds = true, -- Shows folds for sections in chat
				show_help = true, -- Shows help message as virtual lines when waiting for user input
				auto_follow_cursor = true, -- Auto-follow cursor in chat
				auto_insert_mode = false, -- Automatically enter insert mode when opening window and if auto follow cursor is enabled on new prompt
				clear_chat_on_new_prompt = false, -- Clears chat on every new prompt
				highlight_selection = true, -- Highlight selection in the source buffer when in the chat window

				context = nil, -- Default context to use, 'buffers', 'buffer' or none (can be specified manually in prompt via @).
				history_path = vim.fn.stdpath("data") .. "/copilotchat_history", -- Default path to stored history
				callback = nil, -- Callback to use when ask response is received

				-- default selection (visual or line)
				selection = function(source)
					return select.visual(source) or select.line(source)
				end,

				-- default prompts
				prompts = {
					Explain = {
						prompt = "/COPILOT_EXPLAIN Write an explanation for the active selection as paragraphs of text.",
					},
					Review = {
						prompt = "/COPILOT_REVIEW Review the selected code.",
						callback = function(response, source)
							-- see config.lua for implementation
						end,
					},
					Fix = {
						prompt = "/COPILOT_GENERATE There is a problem in this code. Rewrite the code to show it with the bug fixed.",
					},
					Optimize = {
						prompt = "/COPILOT_GENERATE Optimize the selected code to improve performance and readablilty.",
					},
					Docs = {
						prompt = "/COPILOT_GENERATE Please add documentation comment for the selection.",
					},
					Tests = {
						prompt = "/COPILOT_GENERATE Please generate tests for my code.",
					},
					FixDiagnostic = {
						prompt = "Please assist with the following diagnostic issue in file:",
						selection = select.diagnostics,
					},
					Commit = {
						prompt = "Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.",
						selection = select.gitdiff,
					},
					CommitStaged = {
						prompt = "Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.",
						selection = function(source)
							return select.gitdiff(source, true)
						end,
					},
				},

				-- default window options
				window = {
					layout = "vertical", -- 'vertical', 'horizontal', 'float', 'replace'
					width = 0.5, -- fractional width of parent, or absolute width in columns when > 1
					height = 0.5, -- fractional height of parent, or absolute height in rows when > 1
					-- Options below only apply to floating windows
					relative = "editor", -- 'editor', 'win', 'cursor', 'mouse'
					border = "single", -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
					row = nil, -- row position of the window, default is centered
					col = nil, -- column position of the window, default is centered
					title = "Copilot Chat", -- title of chat window
					footer = nil, -- footer of chat window
					zindex = 1, -- determines if window is on top or below other floating windows
				},

				-- default mappings
				mappings = {
					complete = {
						detail = "Use @<Tab> or /<Tab> for options.",
						insert = "<Tab>",
					},
					close = {
						normal = "q",
						insert = "<C-c>",
					},
					reset = {
						normal = "<C-l>",
						insert = "<C-l>",
					},
					submit_prompt = {
						normal = "<CR>",
						insert = "<C-m>",
					},
					accept_diff = {
						normal = "<C-y>",
						insert = "<C-y>",
					},
					yank_diff = {
						normal = "gy",
					},
					show_diff = {
						normal = "gd",
					},
					show_system_prompt = {
						normal = "gp",
					},
					show_user_selection = {
						normal = "gs",
					},
				},
			}
			chat.setup(opts)
		end,
	},
}
