#!/usr/bin/env bash
nixos-rebuild switch --flake ".#etna" --target-host "root@etna.typhon-ci.org"
