#!/usr/bin/env bash
set -euo pipefail

silent=false

# --- First pass: extract flags anywhere ---
cleaned_args=()
for arg in "$@"; do
  case "$arg" in
    -s|--silent)
      silent=true
      ;;
    *)
      cleaned_args+=("$arg")
      ;;
  esac
done

# Replace $@ with cleaned version (flags removed)
set -- "${cleaned_args[@]}"

# --- Positional args ---
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 [--silent|-s] <id-number>"
  exit 1
fi

id_number="$1"
log() { if [ "$silent" = false ]; then echo "$@"; fi; }

id="custom${id_number}"
path="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/${id}/"
schema="org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${path}"

current=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)

# Remove the keybinding path from the list
if echo "$current" | grep -q "$path"; then
  updated=$(echo "$current" | sed "s|'$path',\s*||; s|, '$path'||; s|'$path'||")
  gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$updated"

  # Clear individual schema values
  gsettings reset "$schema" name || true
  gsettings reset "$schema" command || true
  gsettings reset "$schema" binding || true

  log "removed: $id"
else
  log "no such keybinding: $id"
fi

