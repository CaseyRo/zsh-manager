#!/bin/bash
# ============================================================================
# NVM & Node.js Installation
# ============================================================================

install_nvm() {
    print_section "NVM (Node Version Manager)"

    export NVM_DIR="$HOME/.nvm"

    if [[ -d "$NVM_DIR" ]] && [[ -s "$NVM_DIR/nvm.sh" ]]; then
        print_skip "NVM"
        # Load nvm for this session
        source "$NVM_DIR/nvm.sh"
    else
        print_step "Installing NVM"
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

        # Load nvm for this session
        if [[ -s "$NVM_DIR/nvm.sh" ]]; then
            source "$NVM_DIR/nvm.sh"
            print_success "NVM installed"
        else
            print_error "NVM installation failed"
            return 1
        fi
    fi
}

install_node() {
    print_section "Node.js"

    if ! command_exists nvm; then
        # Try loading nvm
        export NVM_DIR="$HOME/.nvm"
        [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
    fi

    if ! command_exists nvm; then
        print_error "NVM not available, skipping Node.js installation"
        return 1
    fi

    # Check if any node version is installed
    if nvm list 2>/dev/null | grep -q "v[0-9]"; then
        local current_version=$(nvm current 2>/dev/null)
        print_skip "Node.js ($current_version)"
        print_step "Checking for updates"

        # Check if there's a newer LTS version
        local latest_lts=$(nvm version-remote --lts 2>/dev/null)
        if [[ "$current_version" != "$latest_lts" ]] && [[ -n "$latest_lts" ]]; then
            print_info "Newer LTS available: $latest_lts"
            print_step "Installing Node.js $latest_lts"
            nvm install --lts &>/dev/null
            nvm use --lts &>/dev/null
            nvm alias default 'lts/*' &>/dev/null
            print_success "Node.js updated to $latest_lts"
        else
            print_success "Already on latest LTS"
        fi
    else
        print_step "Installing Node.js LTS"
        nvm install --lts
        nvm use --lts
        nvm alias default 'lts/*'

        if command_exists node; then
            print_success "Node.js $(node --version) installed"
        else
            print_error "Node.js installation failed"
            return 1
        fi
    fi
}

install_npm_global_packages() {
    if [[ ${#NPM_GLOBAL_PACKAGES[@]} -eq 0 ]]; then
        return 0
    fi

    print_section "Global npm Packages"

    if ! command_exists npm; then
        print_error "npm not available, skipping global packages"
        return 1
    fi

    for package in "${NPM_GLOBAL_PACKAGES[@]}"; do
        if npm list -g "$package" &>/dev/null; then
            print_skip "$package"
        else
            print_package "$package"
            if run_with_spinner "Installing $package" npm install -g "$package"; then
                print_success "$package installed"
            else
                print_error "Failed to install $package"
            fi
        fi
    done
}
