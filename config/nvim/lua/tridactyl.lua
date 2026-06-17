-- Tridactyl WSL integration.
--
-- Firefox runs on Windows; nvim runs here in WSL. Tridactyl's `editorcmd`
-- launches `nvim '<tmpfile>' -c 'call Tridactyl(<line>, <col>, 1)'`. Because
-- Firefox is on Windows, the temp file path is a Windows path (C:\Users\...),
-- which nvim opens as a bogus buffer. This function converts that path to its
-- /mnt/c/... WSL equivalent, swaps to the real file, drops the bogus buffer,
-- and restores the cursor. See ~/.config/tridactyl/ (synced to Windows home).
vim.cmd([[
function! Tridactyl(line, column, is_windows) abort
  if a:is_windows
    let l:win = expand('%')
    let l:wsl = '/mnt/' . tolower(l:win[0]) . substitute(l:win[2:], '\\', '/', 'g')
    let l:bogus = bufnr('%')
    execute 'edit ' . fnameescape(l:wsl)
    execute 'bwipeout! ' . l:bogus
  endif
  call cursor(a:line, a:column + 1)
  " Drop into insert mode where the cursor lands, like a normal text box.
  if col('.') >= col('$') - 1
    startinsert!
  else
    startinsert
  endif
endfunction
]])
