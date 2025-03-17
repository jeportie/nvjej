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
    make \
    git \
    bear \
    tree \
    ripgrep \
    curl \
    wget \
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
apt-get update && apt-get install -y \
    nodejs \
    npm && \
    rm -rf /var/lib/apt/lists/*
