# ============================================================================
# Common Initialization
# ============================================================================
# Loaded on all systems before OS-specific configs

# Machine detection (available for use in other modules)
export MACHINE_HOSTNAME=$(hostname)
export MACHINE_OS=$(uname)
export MACHINE_USER=$(whoami)

# History configuration
HISTFILE=$HOME/dotfiles/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Completion system
zstyle :compinstall filename '$HOME/.zshrc'
autoload -Uz compinit
compinit
