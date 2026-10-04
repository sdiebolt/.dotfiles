#!/bin/sh

geometry=$(slurp) || exit 1
sleep 0.2
grim -g "$geometry" - | wl-copy --type image/png
