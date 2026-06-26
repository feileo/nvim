local opts = {
  keymaps = {
    accept_suggestion = nil,    -- Tab 键由 cmp.lua 统一管理
    clear_suggestion = "<C-]>", -- Ctrl+] 清除建议
    accept_word = "<C-l>",      -- Ctrl+l 接受一个单词
  },
  ignore_filetypes = {
    "TelescopePrompt",
    "NvimTree",
    "dashboard",
    "lazy",
    "mason",
  },
  color = {
    suggestion_color = "#808080", -- 灰色显示 AI 建议
    cterm = 244,
  },
  log_level = "info",                -- 设置为 "off" 可以完全禁用日志
  disable_inline_completion = false, -- 保持灰色内联补全（类 Cursor）
  disable_keymaps = false,           -- 保持部分快捷键
}

return opts
