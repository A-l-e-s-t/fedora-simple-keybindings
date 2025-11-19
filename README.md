# fedora-simple-keybindings
Simplified and memorable GNOME keybindings for Fedora, applied automatically with one script.

## Quick Overview

This project provides a streamlined, layered GNOME keybinding system for Fedora.
It replaces GNOME’s default shortcuts with a consistent, mnemonic layout that groups actions by modifier keys:

- Super → Window management and system navigation
- Ctrl + Super → Application launching
- Alt + Super → Media and accessibility controls

All shortcuts are applied automatically via a single script that backs up your existing configuration, loads the new keybindings, and reloads GNOME Shell.

## Keybindings
<details>
<summary>Expand</summary>

### **Super Layer**

| Action | Keybinding | Comment |
|--------|-------------|------|
| Move window | **Super + M** |  |
| Resize window | **Super + R** |  |
| Quit window | **Super + Q** |  |
| Hide window | **Super + H** | Minimize window |
| Maximize / Unmaximize | **Super + Up / Down** | Default |
| Snap window to Left / Right | **Super + ← / →** | Default |
| Maximize horizontally / vertically | **Super + End / Home** |  |
| Center window | **Super + C** |  |
| Toggle fullscreen | **Super + F** |  |
| Toggle always-on-top | **Super + T** |  |
| Toggle show desktop | **Shift + Super + H** |  |
| Toggle show on all workspaces | **Super + W** |  |
| Switch workspace 1–10 | **Super + 1–0** |  |
| Move window to workspace 1–10 | **Super + Shift + 1–0** |  |
| Switch workspace left / right | **Super + – / =** |  |
| Move window to workspace left / right | **Shift + Super + – / =** |  |
| Force Suspend | **Shift + Super + S** | `systemctl suspend -i` *(custom)* |
| Lock screen | **Super + L** | Default |
| Log out | **Shift + Super + L** |  |
| Power off | **Shift + Super + P** |  |
| Restart | **Shift + Super + R** |  |
| Toggle notification tray | **Super + N** |  |
| Toggle quick settings | **Super + S** |  |
| Toggle application grid | **Super + A** | Default |
| Run Command Dialog | **Shift + Super + T** | opens run command prompt |
| Focus active notification | **Shift + Super + N** | focuses system notification | 

---

### **Ctrl + Super Layer**

| Action | Keybinding | Comment |
|--------|-------------|------|
| Open Calculator | **Ctrl + Super + C** |  |
| Open Settings | **Ctrl + Super + S** |  |
| Open Software | **Ctrl + Shift + Super + S** | `gnome-software` *(custom)* |
| Open Browser | **Ctrl + Super + B** | opens default browser |
| Open Files | **Ctrl + Super + F** | `nautilus --new-window` *(custom)* |
| Open Terminal | **Ctrl + Super + T** | `ptyxis --new-window` *(custom)* |
| Open Notes | **Ctrl + Super + N** | `gnome-text-editor --new-window` *(custom)* |
| Open System Monitor | **Ctrl + Super + M** | `gnome-system-monitor` *(custom)* |
| Open Help | **Ctrl + Super + F1** |  |

---

### **Alt + Super Layer**

| Action | Keybinding | Comment |
|--------|-------------|------|
| Volume Up / Down / Mute | **Alt + Super + Up / Down / M** |  |
| Microphone Mute | **Shift + Alt + Super + M** |  |
| Previous / Play / Next | **Alt + Super + ← / Space / →** |  |
| Zoom Toggle | **Alt + Super + Z** |  |
| Zoom In / Out | **Alt + Super + = / –** |  |
| Toggle High Contrast | **Alt + Super + C** | Doesn't work for me |
| Screen Reader | **Alt + Super + R** |  |
| On-Screen Keyboard | **Alt + Super + K** |  |
| Decrease / Increase Text Size | **Alt + Super + [ / ]** |  |
| Screen Brightness Up / Down | **Alt + Super + PgUp / PgDn** | Requires additional set up (below), `brightnessctl set +5% / 5%-` *(custom)* |

---

### **PrintScreen Layer**

| Action | Keybinding | Comment |
|--------|-------------|------|
| Interactive Screenshot | **PrtScn** | Default |
| Screenshot of a window | **Alt + PrtScn** | Default |
| Full Screenshot | **Super + PrtScn** |  |
| Screen Recording | **Shift + PrtScn** |  |

---

Some keybindings weren't listed as they were untouched.

### **Summary**

This layout unifies all system actions under consistent modifier layers:

- **Super** → Window, workspace, and system navigation
- **Ctrl + Super** → Application launching
- **Alt + Super** → Media, accessibility, and system utilities
- **PrintScreen** → Capture and recording tools

Each layer is mnemonic, conflict-free, and script-driven for easy customization.

### Downsides
Some useful keybinding are not used like:

- Super + PgUp / PgDn
- Super + grave 
- Super + Enter 
- Super + Esc
- Alt + grave 
- Alt + Tab 
- ...

If you have ideas for additional keybindings, feel free to share them.


</details>

## Set Up
Install `zsh`:
```bash
sudo dnf install zsh
```

Clone the repository and navigate:
```bash
git clone https://github.com/A-l-e-s-t/fedora-simple-keybindings
cd fedora-simple-keybindings
```

Make `apply-keybindings.sh` executable:
```bash
chmod +x apply-keybindings.sh
```

Run `apply-keybindings.sh` (backs up your current keybindings):
```bash
./apply-keybindings.sh
```
You have installed my keybindings. You can also install additional custom keybindings.

If you want to revert to your old keybindings:
```bash
./revert-keybindings.sh
```

## Additional Custom Keybindings
### Windows Switching Behavior
Schema keys:

1. `switch-windows` — cycles through individual windows across all applications, showing window preview per opened window.
2. `switch-applications` — cycles between applications, showing one icon per app group.
3. `switch-group` — cycles between windows of the same application.

By default, my layout maps `<Super>Tab` to `switch-windows`, you can switch to GNOME’s default behavior `switch-applications` + `switch-group`, which use `<Super>Tab` + `<Super>grave`, respectively.

Switch to `switch-applications` + `switch-group`:
```bash
gsettings set org.gnome.desktop.wm.keybindings switch-windows "@as []"
gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "@as []"

gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Super>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "['<Shift><Super>Tab']"

gsettings set org.gnome.desktop.wm.keybindings switch-group "['<Super>grave']"
gsettings set org.gnome.desktop.wm.keybindings switch-group-backward "['<Shift><Super>grave']"
```

Revert to `switch-windows` (my default layout)
```bash
gsettings set org.gnome.desktop.wm.keybindings switch-applications "@as []"
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "@as []"

gsettings set org.gnome.desktop.wm.keybindings switch-group "@as []"
gsettings set org.gnome.desktop.wm.keybindings switch-group-backward "@as []"

gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Super>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "['<Shift><Super>Tab']"
```
### Docked Apps Launching Behavior
Schema keys:

1. `switch-to-application-N` — switches to an existing instance; launches a new one if not running.
2. `open-new-window-application-N` — always opens a new window for application N.

By default, my layout maps `<Super><Control><key>` to `switch-to-application-N`; you can change it to `open-new-window-application-N` if you prefer.

Switch to `open-new-window-application-N`:
```bash
for i in {1..9}; do
  gsettings set org.gnome.shell.keybindings switch-to-application-$i "@as []"
done

for i in {1..9}; do
  gsettings set org.gnome.shell.keybindings open-new-window-application-$i "['<Super><Control>${i}']"
done
```

Revert to `switch-to-application-N` (my default layout)
```bash
for i in {1..9}; do
  gsettings set org.gnome.shell.keybindings open-new-window-application-$i "@as []"
done

for i in {1..9}; do
  gsettings set org.gnome.shell.keybindings switch-to-application-$i "['<Super><Control>${i}']"
done
```
### Open System Monitor
I recommend using Mission Center instead of System Monitor

Install Mission Center
```
flatpak install flathub io.missioncenter.MissionCenter
```

Update keybinding
```bash
./set-custom-keybinding.sh 19325306 "Open Mission Center" "flatpak run io.missioncenter.MissionCenter" "<Control><Super>m"
```

Revert
```bash
./set-custom-keybinding.sh 19325306 "Open System Monitor" "gnome-system-monitor" "<Control><Super>m"

flatpak uninstall io.missioncenter.MissionCenter
```

### Adjust Brightness (Laptop)
Install dependency:
```bash
sudo dnf install brightnessctl
```

Set keybindings
```bash
./set-custom-keybinding.sh 19325307 "Laptop monitor brightness up" "brightnessctl set +5%" "<Alt><Super>Page_Up"
./set-custom-keybinding.sh 19325308 "Laptop monitor brightness down" "brightnessctl set 5%-" "<Alt><Super>Page_Down"
```
Revert
```bash
./delete-custom-keybinding.sh 19325307
./delete-custom-keybinding.sh 19325308

sudo dnf remove brightnessctl
```


`brightnessctl` is especially useful because it can dim your screen completely (to 0%).

If you want to control external monitor brightness use `ddcutil` (via DDC)

