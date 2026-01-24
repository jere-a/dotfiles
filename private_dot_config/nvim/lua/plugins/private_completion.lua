return {
  {
    "mfussenegger/nvim-dap-python",
    event = "VeryLazy",
    config = function()
      local ok, dap_python = pcall(require, "dap-python")
      if ok then
        dap_python.setup("python3")
      else
        vim.notify("Failed to load dap-python", vim.log.levels.ERROR)
      end
    end,
  },
}
