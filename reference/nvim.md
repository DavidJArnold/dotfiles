## Vim motions
Combine action/scope/motion

# Actions
`c`: Change (delete and insert)
`d`: Delete
`y`: Copy

# Scope
`i`: Expand to whitespace
`a`: Expand to (and including) whitespace
(Can be left out)

# Motion:
`[hjkl]`: Move cursor left, down, up, right
`w`: Jump forward to next word
`b`: Jump backwards to next word
`fx`: Jump forward to next x on same line
`Fx`: Jump backward to previous x on same line

# Modes
`i`: INSERT mode
`I`: INSERT at start of line (after whitespace)
`o`: INSERT on new line below
`O`: INSERT on new line above
`a`: INSERT after cursor position
`A`: INSERT at end of line
`r`: REPLACE character under cursor
`R`: REPLACE multiple characters
`jk`: Escape from INSERT to NORMAL mode
`<Escape>`: Return to NORMAL mode

# Scrolling:
`<ctrl> + [ud]`: Move half-window up/down
`zz or z.`: Scroll window to centre cursor

# Commands:
`:`: Enter command mode
`:w`: Save
`:q`: Exit

# Telescope shortcuts
`<leader> + sf`: Open fuzzy search files
`<leader> + <space>`: Open buffer list
`<leader> + /`: Fuzzy search in file

# LSP shortcuts
`gd`: Go to definition of symbol
`<shift> + k`: Show help for symbol
`gr`: Go to references/uses of symbol
`<leader> + q`: Show LSP/linter issues

# Tabs:
In netrw, `t` opens a file in a new tab
`:{option}tabnew` opens a new tab, `{option}` is blank (after current tab), `+` (after next tab), `-` (before current tab), `0` (before first tab), `$` (after last tab)
`:{option}tabc` closes a tab, with same options as `:tabnew`
`{count}gt` jumps to tab `{count}` (`{count}` may be omitted)

# Folds:
Create a fold range using `zf` on a selection. Use `zd` to delete the fold, or `zE` to delete all folds in the file.
`zo` and `zc` open and close code folds, or `za` to toggle folding.
Navigate between folds using `[z` and `]z` to go to start/end of the current fold, or `zj` and `zk` to moveto the next/previous fold.
