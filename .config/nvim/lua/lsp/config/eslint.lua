local util = require('lsp.config.util')

local root_file = {
    '.eslintrc',
    '.eslintrc.js',
    '.eslintrc.cjs',
    '.eslintrc.yaml',
    '.eslintrc.yml',
    '.eslintrc.json',
    'eslint.config.js',
    'package.json',
}

require'lspconfig'.eslint.setup{
    root_dir = function(fname)
        root_file = util.insert_package_json(root_file, 'eslintConfig', fname)
        return util.root_pattern(unpack(root_file))(fname)
      end,
}

local eslint_config = require("lspconfig.server_configurations.eslint")

lspconfig.eslint.setup {
    opts.cmd = { "yarn", "exec", unpack(eslint_config.default_config.cmd) }
}