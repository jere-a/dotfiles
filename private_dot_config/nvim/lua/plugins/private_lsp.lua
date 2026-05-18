return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      cssls = {},
      tsserver = {
        enable = false,
      },
      ts_ls = {
        enable = false,
      },
      vtsls = {
        enable = false,
      },
      hyprls = {},
      ty = {},
      --harper_ls = {
      --  settings = {
      --    ["harper-ls"] = {
      --      linters = {
      --        SentenceCapitalization = false,
      --        SpellCheck = false,
      --      },
      --    },
      --  },
      --},
    },
  },
  {
    "stevearc/conform.nvim",
    ---@type conform.setupOpts
    opts = {
      formatters_by_ft = {
        javascript = { "oxfmt" },
        javascriptreact = { "oxfmt" },
        typescript = { "oxfmt" },
        typescriptreact = { "oxfmt" },
        json = { "oxfmt" },
        vue = { "oxfmt" },
      },
    },
  },
}
