return {
  {
    "folke/sidekick.nvim",
    opts = {
      cli = {
        -- 去掉默认的 --search
        tools = {
          codex = { cmd = { "codex" } },
        },
        -- 定义 Commit 预设
        prompts = {
          commit = "Commit staged changes using Commitizen convention.",
        },
      },
    },
  },
}
