return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      -- Remove the HLS package added by LazyVim's Haskell extra.
      opts.ensure_installed = vim.tbl_filter(function(package)
        return package ~= "haskell-language-server"
      end, opts.ensure_installed or {})
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- haskell-tools starts HLS; don't start a second client here.
        hls = { enabled = false },
      },
    },
  },

  {
    "mrcjkb/haskell-tools.nvim",
    init = function()
      vim.g.haskell_tools = vim.tbl_deep_extend("force", vim.g.haskell_tools or {}, {
        hls = {
          cmd = {
            vim.fn.expand("~/.ghcup/bin/haskell-language-server-wrapper"),
            "--lsp",
          },
        },
      })
    end,
  },
}
