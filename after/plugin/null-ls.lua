local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting

formatting.sources = {
    formatting.prettier,
    formatting.stylua
}

null_ls.setup({sources = sources})
