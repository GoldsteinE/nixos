#!/bin/sh
pkill polybar
for m in $(xrandr --query | grep ' connected' | cut -d' ' -f1); do
	POLYBAR_MONITOR="$m" GITHUB_ACCESS_TOKEN="$(pass show github-token-polybar)" polybar main &
	POLYBAR_MONITOR="$m" polybar top &
done
