# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs

export QT_QPA_PLATFORMTHEME=qt6ct
export QT_WAYLAND_FORCE_DPI=physical
export QT_QPA_PLATFORM=wayland

if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec sway
fi

