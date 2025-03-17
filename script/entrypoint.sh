#!/bin/bash
# entrypoint.sh

# Seed Neovim configuration if the mounted /root/.config/nvim is empty.
if [ ! -d "/root/.config/nvim" ] || [ -z "$(ls -A /root/.config/nvim 2>/dev/null)" ]; then
    echo "Seeding default Neovim configuration data..."
    mkdir -p /root/.config/nvim
    cp -r /root/.default.config/nvim/* /root/.config/nvim/
fi

# Seed Neovim local share data if the mounted /root/.local/share/nvim is empty.
if [ ! -d "/root/.local/share/nvim" ] || [ -z "$(ls -A /root/.local/share/nvim 2>/dev/null)" ]; then
    echo "Seeding Neovim local data..."
    mkdir -p /root/.local/share/nvim
    cp -r /root/.default.local/share/nvim/* /root/.local/share/nvim/
fi

# Seed Neovim cache if the mounted /root/.cache/nvim is empty.
if [ ! -d "/root/.cache/nvim" ] || [ -z "$(ls -A /root/.cache/nvim 2>/dev/null)" ]; then
    echo "Seeding Neovim cache data..."
    mkdir -p /root/.cache/nvim
    cp -r /root/.default.cache/* /root/.cache/nvim/ || true
fi

# Seed Neovim state if the mounted /root/.local/state/nvim is empty.
if [ ! -d "/root/.local/state/nvim" ] || [ -z "$(ls -A /root/.local/state/nvim 2>/dev/null)" ]; then
    echo "Seeding Neovim state data..."
    mkdir -p /root/.local/state/nvim
    cp -r /root/.default.local/state/nvim/* /root/.local/state/nvim/ || true
fi

# If an argument is provided (a mounted project directory), configure it as a safe git directory.
if [ -n "$1" ]; then
    folder_name=$(basename "$1")
    echo "Adding /root/projects/${folder_name} as a safe git directory."
    git config --global --add safe.directory "/root/projects/${folder_name}"
fi

# Disable dubious ownership check globally.
git config --global --add safe.directory "*"

# Launch zsh.
exec zsh

