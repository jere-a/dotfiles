return {
  {
    "vyfor/cord.nvim",
    build = ":Cord update",
    opts = function()
      return {
        display = {
          theme = "default",
          flavor = "accent",
        },
        lazy = {
          icon = require("cord.api.icon").get("keyboard"),
        },
        text = {
          workspace = function(opts)
            local hour = tonumber(os.date("%H"))
            local status = hour >= 22 and "🌙 Late night coding"
              or hour >= 18 and "🌆 Evening session"
              or hour >= 12 and "☀️ Afternoon coding"
              or hour >= 5 and "🌅 Morning productivity"
              or "🌙 Midnight hacking"

            return string.format("%s: %s", status, opts.filename)
          end,
        },
      }
    end,
  },
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {
      -- add options here
      -- or leave it empty to use the default settings
    },
    keys = {
      -- suggested keymap
      { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
  },
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts.dashboard.preset.header = [[
	  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
	  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
	  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
	  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
	  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
	  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
      ]]
    end,
  },
  { 
    "wakatime/vim-wakatime", 
    lazy = false,
    event = "VeryLazy",
  },
}

