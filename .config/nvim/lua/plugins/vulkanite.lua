return {
  "kyerpotts/vulkanite.nvim",
  name = "vulkanite.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    -- For initial visual QA, force every bundled integration on.
    -- Remove this later to test package-manager auto-detection.
    -- plugins = { all = true },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vulkanite",
    },
  },
}
