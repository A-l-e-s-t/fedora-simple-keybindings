#!/usr/bin/env zsh

set -euo pipefail

echo "Backing up your current GNOME Keybindings to backup/*"
mkdir -p backup
dconf dump /org/gnome/shell/keybindings/ > backup/shell-keybindings-backup.dconf
dconf dump /org/gnome/desktop/wm/keybindings/ > backup/wm-keybindings-backup.dconf
dconf dump /org/gnome/settings-daemon/plugins/media-keys/ > backup/media-keys-backup.dconf

echo "Applying Alest's Fedora GNOME Simple Keybindings..."


dconf load /org/gnome/shell/keybindings/ <<'EOF'
[/]
focus-active-notification=['<Shift><Super>n']
open-new-window-application-1=@as []
open-new-window-application-2=@as []
open-new-window-application-3=@as []
open-new-window-application-4=@as []
open-new-window-application-5=@as []
open-new-window-application-6=@as []
open-new-window-application-7=@as []
open-new-window-application-8=@as []
open-new-window-application-9=@as []
screenshot=['<Super>Print']
shift-overview-down=@as []
shift-overview-up=@as []
show-screen-recording-ui=['<Shift>Print']
switch-to-application-1=['<Super><Control>1']
switch-to-application-2=['<Super><Control>2']
switch-to-application-3=['<Super><Control>3']
switch-to-application-4=['<Super><Control>4']
switch-to-application-5=['<Super><Control>5']
switch-to-application-6=['<Super><Control>6']
switch-to-application-7=['<Super><Control>7']
switch-to-application-8=['<Super><Control>8']
switch-to-application-9=['<Super><Control>9']
toggle-application-view=['<Super>a']
toggle-message-tray=['<Super>n']
toggle-quick-settings=['<Super>s']
EOF


dconf load /org/gnome/desktop/wm/keybindings/ <<'EOF'
[/]
always-on-top=@as []
begin-move=['<Super>m']
begin-resize=['<Super>r']
close=['<Super>q']
cycle-group=@as []
cycle-group-backward=@as []
cycle-windows=@as []
cycle-windows-backward=@as []
maximize=['<Super>Up']
maximize-horizontally=['<Super>End']
maximize-vertically=['<Super>Home']
minimize=['<Super>h']
move-to-center=['<Super>c']
move-to-workspace-1=['<Super><Shift>1']
move-to-workspace-10=['<Super><Shift>0']
move-to-workspace-2=['<Super><Shift>2']
move-to-workspace-3=['<Super><Shift>3']
move-to-workspace-4=['<Super><Shift>4']
move-to-workspace-5=['<Super><Shift>5']
move-to-workspace-6=['<Super><Shift>6']
move-to-workspace-7=['<Super><Shift>7']
move-to-workspace-8=['<Super><Shift>8']
move-to-workspace-9=['<Super><Shift>9']
move-to-workspace-last=@as []
move-to-workspace-left=['<Shift><Super>minus']
move-to-workspace-right=['<Shift><Super>equal']
panel-run-dialog=['<Super><Shift>t']
show-desktop=['<Shift><Super>h']
switch-applications=@as []
switch-applications-backward=@as []
switch-group=@as []
switch-group-backward=@as []
switch-to-workspace-1=['<Super>1']
switch-to-workspace-10=['<Super>0']
switch-to-workspace-2=['<Super>2']
switch-to-workspace-3=['<Super>3']
switch-to-workspace-4=['<Super>4']
switch-to-workspace-5=['<Super>5']
switch-to-workspace-6=['<Super>6']
switch-to-workspace-7=['<Super>7']
switch-to-workspace-8=['<Super>8']
switch-to-workspace-9=['<Super>9']
switch-to-workspace-down=@as []
switch-to-workspace-last=@as []
switch-to-workspace-left=['<Super>minus']
switch-to-workspace-right=['<Super>equal']
switch-to-workspace-up=@as []
switch-windows=['<Super>Tab']
switch-windows-backward=['<Shift><Super>Tab']
toggle-above=['<Super>T']
toggle-fullscreen=['<Super>f']
toggle-maximized=@as []
toggle-on-all-workspaces=['<Super>w']
unmaximize=['<Super>Down']
EOF


dconf load /org/gnome/settings-daemon/plugins/media-keys/ <<'EOF'
[/]
calculator=['<Control><Super>c']
control-center=['<Control><Super>s']
decrease-text-size=['<Alt><Super>bracketleft']
help=['<Control><Super>F1']
increase-text-size=['<Alt><Super>bracketright']
logout=['<Shift><Super>l']
magnifier=['<Alt><Super>z']
magnifier-zoom-in=['<Alt><Super>equal']
magnifier-zoom-out=['<Alt><Super>minus']
mic-mute=['<Shift><Alt><Super>m']
next=['<Alt><Super>Right']
on-screen-keyboard=['<Alt><Super>k']
play=['<Alt><Super>space']
previous=['<Alt><Super>Left']
reboot=['<Shift><Super>r']
screenreader=['<Alt><Super>r']
screensaver=['<Super>l']
shutdown=['<Shift><Super>p']
toggle-contrast=['<Alt><Super>c']
volume-down=['<Alt><Super>Down']
volume-mute=['<Alt><Super>m']
volume-up=['<Alt><Super>Up']
www=['<Control><Super>b']
EOF

chmod +x set-custom-keybinding.sh
./set-custom-keybinding.sh 19325301 "Force Suspend" "systemctl suspend -i" "<Shift><Super>s" --silent
./set-custom-keybinding.sh 19325302 "Open Files" "nautilus --new-window" "<Control><Super>f" --silent
./set-custom-keybinding.sh 19325303 "Open Terminal" "ptyxis --new-window" "<Control><Super>t" --silent
./set-custom-keybinding.sh 19325304 "Open Software" "gnome-software" "<Shift><Control><Super>s" --silent
./set-custom-keybinding.sh 19325305 "Open Notes" "gnome-text-editor --new-window" "<Control><Super>n" --silent
./set-custom-keybinding.sh 19325306 "Open System Monitor" "gnome-system-monitor" "<Control><Super>m" --silent
# 19325307 Reserved - Laptop monitor brightness up
# 19325308 Reserved - Laptop monitor brightness down

echo "Reloading GNOME Shell (Wayland)…"
busctl --user call org.gnome.Shell /org/gnome/Shell org.gnome.Shell Eval "s" "global.reexec_self()"

echo "Done. Keybindings applied."

