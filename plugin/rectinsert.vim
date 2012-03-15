" Rectangular insert command
" Version: 0.3.0
" Author:  hekyou <hekyolabs+vim@gmail.com>

if exists('g:loaded_rectinsert')
  finish
endif
let g:loaded_rectinsert = 1

command! -nargs=* RectInsert call rectinsert#rectInsert(<f-args>)
command! -nargs=? RectInsertFromClipboard call rectinsert#rectInsertFromClipboard(<q-args>)
command! -nargs=? RectVisualInsertFromClipboard call rectinsert#rectVisualInsertFromClipboard(<q-args>)

nnoremap <silent> <Plug>(rectinsert_insert) :<C-u>RectInsert -i<CR>
nnoremap <silent> <Plug>(rectinsert_append) :<C-u>RectInsert -a<CR>
nnoremap <silent> <Plug>(rectinsert_visual) :<C-u>RectVisualInsertFromClipboard<CR>

