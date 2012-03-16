" Rectangular insert command
" Version: 0.4.1
" Author:  hekyou <hekyolabs+vim@gmail.com>

if exists('g:loaded_rectinsert')
  finish
endif
let g:loaded_rectinsert = 1

let s:save_cpo = &cpo
set cpo&vim

command! -nargs=? RectInsert call rectinsert#insert(<q-args>)
command! -nargs=0 RectVisualInsert call rectinsert#visualInsert()
command! -nargs=? RectScriptInsert call rectinsert#scriptInsert(<q-args>)
command! -nargs=* RectStringInsert call rectinsert#stringInsert(<f-args>)

nnoremap <silent> <Plug>(rectinsert_insert) :<C-u>RectInsert -i<CR>
nnoremap <silent> <Plug>(rectinsert_append) :<C-u>RectInsert -a<CR>
vnoremap <silent> <Plug>(rectinsert_visual) :<C-u>RectVisualInsert<CR>

let &cpo = s:save_cpo
unlet s:save_cpo

