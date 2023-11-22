# kiosk_raspberry_pi_bookworm_wayland_blank_screen
Blank the screen on a raspberry pi running bookworm / wayland
while running chromium-browser in kiosk mode.

I tried finding something that would work with wayland on my raspberry pi but was not able to find anything.

Plenty of solutions for X11.

Using keyd since I was already it to swap the ctrl and cap lock keys.

## To Use:

  - Replace "YOUR-URL" in kiosk.bash

  - Replace /PATH/TO/kiosk.bash in kiosk.desktop

  - Copy kiosk.desktop to /etx/xdg/autostart

  - Install dependencies below

## Depends on:

  - keyd  (https://github.com/rvaiya/keyd.git)

  - pqiv  (sudo apt install pqiv)
