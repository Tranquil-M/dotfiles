echo "Applying Hyprland Colorscheme..."
cd "$HOME"
if command -v matugen >/dev/null 2>&1; then
  matugen image "${wall_dir}/${wall_selection}" --source-color-index 0 || matugen image "${wall_dir}/${wall_selection}"
  swww img --resize crop --transition-type center "${wall_dir}/${wall_selection}"
fi
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3'

rm -- "$0"
