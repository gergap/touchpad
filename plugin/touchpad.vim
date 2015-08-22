" touchpad.vim - Disables your touchpad when typing in insert mode
" Maintainer: Gerhard Gappmeier
" Version: 1.0
" Description:" This script disables the touchpad of your laptop
" when entering insert mode to avoid accidentally changing
" the cursor position when typing.
" When leaving insert mode the touchpad is reanabled again.
" Requirements: xinput
" License: MIT

" use xinput --list to figure out your touchpad name
let g:touchpad_name='SynPS/2 Synaptics TouchPad'

function! TouchpadEnable()
    call system('xinput enable "'.g:touchpad_name.'"')
endfunction

function! TouchpadDisable()
    call system('xinput disable "'.g:touchpad_name.'"')
endfunction

augroup Touchpad
    autocmd!
    autocmd InsertEnter * :call TouchpadDisable()
    autocmd InsertLeave * :call TouchpadEnable()
augroup end
