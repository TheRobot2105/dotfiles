#!/usr/bin/env bash
set -e
tack update
nix flake update
git add .
git commit -m "updated lockfile"
git push
