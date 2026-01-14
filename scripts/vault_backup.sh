#!/usr/bin/env bash

VAULT_PATH="$HOME/vault"

cd "$VAULT_PATH" || exit

git add .
git commit -m "Vault backup: $(date '+%Y-%m-%d %H:%M')"
git push origin main
