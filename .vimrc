syntax on
set tabstop=4
set shiftwidth=4
colorscheme desert
set autoindent
set number
filetype indent on

" 補齊括弧
" 語法
" inoremap  triger_char  mapping_str
" 映射指令     觸發字元     映射字串
"
" 註：<LEFT> 為向右鍵字元
 
inoremap ( ()<LEFT>
inoremap () ()<RIGHT>
inoremap < <><LEFT>
inoremap [ []<LEFT> 
inoremap ] <RIGHT> 
inoremap {<CR> {<CR>}<Esc>ko
"在 insert-mode 時，當輸入 { ，vim會輸入 { → <CR> 換行 → 輸入 } → 進入command-mode → k 光標上移 → o 插入新的一行 → 自動增加縮排
inoremap ' ''<LEFT>
inoremap " ""<LEFT>
