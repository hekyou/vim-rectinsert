" Rectangular insert command
" Version: 0.4.2
" Author:  hekyou <hekyolabs+vim@gmail.com>

if exists('g:loaded_rectinsert')
  finish
endif
let g:loaded_rectinsert = 1

let s:save_cpo = &cpo
set cpo&vim

command! -nargs=? -range=0 RectInsert call rectinsert#insert(<q-args>, <count>, <line1>, <line2>)
command! -nargs=* RectInsertTo call rectinsert#insertTo(<f-args>)
command! -nargs=? -range=0 RectReplace call rectinsert#replace(<q-args>, <count>)
command! -nargs=* RectReplaceTo call rectinsert#replaceTo(<f-args>)
command! -nargs=? RectScriptInsert call rectinsert#scriptInsert(<q-args>)
command! -nargs=* RectStringInsert call rectinsert#stringInsert(<f-args>)

nnoremap <silent> <Plug>(rectinsert_insert) :<C-u>RectInsert -i<CR>
nnoremap <silent> <Plug>(rectinsert_append) :<C-u>RectInsert -a<CR>
vnoremap <silent> <Plug>(rectinsert_insert) :<C-u>RectInsert -i -mode-v<CR>
vnoremap <silent> <Plug>(rectinsert_append) :<C-u>RectInsert -a -mode-v<CR>

nnoremap <silent> <Plug>(rectreplace_insert) :<C-u>RectReplace -i<CR>
nnoremap <silent> <Plug>(rectreplace_append) :<C-u>RectReplace -a<CR>
vnoremap <silent> <Plug>(rectreplace_insert) :<C-u>RectReplace -i -mode-v<CR>
vnoremap <silent> <Plug>(rectreplace_append) :<C-u>RectReplace -a -mode-v<CR>

let &cpo = s:save_cpo
unlet s:save_cpo

