export DEFAULT_USER="nvjej"
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

ZSH_COMPDUMP=/tmp/zcompdump

plugins=(
    git
    dirhistory 
    copypath 
    web-search 
    sudo 
    npm
)

VENV_PATH="/root/venv/bin/activate"

if [ -f "$VENV_PATH" ]; then
    source "$VENV_PATH"
    echo "Virtual environment activated."
else
    echo "Virtual environment not found at $VENV_PATH"
fi

source $ZSH/oh-my-zsh.sh

alias venv="source /root/venv/bin/activate"

alias vi="vim"

vim() {
    FLAG="/root/.cache/nvim/mason_installed.flag"
    if [ ! -f "$FLAG" ]; then
        nvim -c 'MasonInstall clang-format codelldb' -c "TSInstall c cpp bash cmake make" "$@"
        # Create the flag file so we don't run initialization again
        touch "$FLAG"
    else
        nvim "$@"
    fi
}

pause() {
    if [ -n "$1" ]; then
        COMMIT=$(basename "$1")
    else
        COMMIT="push pause"
    fi
    git add . && git commit -m "$COMMIT" && git push && git status
}

sepcat() {
  # If no arguments, use the default glob pattern
  if [ "$#" -eq 0 ]; then
    set -- */*
  fi

  for file in "$@"; do
    if [ -f "$file" ]; then
      echo "===== $file ====="
      cat "$file"
    fi
  done
}

cform() {
  # Define the available styles.
  local styles=("LLVM" "Google" "Chromium" "Mozilla" "WebKit" "Microsoft" "GNU")
  
  echo "Select a clang-format style:"
  select style in "${styles[@]}"; do
    if [[ -n $style ]]; then
      ~/.local/share/nvim/mason/bin/clang-format --style "$style" --dump-config > .clang-format
      echo ".clang-format file created with style $style"
      break
    else
      echo "Invalid selection. Please try again."
    fi
  done
}

alias maj="bash /sh/update_makefile.sh"
