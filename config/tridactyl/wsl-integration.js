// Tridactyl <-> nvim-on-WSL integration.
// Reference: https://github.com/tridactyl/tridactyl/wiki/WSL-Vim-Integration-Tutorial
//
// Firefox runs on Windows, nvim runs in WSL (Debian). When you edit a text box
// with `gi`/Ctrl-i, Tridactyl writes a temp file and runs `editorcmd`. We open
// nvim inside Debian in a new WezTerm window. `wezterm start --always-new-process`
// runs the GUI in this invocation and blocks until nvim exits, so Tridactyl's
// native messenger reads the saved file back afterwards. The matching
// `Tridactyl()` function lives in ~/.config/nvim/lua/tridactyl.lua and fixes up
// the Windows temp path + cursor position on the WSL side.
let is_windows = +/Windows/.test(navigator.userAgent)
let invoke = `nvim '%f' -c 'call Tridactyl(%l, %c, ${is_windows})'`
tri.excmds.set(
  "editorcmd",
  is_windows
    ? `wezterm.exe start --always-new-process -- wsl.exe -d Debian bash -c "${invoke}"`
    : invoke,
)
