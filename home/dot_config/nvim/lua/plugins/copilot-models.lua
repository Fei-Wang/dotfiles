return {
  -- 1) Copilot Chat：固定为 GPT-5
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = {
      model = "gpt-5",
    },
  },

  -- 2) Copilot 补全：显式用 GPT-4.1（或留空走服务端默认）
  -- {
  --   "zbirenbaum/copilot.lua",
  --   opts = {
  --     copilot_model = "gpt-4.1",
  --   },
  -- },
}
