return {
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    ---@type snacks.Config
    opts = {
      indent = { enabled = true },
      notifier = { enabled = true },
      scope = { enabled = true },
      statuscolumn = { enabled = true }, -- we set this in options.lua
      words = { enabled = true },
      dashboard = {
        formats = {
          key = function(item)
            return {
              { "[", hl = "special" },
              { item.key, hl = "key" },
              { "]", hl = "special" }
            }
          end,
        },
        sections = {
          { section = "terminal", cmd = "fortune -s | cowsay", hl = "header", height = 12, padding = 1, indent = 8 },
          { title = "MRU", padding = 1 },
          { section = "recent_files", limit = 8, padding = 1 },
          { title = "Sessions", padding = 1 },
          { section = "projects", padding = 1 },
          { title = "Bookmarks", padding = 1 },
          { section = "keys" },
          { section = "startup" },
        },
      },
    },
  }
}
