# ============================================================================
# Oh My Zsh Configuration
# ============================================================================

# Determine oh-my-zsh installation path based on OS
if [[ "$MACHINE_OS" == "Darwin" ]]; then
    export ZSH="/users/$USER/.oh-my-zsh"
else
    export ZSH="/home/$USER/.oh-my-zsh"
    ZSH_DISABLE_COMPFIX=true
fi

# Theme
ZSH_THEME=agnoster

# Plugins
plugins=(zsh-autosuggestions docker docker-compose zsh-autocomplete)

# Auto-update configuration
zstyle ':omz:update' mode auto

# Initialize oh-my-zsh
source $ZSH/oh-my-zsh.sh
