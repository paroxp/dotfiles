-- Honukai: matches the Konsole colour scheme in
-- ~/.local/share/konsole/Honukai.colorscheme and the starship prompt.
-- The main background is left transparent so the terminal's own background
-- (and its opacity) shows through, as it does in the shell and tmux.

vim.cmd("highlight clear")
vim.o.background = "dark"
vim.g.colors_name = "honukai"

local c = {
  bg = "#111625",
  surface0 = "#1a2032",
  surface1 = "#252d45",
  surface2 = "#3a4462",
  muted = "#747b96",
  fg = "#babcc8",
  black = "#000000",
  red = "#dd5030",
  green = "#6cbd3a",
  yellow = "#e6d72d",
  blue = "#2670fc",
  magenta = "#f258b9",
  cyan = "#38b2da",
  white = "#bbbbbb",
  bright_black = "#555555",
  bright_red = "#e17f64",
  bright_green = "#7fba5a",
  bright_yellow = "#ffff55",
  bright_blue = "#5d8ff3",
  bright_magenta = "#fa83c0",
  bright_cyan = "#78cee7",
  bright_white = "#ffffff",
}

-- :terminal uses the same ANSI palette as the terminal emulator
local ansi = {
  c.black, c.red, c.green, c.yellow, c.blue, c.magenta, c.cyan, c.white,
  c.bright_black, c.bright_red, c.bright_green, c.bright_yellow,
  c.bright_blue, c.bright_magenta, c.bright_cyan, c.bright_white,
}
for i, colour in ipairs(ansi) do
  vim.g["terminal_color_" .. (i - 1)] = colour
end

---@type table<string, vim.api.keyset.highlight>
local groups = {
  -- Editor
  Normal = { fg = c.fg },
  NormalFloat = { fg = c.fg, bg = c.surface0 },
  FloatBorder = { fg = c.surface2, bg = c.surface0 },
  FloatTitle = { fg = c.yellow, bg = c.surface0, bold = true },
  FloatShadow = { bg = c.black, blend = 80 },
  FloatShadowThrough = { bg = c.black, blend = 100 },
  Cursor = { fg = c.bg, bg = c.fg },
  lCursor = { link = "Cursor" },
  TermCursor = { reverse = true },
  CursorLine = { bg = c.surface0 },
  CursorColumn = { bg = c.surface0 },
  CursorLineNr = { fg = c.yellow, bold = true },
  LineNr = { fg = c.surface2 },
  SignColumn = { fg = c.surface2 },
  FoldColumn = { fg = c.surface2 },
  Folded = { fg = c.muted, bg = c.surface0 },
  ColorColumn = { bg = c.surface0 },
  Conceal = { fg = c.muted },
  NonText = { fg = c.surface2 },
  SpecialKey = { fg = c.surface2 },
  Whitespace = { fg = c.surface2 },
  EndOfBuffer = { fg = c.bg },
  WinSeparator = { fg = c.surface2 },
  Visual = { bg = c.surface1 },
  Search = { fg = c.fg, bg = "#4a4416" },
  CurSearch = { fg = c.bg, bg = c.yellow },
  IncSearch = { link = "CurSearch" },
  Substitute = { fg = c.bg, bg = c.magenta },
  MatchParen = { fg = c.yellow, bg = c.surface1, bold = true },
  Directory = { fg = c.yellow, bold = true },
  Title = { fg = c.yellow, bold = true },
  QuickFixLine = { bg = c.surface1, bold = true },

  -- Status, tab and window bars
  StatusLine = { fg = c.fg, bg = c.surface0 },
  StatusLineNC = { fg = c.muted, bg = c.surface0 },
  TabLine = { fg = c.muted, bg = c.surface0 },
  TabLineFill = { bg = c.surface0 },
  TabLineSel = { fg = c.yellow, bold = true },
  WinBar = { fg = c.fg, bold = true },
  WinBarNC = { fg = c.muted },

  -- Popup menu
  Pmenu = { fg = c.fg, bg = c.surface0 },
  PmenuSel = { fg = c.bright_white, bg = c.surface1, bold = true },
  PmenuSbar = { bg = c.surface0 },
  PmenuThumb = { bg = c.surface2 },

  -- Messages
  ModeMsg = { fg = c.green, bold = true },
  MoreMsg = { fg = c.cyan },
  Question = { fg = c.cyan },
  ErrorMsg = { fg = c.red, bold = true },
  WarningMsg = { fg = c.yellow },
  NvimInternalError = { fg = c.bright_white, bg = c.red },

  -- Syntax
  Comment = { fg = c.muted, italic = true },
  Constant = { fg = c.bright_red },
  String = { fg = c.green },
  Character = { link = "String" },
  Identifier = { fg = c.fg },
  Function = { fg = c.bright_blue },
  Statement = { fg = c.magenta },
  Operator = { fg = c.cyan },
  PreProc = { fg = c.cyan },
  Type = { fg = c.yellow },
  Special = { fg = c.cyan },
  Delimiter = { fg = c.fg },
  Underlined = { underline = true },
  Error = { fg = c.bright_white, bg = c.red },
  Todo = { fg = c.bg, bg = c.yellow, bold = true },
  ["@variable"] = { fg = c.fg },
  ["@markup.strong"] = { bold = true },
  ["@markup.italic"] = { italic = true },
  ["@markup.underline"] = { underline = true },

  -- Diffs and version control
  Added = { fg = c.green },
  Changed = { fg = c.cyan },
  Removed = { fg = c.red },
  DiffAdd = { bg = "#1d3320" },
  DiffChange = { bg = "#1b2a48" },
  DiffDelete = { fg = c.red, bg = "#3a1c1f" },
  DiffText = { bg = "#2a4378" },

  -- Diagnostics
  DiagnosticError = { fg = c.red },
  DiagnosticWarn = { fg = c.yellow },
  DiagnosticInfo = { fg = c.cyan },
  DiagnosticHint = { fg = c.bright_blue },
  DiagnosticOk = { fg = c.green },
  DiagnosticUnderlineError = { sp = c.red, undercurl = true },
  DiagnosticUnderlineWarn = { sp = c.yellow, undercurl = true },
  DiagnosticUnderlineInfo = { sp = c.cyan, undercurl = true },
  DiagnosticUnderlineHint = { sp = c.bright_blue, undercurl = true },
  DiagnosticUnderlineOk = { sp = c.green, undercurl = true },
  DiagnosticDeprecated = { sp = c.muted, strikethrough = true },

  -- Spelling
  SpellBad = { sp = c.red, undercurl = true },
  SpellCap = { sp = c.yellow, undercurl = true },
  SpellLocal = { sp = c.green, undercurl = true },
  SpellRare = { sp = c.cyan, undercurl = true },
}

for name, spec in pairs(groups) do
  vim.api.nvim_set_hl(0, name, spec)
end
