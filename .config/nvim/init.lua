--[[
 _   _                 _
| \ | | ___  _____   _(_)_ __ ___
|  \| |/ _ \/ _ \ \ / / | '_ ` _ \
| |\  |  __/ (_) \ V /| | | | | | |
|_| \_|\___|\___/ \_/ |_|_| |_| |_|

Neovim config
]]

-- Paq plugins
local Paq = require("paq")
Paq {
	-- Paq itself
	"savq/paq-nvim",

	-- Libs
	"kyazdani42/nvim-web-devicons",
	"nvim-lua/plenary.nvim",

	-- QOL
	"tpope/vim-sensible",
	"tpope/vim-surround",
	'winston0410/cmd-parser.nvim',
	'winston0410/range-highlight.nvim',
	"jghauser/mkdir.nvim",
	"p00f/nvim-ts-rainbow",
	"steelsojka/pears.nvim",

	-- Fancy startup screen
	"mhinz/vim-startify",

	-- LSP and fancy related stuff
	"neovim/nvim-lspconfig",
	"folke/lsp-colors.nvim",
	"folke/lsp-trouble.nvim",

	-- Completion
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",

	-- Treesitter
	"nvim-treesitter/nvim-treesitter",
	
	-- Fancy diagrams
	"jbyuki/venn.nvim",

	-- Extra
	"ThePrimeagen/vim-be-good",
	"tamago324/lir.nvim",

	-- Acme style editing
	"Bowuigi/acme-nvim",
}

vim.cmd [[
augroup my-config
	autocmd!
	autocmd TermOpen * :setlocal nonu nornu
augroup END
]]

-- Helpers
local function map(mode, key, action)
	vim.api.nvim_set_keymap(mode, key, action, {noremap = true})
end

local function capitalize(str)
	return (str:gsub("^%l", string.upper))
end

-- venn: enable or disable keymappings
function Diagram()
	local venn_enabled = vim.inspect(vim.b.venn_enabled)
	if venn_enabled == "nil" then
		vim.b.venn_enabled = true
		vim.cmd "setlocal ve=all"
		vim.cmd "setlocal cursorline cursorcolumn"
		-- Draw a line on HJKL keystokes
		vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", {noremap = true})
		vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", {noremap = true})
		vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", {noremap = true})
		vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", {noremap = true})
		-- Draw a box by pressing "f" with visual selection
		vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", {noremap = true})
	else
		vim.cmd "setlocal ve="
		vim.cmd "mapclear <buffer>"
		vim.cmd "setlocal nocursorline nocursorcolumn"
		vim.b.venn_enabled = nil
	end
end

local modes = {
	['n']  = 'Normal',
	['no'] = 'N-Pending',
	['v']  = 'Visual',
	['V']  = 'V-Line',
	[''] = 'V-Block',
	['s']  = 'Select',
	['S']  = 'S-Line',
	[''] = 'S-Block',
	['i']  = 'Insert',
	['ic'] = 'Insert',
	['R']  = 'Replace',
	['Rv'] = 'V-Replace',
	['c']  = 'Command',
	['cv'] = 'Vim-Ex',
	['ce'] = 'Ex',
	['r']  = 'Prompt',
	['rm'] = 'More',
	['r?'] = 'Confirm',
	['!']  = 'Shell',
	['t']  = 'Terminal'
}

local function get_mode()
	local m=vim.fn.mode()

	for k,v in pairs(modes) do
		if m==k then
			return v
		end
	end

	return m
end

-- Neovim options
local options={
	autochdir = true;
	autowriteall = true;
	compatible = false;
	completeopt = "menuone,preview,noinsert,noselect";
	conceallevel = 2;
	cursorbind = false;
	cursorline = false;
	expandtab = false;
	fillchars = "vert:│,fold:-,stl: ,stlnc: ,diff:-";
	hidden = true;
	ignorecase = true;
	mouse = "a";
	number = true;
	relativenumber = true;
	shiftwidth = 4;
	shortmess = "c";
	showcmd = true;
	showmode = false;
	smartindent = true;
	spell = false;
	spelllang = {"en_us","es_es"};
	splitbelow = true;
	splitright = true;
	tabstop = 4;
	title = true;
	titlestring = "%F - Neovim";
	updatetime = 2000;
	wrap = false;
}

for key,value in pairs(options) do
	vim.opt[key]=value
end

-- Global settings
vim.g.mapleader=" "
-- Completion
vim.g.c_syntax_for_h = true

-- Stuff that is unimplemented
vim.cmd [[
	syntax enable
	color smyck
]]

-- Key (re)mappings
map("n", "ñ"               , ":")
map("n", "<leader>:"       , ":<Up><CR>")
map("n", "<leader>ñ"       , ":<Up><CR>")

-- Leader mappings
map("n", "<leader>h"       , "<Cmd>silent! ClangdSwitchSourceHeader<CR>")
map("n", "<leader>s"       , "<Cmd>silent set spell!<CR>")
map("n", "<leader>w"       , "<Cmd>silent set wrap!<CR>")
map("n", "<leader>c"       , "<Cmd>nohl<CR>")
map("n", "<leader>t"       , "<Cmd>tabs<CR>")
map("n", "<leader>b"       , "<Cmd>buffers<CR>")
map("n", "<leader>B"       , "<Cmd>bdelete<CR>")
map("n", "<leader>m"       , "<Cmd>silent tabnext<CR>")
map("n", "<leader>n"       , "<Cmd>silent tabprev<CR>")
map("n", "<leader>N"       , ":tabnew ")
map("n", "<leader><leader>", "<Cmd>w<CR>")

-- Plugin mappings
map("n", "<leader>l", "<Cmd>TroubleToggle<CR>")
map("n", "gR", "<Cmd>TroubleToggle lsp_references<CR>")
map("n", "<leader>d", "<Cmd>lua Diagram()<CR>")
map("n", "<CR>", "<Cmd>AcmeExec<CR>")
map("v", "<CR>", "<Cmd>AcmeExec<CR>")
map("n", "<leader>T", "<Cmd>AcmeTagline<CR>")

-- Term mode mappings
map("t", "<C-x><C-x>", "<C-\\><C-n>")
map("t", "<C-w>", "<C-x><C-x><C-w>")
map("t", "<A-h>", "<C-w>h")
map("t", "<A-j>", "<C-w>j")
map("t", "<A-k>", "<C-w>k")
map("t", "<A-l>", "<C-w>l")

-- Statusline
vim.cmd [[
	hi TablineBG            ctermbg=233   ctermfg=233
	hi TablineNormal        ctermbg=236   ctermfg=white
	hi TablineSel           ctermbg=27    ctermfg=white
	hi TablinePreSel        ctermbg=27    ctermfg=236
	hi TablinePostSel       ctermbg=236   ctermfg=27
	hi TablinePostSelB      ctermbg=233   ctermfg=27

	hi StatuslineBG         ctermbg=233   ctermfg=233
	hi StatuslineMode       ctermbg=10    ctermfg=black
	hi StatuslineModeR      ctermbg=27    ctermfg=10
	hi StatuslineFilename   ctermbg=27    ctermfg=white
	hi StatuslineFilenameR  ctermbg=233   ctermfg=27
	hi StatuslinePosition   ctermbg=39    ctermfg=black
	hi StatuslinePositionR  ctermbg=39    ctermfg=233
	hi StatuslinePositionR2 ctermbg=233   ctermfg=39
	hi StatuslineFiletype   ctermbg=77    ctermfg=black
	hi StatuslineFiletypeR  ctermbg=77    ctermfg=233

	" Lir
	hi LirFloatNormal   ctermbg=233
	hi LirDir           ctermfg=27
	hi LirSymLink       ctermfg=10
	hi LirEmptyDirText  ctermfg=0
]]

function getPowerSym()
	if (vim.env.TERM == "linux") then
		return ""
	end
	return ""
end

function Statusline()
	return  "%#StatuslineMode# "          .. -- Mode color
            get_mode()                    .. -- Mode
	        " %#StatuslineModeR#"         .. -- Mode color
            getPowerSym()                 .. -- Fancy symbols
            "%#StatuslineFilename#"       .. -- Color
            " %t "                        .. -- Filename
            "%m"                          .. -- Saved?
            "%#StatuslineFilenameR#"      .. -- Fancy symbols
	        getPowerSym()                 .. -- The actual symbol
	        "%#StatuslineBG#"             .. -- Background
	        "%="                          .. -- Change side
	        "%#StatuslinePositionR#"      .. -- More fancy symbols
	        getPowerSym()                 .. -- The actual symbol again
	        "%#StatuslinePosition#"       .. -- More color
	        " %c,%l "                     .. -- Position
	        "%#StatuslinePositionR2#"     .. -- Even more fancy symbols
	        getPowerSym()                 .. -- The actual symbol again
	        "%#StatuslineBG#  "           .. -- Space
	        "%#StatuslineFiletypeR#"      .. -- Even more fancy symbols
	        getPowerSym()                 .. -- The actual symbol again
	        "%#StatuslineFiletype# "      .. -- Even more color
            capitalize(vim.bo.filetype).." " -- Filetype
end

vim.opt.statusline="%!v:lua.Statusline()"

local icons=require('nvim-web-devicons')

function TabLabel(n)
	local b = vim.fn.tabpagebuflist(n)
	local w = vim.fn.tabpagewinnr(n)
	local f = vim.fn.bufname(b[w])
	local ftype = vim.fn.getbufvar(b[w], '&filetype')
	local btype = vim.fn.getbufvar(b[w], '&buftype')

	local icon=icons.get_icon(ftype)

	if icon~=nil then
		icon=icon.." "
	end
	icon=icon or ""

	if btype=="help" then
		return "Neovim Help"
	elseif ftype=="startify" then
		return "Startify"
	elseif f=="" then
		return "[No name]"
	end

	return icon..vim.fn.fnamemodify(f, ':t')
end

function Tabline()
	local s=""
	for i=1, vim.fn.tabpagenr('$') do
		if (i == vim.fn.tabpagenr()) then
			s=s.."%#TablineSel#"
		else
			s=s.."%#TablineNormal#"
		end
		s=s.." "..TabLabel(i).." "

		if (i == vim.fn.tabpagenr() and (i~=vim.fn.tabpagenr('$'))) then
			s=s.."%#TablinePostSel#"..""
		elseif (i+1 == vim.fn.tabpagenr()) then
			s=s.."%#TablinePreSel#"..""
		end
	end
	s=s.."%#TablineBG##%T"
	return s
end

vim.opt.tabline="%!v:lua.Tabline()"

-- Vim startify
vim.g.startify_bookmarks = {
	{ T = '~/tasks.st'},
	{ I = '~/.config/nvim/init.lua'},
	{ S = '~/.config/sxhkd/sxhkdrc' },
	{ B = '~/.config/bspwm/bspwmrc'},
	{ L = '~/.config/lemonbar/lemonbarrc'}
}
vim.g.startify_lists = {
	{ type = 'files',     header = {'   Files'}                      },
	{ type = 'dir',       header = {'   Files on '..vim.fn.getcwd()} },
	{ type = 'sessions',  header = {'   Sessions'}                   },
	{ type = 'bookmarks', header = {'   Bookmarks'}                  },
}

vim.g.startify_fortune_use_unicode = 1
vim.g.startify_session_persistence = 1

vim.cmd [[
let g:startify_custom_header = startify#pad(split(system('figlet -w 100 Neovim;echo "The best way to flex on VSCode users"'), "\n") + [""] + startify#fortune#boxed())
]]

-- LSP + completion
local lsp = require "lspconfig"
local cmp_capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

lsp.clangd.setup {
	capabilities = cmp_capabilities
}

-- Lua LSP
-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)
USER = vim.fn.expand('$USER')

local sumneko_root_path = ""
local sumneko_binary = ""

-- Assume Linux
sumneko_root_path = "/home/" .. USER .. "/.local/share/nvim/lua-language-server"
sumneko_binary = sumneko_root_path .."/bin/Linux/lua-language-server"

require'lspconfig'.sumneko_lua.setup {
	capabilities = cmp_capabilities,
	cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
				-- Setup your lua path
				path = vim.split(package.path, ';')
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` and `love` globals
				globals = {'vim', 'love'},
				disable = {
					'lowercase-global'
				}
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true}
			}
		}
	}
}

-- Treesitter and Rainbow parentheses
require'nvim-treesitter.configs'.setup {
	highlight = {
		enable = true,
		custom_captures = {},
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
	rainbow = {
		enable = false,
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
--		colors = {}, -- table of hex strings
--		termcolors = {} -- table of colour name strings
	}
}

-- Surround
--require("surround").setup {}

-- Range-highlight
require('range-highlight').setup{}

-- MKdir
require('mkdir')

-- Lir
local actions = require'lir.actions'
local mark_actions = require 'lir.mark.actions'
local clipboard_actions = require'lir.clipboard.actions'

require'lir'.setup {
	show_hidden_files = false,
	devicons_enable = true,
	mappings = {
		['l']     = actions.edit,
		['<C-s>'] = actions.split,
		['<C-v>'] = actions.vsplit,
		['<C-t>'] = actions.tabedit,
		['h']     = actions.up,
		['q']     = actions.quit,
		['K']     = actions.mkdir,
		['N']     = actions.newfile,
		['R']     = actions.rename,
		['@']     = actions.cd,
		['Y']     = actions.yank_path,
		['.']     = actions.toggle_show_hidden,
		['D']     = actions.delete,
		['J'] = function()
			mark_actions.toggle_mark()
			vim.cmd('normal! j')
		end,
		['C'] = clipboard_actions.copy,
		['X'] = clipboard_actions.cut,
		['P'] = clipboard_actions.paste,
	},
	float = {
		winblend = 0,
	},
	hide_cursor = true,
}

-- custom folder icon
require'nvim-web-devicons'.setup {}

-- use visual mode
function LirSettings()
	vim.api.nvim_buf_set_keymap(0, 'x', 'J', ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>', {noremap = true, silent = true})
	-- echo cwd
	vim.api.nvim_echo({{vim.fn.expand('%:p'), 'Normal'}}, false, {})
end

vim.cmd [[
	augroup lir-settings
		autocmd!
		autocmd Filetype lir :lua LirSettings()
	augroup END
]]

-- Pair matching with pears.nvim
require("pears").setup()

-- Vim-markdown highlighting
vim.g.markdown_fenced_languages = {'lua','c'}

-- Fancy quick fix list
require("trouble").setup {}

-- Completion
local cmp = require("cmp")

cmp.setup {
	-- No, I don't want snippets
	snippet = {expand = function(args) end},
	
	sources = cmp.config.sources({
		{name = 'nvim_lsp'},
		{name = 'path'}
	}, {{name = 'buffer'}})
}

cmp.setup.cmdline('/', {
	sourcess = {{name = 'buffer'}}
})

cmp.setup.cmdline(':', {
	sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}})
})

