" Rectangular insert command
" Version: 0.4.0
" Author:  hekyou <hekyolabs+vim@gmail.com>

scriptencoding utf-8

function! rectinsert#insert(opt)
  call s:insert(a:opt, @*)
endfunction

function! rectinsert#visualInsert()
  call s:visual_insert(@*)
endfunction

function! rectinsert#scriptInsert(opt)
  call s:script_insert(a:opt)
endfunction

function! rectinsert#stringInsert(opt, src)
  call s:insert(a:opt, a:src)
endfunction

function! s:insert(opt, src)
  let s:pos = getpos('.')

  let s:base_line = s:pos[1]
  let s:base_col = s:pos[2]

  if a:opt !=? '-a'
    let s:base_col = s:base_col - 1
  endif

  let s:data = split(a:src, "\n")

  let s:idx = 0

  for s:line in s:data
    let s:str = getline(s:base_line + s:idx)
    while strlen(s:str) < s:base_col
      let s:str = s:str . " "
    endwhile
    let s:str = strpart(s:str, 0, s:base_col) . s:line . strpart(s:str, s:base_col)
    call setline(s:base_line + s:idx, s:str)

    let s:idx = s:idx + 1
  endfor

  call setpos('.', s:pos)
endfunction

function! s:visual_insert(src)
  let s:start_pos = getpos("'<")
  let s:end_pos = getpos("'>")

  let s:line_cnt = abs(s:end_pos[1] - s:start_pos[1]) + 1

  let s:base_line = s:start_pos[1]
  let s:base_col = s:start_pos[2] - 1

  let s:data = split(a:src, "\n")
  let s:data_cnt = len(s:data)

  let s:idx = 0

  while s:idx < s:line_cnt
    let s:str = getline(s:base_line + s:idx)
    while strlen(s:str) < s:base_col
      let s:str = s:str . " "
    endwhile
    let s:str = strpart(s:str, 0, s:base_col) . s:data[s:idx % s:data_cnt] . strpart(s:str, s:base_col)
    call setline(s:base_line + s:idx, s:str)

    let s:idx = s:idx + 1
  endwhile

  call setpos('.', s:start_pos)
endfunction

function! s:script_insert(opt)
  let s:filetype = a:opt

  if !exists('s:bufnr')
      let s:bufnr = -1
  endif
  if bufexists(s:bufnr)
      let g:__rectinsert_script_result__ = ''
      execute "QuickRun -outputter variable:name=__rectinsert_script_result__"
      execute 'bd! '.s:bufnr
      unlet s:bufnr
      call rectinsert#stringInsert("-i", g:__rectinsert_script_result__)
      unlet g:__rectinsert_script_result__
  else
      setlocal bufhidden=hide buftype=nofile noswapfile
      execute 'split'
      execute 'edit [RectScriptInsert]['.s:filetype.']'
      let s:bufnr = bufnr('%')
      execute "setlocal filetype=".s:filetype
  endif
endfunction

