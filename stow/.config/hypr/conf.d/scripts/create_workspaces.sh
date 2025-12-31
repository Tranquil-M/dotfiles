#!/bin/bash

MONITORS=$(hyprctl monitors -j | jq -r '.[].name')
WORKSPACE=1

for MONITOR in $MONITORS; do
    for WORKSPACE_OFFSET in {0..2}; do
        CURRENT_WORKSPACE=$((WORKSPACE))
        hyprctl dispatch workspace "$CURRENT_WORKSPACE"
        hyprctl dispatch moveworkspacetomonitor "$CURRENT_WORKSPACE" "$MONITOR"
    done
    WORKSPACE=$((WORKSPACE + 3))
done
