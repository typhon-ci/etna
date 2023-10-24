#!/usr/bin/env bash
NIX_SSHOPTS=-t nixos-rebuild switch --flake .#etna --target-host pnm@etna.typhon-ci.org --use-remote-sudo
