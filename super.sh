#!/bin/sh

cleanup() {
	doas chown -R root:root /etc/nixos
}

trap cleanup INT TERM
doas chown -R goldstein /etc/nixos
zsh
cleanup
