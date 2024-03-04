#!/usr/bin/bash
# From https://github.com/BoManev/.dotfiles/blob/main/scripts/i3exit.sh

img=/tmp/i3lock.png

pre_lock() {
    dunstctl set-paused true

    scrot -o $img
    convert $img -scale 10% -scale 1000% $img

    xset dpms 30 60 0
    return
}

post_lock() {
    dunstctl set-paused false

    xset dpms 240 360 0
    xset dpms force on
    return
}


pre_lock

if [[ -e /dev/fd/${XSS_SLEEP_LOCK_FD:--1} ]]; then
    kill_i3lock() {
        pkill -xu $EUID "$@" i3lock
    }
    trap kill_i3lock TERM INT

    i3lock $i3lock_options {XSS_SLEEP_LOCK_FD}<&-
    exec {XSS_SLEEP_LOCK_FD}<&-

    while kill_i3lock -0; do
        sleep 0.5
    done
else
  trap 'kill %%' TERM INT
  i3lock $i3lock_options --image $img --nofork --show-failed-attempts --ignore-empty-password
  wait
fi

post_lock
