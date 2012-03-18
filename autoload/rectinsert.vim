" Rectangular insert command
" Version: 0.4.2
" Author:  hekyou <hekyolabs+vim@gmail.com>

scriptencoding utf-8

function! rectinsert#insert(opt, count, line1, line2)
  let s:opts = split(a:opt, " ")
  if a:count
    call s:visual_insert(s:opts[0], @*, a:line1, a:line2)
  elseif len(s:opts) == 2 && s:opts[1] ==# "-mode-v"
    let s:start_pos = getpos("'<")
    let s:end_pos = getpos("'>")
    call s:visual_insert(s:opts[0], @*, s:start_pos[1], s:end_pos[1])
  else
    call s:insert(s:opts[0], @*)
  endif
endfunction

function! rectinsert#insertTo(line, opt)
  let s:lines = split(a:line, ",")
  call s:visual_insert(a:opt, @*, s:lines[0], s:lines[1])
endfunction

function! rectinsert#replace(opt, count)
  let s:opts = split(a:opt, " ")
  if a:count || (len(s:opts) == 2 && s:opts[1] ==# "-mode-v")
    let s:start_pos = getpos("'<")
    let s:end_pos = getpos("'>")
    call s:visual_replace(@*, s:start_pos[1], s:end_pos[1], s:end_pos[2] - s:start_pos[2] + 1)
  else
    call s:replace(s:opts[0], @*)
  endif
endfunction

function! rectinsert#replaceTo(line, width)
  let s:lines = split(a:line, ",")
  call s:visual_replace(@*, s:lines[0], s:lines[1], a:width)
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
    let s:str = s:str . repeat(" ", s:base_col - strlen(s:str))
    let s:str = strpart(s:str, 0, s:base_col) . s:line . strpart(s:str, s:base_col)
    call setline(s:base_line + s:idx, s:str)

    let s:idx = s:idx + 1
  endfor
endfunction

function! s:visual_insert(opt, src, start, end)
  let s:line_cnt = abs(a:end - a:start) + 1

  let s:base_line = a:start
  let s:base_col = col(".")

  if a:opt !=? '-a'
    let s:base_col = s:base_col - 1
  endif

  let s:data = split(a:src, "\n")
  let s:data_cnt = len(s:data)

  let s:idx = 0

  while s:idx < s:line_cnt
    let s:str = getline(s:base_line + s:idx)
    let s:str = s:str . repeat(" ", s:base_col - strlen(s:str))
    let s:str = strpart(s:str, 0, s:base_col) . s:data[s:idx % s:data_cnt] . strpart(s:str, s:base_col)
    call setline(s:base_line + s:idx, s:str)

    let s:idx = s:idx + 1
  endwhile
endfunction

function! s:replace(opt, src)
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
    let s:str = s:str . repeat(" ", s:base_col - strlen(s:str))
    let s:str = strpart(s:str, 0, s:base_col) . s:line . strpart(s:str, s:base_col + strlen(s:line))
    call setline(s:base_line + s:idx, s:str)

    let s:idx = s:idx + 1
  endfor
endfunction

function! s:visual_replace(src, start, end, width)
  let s:line_cnt = abs(a:end - a:start) + 1

  let s:base_line = a:start
  let s:base_col = col(".") - 1

  let s:data = split(a:src, "\n")
  let s:data_cnt = len(s:data)

  let s:idx = 0

  while s:idx < s:line_cnt
    let s:str = getline(s:base_line + s:idx)
    let s:str = s:str . repeat(" ", s:base_col - strlen(s:str))
    let s:str = strpart(s:str, 0, s:base_col) . s:data[s:idx % s:data_cnt] . strpart(s:str, s:base_col + a:width)
    call setline(s:base_line + s:idx, s:str)

    let s:idx = s:idx + 1
  endwhile
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

