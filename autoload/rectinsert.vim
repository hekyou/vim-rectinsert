" Rectangular insert command
" Version: 0.1.0
" Author:  hekyou <hekyolabs+vim@gmail.com>

scriptencoding utf-8

function! rectinsert#rectInsert(opt)
  let s:insert_type = a:opt =~ '-a' ? 'a' : 'i'

  let s:save_cpo = &cpo
  let s:save_ve = &ve
  let s:save_et = &et

  set cpo&vim
  set ve=all
  set noet

  let s:pos = getpos('.')

  let s:data = split(@*, "\n")

  call s:insert(s:insert_type, s:data[0], s:pos[2])

  for s:line in s:data[1:]
    if line('.') == line('$')
      execute ":normal o"
      call cursor(line('.'), s:pos[2])
    else
      execute ":normal j"
    endif
    call s:insert(s:insert_type, s:line, s:pos[2])
  endfor

  call setpos('.', s:pos)

  let &et = s:save_et
  let &ve = s:save_ve
  let &cpo = s:save_cpo
endfunction

function! s:insert(type, str, col)
  execute ":normal ".a:type.a:str
  call cursor(line('.'), a:col)
endfunction

