local M = {}

local lines = {
  "NVIM SHORTCUT CHEAT SHEET",
  "leader = <Space>",
  "",
  "FILES / SEARCH",
  "  <leader>ff    Find files",
  "  <leader>fg    Live grep",
  "  <leader>fb    Buffers",
  "  <leader>fr    Recent files",
  "  <leader>fh    Help tags",
  "  <leader>fc    Commands",
  "  <leader>fk    Keymaps",
  "  <leader>e     Toggle explorer",
  "  <leader>E     Reveal current file in explorer",
  "",
  "BUFFERS / WINDOWS",
  "  <S-h>         Previous buffer",
  "  <S-l>         Next buffer",
  "  <leader>bd    Delete buffer",
  "  <C-h>         Go to left window",
  "  <C-j>         Go to lower window",
  "  <C-k>         Go to upper window",
  "  <C-l>         Go to right window",
  "",
  "GIT",
  "  <leader>gg    LazyGit",
  "  <leader>gb    Blame line",
  "  <leader>gd    Diff this",
  "  <leader>gp    Preview hunk",
  "  <leader>gs    Stage hunk",
  "  <leader>gr    Reset hunk",
  "  ]h            Next hunk",
  "  [h            Previous hunk",
  "",
  "LSP",
  "  gd            Go to definition",
  "  gD            Go to declaration",
  "  gr            References",
  "  gI            Go to implementation",
  "  K             Hover docs",
  "  <leader>la    Code action",
  "  <leader>lr    Rename",
  "  <leader>lf    Format",
  "  <leader>ls    Document symbols",
  "  <leader>lS    Workspace symbols",
  "",
  "DIAGNOSTICS / TROUBLE",
  "  [d            Previous diagnostic",
  "  ]d            Next diagnostic",
  "  <leader>ld    Line diagnostics",
  "  <leader>xx    Workspace diagnostics",
  "  <leader>xX    Buffer diagnostics",
  "  <leader>xs    Symbols",
  "  <leader>xl    LSP references / location list",
  "  <leader>xq    Quickfix list",
  "  <leader>xt    Todo comments",
  "",
  "DEBUG",
  "  <leader>db    Toggle breakpoint",
  "  <leader>dc    Continue",
  "  <leader>di    Step into",
  "  <leader>do    Step over",
  "  <leader>dO    Step out",
  "  <leader>dr    DAP REPL",
  "  <leader>dt    Terminate",
  "",
  "EDITING",
  "  gc            Comment line/block",
  "  gb            Block comment",
  "  ys            Add surround",
  "  ds            Delete surround",
  "  cs            Change surround",
  "  <leader>w     Write",
  "  <leader>h     Clear search highlight",
  "",
  "TERMINAL / SESSION",
  "  <Esc><Esc>    Exit terminal mode",
  "  <leader>qq    Quit all",
  "  q             Close help, quickfix, checkhealth, and similar windows",
  "",
  "CHEAT SHEET BUFFER",
  "  j/k           Scroll normally",
  "  <C-d>/<C-u>   Half-page down/up",
  "  gg/G          Top/bottom",
  "  q             Close this sheet",
}

function M.open()
  vim.cmd("tabnew")
  local buf = vim.api.nvim_get_current_buf()
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].buflisted = false
  vim.bo[buf].swapfile = false
  vim.bo[buf].filetype = "help"
  vim.wo.number = false
  vim.wo.relativenumber = false
  vim.wo.signcolumn = "no"
  vim.wo.wrap = false

  vim.api.nvim_buf_set_name(buf, "Shortcut Cheat Sheet")
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.keymap.set("n", "q", "<cmd>tabclose<cr>", { buffer = buf, silent = true, desc = "Close cheat sheet" })
end

vim.api.nvim_create_user_command("Cheatsheet", M.open, { desc = "Open shortcut cheat sheet" })

return M
