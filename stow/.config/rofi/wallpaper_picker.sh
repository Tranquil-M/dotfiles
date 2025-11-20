#!/bin/bash

wall_dir="${HOME}/Pictures/Wallpapers"
cacheDir="${HOME}/.cache/jp/${theme:-default}"
mkdir -p "${cacheDir}"

thumb_size=50

rofi_override="
element-icon {
    size: ${thumb_size}px;
    border-radius: 4px;
}
listview {
    columns: 3;
    rows: 2;
    scrollbar: true;
    dynamic: true;
    cycle: false;
}
window {
    width: 60%;
    height: 60%;
}
"


rofi_command="rofi -x11 -dmenu -show-icons true \
-theme ${HOME}/.config/rofi/config.rasi \
-theme-str \"${rofi_override}\""

# Generate thumbnails
shopt -s nullglob
for imagen in "$wall_dir"/*.{jpg,jpeg,png}; do
    [ -f "$imagen" ] || continue
    nombre_archivo=$(basename "$imagen")
    out="${cacheDir}/${nombre_archivo}"
    if [ ! -f "$out" ]; then
        convert -strip "$imagen" -thumbnail 100x100^ -gravity center -extent 100x100 "$out"
    fi
done

# Feed into rofi
wall_selection=$(
    find "${wall_dir}" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) |
    sort |
    while read -r A; do
        printf "%s\x00icon\x1f%s\n" "$(basename "$A")" "${cacheDir}/$(basename "$A")"
    done | eval "$rofi_command"
)

[[ -n "$wall_selection" ]] || exit 1
matugen image "${wall_dir}/${wall_selection}"
