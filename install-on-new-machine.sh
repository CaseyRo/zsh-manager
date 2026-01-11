#!/bin/bash
# ============================================================================
#
#   ███████╗███████╗██╗  ██╗      ███╗   ███╗ █████╗ ███╗   ██╗ █████╗  ██████╗ ███████╗██████╗
#   ╚══███╔╝██╔════╝██║  ██║      ████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝ ██╔════╝██╔══██╗
#     ███╔╝ ███████╗███████║█████╗██╔████╔██║███████║██╔██╗ ██║███████║██║  ███╗█████╗  ██████╔╝
#    ███╔╝  ╚════██║██╔══██║╚════╝██║╚██╔╝██║██╔══██║██║╚██╗██║██╔══██║██║   ██║██╔══╝  ██╔══██╗
#   ███████╗███████║██║  ██║      ██║ ╚═╝ ██║██║  ██║██║ ╚████║██║  ██║╚██████╔╝███████╗██║  ██║
#   ╚══════╝╚══════╝╚═╝  ╚═╝      ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝
#
#   New Machine Setup Script
#   https://github.com/CaseyRo/zsh-manager
#
# ============================================================================

set -e

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_DIR="$SCRIPT_DIR/install"

# Source utilities and package lists
source "$INSTALL_DIR/utils.sh"
source "$INSTALL_DIR/packages.sh"
source "$INSTALL_DIR/brew.sh"
source "$INSTALL_DIR/rust.sh"
source "$INSTALL_DIR/nvm.sh"
source "$INSTALL_DIR/oh-my-zsh.sh"

# ============================================================================
# Main Installation
# ============================================================================

main() {
    clear

    print_header "ZSH-Manager: New Machine Setup"

    echo -e "  ${DIM}This script will install:${RESET}"
    echo -e "  ${SYMBOL_BULLET} Homebrew + CLI tools (bat, zoxide, eza, etc.)"
    echo -e "  ${SYMBOL_BULLET} Rust & Cargo"
    echo -e "  ${SYMBOL_BULLET} NVM + Node.js LTS + global packages (pm2, node-red)"
    echo -e "  ${SYMBOL_BULLET} Oh My Zsh + plugins"
    echo -e "  ${SYMBOL_BULLET} ZSH-Manager configuration"
    echo ""
    echo -e "  ${DIM}Safe to re-run - already installed items will be skipped.${RESET}"
    echo ""

    # Confirm before proceeding
    read -p "  Continue? [Y/n] " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]] && [[ -n $REPLY ]]; then
        echo -e "  ${YELLOW}Aborted.${RESET}"
        exit 0
    fi

    # Detect OS
    print_section "System Detection"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        print_info "Detected: macOS"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        print_info "Detected: Linux"
        if [[ -f /etc/os-release ]]; then
            source /etc/os-release
            print_info "Distribution: $PRETTY_NAME"
        fi
    else
        print_info "Detected: $OSTYPE"
    fi

    # Install components
    install_homebrew
    install_brew_packages
    install_brew_casks

    install_rust
    install_cargo_packages

    install_nvm
    install_node
    install_npm_global_packages

    install_oh_my_zsh
    install_zsh_plugins

    # Setup zsh-manager symlink
    print_section "ZSH-Manager Configuration"
    ZSHRC_TARGET="$HOME/.zshrc"

    if [[ -L "$ZSHRC_TARGET" ]] && [[ "$(readlink "$ZSHRC_TARGET")" == "$SCRIPT_DIR/.zshrc" ]]; then
        print_skip "zshrc symlink"
    else
        if [[ -f "$ZSHRC_TARGET" ]] || [[ -L "$ZSHRC_TARGET" ]]; then
            print_step "Backing up existing .zshrc"
            mv "$ZSHRC_TARGET" "$ZSHRC_TARGET.backup.$(date +%Y%m%d_%H%M%S)"
            print_success "Backup created"
        fi

        print_step "Creating symlink"
        ln -s "$SCRIPT_DIR/.zshrc" "$ZSHRC_TARGET"
        print_success "~/.zshrc → $SCRIPT_DIR/.zshrc"
    fi

    # Done!
    print_summary
}

# Run main function
main "$@"
