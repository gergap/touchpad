" touchpad.vim - Disables your touchpad when typing in insert mode
" Maintainer: Gerhard Gappmeier
" Version: 1.0
" Description:" This script disables the touchpad of your laptop
" when entering insert mode to avoid accidentally changing
" the cursor position when typing. This happens for me when my palm is
" touching the right edge of the touchpad and causes scroll events.
" When leaving insert mode the touchpad is re-enabled again.
" Requirements: xinput
" License: MIT

if (exists("g:loaded_touchpad") && g:loaded_touchpad)
    finish
endif
let g:loaded_touchpad = 1

" use xinput --list to figure out your touchpad name
let g:touchpad_name='SynPS/2 Synaptics TouchPad'
" track insertmode (available in insertenter,leave,change)
" to be available also in focus events
let g:touchpad_insertmode=''

function! TouchpadEnable()
    "echo "touchpad enabled"
    call system('xinput enable "'.g:touchpad_name.'"')
endfunction

function! TouchpadDisable()
    "echo "touchpad disabled"
    call system('xinput disable "'.g:touchpad_name.'"')
endfunction

function! TouchpadInsertEnter(mode)
    let g:touchpad_insertmode=a:mode
    "echo "enter: ".a:mode
    call TouchpadDisable()
endfunction

function! TouchpadInsertLeave(mode)
    let g:touchpad_insertmode=''
    "echo "leave: ".a:mode
    call TouchpadEnable()
endfunction

function! TouchpadFocusLost()
    echo "focus lost: enabled touchpad"
    call TouchpadEnable()
endfunction

function! TouchpadFocusGained()
    if g:touchpad_insertmode == 'i'
        echo "focus gained(insertmode): disable touchpad"
        call TouchpadDisable()
    else
        echo "focus gained(no insertmode): touchpad stays enabled"
    end
endfunction

" Touchpad_Initialize registers the autocmds for handling
" various events for enabling/disabling the touchpad
function! Touchpad_Initialize()
    augroup Touchpad
        autocmd!
        autocmd InsertEnter * :call TouchpadInsertEnter(v:insertmode)
        autocmd InsertLeave * :call TouchpadInsertLeave(v:insertmode)
        autocmd FocusLost   * :call TouchpadFocusLost()
        autocmd FocusGained * :call TouchpadFocusGained()
    augroup end
endfunction

let input_devices = system('xinput --list')
" using very no magic, we only need to escape \
let search_pattern = '\V'.escape(touchpad_name, '\\')
let match = matchstr(input_devices, search_pattern)
" Enable touchpad hooks only if the configured touchpad is available
if !empty(match)
    @echom "Touchpad found"
    call Touchpad_Initialize()
else
    @echom "Touchpad not found"
endif
