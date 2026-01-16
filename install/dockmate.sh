#!/bin/bash
# ============================================================================
# DockMate Installation
# ============================================================================

install_dockmate() {
    print_section "DockMate"

    if command_exists dockmate; then
        print_skip "DockMate"
        track_skipped "DockMate"
        return 0
    fi

    local is_ubuntu=false
    if [[ "$OSTYPE" == "linux-gnu"* ]] && [[ -f /etc/os-release ]]; then
        source /etc/os-release
        if [[ "$ID" == "ubuntu" || "$ID_LIKE" == *"ubuntu"* ]]; then
            is_ubuntu=true
        fi
    fi

    print_package "dockmate"
    if [[ "$OSTYPE" == "darwin"* ]] || [[ "$is_ubuntu" == false ]]; then
        if run_with_spinner "Installing DockMate" brew install "shubh-io/tap/dockmate"; then
            print_success "DockMate installed"
            track_installed "DockMate"
        else
            print_error "Failed to install DockMate"
            track_failed "DockMate"
        fi
    else
        if run_with_spinner "Installing DockMate" sh -c "curl -fsSL https://raw.githubusercontent.com/shubh-io/DockMate/main/install.sh | sh"; then
            print_success "DockMate installed"
            track_installed "DockMate"
        else
            print_error "Failed to install DockMate"
            track_failed "DockMate"
        fi
    fi
}
