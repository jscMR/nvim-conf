-- ===============
-- Keybindings
-- ===============
global.mapleader = ','

local key_mapper = function(mode, key, result)
    map(mode, key, result, {
        noremap = true,
        silent = true
    })
end

key_mapper('', '<up>', '<nop>')
key_mapper('', '<down>', '<nop>')
key_mapper('', '<left>', '<nop>')
key_mapper('', '<right>', '<nop>')
key_mapper('i', 'jk', '<ESC>')
key_mapper('i', 'JK', '<ESC>')
key_mapper('i', 'jK', '<ESC>')
key_mapper('v', 'jk', '<ESC>')
key_mapper('v', 'JK', '<ESC>')
key_mapper('v', 'jK', '<ESC>')

-- NerdTRee

key_mapper('n', '<leader>n', ':NvimTreeToggle<CR>')

--[[ key_mapper('n', 'lt', ':IndentLinesToggle<CR>')
key_mapper('n', 't', ':TagbarToggle<CR>') ]]

key_mapper('n', '<leader>ff', ':Telescope find_files<CR>')
key_mapper('n', '<leader>fb', ':Telescope buffers<CR>')
key_mapper('n', '<leader>fh', ':Telescope help_tags<CR>')
key_mapper('n', '<C-P>', ':Telescope git_files hidden=true <CR>')
key_mapper('n', '<CS-f>', ':Telescope live_grep<CR>')

-- LSP
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function()
        local bufmap = function(mode, lhs, rhs)
            local opts = {
                buffer = true
            }
            vim.keymap.set(mode, lhs, rhs, opts)
        end

        bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
        bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
        bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
        bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
        bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
        bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
        bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
        bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
        bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
        bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')
        bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
        bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
        bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
    end
})
