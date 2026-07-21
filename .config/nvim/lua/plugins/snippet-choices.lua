return {
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      local function change_choice(direction)
        return function()
          local luasnip = require("luasnip")
          if luasnip.choice_active() then
            luasnip.change_choice(direction)
            return true
          end
        end
      end

      opts.keymap["<C-n>"] = { change_choice(1), "select_next", "fallback" }
      opts.keymap["<C-p>"] = { change_choice(-1), "select_prev", "fallback" }
    end,
  },
}
