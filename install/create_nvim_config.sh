#!/usr/bin/env bash
set -euo pipefail

rm -rf ~/.config/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.local/share/nvim

git clone https://github.com/NvChad/starter ~/.config/nvim/
cd ~/.config/nvim
git clone https://github.com/NvChad/pywal

echo "os.execute(\"python ~/.config/nvim/pywal/chadwal.py &> /dev/null &\")

local autocmd = vim.api.nvim_create_autocmd

autocmd(\"Signal\", {
  pattern = \"SIGUSR1\",
  callback = function()
    require('nvchad.utils').reload()
  end
})" >> init.lua
