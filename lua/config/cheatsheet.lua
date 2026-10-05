local M = {}

local helpers_path = vim.fn.stdpath("config") .. "/cheatsheet-defaults.md"
local namespace = vim.api.nvim_create_namespace("config.cheatsheet")
local column_gap = "     "
local left_gutter = "    "
local shortcut_key_width = 16

local function strip_inline_code(text)
  local stripped = text:gsub("`([^`]*)`", "%1")
  return stripped
end

local function is_table_separator(line)
  return line:match("^%s*|%s*:?-+:?%s*|") ~= nil
end

local function parse_table_row(line)
  if not line:match("^%s*|") then
    return nil
  end

  local cells = {}
  local row = line:gsub("^%s*|", ""):gsub("|%s*$", "")

  for cell in row:gmatch("([^|]+)") do
    cell = strip_inline_code(vim.trim(cell))
    table.insert(cells, cell)
  end

  return cells
end

local function render_table(rows, opts)
  opts = opts or {}
  local widths = {}

  for _, row in ipairs(rows) do
    for col, cell in ipairs(row) do
      widths[col] = math.max(widths[col] or 0, vim.fn.strdisplaywidth(cell))
    end
  end

  if opts.min_key_width then
    widths[1] = math.max(widths[1] or 0, opts.min_key_width)
  end

  local rendered = {}

  local function border(left, fill, join, right)
    local parts = {}
    for _, width in ipairs(widths) do
      table.insert(parts, string.rep(fill, width + 2))
    end
    return "  " .. left .. table.concat(parts, join) .. right
  end

  local function row_line(row)
    local parts = {}

    for col, cell in ipairs(row) do
      local padding = string.rep(" ", widths[col] - vim.fn.strdisplaywidth(cell))
      table.insert(parts, " " .. cell .. padding .. " ")
    end

    return "  │" .. table.concat(parts, "│") .. "│"
  end

  table.insert(rendered, border("╭", "─", "┬", "╮"))

  for index, row in ipairs(rows) do
    table.insert(rendered, row_line(row))

    if index == 1 then
      table.insert(rendered, border("├", "─", "┼", "┤"))
    end
  end

  table.insert(rendered, border("╰", "─", "┴", "╯"))

  return rendered
end

local function render_markdown(lines, opts)
  opts = opts or {}
  local rendered = {}
  local index = 1

  while index <= #lines do
    local line = lines[index]

    if line:match("^# ") then
      table.insert(rendered, strip_inline_code(line:gsub("^#%s+", "")):upper())
    elseif line:match("^## ") then
      table.insert(rendered, "")
      table.insert(rendered, strip_inline_code(line:gsub("^##%s+", "")):upper())
    elseif parse_table_row(line) and not is_table_separator(line) then
      local rows = {}

      while index <= #lines do
        local row = parse_table_row(lines[index])
        if not row then
          break
        end

        if not is_table_separator(lines[index]) then
          table.insert(rows, row)
        end

        index = index + 1
      end

      vim.list_extend(rendered, render_table(rows, opts))
      index = index - 1
    elseif line ~= "" then
      table.insert(rendered, strip_inline_code(line))
    end

    index = index + 1
  end

  return rendered
end

local function line_width(line)
  return vim.fn.strdisplaywidth(line)
end

local function pad_right(line, width)
  return line .. string.rep(" ", math.max(width - line_width(line), 0))
end

local function max_width(lines)
  local width = 0

  for _, line in ipairs(lines) do
    width = math.max(width, line_width(line))
  end

  return width
end

local function render_columns(left, right)
  local rendered = {}
  local left_width = max_width(left)
  local line_count = math.max(#left, #right)

  for index = 1, line_count do
    local left_line = left[index] or ""
    local right_line = right[index] or ""

    if right_line == "" then
      table.insert(rendered, left_line)
    else
      table.insert(rendered, pad_right(left_line, left_width) .. column_gap .. right_line)
    end
  end

  return rendered
end

local function add_left_gutter(lines)
  local rendered = {}

  for _, line in ipairs(lines) do
    table.insert(rendered, left_gutter .. line)
  end

  return rendered
end

local function setup_highlights()
  vim.api.nvim_set_hl(0, "CheatsheetTitle", { fg = "#fabd2f", bold = true })
  vim.api.nvim_set_hl(0, "CheatsheetLeader", { fg = "#83a598", italic = true })
  vim.api.nvim_set_hl(0, "CheatsheetSection", { fg = "#b8bb26", bold = true })
  vim.api.nvim_set_hl(0, "CheatsheetBorder", { fg = "#665c54" })
  vim.api.nvim_set_hl(0, "CheatsheetHeader", { fg = "#fe8019", bold = true })
  vim.api.nvim_set_hl(0, "CheatsheetKey", { fg = "#8ec07c", bold = true })
end

local function add_highlight(buf, line, group, start_col, end_col, priority)
  if end_col < 0 then
    end_col = #vim.api.nvim_buf_get_lines(buf, line, line + 1, false)[1]
  end

  vim.api.nvim_buf_set_extmark(buf, namespace, line, start_col, {
    end_col = end_col,
    hl_group = group,
    priority = priority or 100,
  })
end

local function find_pipes(line)
  local pipes = {}
  local start_at = 1

  while true do
    local pipe = line:find("│", start_at, true)
    if not pipe then
      return pipes
    end

    table.insert(pipes, pipe)
    start_at = pipe + #"│"
  end
end

local function highlight_table_rows(buf, row, line)
  local pipes = find_pipes(line)

  for index = 1, #pipes - 2, 3 do
    local key_start = pipes[index] + #"│"
    local key_end = pipes[index + 1] - 1
    add_highlight(buf, row, "CheatsheetKey", key_start, key_end, 300)
  end
end

local function highlight_border_chars(buf, row, line)
  local chars = { "╭", "╮", "╰", "╯", "├", "┤", "┬", "┴", "┼", "─", "│" }

  for _, char in ipairs(chars) do
    local start_at = 1

    while true do
      local start_col, end_col = line:find(char, start_at, true)
      if not start_col then
        break
      end

      add_highlight(buf, row, "CheatsheetBorder", start_col - 1, end_col, 250)
      start_at = end_col + 1
    end
  end
end

local function highlight_table_headers(buf, row, line)
  local start_at = 1

  while true do
    local start_col, end_col = line:find("Key", start_at, true)
    if not start_col then
      break
    end

    add_highlight(buf, row, "CheatsheetHeader", start_col - 1, end_col, 300)
    start_at = end_col + 1
  end

  start_at = 1
  while true do
    local start_col, end_col = line:find("Action", start_at, true)
    if not start_col then
      break
    end

    add_highlight(buf, row, "CheatsheetHeader", start_col - 1, end_col, 300)
    start_at = end_col + 1
  end
end

local function highlight_matches(buf, row, line, pattern, group, priority)
  local start_at = 1

  while true do
    local start_col, end_col = line:find(pattern, start_at)
    if not start_col then
      return
    end

    add_highlight(buf, row, group, start_col - 1, end_col, priority)
    start_at = end_col + 1
  end
end

local function apply_highlights(buf, lines)
  setup_highlights()
  vim.api.nvim_buf_clear_namespace(buf, namespace, 0, -1)

  for index, line in ipairs(lines) do
    local row = index - 1

    highlight_border_chars(buf, row, line)

    if line:find("NVIM SHORTCUT CHEAT SHEET", 1, true) then
      local start_col, end_col = line:find("NVIM SHORTCUT CHEAT SHEET", 1, true)
      add_highlight(buf, row, "CheatsheetTitle", start_col - 1, end_col, 300)
    end

    if line:find("DEFAULT NVIM HELPERS", 1, true) then
      local start_col, end_col = line:find("DEFAULT NVIM HELPERS", 1, true)
      add_highlight(buf, row, "CheatsheetTitle", start_col - 1, end_col, 300)
    end

    if line:find("leader = <Space>", 1, true) then
      local start_col, end_col = line:find("leader = <Space>", 1, true)
      add_highlight(buf, row, "CheatsheetLeader", start_col - 1, end_col, 300)
    end

    if line:match("^%s*%u[%u%s/]+") then
      local start_col, end_col = line:find("^%s*%u[%u%s/]+")
      add_highlight(buf, row, "CheatsheetSection", start_col - 1, end_col, 300)
    end

    for start_col, section in line:gmatch("()(" .. column_gap .. "%u[%u%s/]+)") do
      add_highlight(buf, row, "CheatsheetSection", start_col + #column_gap - 1, start_col + #section - 1, 300)
    end

    if line:find("│ Key", 1, true) then
      highlight_table_headers(buf, row, line)
    elseif line:find("│", 1, true) then
      highlight_table_rows(buf, row, line)
    end
  end
end

local sections = {
  { "Files / Search", { "<leader>f", "<leader>s", "<leader>e", "<leader>E", "<leader>/", "-" } },
  {
    "Navigation",
    { "s", "S", "<leader>a", "<leader>A", "<leader>1", "<leader>2", "<leader>3", "<leader>4", "<S-", "<C-" },
  },
  { "Buffers / Tabs", { "<leader>b", "<leader><Tab>" } },
  { "Git", { "<leader>g", "]h", "[h" } },
  { "LSP", { "<leader>l", "g", "K" } },
  { "Copilot", { "<leader>c", "<M-" } },
  { "Diagnostics / Trouble", { "<leader>x", "[d", "]d" } },
  { "Debug", { "<leader>d" } },
  { "Terminal / Session", { "<leader>t", "<leader>q", "<Esc><Esc>" } },
  { "UI", { "<leader>u" } },
}

local function section_of(lhs)
  for _, section in ipairs(sections) do
    for _, prefix in ipairs(section[2]) do
      if lhs:sub(1, #prefix) == prefix then
        return section[1]
      end
    end
  end
  return "Editing"
end

local function collect_keymaps(buf)
  local entries, order = {}, {}

  for _, mode in ipairs({ "n", "x", "t" }) do
    local maps = vim.api.nvim_get_keymap(mode)
    vim.list_extend(maps, vim.api.nvim_buf_get_keymap(buf, mode))

    for _, map in ipairs(maps) do
      local lhs = map.lhs:gsub("^ ", "<leader>")
      local user_defined = map.sid and map.sid > 0
      if map.desc and user_defined and not lhs:match("^<Plug>") then
        local id = lhs .. "\0" .. map.desc
        if not entries[id] then
          entries[id] = { lhs = lhs, desc = map.desc, modes = {} }
          table.insert(order, id)
        end
        entries[id].modes[mode] = true
      end
    end
  end

  local found = {}
  for _, id in ipairs(order) do
    local entry = entries[id]
    local desc = entry.desc
    if not entry.modes.n then
      desc = table.concat(vim.tbl_keys(entry.modes), "/") .. " " .. desc
    end
    local name = section_of(entry.lhs)
    found[name] = found[name] or {}
    table.insert(found[name], { entry.lhs, desc })
  end

  return found
end

-- Builds the shortcut table markdown from the live keymaps so it cannot drift.
local function generate_markdown(buf)
  local found = collect_keymaps(buf)
  local lines = { "# Nvim Shortcut Cheat Sheet", "", "`leader` = `<Space>`" }
  local order = { "Files / Search", "Navigation", "Buffers / Tabs", "Git", "LSP", "Copilot" }
  vim.list_extend(order, { "Diagnostics / Trouble", "Debug", "Terminal / Session", "UI", "Editing" })

  for _, name in ipairs(order) do
    local rows = found[name]
    if rows then
      table.sort(rows, function(a, b)
        return a[1] < b[1]
      end)
      vim.list_extend(lines, { "", "## " .. name, "", "| Key | Action |", "| --- | --- |" })
      for _, row in ipairs(rows) do
        table.insert(lines, ("| `%s` | %s |"):format(row[1], row[2]))
      end
    end
  end

  return lines
end

function M.open()
  local source_buf = vim.api.nvim_get_current_buf()
  vim.cmd("enew")
  local buf = vim.api.nvim_get_current_buf()

  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].buflisted = true
  vim.bo[buf].swapfile = false
  vim.bo[buf].filetype = "cheatsheet"
  vim.wo.number = false
  vim.wo.relativenumber = false
  vim.wo.signcolumn = "no"
  vim.wo.wrap = false

  vim.api.nvim_buf_set_name(buf, "Shortcut Cheat Sheet")
  local shortcuts = render_markdown(generate_markdown(source_buf), { min_key_width = shortcut_key_width })
  local helpers = render_markdown(vim.fn.readfile(helpers_path))
  local rendered = add_left_gutter(render_columns(shortcuts, helpers))
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, rendered)
  apply_highlights(buf, rendered)
  vim.bo[buf].modifiable = false
  vim.keymap.set("n", "q", "<cmd>bdelete<cr>", { buffer = buf, silent = true, desc = "Close cheat sheet" })
end

vim.api.nvim_create_user_command("Cheatsheet", M.open, { desc = "Open shortcut cheat sheet" })

return M
