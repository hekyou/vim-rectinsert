if exists('g:loaded_rectinsert')
  finish
endif
let g:loaded_rectinsert = 1

"command! -nargs=? RectInsert call rectinsert#rectInsert(<q-args>)
command! -nargs=* RectInsert call rectinsert#rectInsert(<q-args>)

nnoremap <silent> <Plug>(rectinsert_insert) :<C-u>RectInsert -i<CR>
nnoremap <silent> <Plug>(rectinsert_append) :<C-u>RectInsert -a<CR>

