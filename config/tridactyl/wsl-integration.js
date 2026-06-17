// Tridactyl <-> nvim-on-WSL integration.
// Reference: https://github.com/tridactyl/tridactyl/wiki/WSL-Vim-Integration-Tutorial
//
// Firefox runs on Windows, nvim runs in WSL (Debian). When you edit a text box
// with `gi`/Ctrl-i, Tridactyl writes a temp file and runs `editorcmd`. We launch
// nvim inside Debian in a new console (`start /wait` so the native messenger
// blocks until you quit nvim, then reads the saved file back). The matching
// `Tridactyl()` function lives in ~/.config/nvim/lua/tridactyl.lua and fixes up
// the Windows temp path + cursor position on the WSL side.
let is_windows = +/Windows/.test(navigator.userAgent)
let invoke = `nvim '%f' -c 'call Tridactyl(%l, %c, ${is_windows})'`
tri.excmds.set(
  "editorcmd",
  is_windows ? `start /wait wsl.exe -d Debian bash -c "${invoke}"` : invoke,
)
