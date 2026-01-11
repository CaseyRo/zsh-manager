# ============================================================================
# Package Lists
# ============================================================================
# Edit these arrays to customize what gets installed on new machines.
# ============================================================================

# Homebrew packages (installed via brew install)
BREW_PACKAGES=(
    "zsh"
    "bat"
    "zoxide"
    "topgrade"
    "hyfetch"
    "eza"        # modern ls replacement
    "ripgrep"    # fast grep
    "fd"         # fast find
    "fzf"        # fuzzy finder
    "byobu"      # terminal multiplexer
)

# Homebrew casks (macOS GUI apps, skipped on Linux)
BREW_CASKS=(
    # Add any GUI apps here, e.g.:
    # "iterm2"
    # "visual-studio-code"
)

# Cargo packages (installed via cargo install)
# Used for packages not available in brew, or if you prefer cargo versions
CARGO_PACKAGES=(
    # Add cargo packages here if needed, e.g.:
    # "du-dust"
    # "bottom"
)

# Global npm packages (installed via npm install -g)
NPM_GLOBAL_PACKAGES=(
    "pm2"
    "node-red"
)
