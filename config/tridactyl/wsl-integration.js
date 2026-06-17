// Tridactyl <-> nvim-on-WSL integration.
// Reference: https://github.com/tridactyl/tridactyl/wiki/WSL-Vim-Integration-Tutorial
//
// Firefox runs on Windows, nvim runs in WSL (Debian). When you edit a text box
// with `gi`/Ctrl-i, Tridactyl writes a temp file and runs `editorcmd`. We open
// nvim inside Debian in a new WezTerm window. `wezterm start --always-new-process`
// runs the GUI in this invocation and blocks until nvim exits, so Tridactyl's
// native messenger reads the saved file back afterwards.
//
// The actual nvim launch lives in ~/.config/tridactyl/edit.sh (WSL side) so the
// command below stays free of the nested quoting that breaks across the
// cmd -> wezterm -> wsl -> bash chain. The matching `Tridactyl()` function in
// ~/.config/nvim/lua/tridactyl.lua converts the C:\ path and restores the cursor.
let is_windows = +/Windows/.test(navigator.userAgent)
let wsl = `wezterm.exe start --always-new-process -- wsl.exe -d Debian bash -c "$HOME/.config/tridactyl/edit.sh '%f' %l %c"`
let native = `nvim '%f' -c 'call Tridactyl(%l, %c, 0)'`
tri.excmds.set("editorcmd", is_windows ? wsl : native)
