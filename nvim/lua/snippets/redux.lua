local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

return {
  s(
    "reduxsl",
    fmt(
      [[
import {{ createSlice }} from '@reduxjs/toolkit';

export const {} = createSlice({{
    name: '{}',
    initialState: {{
        counter: 10
    }},
    reducers: {{
        increment: (state /* action */) => {{
            // Redux Toolkit allows us to write "mutating" logic in reducers.
            // It doesn't actually mutate the state because it uses Immer.
            state.counter += 1;
        }},
    }}
}});

export const {{ increment }} = {}.actions;
  ]],
      {
        i(1, "templateSlice"), -- nombre de la constante
        i(2, "name"), -- name del slice
        rep(1), -- reuse el nombre del slice abajo
      }
    )
  ),
}
