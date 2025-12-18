# Fedora Sway Dotfiles

![Sway](https://i.imgur.com/KZXqSby.jpeg)

## Tutorial

```
sudo dnf install sway alacritty xdg-desktop-portal-wlr swaybg swaylock swayidle bemenu mako wl-clipboard grim slurp libnotify unzip ripgrep imv  j4-dmenu-desktop wget
curl -sLO https://github.com/eigilnikolajsen/commit-mono/releases/download/v1.143/CommitMono-1.143.zip
unzip CommitMono-1.143.zip 
mkdir -p "$HOME/.local/share/fonts"
cp CommitMono*/*.otf "$HOME/.local/share/fonts/"
rm -r CommitMono*
curl -sLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/NerdFontsSymbolsOnly.zip
unzip NerdFontsSymbolsOnly.zip -d NerdFonts/
cp NerdFonts/SymbolsNerdFont* .local/share/fonts/
rm -r NerdFonts*
fc-cache -f -v >/dev/null
sudo wget -O /usr/local/bin/autotiling https://raw.githubusercontent.com/nwg-piotr/autotiling/master/autotiling/main.py
chmod +x /usr/local/bin/autotiling
```
