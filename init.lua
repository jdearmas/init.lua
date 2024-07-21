local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Example using a list of specs with the default options
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup({
  "gcmt/taboo.vim",
  "mattn/emmet-vim",
  "mbbill/undotree",
  "nvim-treesitter/nvim-treesitter-context",
  {
    "folke/twilight.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  {
    'MattesGroeger/vim-bookmarks',
    config = function()
      vim.g.bookmark_sign = '⚑'
      vim.g.bookmark_highlight_lines = 1
    end
  },
  "github/copilot.vim",
  "junegunn/goyo.vim",
  "chrisbra/NrrwRgn",
  "pocco81/true-zen.nvim",
  "yorickpeterse/nvim-window",
  'sbdchd/neoformat',
  "mtikekar/nvim-send-to-term",
  "lmburns/lf.nvim",
  {'ptzz/lf.vim', dependencies = { 'voldikss/vim-floaterm' }},
  {
    {
      "NeogitOrg/neogit",
      dependencies = {
        "nvim-lua/plenary.nvim", -- required
        "nvim-telescope/telescope.nvim", -- optional
        "sindrets/diffview.nvim", -- optional
        "ibhagwan/fzf-lua", -- optional
      },
      config = true
    },
    "folke/which-key.nvim",
    config = function() require("which-key").setup {} end
  },
  { "folke/neoconf.nvim",                      cmd = "Neoconf" },
  "folke/neodev.nvim",
  {'chomosuke/term-edit.nvim',
  lazy = false, -- or ft = 'toggleterm' if you use toggleterm.nvim
  version = '1.*',
},
{'VonHeikemen/fine-cmdline.nvim',
dependencies = {
  {'MunifTanjim/nui.nvim'}
}},
{
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  }
},
"williamboman/mason.nvim",
{
  "ray-x/go.nvim",
  dependencies = {  -- optional packages
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("go").setup()
  end,
  event = {"CmdlineEnter"},
  ft = {"go", 'gomod'},
  build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
},
"tpope/vim-fugitive",
"tpope/vim-dispatch",
'junegunn/fzf',
'junegunn/fzf.vim',
"williamboman/mason-lspconfig.nvim",
"jreybert/vimagit",
"tpope/vim-commentary",
{'akinsho/toggleterm.nvim', version = "*", config = true},
{'nvim-telescope/telescope.nvim'},
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-telescope/telescope-fzf-native.nvim' },
  'nvim-telescope/telescope-media-files.nvim',
  { 'VonHeikemen/lsp-zero.nvim', branch = 'v3.x' },
  { 'neovim/nvim-lspconfig' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/nvim-cmp' },
  {
    'nvim-treesitter/nvim-treesitter',
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query",
    "git_config",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "go",
    "html",
    "http",
    "javascript",
    "json",
    "markdown",
    "markdown_inline",
    "norg",
    "python",
    "rust",
    "sql",
    "toml",
    "xml",
    "yaml",
  }

},


{
  "nvim-neorg/neorg",
  build = ":Neorg sync-parsers",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("neorg").setup {
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/notes",
            },
            default_workspace = "notes",
          },
        },
      },
    }

    vim.wo.foldlevel = 99
    vim.wo.conceallevel = 2
  end,
},

{
  'nvim-orgmode/orgmode',
  dependencies = {
    { 'nvim-treesitter/nvim-treesitter', lazy = true },
  },
  event = 'VeryLazy',
  config = function()
    -- Load treesitter grammar for org
    require('orgmode').setup_ts_grammar()

    -- Setup treesitter
    require('nvim-treesitter.configs').setup({
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'org' },
      },
      ensure_installed = { 'org' },
    })

    -- Setup orgmode
    require('orgmode').setup({
      org_agenda_files = '~/org/**/*',
      org_default_notes_file = '~/org/refile.org',
    })
  end,
},

{
  "dstein64/vim-startuptime",
  -- lazy-load on a command
  cmd = "StartupTime",
  -- init is called during startup. Configuration for vim plugins typically should be set in an init function
  init = function()
    vim.g.startuptime_tries = 10
  end,
},
{
  "epwalsh/pomo.nvim",
  version = "*",  -- Recommended, use latest release instead of latest commit
  lazy = true,
  cmd = { "TimerStart", "TimerRepeat" },
  dependencies = {
    -- Optional, but highly recommended if you want to use the "Default" timer
    "rcarriga/nvim-notify",
  },
  opts = {
    -- See below for full list of options 👇
  },
},

})

-- Keybinding to open init.lua
vim.api.nvim_set_keymap('n', '<leader>e', ':edit ~/.config/nvim/init.lua<CR>', { noremap = true, silent = true })

local lsp_zero = require('lsp-zero')
lsp_zero.setup()

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  local opts = { buffer = bufnr, remap = false }
  lsp_zero.default_keymaps({ buffer = bufnr })
end)

require('mason').setup({
  PATH = "prepend",
})
require('mason-lspconfig').setup({
  ensure_installed = {
    'rust_analyzer',
    "clangd",
    "gopls",
    "lua_ls",
    "pylsp",
    "taplo",
    "lemminx",
    "terraformls"
  },
  handlers = {
    lsp_zero.default_setup,
  },
})


lsp_zero.setup_servers({ 'lua_ls', 'rust_analyzer' })

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({ select = false }),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Navigate between snippet placeholder
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),

    -- Scroll up and down in the completion documentation
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  })
})



lsp_zero.setup_servers({
  'tsserver',
  'rust_analyzer',
  "clangd",
  "dockerls",
  "eslint",
  "gopls",
  "graphql",
  "html",
  "jsonls",
  "lua_ls",
  "pylsp",
  "taplo",
  "lemminx",
  "yamlls",
})


-- Function to format Python buffer using black
-- Format the current buffer with black and return to original position
function format_with_black()
  local cur_pos = vim.fn.getpos('.') -- Save current cursor position

  vim.cmd('write')            -- Save the current buffer
  vim.cmd('silent! !black -q %') -- Run black on the current buffer
  vim.cmd('edit')             -- Reload the buffer to reflect changes

  vim.fn.setpos('.', cur_pos) -- Restore cursor position
end

-- Auto command to format Python buffers with black on save
vim.cmd('au BufWritePre *.py lua format_with_black()')

-- Set relative line numbers
vim.opt.number = true         -- Enable line numbers
vim.opt.relativenumber = true -- Enable relative line numbers



-- Folding configuration

-- Set folding method to 'indent'
vim.opt.foldmethod = 'indent'

-- Set initial fold level to 1
vim.opt.foldlevelstart = 1

-- Enable folding
vim.opt.foldenable = true

-- Other configurations ...

-- Configure 'makeprg' for Python
vim.cmd [[
autocmd FileType python setlocal makeprg=python3\ %
autocmd FileType python setlocal errorformat=%f:%l:\ %m
]]

-- Bind the function to a key
vim.api.nvim_set_keymap('n', '<leader>d', ":Dispatch<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>p', ":Make<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>q', ':copen<CR>', { noremap = true, silent = true })

-- Rest of your init.lua configurations...
require 'telescope'.setup {
  extensions = {
    fzf = {
      fuzzy = true, -- Enable fuzzy search
      override_generic_sorter = true, -- Override the generic sorter
      override_file_sorter = true, -- Override the file sorter
    }
  }
}

-- Load fzf-native extension
-- require'telescope'.load_extension('fzf')
vim.api.nvim_set_keymap('n', '<leader>fl', ':Telescope lsp_document_symbols<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fo', ':Telescope oldfiles<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fg', ':Telescope git_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fc', ':Rg<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>b', ':Telescope buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gf', ':Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gb', ':Telescope current_buffer_fuzzy_find<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gj', ':Telescope jumplist<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>go', ':Telescope vim_bookmarks all<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>t', ':SendHere<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gs', ':Neogit<CR>', { noremap = true, silent = true })


require("which-key").setup {
  show_help = true, -- Make sure the help message is shown (default)
  triggers = "auto", -- Automatically show the popup for a prefix key (default is "auto")
  -- ... other configurations ...
}

require('orgmode').setup_ts_grammar()

vim.api.nvim_set_keymap('n', '<leader>u', ':Lf<CR>', { noremap = true, silent = true })

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'hs', [[<C-\><C-n>]], opts)
  vim.keymap.set('n', 'f', ':f ', opts)

  -- vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  -- vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)

  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

require('fine-cmdline').setup({
  cmdline = {
    enable_keymaps = true,
    smart_history = true,
    prompt = ': '
  },
  popup = {
    position = {
      row = '50%',
      col = '50%',
    },
    size = {
      width = '60%',
    },
    border = {
      style = 'rounded',
    },
    win_options = {
      winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
    },
  },
  hooks = {
    before_mount = function(input)
      -- code
    end,
    after_mount = function(input)
      -- code
    end,
    set_keymaps = function(imap, feedkeys)
      -- code
    end
  }
})

set_keymaps = function(imap, feedkeys)
  local fn = require('fine-cmdline').fn

  imap('<M-k>', fn.up_search_history)
  imap('<M-j>', fn.down_search_history)
  imap('<Up>', fn.up_history)
  imap('<Down>', fn.down_history)
end

vim.api.nvim_set_keymap('n', ':', '<cmd>FineCmdline<CR>', {noremap = true})


vim.g.floaterm_width = 0.95
vim.g.floaterm_height = 0.95

-- Function to ask for a directory and then run :Files
local function fzf_files_with_input()
  local input = vim.fn.input("Enter directory: ", vim.fn.getcwd() .. "/", "dir")
  vim.cmd("Files " .. input)
end

-- Map the function to <leader>f
vim.api.nvim_set_keymap('n', '<leader>h', '', {
  noremap = true,
  silent = true,
  callback = fzf_files_with_input
})


vim.api.nvim_set_keymap('', '<leader>j', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', '<leader>k', '<C-w>k', { noremap = true, silent = true })

-- vim.opt.readonly = true

vim.cmd([[hi! link SignColumn Normal]])
vim.cmd([[hi! Folded ctermbg=0]])

vim.o.clipboard = "unnamedplus"

vim.api.nvim_set_keymap('n', '<leader>a', ':lua require("nvim-window").pick()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>w', ':set wrap!<CR>', { noremap = true, silent = true })

-- vim.cmd('autocmd BufReadPre * set readonly')

vim.api.nvim_create_user_command("DiagnosticToggle", function()
  local config = vim.diagnostic.config
  local vt = config().virtual_text
  config {
    virtual_text = not vt,
    underline = not vt,
    signs = not vt,
  }
end, { desc = "toggle diagnostic" })


require 'term-edit'.setup {
  -- Mandatory option:
  -- Set this to a lua pattern that would match the end of your prompt.
  -- Or a table of multiple lua patterns where at least one would match the
  -- end of your prompt at any given time.
  -- For most bash/zsh user this is '%$ '.
  -- For most powershell/fish user this is '> '.
  -- For most windows cmd user this is '>'.
  prompt_end = {windows='%$ ', bash='> '},
  -- How to write lua patterns: https://www.lua.org/pil/20.2.html
}


goto_or_create = function()
  local filename = vim.fn.expand("<cfile>")
  if vim.fn.filereadable(filename) == 1 then
    vim.cmd('edit ' .. filename)
  else
    vim.cmd('split ' .. filename)
    vim.cmd('write')
  end
end

vim.api.nvim_set_keymap('n','gf', ':lua goto_or_create()<CR>', { noremap=true, silent=true})
vim.api.nvim_set_keymap('n','<leader>m', ':Goyo 140<CR>', { noremap=true, silent=true})
-- Place this code in your Neovim configuration file (e.g., init.lua)

-- Assign the keybinding
vim.api.nvim_set_keymap('n', '<leader>i', ':new | terminal<CR>', { noremap = true, silent = true })

vim.opt.ignorecase = true

-- Set the keybinding
vim.api.nvim_set_keymap('n', '<leader>r', ':only<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader><leader>', ':w<CR>', { noremap = true, silent = true })

-- Define a custom highlight group for the border
vim.cmd("hi CustomVertSplit guibg=green")

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.softtabstop = 2
vim.opt.autoindent = true

-- Enable true color
vim.o.termguicolors = true


vim.api.nvim_set_hl(0, 'Folded', {bg = 'none'})

vim.api.nvim_set_keymap("n", "<leader>zn", ":TZNarrow<CR>", {})
vim.api.nvim_set_keymap("v", "<leader>zn", ":'<,'>TZNarrow<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>zf", ":TZFocus<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>zm", ":TZMinimalist<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>za", ":TZAtaraxis<CR>", {})

function copy_full_path_to_clipboard()
  local full_path = vim.fn.expand('%:p')  -- Gets the full path of the current file
  vim.fn.setreg('+', full_path)  -- Copies the full path to the clipboard
  print('Path copied to clipboard: ' .. full_path)  -- Optional: prints a confirmation message
end

vim.api.nvim_set_keymap('n', '<leader>cp', ':lua copy_full_path_to_clipboard()<CR>', { noremap = true, silent = true })


vim.api.nvim_set_keymap('n', '<leader>lr', ':luafile %<CR>', { noremap = true, silent = true })

-- :%s/\(\S\+\)\s\+\(\S\+\)/\1 \2\\r/g
vim.opt.autochdir = true
vim.opt.scrollback = 100000
-- vim.opt.scrollback = -1

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.lsp.handlers['textDocument/signatureHelp']  = vim.lsp.with(vim.lsp.handlers['signature_help'], {
  border = 'single',
  close_events = { "CursorMoved", "BufHidden" },
})
vim.keymap.set('i', '<c-s>', vim.lsp.buf.signature_help)
vim.keymap.set('n', '<space>nl', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'H', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

local diagnostics_active = false
vim.keymap.set('n', '<leader>tt', function()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.diagnostic.enable()
  else
    vim.diagnostic.disable()
  end
end)



require'nvim-treesitter.configs'.setup {
  -- Modules and its options go here
  highlight = { enable = true },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
}

vim.api.nvim_set_keymap('n', 'J', '<PageDown>',{})
vim.api.nvim_set_keymap('n', '<leader>s', ':split<CR>',{})
vim.api.nvim_set_keymap('n', 'K', '<PageUp>',{})

-- Set '7' to resize the window equally
vim.api.nvim_set_keymap('n', '7', '<C-w>=',{})
vim.api.nvim_set_keymap('n', '<leader>c', ':close<CR>',{})
vim.api.nvim_set_keymap('n', '<leader>=', ':%!jq .<CR>',{})
vim.api.nvim_set_keymap('n', '<leader>D', ":bd!<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tr', ":TabooRename<Space>", { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>tn', ":tabnew<CR>", { noremap = true })
vim.api.nvim_set_keymap('i', 'hs', "<esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', 'hu', "<esc>", { noremap = true, silent = true })
