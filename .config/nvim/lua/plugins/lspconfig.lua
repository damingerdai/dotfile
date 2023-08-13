return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            { 'williamboman/mason.nvim', config = true, cmd = "Mason" },
            'williamboman/mason-lspconfig.nvim',
            -- Useful status updates for LSP
            { 'j-hui/fidget.nvim', config = true },
            -- Additional lua configuration, makes nvim stuff amazing
            { 'folke/neodev.nvim', config = true },
            'hrsh7th/cmp-nvim-lsp',
        },
    }
}