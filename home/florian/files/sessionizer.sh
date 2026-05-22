#!/usr/bin/env bash
# tmux sessionizer : pick a project dir via fzf, attach to a tmux session for it.
# Bound to prefix + f in tmux.nix.

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/dev ~/obsidian-vault ~/nixos-config -mindepth 0 -maxdepth 2 -type d 2>/dev/null | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s "$selected_name" -c "$selected"
    exit 0
fi

if ! tmux has-session -t="$selected_name" 2>/dev/null; then
    tmux new-session -ds "$selected_name" -c "$selected"
fi

tmux switch-client -t "$selected_name"
