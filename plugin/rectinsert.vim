" Rectangular insert command
" Version: 0.3.1
" Author:  hekyou <hekyolabs+vim@gmail.com>

if exists('g:loaded_rectinsert')
  finish
endif
let g:loaded_rectinsert = 1

command! -nargs=? RectInsert call rectinsert#rectInsert(<q-args>)
command! -nargs=0 RectVisualInsert call rectinsert#rectVisualInsert()
command! -nargs=* RectStringInsert call rectinsert#rectStringInsert(<f-args>)

nnoremap <silent> <Plug>(rectinsert_insert) :<C-u>RectInsert -i<CR>
nnoremap <silent> <Plug>(rectinsert_append) :<C-u>RectInsert -a<CR>
vnoremap <silent> <Plug>(rectinsert_visual) :<C-u>RectVisualInsert<CR>

