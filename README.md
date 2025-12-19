# Fedora Sway Dotfiles (Catppuccin Frappé)

![Sway](https://i.imgur.com/pIDFqOz.jpeg)

A minimalist, high-performance, and aesthetically pleasing Sway environment for Fedora. This setup is optimized for low resource usage, deep customization, and a seamless workflow.

## Tech Stack

* **OS:** Fedora Linux
* **WM:** Sway (Wayland)
* **Terminal:** Alacritty
* **Shell:** Bash (with Sway autostart via .bash_profile)
* **Launcher:** Bemenu (Catppuccin Frappé style)
* **Status Bar:** Swaybar (Minimalist status_command)
* **Notifications:** Mako
* **Browser:** Firefox
* **Text Editor:** Kate
* **File Manager:** Dolphin (QT6CT themed)
* **Font:** CommitMono (Nerd Font)
* **Colorscheme:** Catppuccin Frappé

## Installation Tutorial

Run the following commands to install all required packages, tools, and fonts:

```bash
# Install system packages
sudo dnf install sway alacritty xdg-desktop-portal-wlr swaybg swaylock swayidle bemenu mako wl-clipboard clipman grim slurp libnotify unzip ripgrep imv j4-dmenu-desktop wget playerctl meson ninja-build gcc gcc-c++ scdoc wayland-devel systemd-devel pulseaudio-libs-devel

# Install CommitMono Font
curl -sLO https://github.com/eigilnikolajsen/commit-mono/releases/download/v1.143/CommitMono-1.143.zip
unzip CommitMono-1.143.zip 
mkdir -p "$HOME/.local/share/fonts"
cp CommitMono*/*.otf "$HOME/.local/share/fonts/"
rm -r CommitMono*

# Install Nerd Fonts Symbols
curl -sLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/NerdFontsSymbolsOnly.zip
unzip NerdFontsSymbolsOnly.zip -d NerdFonts/
cp NerdFonts/SymbolsNerdFont* "$HOME/.local/share/fonts/"
rm -r NerdFonts*
fc-cache -f -v >/dev/null

# Compile and Install sway-audio-idle-inhibit (Prevents sleep during media playback)
git clone https://github.com/ErikReider/sway-audio-idle-inhibit.git
cd sway-audio-idle-inhibit
meson setup build && ninja -C build
sudo ninja -C build install

# Install Autotiling script
sudo wget -O /usr/local/bin/autotiling https://raw.githubusercontent.com/nwg-piotr/autotiling/master/autotiling/main.py
sudo chmod +x /usr/local/bin/autotiling
