set expandtab

if executable('black')
	nnoremap <buffer> <silent> <leader><Space> :w | !black %<Return>
endif
