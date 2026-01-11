# ============================================================================
# Common Tools & Utilities
# ============================================================================

# Znap (zsh plugin manager)
[[ -r ~/dotfiles/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/dotfiles/znap
source ~/dotfiles/znap/znap.zsh

# Zoxide (smart directory jumper)
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi

# Envman
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# Source additional environment file if it exists
[ -s "$HOME/.local/bin/env" ] && source "$HOME/.local/bin/env"
