local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true,       -- shows a list of your marks on ' and `
    registers = true,   -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false,   -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true,      -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true,      -- default bindings on <c-w>
      nav = true,          -- misc bindings to work with windows
      z = true,            -- bindings for folds, spelling and others prefixed with z
      g = true,            -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  replace = {
    key = {
      function(key)
        return require("which-key.view").format(key)
      end,
      { "<Space>", "SPC" },
    },
    desc = {
      { "<Plug>%(?(.*)%)?", "%1" },
      { "^%+",              "" },
      { "<[cC]md>",         "" },
      { "<[cC][rR]>",       "" },
      { "<[sS]ilent>",      "" },
      { "^lua%s+",          "" },
      { "^call%s+",         "" },
      { "^:%s*",            "" },
    },
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  keys = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>",   -- binding to scroll up inside the popup
  },
  win = {
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    wo = {
      winblend = 10
    }
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3,                    -- spacing between columns
    align = "left",                 -- align columns left, center or right
  },
  filter = function(mapping)
    -- example to exclude mappings without a description
    -- return mapping.desc and mapping.desc ~= ""
    return true
  end,
  show_help = true, -- show help message on the command line when the popup is visible
}

which_key.setup(setup)
which_key.add({
  {
    { "<leader>B",  "<cmd>Bdelete menu<CR>",                                                                                          desc = "Buffer quick menu",    nowait = true, remap = false },
    { "<leader>P",  "<cmd>lua require('telescope').extensions.projects.projects()<cr>",                                               desc = "Projects",             nowait = true, remap = false },
    { "<leader>a",  "<cmd>Alpha<cr>",                                                                                                 desc = "Alpha",                nowait = true, remap = false },
    { "<leader>b",  "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>", desc = "Buffers",              nowait = true, remap = false },
    { "<leader>cs", "<cmd>lua toggle_cspell()<CR>",                                                                                   desc = "Toggle cspell",        nowait = true, remap = false },
    { "<leader>e",  "<cmd>NvimTreeToggle<cr>",                                                                                        desc = "Explorer",             nowait = true, remap = false },
    { "<leader>f",  group = "Find",                                                                                                   nowait = true,                 remap = false },
    { "<leader>fB", ":Telescope marks<CR>",                                                                                           desc = "Find BookMark",        nowait = true, remap = false },
    { "<leader>fb", ":Telescope buffers<CR>",                                                                                         desc = "Buffer",               nowait = true, remap = false },
    { "<leader>fd", ":Telescope find_directories<CR>",                                                                                desc = "Directory",            nowait = true, remap = false },
    { "<leader>ff", ":Telescope find_files<CR>",                                                                                      desc = "File",                 nowait = true, remap = false },
    { "<leader>fh", ":Telescope help_tags<CR>",                                                                                       desc = "Help File",            nowait = true, remap = false },
    { "<leader>fo", ":Telescope oldfiles<CR>",                                                                                        desc = "Old File",             nowait = true, remap = false },
    { "<leader>fw", ":Telescope live_grep<CR>",                                                                                       desc = "Word",                 nowait = true, remap = false },
    { "<leader>h",  "<cmd>nohlsearch<CR>",                                                                                            desc = "No Highlight",         nowait = true, remap = false },
    { "<leader>l",  group = "LSP",                                                                                                    nowait = true,                 remap = false },
    { "<leader>lI", "<cmd>LspInstallInfo<cr>",                                                                                        desc = "Installer Info",       nowait = true, remap = false },
    { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",                                                               desc = "Workspace Symbols",    nowait = true, remap = false },
    { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>",                                                                         desc = "Code Action",          nowait = true, remap = false },
    { "<leader>ld", "<cmd>Telescope diagnostics<cr>",                                                                                 desc = "Document Diagnostics", nowait = true, remap = false },
    { "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<cr>",                                                                          desc = "Format",               nowait = true, remap = false },
    { "<leader>li", "<cmd>LspInfo<cr>",                                                                                               desc = "Info",                 nowait = true, remap = false },
    { "<leader>lj", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",                                                                    desc = "Next Diagnostic",      nowait = true, remap = false },
    { "<leader>lk", "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",                                                                    desc = "Prev Diagnostic",      nowait = true, remap = false },
    { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>",                                                                            desc = "CodeLens Action",      nowait = true, remap = false },
    { "<leader>lq", "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>",                                                                  desc = "Quickfix",             nowait = true, remap = false },
    { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>",                                                                              desc = "Rename",               nowait = true, remap = false },
    { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>",                                                                        desc = "Document Symbols",     nowait = true, remap = false },
    { "<leader>s",  group = "Search",                                                                                                 nowait = true,                 remap = false },
    { "<leader>sC", "<cmd>Telescope commands<cr>",                                                                                    desc = "Commands",             nowait = true, remap = false },
    { "<leader>sM", "<cmd>Telescope man_pages<cr>",                                                                                   desc = "Man Pages",            nowait = true, remap = false },
    { "<leader>sR", "<cmd>Telescope registers<cr>",                                                                                   desc = "Registers",            nowait = true, remap = false },
    { "<leader>sb", "<cmd>Telescope git_branches<cr>",                                                                                desc = "Checkout branch",      nowait = true, remap = false },
    { "<leader>sc", "<cmd>Telescope colorscheme<cr>",                                                                                 desc = "Colorscheme",          nowait = true, remap = false },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>",                                                                                   desc = "Find Help",            nowait = true, remap = false },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>",                                                                                     desc = "Keymaps",              nowait = true, remap = false },
    { "<leader>sr", "<cmd>Telescope oldfiles<cr>",                                                                                    desc = "Open Recent File",     nowait = true, remap = false },
    { "<leader>w",  "<cmd>w!<CR>",                                                                                                    desc = "Save",                 nowait = true, remap = false },
  }
})
--[[ which_key.register(mappings, opts) ]]
