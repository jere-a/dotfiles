return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      biome = {},
      cssls = {},
      --tsserver = false,
      --ts_ls = false,
      --denols = {},
      hyprls = {},
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
}
