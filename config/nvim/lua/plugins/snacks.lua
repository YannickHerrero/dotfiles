return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    picker = { enabled = true },
    explorer = { enabled = true },
    bigfile = { enabled = true },
    quickfile = { enabled = true },
  },
  keys = {
    { "<leader> ", function() Snacks.picker.files() end, desc = "find file" },
    { "<leader>sg", function() Snacks.picker.grep() end, desc = "live grep" },
    { "<leader>e", function() Snacks.explorer() end, desc = "file explorer" },
  },
}
