local plenary = require("plenary")
local json = vim.json
local api = vim.api
local uv = vim.loop
local M = {}

M.condfig = {
	mappings = {},
}

-- Setup function to accept configuration options
function M.setup(opts)
	M.config = vim.tbl_deep_extend("force", M.config, opts)
end

-- Load configuration for a specific filetype
local function get_mapping(filetype)
	for _, mapping in pairs(M.config.mappings) do
		if mapping.filetype == filetype then
			return mapping
		end
	end
	return nil
end

-- Clone the repository to a temporary directory
local function clone_repo(repo_url, callback)
	local tmp_dir = "/tmp/nvim_syntax_plugin_" .. uv.hrtime()
	plenary
		:new({
			command = "git",
			args = { "clone", repo_url, tmp_dir },
			on_exit = function(j, return_val)
				if return_val == 0 then
					callback(tmp_dir)
				else
					print("Failed to clone repository: " .. repo_url)
				end
			end,
		})
		:start()
end

-- Search for .tmLanguage.json files in the cloned repository
local function search_tm_files(dir)
	local found_files = {}
	local handle

	handle = uv.fs_scandir(dir)
	if not handle then
		return found_files
	end

	while true do
		local name, type = uv.fs_scandir_next(handle)
		if not name then
			break
		end

		local full_path = dir .. "/" .. name
		if type == "file" and name:match("%.tmLanguage%.json$") then
			table.insert(found_files, full_path)
		elseif type == "directory" then
			vim.list_extend(found_files, search_tm_files(full_path))
		end
	end

	return found_files
end

-- Fetch the tmLanguage JSON from a local file
local function fetch_tm_json_from_file(file_path, callback)
	local content = vim.fn.readfile(file_path)
	if content then
		local tm_json = json.decode(table.concat(content, "\n"))
		callback(tm_json)
	else
		print("Failed to read tmLanguage JSON from: " .. file_path)
	end
end

-- Convert TextMate JSON to Neovim syntax
local function convert_tm_to_vim_syntax(tm_json, filetype)
	local syntax_lines = {}

	-- for _, pattern in ipairs(tm_json.patterns or {}) do
	-- 	if pattern.name and pattern.match then
	-- 		local syntax_line = string.format(
	-- 			'syntax match %s "%s"',
	-- 			filetype .. pattern.name:gsub("%.", ""),
	-- 			pattern.match:gsub("\\", "\\\\")
	-- 		)
	-- 		table.insert(syntax_lines, syntax_line)
	-- 		table.insert(
	-- 			syntax_lines,
	-- 			string.format("highlight link %s %s", filetype .. pattern.name:gsub("%.", ""), "Keyword")
	-- 		)
	-- 	elseif pattern.name and pattern.begin and pattern["end"] then
	-- 		local syntax_region = string.format(
	-- 			'syntax region %s start="%s" end="%s"',
	-- 			filetype .. pattern.name:gsub("%.", ""),
	-- 			pattern.begin:gsub("\\", "\\\\"),
	-- 			pattern["end"]:gsub("\\", "\\\\")
	-- 		)
	-- 		table.insert(syntax_lines, syntax_region)
	-- 		table.insert(
	-- 			syntax_lines,
	-- 			string.format("highlight link %s %s", filetype .. pattern.name:gsub("%.", ""), "Comment")
	-- 		)
	-- 	end
	-- end

	-- Load syntax into Neovim
	for _, line in ipairs(syntax_lines) do
		api.nvim_exec(line, false)
	end
end

-- Main function to load syntax based on the filetype
function M.load_syntax(filetype)
	local mapping = get_mapping(filetype)

	if not mapping then
		print("No mapping found for filetype: " .. filetype)
		return
	end

	-- If the URL points to a GitHub repository, clone it and find the .tmLanguage.json file
	if mapping.url:match("github.com") then
		clone_repo(mapping.url, function(clone_dir)
			local tm_files = search_tm_files(clone_dir)
			if #tm_files == 0 then
				print("No .tmLanguage.json files found in the repository: " .. mapping.url)
				return
			end

			-- If multiple files are found, we take the first one. You could improve this logic if needed.
			local selected_file = tm_files[1]
			fetch_tm_json_from_file(selected_file, function(tm_json)
				convert_tm_to_vim_syntax(tm_json, filetype)
			end)
		end)
	else
		print("Invalid URL format for: " .. mapping.url)
	end
end

-- Autocommand to automatically load syntax on file type detection
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		M.load_syntax(vim.bo.filetype)
	end,
})

return M
