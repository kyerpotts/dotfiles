return {
  "kyerpotts/vulkanite.nvim",
  branch = "vulkanite-mvp",
  name = "vulkanite.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    -- For initial visual QA, force every bundled integration on.
    -- Remove this later to test package-manager auto-detection.
    -- plugins = { all = true },
  },
  config = function(_, opts)
    require("vulkanite").setup(opts)
    vim.cmd.colorscheme("vulkanite")
  end,
}
