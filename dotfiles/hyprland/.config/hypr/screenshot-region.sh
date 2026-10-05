#!/bin/sh
set -eu

tmp=$(mktemp --suffix=.png)
trap 'rm -f "$tmp"' EXIT

grim -s 1 "$tmp"
geometry=$(slurp) || exit 1

xy=${geometry%% *}
size=${geometry#* }
x=${xy%,*}
y=${xy#*,}
w=${size%x*}
h=${size#*x}
min_x=$(hyprctl monitors -j | jq '[.[].x] | min')
min_y=$(hyprctl monitors -j | jq '[.[].y] | min')

magick "$tmp" -crop "${w}x${h}+$((x - min_x))+$((y - min_y))" +repage png:- \
  | wl-copy --type image/png
