# ============================================================================
# Zsh Autosuggestions Setup
# ============================================================================
# Installs zsh-autosuggestions if not already installed
# Oh-my-zsh will source it via the plugins array in oh-my-zsh.sh

ZSH_AUTOSUGGESTIONS_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

# Install if not present
if [[ ! -d "$ZSH_AUTOSUGGESTIONS_DIR" ]]; then
    echo "Installing zsh-autosuggestions..."
    git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_AUTOSUGGESTIONS_DIR"
fi
