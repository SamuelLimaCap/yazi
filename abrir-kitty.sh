#!/usr/bin/env bash
# Abre arquivos no lvim-react em outra aba ou num split do kitty.
# Uso: abrir-kitty.sh aba|split ARQUIVO...
modo=$1; shift
[ $# -eq 0 ] && exit 0
dir=$(dirname "$1")
nv=(--env NVIM_APPNAME=lvim-react /snap/bin/nvim "$@")

if ! command -v kitten >/dev/null || [ -z "$KITTY_WINDOW_ID$KITTY_LISTEN_ON" ]; then
  # Fora do kitty: abre no próprio terminal.
  exec env NVIM_APPNAME=lvim-react /snap/bin/nvim "$@"
fi

case $modo in
  aba)
    kitten @ launch --type=tab --cwd="$dir" --tab-title "$(basename "$1")" "${nv[@]}" ;;
  split)
    # Split lado a lado só existe no layout "splits"
    kitten @ goto-layout splits
    kitten @ launch --type=window --location=vsplit --cwd="$dir" "${nv[@]}" ;;
esac
