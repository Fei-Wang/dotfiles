return {
  {
    "folke/sidekick.nvim",
    opts = {
      cli = {
        tools = {
          codex = {
            -- 去掉 "--search"
            cmd = { "codex" },
          },
        },
      },
    },
  },
}
