let s:default_config = {
    \ 'prefix_lines': 8,
    \ 'suffix_lines': 8,
    \ 'endpoint': 'http://127.0.0.1:30890/completion',
    \ 'fim_prefix': '<|fim_prefix|>',
    \ 'fim_suffix': '<|fim_suffix|>',
    \ 'fim_middle': '<|fim_middle|>',
    \ 'stop': ["\n"],
    \ 'n_predict': 64,
    \ 'n_probs': 3,
    \ 'temperature': 1.0
    \}

let g:llama_config = get(g:, 'llama_config', s:default_config)

" augroup llama_cpp
"     autocmd!
"     autocmd InsertEnter * inoremap <buffer> <silent> <C-F> <Esc>:call llama#fim()<CR>
" augroup END

function! llama#fim() abort
    let l:lines_prefix = getline(max([1, line('.') - g:llama_config.suffix_lines]), line('.') - 1)
    let l:lines_suffix = getline(line('.') + 1, min([line('$'), line('.') + g:llama_config.prefix_lines]))

    let l:cursor_col = col('.')
    let l:line_cur = getline('.')
    let l:line_cur_prefix = strpart(l:line_cur, 0, l:cursor_col)
    let l:line_cur_suffix = strpart(l:line_cur, l:cursor_col)

    let l:prompt = g:llama_config.fim_prefix
        \ . join(l:lines_prefix, "\n")
        \ . "\n"
        \ . l:line_cur_prefix
        \ . g:llama_config.fim_suffix
        \ . l:line_cur_suffix
        \ . join(l:lines_suffix, "\n")
        \ . g:llama_config.fim_middle

    let l:request = json_encode({
        \ 'prompt':         l:prompt,
        "\ 'stop':           g:llama_config.stop,
        \ 'n_predict':      g:llama_config.n_predict,
        \ 'n_probs':        g:llama_config.n_probs,
        \ 'penalty_last_n': 0,
        \ 'temperature':    g:llama_config.temperature,
        \ 'top_k':          1,
        \ 'stream':         v:false,
        \ 'samplers':       ["top_k"]
        \ })

    " request completion from the server
    let l:curl_command = printf(
        \ "curl --silent --no-buffer --request POST --url %s --header \"Content-Type: application/json\" --data %s",
        \ g:llama_config.endpoint, shellescape(l:request))

    let l:response = json_decode(system(l:curl_command))

    echom l:response

    let l:content = []
    for l:part in split(get(l:response, 'content', ''), "\n", 1)
        call add(l:content, l:part)
    endfor

    echom l:content

    " insert the 'content' at the current cursor location
    let l:content[0]   = l:line_cur_prefix . l:content[0]
    let l:content[-1] .= l:line_cur_suffix

    call setline('.', l:content[0])
    call append(line('.'), l:content[1:-1])
endfunction
