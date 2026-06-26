-- 加载 nvchad 默认配置
local default_config = require "nvchad.configs.cmp"
local cmp = require "cmp"
local luasnip = require "luasnip"

-- Tab: 优先 supermaven，其次 luasnip；cmp 走 C-n/C-p + CR
local function tab_complete(fallback)
  local suggestion = require "supermaven-nvim.completion_preview"
  if suggestion.has_suggestion() then
    vim.schedule(function()
      suggestion.on_accept_suggestion()
    end)
  elseif luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  else
    fallback()
  end
end

local function shift_tab_complete(fallback)
  if cmp.visible() then
    cmp.select_prev_item()
  elseif luasnip.jumpable(-1) then
    luasnip.jump(-1)
  else
    fallback()
  end
end

local config = {
  mapping = {
    ["<Tab>"] = cmp.mapping(tab_complete, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(shift_tab_complete, { "i", "s" }),
    ["<C-c>"] = cmp.mapping.close(),
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp", priority = 1000 },
    { name = "luasnip", priority = 750 },
    { name = "nvim_lua", priority = 500 },
    { name = "async_path", priority = 300 },
  }, {
    { name = "buffer", priority = 200 },
  }),
}

return vim.tbl_deep_extend("force", default_config, config)
