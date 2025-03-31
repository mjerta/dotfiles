local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node
luasnip.add_snippets("lua", {
  s("hi", {
    t("hello, world"),
  }),
})
