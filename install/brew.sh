#!/bin/bash
# ============================================================================
# Homebrew Installation
# ============================================================================

install_homebrew() {
    print_section "Homebrew"

    if command_exists brew; then
        print_skip "Homebrew"
        track_skipped "Homebrew"
        print_step "Updating Homebrew"
        run_with_spinner "Updating Homebrew" brew update
        print_success "Homebrew updated"
    else
        print_step "Installing Homebrew"
        if [[ "$VERBOSE" == true ]]; then
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        else
            NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" &>/dev/null
        fi

        # Add brew to PATH for this session
        if [[ "$OSTYPE" == "darwin"* ]]; then
            if [[ -f /opt/homebrew/bin/brew ]]; then
                eval "$(/opt/homebrew/bin/brew shellenv)"
            elif [[ -f /usr/local/bin/brew ]]; then
                eval "$(/usr/local/bin/brew shellenv)"
            fi
        elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        fi

        if command_exists brew; then
            print_success "Homebrew installed"
            track_installed "Homebrew"
        else
            print_error "Homebrew installation failed"
            track_failed "Homebrew"
            return 1
        fi
    fi
}

install_brew_packages() {
    print_section "Brew Packages"

    for package in "${BREW_PACKAGES[@]}"; do
        if brew list "$package" &>/dev/null; then
            print_skip "$package"
            track_skipped "$package"
        else
            print_package "$package"
            if run_with_spinner "Installing $package" brew install "$package"; then
                print_success "$package installed"
                track_installed "$package"
            else
                print_error "Failed to install $package"
                track_failed "$package"
            fi
        fi
    done
}

install_brew_casks() {
    # Only run on macOS
    if [[ "$OSTYPE" != "darwin"* ]]; then
        return 0
    fi

    if [[ ${#BREW_CASKS[@]} -eq 0 ]]; then
        return 0
    fi

    print_section "Brew Casks (macOS Apps)"

    for cask in "${BREW_CASKS[@]}"; do
        if brew list --cask "$cask" &>/dev/null; then
            print_skip "$cask"
            track_skipped "$cask"
        else
            print_package "$cask"
            if run_with_spinner "Installing $cask" brew install --cask "$cask"; then
                print_success "$cask installed"
                track_installed "$cask"
            else
                print_error "Failed to install $cask"
                track_failed "$cask"
            fi
        fi
    done
}

install_brew_packages_linux() {
    # Only run on Linux (not macOS)
    if [[ "$OSTYPE" == "darwin"* ]]; then
        return 0
    fi

    if [[ ${#BREW_PACKAGES_LINUX[@]} -eq 0 ]]; then
        return 0
    fi

    print_section "Linux Packages (Docker)"

    for package in "${BREW_PACKAGES_LINUX[@]}"; do
        if brew list "$package" &>/dev/null; then
            print_skip "$package"
            track_skipped "$package"
        else
            print_package "$package"
            if run_with_spinner "Installing $package" brew install "$package"; then
                print_success "$package installed"
                track_installed "$package"
            else
                print_error "Failed to install $package"
                track_failed "$package"
            fi
        fi
    done
}
