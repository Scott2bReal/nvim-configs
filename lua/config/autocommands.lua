vim.cmd([[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200})
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
  augroup end

  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
    autocmd!
    " autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
  augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd =
  augroup end

  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end

  augroup _shape
    autocmd VimLeave * set guicursor=a:hor10-blinkwait150-blinkoff150-blinkon150
  augroup end

  augroup _autoformat
    autocmd!
    autocmd BufWritePre * lua vim.lsp.buf.format({ timeout_ms = 5000 })
  augroup end

  " TODO open alpha when every buffer is closed
  " augroup _show_alpha
  "   autocmd!
  "   let bufs_open = len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
  "   autocmd BufDelete * if bufs_open == 1 | :execute "Alpha" | endif
  " augroup end
]])

-- Autoformat
-- augroup _lsp
--   autocmd!
--   autocmd BufWritePre * lua vim.lsp.buf.formatting()
-- augroup end
