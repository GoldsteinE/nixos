#!/bin/sh

cleanup() {
	sudo chown -R root:root /etc/nixos
}

trap cleanup INT TERM
sudo chown -R goldstein /etc/nixos
zsh
cleanup
