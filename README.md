# touchpad.vim
Disables the touchpad when editing in insert mode.

I was annoyed that I sporadically mess up my cursor position when typing on my
laptop, because sometimes my thumbs are touching the touchpad. I tried some
tricks like temporarily disabling the touchpad using KDE's Touchpad KCM, but
this timeout based disabling doesn't work very well.

Luckily I'm editing in Vim most of the time. Vim has an insert mode, so I now
simply disable the touchpad in insertmode and restore it when leaving
insertmode.

TODO:
* testing how good this works
* maybe restoring touchpad when vim looses focus might be a good idea

