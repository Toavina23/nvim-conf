local lsp = require('lsp-zero').preset("recommended")
lsp.ensure_installed({ 'tsserver', 'eslint' ,'rust_analyzer'})

local cmp = require('cmp')
local smp_select = { behavior =  cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-y>'] = cmp.mapping.confirm({select = true}),
	['<C-Space>'] = cmp.mapping.complete(),
})
lsp.setup_nvim_cmp({ mapping = cmp_mappings}) 
lsp.on_attach(function(client, bufnr) 
    if client.name == "tsserver" then 
        client.server_capabilities.document_formatting = false
    end
	local opts = {buffer = bufnr, remap = false}
	vim.keymap.set("n", "gd" , function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>vws",  function() vim.lsp.buf.workspace_symblol() end , opts)
	vim.keymap.set("n", "<leader>vd", function() vim.lsp.buf.open_float() end, opts)
	vim.keymap.set("n", "[d", function() vim.lsp.buf.goto_next() end, opts)
	vim.keymap.set("n", "]d", function() vim.lsp.buf.goto_prev() end, opts)
	vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.remove() end, opts)
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    vim.cmd[[ command! Format execute 'lua vim.lsp.buf.format()']]
end)
-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()
