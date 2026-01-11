# ============================================================================
# Zsh Autocomplete Setup
# ============================================================================
# Installs zsh-autocomplete if not already installed
# Oh-my-zsh will source it via the plugins array in oh-my-zsh.sh

ZSH_AUTOCOMPLETE_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autocomplete"

# Install if not present
if [[ ! -d "$ZSH_AUTOCOMPLETE_DIR" ]]; then
    echo "Installing zsh-autocomplete..."
    git clone --depth 1 https://github.com/marlonrichert/zsh-autocomplete.git "$ZSH_AUTOCOMPLETE_DIR"
fi
