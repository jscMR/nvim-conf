-- ===============
-- Plugins
-- ===============
-- Neovim to automatically run :PackerCompile
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- ensure that packer is installed
--[[ local install_path = fn.stdpath('data').."\site\pack\packer\opt\packer.nvim"
 if fn.empty(fn.glob(install_path)) > 0 then
    cmd('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    cmd 'packadd packer.nvim'
    print("No instalado el Packer")
 end ]]

vim.cmd('packadd packer.nvim')

local packer = require 'packer'
local util = require 'packer.util'

packer.init({
    package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})

--- startup and add configure plugins
packer.startup(function()

    local use = use

    -- Package manager
    use 'wbthomason/packer.nvim'

    use 'nvim-treesitter/nvim-treesitter'
    use 'sheerun/vim-polyglot'

    -- Dev Icons
    use 'kyazdani42/nvim-web-devicons'

    -- Themes!
    use 'tjdevries/colorbuddy.nvim'
    use 'bkegley/gloombuddy'
    use {'Mofiqul/dracula.nvim'} -- colorscheme

    -- Tema inspirado en Atom
    use 'joshdick/onedark.vim'

    -- sneaking some formatting in here too
    use {
        'prettier/vim-prettier',
        run = 'yarn install'
    }

    -- lua line
    use {
        'nvim-lualine/lualine.nvim',
        requires = {
            'kyazdani42/nvim-web-devicons',
            opt = true
        }
    }

    use({
        'noib3/nvim-cokeline',
        requires = 'kyazdani42/nvim-web-devicons', -- If you want devicons
        config = function()
            require('cokeline').setup({
                -- Only show the bufferline when there are at least this many visible buffers.
                -- default: `1`.
                show_if_buffers_are_at_least = 2
            })
        end
    })

    -- [[ Dev ]]
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.0',
        requires = {{'nvim-lua/plenary.nvim'}}
    }
    use 'nvim-lua/popup.nvim'
    use 'jremmen/vim-ripgrep'

    use {'majutsushi/tagbar'} -- code structure
    use {'Yggdroot/indentLine'} -- see indentation
    use {'tpope/vim-fugitive'} -- git integration
    use {'junegunn/gv.vim'} -- commit history
    use {'windwp/nvim-autopairs'}

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'anott03/nvim-lspinstall'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'hrsh7th/cmp-nvim-lsp'

    -- Completion
    use {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        opt = true,
        wants = {"LuaSnip"},
        requires = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lua",
            "ray-x/cmp-treesitter",
            "hrsh7th/cmp-cmdline",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-calc",
            "f3fora/cmp-spell",
            "hrsh7th/cmp-emoji",
            {
                "L3MON4D3/LuaSnip",
                wants = "friendly-snippets",
            },
            "rafamadriz/friendly-snippets",
            disable = false
        }
    }

    -- NerdTree
    use { -- filesystem navigation
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons',
            opt = true
        } -- filesystem icons
    }

    if install_plugins then
        require('packer').sync()
    end
end)

if install_plugins then
    return
end

require'nvim-web-devicons'.setup {}

-- ===============
-- TreeSitter
-- ===============
-- global.colors_name = 'gloombuddy'
local configs = require 'nvim-treesitter.configs'
configs.setup {
    ensure_installed = {"lua", "javascript", "typescript", "html", "css", "rust"},
    highlight = {
        enable = true,
        use_languagetree = true
    }
}

-- ===============
-- LuaLine
-- ===============
require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'dracula-nvim',
        component_separators = {
            left = '',
            right = ''
        },
        section_separators = {
            left = '',
            right = ''
        },
        disabled_filetypes = {
            statusline = {},
            winbar = {}
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000
        }
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}

-- NerdTree
require('nvim-tree').setup {}

require('nvim-autopairs').setup {}

-- Telescope
require('telescope').setup {}
-- require('telescope').load_extension('fzf')


---
-- Diagnostics
---

local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = '✘'})
sign({name = 'DiagnosticSignWarn', text = '▲'})
sign({name = 'DiagnosticSignHint', text = '⚑'})
sign({name = 'DiagnosticSignInfo', text = ''})

vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {border = 'rounded'}
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {border = 'rounded'}
)

---
-- LSP config
---

require('mason').setup({})
require('mason-lspconfig').setup({})

local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)


---
-- LSP servers
---

lspconfig.tsserver.setup({})
lspconfig.html.setup({})
lspconfig.cssls.setup({})
lspconfig.sumneko_lua.setup({})

---
-- Autocomplete
---
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

require('luasnip.loaders.from_vscode').lazy_load()

local cmp = require('cmp')
local luasnip = require('luasnip')

local select_opts = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp', keyword_length = 3},
    {name = 'buffer', keyword_length = 3},
    {name = 'luasnip', keyword_length = 2},
  },
  window = {
    documentation = cmp.config.window.bordered()
  },
  formatting = {
    fields = {'menu', 'abbr', 'kind'},
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = 'λ',
        luasnip = '⋗',
        buffer = 'Ω',
        path = '🖫',
      }

      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
  mapping = {
    ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
    ['<Down>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
    ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),

    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    ['<C-d>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, {'i', 's'}),

    ['<C-b>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {'i', 's'}),

    ['<Tab>'] = cmp.mapping(function(fallback)
      local col = vim.fn.col('.') - 1

      if cmp.visible() then
        cmp.select_next_item(select_opts)
      elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        fallback()
      else
        cmp.complete()
      end
    end, {'i', 's'}),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item(select_opts)
      else
        fallback()
      end
    end, {'i', 's'}),
  },
})