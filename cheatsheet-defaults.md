# Default Nvim Helpers

## Movement

| Key | Action |
| --- | --- |
| `h` / `j` / `k` / `l` | Left / down / up / right |
| `w` / `b` | Next / previous word |
| `e` | End of word |
| `0` / `^` / `$` | Line start / first text / end |
| `gg` / `G` | Top / bottom of file |
| `{` / `}` | Previous / next paragraph |

## Editing

| Key | Action |
| --- | --- |
| `i` / `a` | Insert before / after cursor |
| `I` / `A` | Insert at line start / end |
| `o` / `O` | New line below / above |
| `x` | Delete character |
| `dd` / `yy` / `p` | Delete / yank / paste line |
| `u` / `<C-r>` | Undo / redo |

## Operators

| Key | Action |
| --- | --- |
| `d{motion}` | Delete by motion |
| `y{motion}` | Yank by motion |
| `c{motion}` | Change by motion |
| `v` / `V` / `<C-v>` | Visual / line / block mode |
| `>` / `<` | Indent / dedent selection |
| `.` | Repeat last change |

## Search / Replace

| Key | Action |
| --- | --- |
| `/` / `?` | Search forward / backward |
| `n` / `N` | Next / previous match |
| `*` / `#` | Search word under cursor |
| `:%s/old/new/g` | Replace in file |
| `:noh` | Clear search highlight |

## Windows / Tabs

| Key | Action |
| --- | --- |
| `<C-w>s` / `<C-w>v` | Split horizontal / vertical |
| `<C-w>w` | Cycle windows |
| `<C-w>=` | Equalize windows |
| `<C-w>q` | Close window |
| `gt` / `gT` | Next / previous tab |
