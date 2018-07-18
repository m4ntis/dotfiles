" Define custom path configuration based on filetype
autocmd FileType go setlocal path+=/usr/local/go/src/**,
autocmd FileType c setlocal path+=/usr/include,
autocmd FileType cpp setlocal path+=/usr/include,
autocmd FileType arduino setlocal path+=~/code/arduino/libraries/**,
