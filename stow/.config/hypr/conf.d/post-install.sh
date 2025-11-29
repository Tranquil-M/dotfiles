echo "Applying Hyprland Colorscheme..."
cd "$HOME"
if command -v matugen >/dev/null 2>&1; then
    matugen -q image "Pictures/Wallpapers/White-Cat.png" >/dev/null 2>&1
fi
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3'

rm -- "$0"
