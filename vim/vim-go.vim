autocmd FileType go nmap ,r <Plug>(go-run)
autocmd FileType go nmap ,t <Plug>(go-test)
autocmd FileType go nmap ,c <Plug>(go-coverage-toggle)

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

"autocmd FileType go nmap ,b :call <SID>build_go_files()<CR>
autocmd FileType go nmap ,b  <Plug>(go-build)
