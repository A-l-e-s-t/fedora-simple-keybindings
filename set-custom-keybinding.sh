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
if [ "$#" -ne 4 ]; then
  echo "Usage: $0 [--silent|-s] <id-number> <name> <command> <binding>"
  exit 1
fi

id_number="$1"
name="$2"
command="$3"
binding="$4"

log() { if [ "$silent" = false ]; then echo "$@"; fi; }

id="custom${id_number}"
path="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/${id}/"
schema="org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${path}"

current=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)

if echo "$current" | grep -q "$path"; then
  action="updated"
  updated="$current"
else
  action="added"
  updated=$(echo "$current" | sed "s|]$|, '$path']|")
fi

gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$updated"

gsettings set "$schema" name "$name"
gsettings set "$schema" command "$command"
gsettings set "$schema" binding "$binding"

log "$action: $id → $binding → $command"

