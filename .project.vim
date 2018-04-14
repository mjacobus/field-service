" ------------------------------------------------------------------------------
" Configs
" ------------------------------------------------------------------------------

set backspace=indent,eol,start
set splitright

" javascript specify
autocmd FileType javascript nnoremap <buffer> <leader>T <esc>:call RunTestFile()<cr>
autocmd FileType javascript nnoremap <buffer> <leader>t <esc>:call RunTestFileFilteredByLine()<cr>
autocmd FileType javascript nnoremap <buffer> <leader>x <esc>:call ClearEchoAndExecute('time node ' . expand('%'))<cr>

" ruby specify
autocmd FileType ruby nnoremap <buffer> <leader>T <esc>:call RunTestFile()<cr>
autocmd FileType ruby nnoremap <buffer> <leader>t <esc>:call RunTestFileFilteredByLine()<cr>
autocmd FileType ruby nnoremap <buffer> <leader>x <esc>:call ClearEchoAndExecute('time ruby ' . expand('%'))<cr>
autocmd FileType ruby nnoremap <buffer> <leader>cs  :call RubocopFixCs()<cr>
autocmd FileType ruby nnoremap <buffer> <leader>ccs :call ReekCodeSmell()<cr>

" bash specify
autocmd FileType sh nnoremap <buffer> <leader>x <esc>:call ClearEchoAndExecute('time ./' . expand('%'))<cr>

" ------------------------------------------------------------------------------
" Functions
" ------------------------------------------------------------------------------

function! ClearEchoAndExecute(command)
  if has('nvim')
    -tabnew
    call termopen(a:command)
    startinsert
    return
  endif

  let message = '.editor/project.vim => ' . a:command
  let command = "echo -e '" . message . "' && " . a:command
  echo command

  if has('nvim')
    -tabnew
    call termopen(command)
    startinsert
    return
  endif

  let command = '! clear && ' . command
  execute command
endfunction

function! RunTestFileFilteredByLine()
  let command = "bundle exec run_test " . expand('%') . " --line=" . line(".")
  call ClearEchoAndExecute(command)
endfunction

function! RunTestFile()
  let command = "bundle exec run_test " . expand('%')
  call ClearEchoAndExecute(command)
endfunction

function! RubocopFixCs()
  let command = "bundle exec rubocop -a " . expand('%')
  call ClearEchoAndExecute(command)
endfunction

function! ReekCodeSmell()
  let command = "bundle exec reek " . expand('%')
  call ClearEchoAndExecute(command)
endfunction
