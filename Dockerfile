# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jeportie <jeportie@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/03/12 12:58:41 by jeportie          #+#    #+#              #
#    Updated: 2025/03/16 14:26:57 by jeportie         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Base System Configuration ************************************************** #
FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

# Locale Configuration ******************************************************* #
RUN apt-get update && apt-get install -y locales locales-all && \
    locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8 && \
    rm -rf /var/lib/apt/lists/*
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
WORKDIR /root

# Copy and execute installation script *************************************** #
COPY script/install.dockerfile /tmp/install.dockerfile
RUN chmod +x /tmp/install.dockerfile
RUN bash /tmp/install.dockerfile && rm /tmp/install.dockerfile

# Create a Python virtual environment and install : 
# pip, setuptools, pynvim and norminette ************************************* #
RUN python3 -m venv /root/venv && \
    /root/venv/bin/pip install --upgrade pip setuptools pynvim
ENV VIRTUAL_ENV_DISABLE_PROMPT=1
ENV PATH="/root/venv/bin:${PATH}"
RUN /root/venv/bin/pip install norminette

# Install & config docker shell UI ******************************************* #
RUN sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" "" --unattended && \
    sed -i 's/ZSH_THEME=".*"/ZSH_THEME="agnoster"/' ~/.zshrc
RUN chsh -s $(which zsh)
RUN touch ~/.zsh_history && chmod 600 ~/.zsh_history
RUN npm i @vscode/codicons
COPY custom/custom_agnoster.zsh-theme /root/.oh-my-zsh/themes/agnoster.zsh-theme
COPY config/nvjej.zshrc /root/.zshrc
COPY config/allman.clang-format /root/.clang-format-styles/Allman
COPY config/mcpservers.json /root/.mcp/mcpservers.json

# Set the entrypoint to launch the customized shell ************************** #
COPY script/entrypoint.sh /sh/entrypoint.sh
RUN chmod +x /sh/entrypoint.sh
ENTRYPOINT ["/sh/entrypoint.sh"]
RUN git config --global user.email "jeportie@student.42.fr"
RUN git config --global user.name "jeportie"

# Install the latest stable Neovim + NVChad Base Disrto ********************** #
RUN wget https://github.com/neovim/neovim/releases/download/v0.10.4/nvim-linux-x86_64.tar.gz && \
    tar -xzf nvim-linux-x86_64.tar.gz && \
    cp -r nvim-linux-x86_64/* /usr/local/ && \
    rm -rf nvim-linux-x86_64.tar.gz nvim-linux-x86_64
RUN git clone https://github.com/NvChad/starter ~/.config/nvim && \
    rm -rf ~/.config/nvim/.git

# Bash Scripts copy ********************************************************** #
COPY script/update_makefile.sh /sh/update_makefile.sh

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash && \
    . ~/.nvm/nvm.sh && \
    nvm install node

#RUN nvm install v22.14.0 
#RUN npm install -g mcp-hub@1.7.1

RUN nvim --headless +"Lazy! sync" +qa

# Copy lua config files ****************************************************** #
COPY lua/chadrc.lua /root/.config/nvim/lua/chadrc.lua
COPY lua/options.lua /root/.config/nvim/lua/options.lua
COPY lua/cmp.lua /root/.local/share/nvim/lazy/NvChad/lua/nvchad/configs/cmp.lua
COPY lua/lspconfig.lua /root/.config/nvim/lua/configs/lspconfig.lua
COPY lua/lsp_servers.lua /root/.config/nvim/lua/custom/lsp_servers.lua
COPY lua/lazy.lua /root/.config/nvim/lua/plugins/lazy.lua
COPY lua/mappings.lua /root/.config/nvim/lua/custom/mappings.lua
COPY lua/null-ls.lua /root/.config/nvim/lua/custom/configs/null-ls.lua
COPY lua/mappings.lua /root/.local/share/nvim/lazy/NvChad/lua/nvchad/mappings.lua

# Trigger lazy.nvim to sync plugins in headless mode ************************* #
RUN nvim --headless +"Lazy! sync" +qa

# COPY mounted volumes to default
RUN cp -r /root/.cache /root/.default.cache
RUN cp -r /root/.config /root/.default.config
RUN cp -r /root/.local /root/.default.local
