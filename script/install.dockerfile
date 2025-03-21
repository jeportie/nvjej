# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    install.dockerfile                                 :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jeportie <jeportie@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/03/16 14:06:12 by jeportie          #+#    #+#              #
#    Updated: 2025/03/16 14:06:26 by jeportie         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


# **************************************************************************** #
# All Dependencies needed to be intalled on the Docker.
# **************************************************************************** #

# Essential Development Tools
apt-get update && apt-get install -y \
    build-essential \
	cmake \
    make \
    git \
    bear \
    tree \
    ripgrep \
    curl \
    wget \
	npm \
	expect \
    unzip \
    tar \
    p7zip-full && \
    rm -rf /var/lib/apt/lists/*

# Shell Environment
apt-get update && apt-get install -y \
    zsh \
    libreadline-dev && \
    rm -rf /var/lib/apt/lists/*

# Debugging Tools
apt-get update && apt-get install -y \
    valgrind \
    check \
    lldb && \
    rm -rf /var/lib/apt/lists/*

# X11 and Graphics Dependencies
apt-get update && apt-get install -y \
    libxext-dev \
    libx11-dev \
    libbsd-dev \
    x11-apps \
    xclip && \
    rm -rf /var/lib/apt/lists/*

# Minilibx Install
git clone https://github.com/42Paris/minilibx-linux.git /opt/minilibx \
	&& cd /opt/minilibx \
	&& make

# Python Environment
apt-get update && apt-get install -y \
    python3-pip \
    python3-venv && \
    rm -rf /var/lib/apt/lists/*

# Node.js Environment
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh
nvm install v22.14.0

# Google Test Install
apt-get update && apt-get install -y \
    libgtest-dev && \
    cd /usr/src/gtest && \
    cmake . && \
    make && \
    cp lib/*.a /usr/lib/ && \
    ldconfig

# Install Lua Interpreters *************************************************** #
apt-get update && apt-get install -y \
    lua5.3 lua5.3-dev \
    lua5.1 lua5.1-dev && \
    rm -rf /var/lib/apt/lists/*

# LuaRocks and Lua Modules Installation ************************************** #
wget https://luarocks.org/releases/luarocks-3.11.1.tar.gz && \
    tar zxpf luarocks-3.11.1.tar.gz && \
    cd luarocks-3.11.1 && \
    ./configure && make && make install && \
    luarocks install luasocket && \
    luarocks install busted && \
    luarocks --lua-version=5.1 install vusted && \
    cd .. && rm -rf luarocks-3.11.1 luarocks-3.11.1.tar.gz

# Install MCP Hub
npm install -g mcp-hub@1.7.1
