local status_ok, chatgpt = pcall(require, "chatgpt")
if not status_ok then
	return
end

require("chatgpt").setup(
	{
		api_key_cmd = nil,
		yank_register = "+",
		edit_with_instructions = {
			diff = false,
			keymaps = {
				close = "<C-c>",
				accept = "<C-y>",
				toggle_diff = "<C-d>",
				toggle_settings = "<C-o>",
				cycle_windows = "<Tab>",
				use_output_as_input = "<C-i>",
			},
		},
		chat = {
			welcome_message = "hihihihihihih",
			loading_text = "Loading, please wait ...",
			question_sign = "",
			answer_sign = "ﮧ",
			max_line_length = 120,
			sessions_window = {
				border = {
					style = "rounded",
					text = {
						top = " Sessions ",
					},
				},
				win_options = {
					winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
				},
			},
			keymaps = {
				close = { "<C-c>" },
				yank_last = "<C-y>",
				yank_last_code = "<C-k>",
				scroll_up = "<C-u>",
				scroll_down = "<C-d>",
				new_session = "<C-n>",
				cycle_windows = "<Tab>",
				cycle_modes = "<C-f>",
				select_session = "<Space>",
				rename_session = "r",
				delete_session = "d",
				draft_message = "<C-d>",
				toggle_settings = "<C-o>",
				toggle_message_role = "<C-r>",
				toggle_system_role_open = "<C-s>",
				stop_generating = "<C-x>",
			},
		},
		popup_layout = {
			default = "center",
			center = {
				width = "80%",
				height = "80%",
			},
			right = {
				width = "30%",
				width_settings_open = "50%",
			},
		},
		popup_window = {
			border = {
				highlight = "FloatBorder",
				style = "rounded",
				text = {
					top = " ChatGPT ",
				},
			},
			win_options = {
				wrap = true,
				linebreak = true,
				foldcolumn = "1",
				winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
			},
			buf_options = {
				filetype = "markdown",
			},
		},
		system_window = {
			border = {
				highlight = "FloatBorder",
				style = "rounded",
				text = {
					top = " SYSTEM ",
				},
			},
			win_options = {
				wrap = true,
				linebreak = true,
				foldcolumn = "2",
				winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
			},
		},
		popup_input = {
			prompt = "  ",
			border = {
				highlight = "FloatBorder",
				style = "rounded",
				text = {
					top_align = "center",
					top = " Prompt ",
				},
			},
			win_options = {
				winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
			},
			submit = "<C-Enter>",
			submit_n = "<Enter>",
			max_visible_lines = 20
		},
		settings_window = {
			border = {
				style = "rounded",
				text = {
					top = " Settings ",
				},
			},
			win_options = {
				winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
			},
		},
		openai_params = {
			model = "gpt-4o",
			frequency_penalty = 0,
			presence_penalty = 0,
			max_tokens = 4000,
			temperature = 0.5,
			top_p = 1,
			n = 1,
		},
		openai_edit_params = {
			model = "gpt-4o",
			frequency_penalty = 0,
			presence_penalty = 0,
			max_tokens = 4000,
			temperature = 0,
			top_p = 1,
			n = 1,
		},
		actions_paths = {},
		show_quickfixes_cmd = "Trouble quickfix",
		predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/f/awesome-chatgpt-prompts/main/prompts.csv",
	}
)

-- which key integration
local wk = require("which-key")
wk.add(
	{
		{ "<leader>C", "<cmd>ChatGPT<CR>", desc = "ChatGPT", mode = "v" },
		{
			mode = { "n", "v" },
			{ "<leader>Ca", "<cmd>ChatGPTRun add_tests<CR>",                 desc = "Add Tests" },
			{ "<leader>Cd", "<cmd>ChatGPTRun docstring<CR>",                 desc = "Docstring" },
			{ "<leader>Ce", "<cmd>ChatGPTEditWithInstruction<CR>",           desc = "Edit with instruction" },
			{ "<leader>Cf", "<cmd>ChatGPTRun fix_bugs<CR>",                  desc = "Fix Bugs" },
			{ "<leader>Cg", "<cmd>ChatGPTRun grammar_correction<CR>",        desc = "Grammar Correction" },
			{ "<leader>Ck", "<cmd>ChatGPTRun keywords<CR>",                  desc = "Keywords" },
			{ "<leader>Cl", "<cmd>ChatGPTRun code_readability_analysis<CR>", desc = "Code Readability Analysis" },
			{ "<leader>Co", "<cmd>ChatGPTRun optimize_code<CR>",             desc = "Optimize Code" },
			{ "<leader>Cr", "<cmd>ChatGPTRun roxygen_edit<CR>",              desc = "Roxygen Edit" },
			{ "<leader>Cs", "<cmd>ChatGPTRun summarize<CR>",                 desc = "Summarize" },
			{ "<leader>Ct", "<cmd>ChatGPTRun translate<CR>",                 desc = "Translate" },
			{ "<leader>Cx", "<cmd>ChatGPTRun explain_code<CR>",              desc = "Explain Code" },
		},
	}
)
