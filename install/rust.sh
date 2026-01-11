#!/bin/bash
# ============================================================================
# Rust & Cargo Installation
# ============================================================================

install_rust() {
    print_section "Rust"

    if command_exists rustc && command_exists cargo; then
        print_skip "Rust/Cargo"
        print_step "Updating Rust"
        run_with_spinner "Updating Rust" rustup update
        print_success "Rust updated"
    else
        print_step "Installing Rust via rustup"
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

        # Add cargo to PATH for this session
        if [[ -f "$HOME/.cargo/env" ]]; then
            source "$HOME/.cargo/env"
        fi

        if command_exists cargo; then
            print_success "Rust installed"
        else
            print_error "Rust installation failed"
            return 1
        fi
    fi
}

install_cargo_packages() {
    if [[ ${#CARGO_PACKAGES[@]} -eq 0 ]]; then
        return 0
    fi

    print_section "Cargo Packages"

    for package in "${CARGO_PACKAGES[@]}"; do
        if cargo install --list | grep -q "^$package "; then
            print_skip "$package"
        else
            print_package "$package"
            if run_with_spinner "Installing $package" cargo install "$package"; then
                print_success "$package installed"
            else
                print_error "Failed to install $package"
            fi
        fi
    done
}
