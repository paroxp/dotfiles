-- omorfos Prism: the omorfos brand palette, matching the terminal colour
-- schemes (foot, Konsole) and the starship prompt.
-- The main background is left transparent so the terminal's own background
-- (and its opacity) shows through, as it does in the shell and tmux.
--
-- Brand roles: cyan is the main accent (selection, focus), orange marks what
-- needs attention (the cursor), and errors use coral red, never pink.

vim.cmd("highlight clear")
vim.o.background = "dark"
vim.g.colors_name = "omorfos"

local c = {
  bg = "#0c1226", -- navy
  surface0 = "#141c38", -- navy-2: raised surfaces
  surface1 = "#243364", -- navy-3: selection
  surface2 = "#34457e", -- borders and invisible characters, not text
  comment = "#7482b3", -- dimmest text the brand allows on navy
  muted = "#9aa4c7",
  fg = "#e6eaf5",
  orange = "#fb923c",
  black = "#141c38",
  red = "#f8616d",
  green = "#84cc16",
  yellow = "#facc15",
  blue = "#60a5fa",
  magenta = "#f472b6",
  cyan = "#22d3ee",
  white = "#b8c0de",
  bright_black = "#7482b3",
  bright_red = "#ff8a93",
  bright_green = "#a3e635",
  bright_yellow = "#fde047",
  bright_blue = "#93c5fd",
  bright_magenta = "#f9a8d4",
  bright_cyan = "#67e8f9",
  bright_white = "#f3f5fb",
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
  FloatTitle = { fg = c.cyan, bg = c.surface0, bold = true },
  FloatShadow = { bg = c.bg, blend = 80 },
  FloatShadowThrough = { bg = c.bg, blend = 100 },
  Cursor = { fg = c.bg, bg = c.orange },
  lCursor = { link = "Cursor" },
  TermCursor = { fg = c.bg, bg = c.orange },
  CursorLine = { bg = c.surface0 },
  CursorColumn = { bg = c.surface0 },
  CursorLineNr = { fg = c.cyan, bold = true },
  LineNr = { fg = c.comment },
  SignColumn = { fg = c.comment },
  FoldColumn = { fg = c.comment },
  Folded = { fg = c.muted, bg = c.surface0 },
  ColorColumn = { bg = c.surface0 },
  Conceal = { fg = c.muted },
  NonText = { fg = c.surface2 },
  SpecialKey = { fg = c.surface2 },
  Whitespace = { fg = c.surface2 },
  EndOfBuffer = { fg = c.bg },
  WinSeparator = { fg = c.surface2 },
  Visual = { bg = c.surface1 },
  Search = { fg = c.fg, bg = "#413f2d" },
  CurSearch = { fg = c.bg, bg = c.bright_yellow },
  IncSearch = { link = "CurSearch" },
  Substitute = { fg = c.bg, bg = c.magenta },
  MatchParen = { fg = c.orange, bg = c.surface1, bold = true },
  Directory = { fg = c.yellow, bold = true },
  Title = { fg = c.cyan, bold = true },
  QuickFixLine = { bg = c.surface1, bold = true },

  -- Status, tab and window bars
  StatusLine = { fg = c.fg, bg = c.surface0 },
  StatusLineNC = { fg = c.muted, bg = c.surface0 },
  TabLine = { fg = c.muted, bg = c.surface0 },
  TabLineFill = { bg = c.surface0 },
  TabLineSel = { fg = c.cyan, bold = true },
  WinBar = { fg = c.fg, bold = true },
  WinBarNC = { fg = c.muted },

  -- Popup menu
  Pmenu = { fg = c.fg, bg = c.surface0 },
  PmenuSel = { fg = c.bright_white, bg = c.surface1, bold = true },
  PmenuSbar = { bg = c.surface0 },
  PmenuThumb = { bg = c.surface2 },

  -- Messages
  ModeMsg = { fg = c.cyan, bold = true },
  MoreMsg = { fg = c.cyan },
  Question = { fg = c.cyan },
  ErrorMsg = { fg = c.red, bold = true },
  WarningMsg = { fg = c.yellow },
  NvimInternalError = { fg = c.bg, bg = c.red },

  -- Syntax
  Comment = { fg = c.comment, italic = true },
  Constant = { fg = c.orange },
  String = { fg = c.green },
  Character = { link = "String" },
  Identifier = { fg = c.fg },
  Function = { fg = c.blue },
  Statement = { fg = c.magenta },
  Operator = { fg = c.cyan },
  PreProc = { fg = c.cyan },
  Type = { fg = c.yellow },
  Special = { fg = c.cyan },
  Delimiter = { fg = c.white },
  Underlined = { underline = true },
  Error = { fg = c.bg, bg = c.red },
  Todo = { fg = c.bg, bg = c.yellow, bold = true },
  ["@variable"] = { fg = c.fg },
  ["@markup.strong"] = { bold = true },
  ["@markup.italic"] = { italic = true },
  ["@markup.underline"] = { underline = true },

  -- Diffs and version control
  Added = { fg = c.green },
  Changed = { fg = c.blue },
  Removed = { fg = c.red },
  DiffAdd = { bg = "#1f3023" },
  DiffChange = { bg = "#192a48" },
  DiffDelete = { fg = c.red, bg = "#362033" },
  DiffText = { bg = "#27416a" },

  -- Diagnostics
  DiagnosticError = { fg = c.red },
  DiagnosticWarn = { fg = c.yellow },
  DiagnosticInfo = { fg = c.cyan },
  DiagnosticHint = { fg = c.blue },
  DiagnosticOk = { fg = c.green },
  DiagnosticUnderlineError = { sp = c.red, undercurl = true },
  DiagnosticUnderlineWarn = { sp = c.yellow, undercurl = true },
  DiagnosticUnderlineInfo = { sp = c.cyan, undercurl = true },
  DiagnosticUnderlineHint = { sp = c.blue, undercurl = true },
  DiagnosticUnderlineOk = { sp = c.green, undercurl = true },
  DiagnosticDeprecated = { sp = c.comment, strikethrough = true },

  -- Spelling
  SpellBad = { sp = c.red, undercurl = true },
  SpellCap = { sp = c.yellow, undercurl = true },
  SpellLocal = { sp = c.green, undercurl = true },
  SpellRare = { sp = c.cyan, undercurl = true },
}

for name, spec in pairs(groups) do
  vim.api.nvim_set_hl(0, name, spec)
end
