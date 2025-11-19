#!/usr/bin/env zsh

set -euo pipefail

echo "Reverting GNOME keybindings from backup/*"

if [[ ! -f backup/shell-keybindings-backup.dconf ]] || \
   [[ ! -f backup/wm-keybindings-backup.dconf ]] || \
   [[ ! -f backup/media-keys-backup.dconf ]]; then
  echo "Error: backup files not found. Run apply-keybindings.sh first."
  exit 1
fi

echo "Restoring backups..."

# Reset all keybindings to start clean
dconf reset -f /org/gnome/desktop/wm/keybindings/
dconf reset -f /org/gnome/shell/keybindings/
dconf reset -f /org/gnome/settings-daemon/plugins/media-keys/

# Load backed up keybindings
dconf load /org/gnome/shell/keybindings/ < backup/shell-keybindings-backup.dconf
dconf load /org/gnome/desktop/wm/keybindings/ < backup/wm-keybindings-backup.dconf
dconf load /org/gnome/settings-daemon/plugins/media-keys/ < backup/media-keys-backup.dconf

# Remove custom keybindings added by apply-keybindings.sh
echo "Removing custom keybindings added by apply-keybindings.sh..."

custom_ids=(
  19325301  # Force Suspend
  19325302  # Open Files
  19325303  # Open Terminal
  19325304  # Open Software
  19325305  # Open Notes
  19325306  # Open System Monitor
  19325307  # Laptop monitor brightness up
  19325308  # Laptop monitor brightness down
)

for id in "${custom_ids[@]}"; do
  ./revert-custom-keybinding.sh "$id" --silent 2>/dev/null || true
done

echo "Reloading GNOME Shell (Wayland)…"
busctl --user call org.gnome.Shell /org/gnome/Shell org.gnome.Shell Eval "s" "global.reexec_self()"

echo "Done. Keybindings reverted."

