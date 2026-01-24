return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      biome = {},
      --tsserver = false,
      --ts_ls = false,
      denols = {},
      hyprls = {},
      harper_ls = {
        settings = {
          ["harper-ls"] = {
            linters = {
              SentenceCapitalization = false,
              SpellCheck = false,
            },
          },
        },
      },
    },
  },
}
