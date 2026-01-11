# ============================================================================
# CLI Styling Utilities
# ============================================================================

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'

# Symbols
SYMBOL_SUCCESS="✓"
SYMBOL_FAIL="✗"
SYMBOL_ARROW="→"
SYMBOL_BULLET="•"
SYMBOL_SPARKLE="✨"
SYMBOL_PACKAGE="📦"
SYMBOL_WRENCH="🔧"
SYMBOL_ROCKET="🚀"
SYMBOL_CHECK="✅"
SYMBOL_WARN="⚠️"

# Print a styled header
print_header() {
    echo ""
    echo -e "${BOLD}${MAGENTA}╔════════════════════════════════════════════════════════════╗${RESET}"
    echo -e "${BOLD}${MAGENTA}║${RESET}  ${BOLD}${WHITE}$1${RESET}"
    echo -e "${BOLD}${MAGENTA}╚════════════════════════════════════════════════════════════╝${RESET}"
    echo ""
}

# Print a section header
print_section() {
    echo ""
    echo -e "${BOLD}${CYAN}━━━ $1 ━━━${RESET}"
    echo ""
}

# Print success message
print_success() {
    echo -e "  ${GREEN}${SYMBOL_SUCCESS}${RESET} $1"
}

# Print error message
print_error() {
    echo -e "  ${RED}${SYMBOL_FAIL}${RESET} $1"
}

# Print warning/skip message
print_skip() {
    echo -e "  ${YELLOW}${SYMBOL_ARROW}${RESET} $1 ${DIM}(already installed)${RESET}"
}

# Print info message
print_info() {
    echo -e "  ${BLUE}${SYMBOL_BULLET}${RESET} $1"
}

# Print step being executed
print_step() {
    echo -e "  ${CYAN}${SYMBOL_ARROW}${RESET} $1..."
}

# Print package installation
print_package() {
    echo -e "  ${SYMBOL_PACKAGE} Installing ${BOLD}$1${RESET}..."
}

# Check if command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Spinner for long-running operations
spinner() {
    local pid=$1
    local message=$2
    local spin='⣾⣽⣻⢿⡿⣟⣯⣷'
    local i=0

    while kill -0 $pid 2>/dev/null; do
        i=$(( (i+1) % ${#spin} ))
        printf "\r  ${CYAN}${spin:$i:1}${RESET} ${message}..."
        sleep 0.1
    done
    printf "\r"
}

# Run command with spinner
run_with_spinner() {
    local message=$1
    shift

    "$@" &>/dev/null &
    local pid=$!
    spinner $pid "$message"
    wait $pid
    return $?
}

# Print final summary
print_summary() {
    echo ""
    echo -e "${BOLD}${GREEN}╔════════════════════════════════════════════════════════════╗${RESET}"
    echo -e "${BOLD}${GREEN}║${RESET}  ${SYMBOL_SPARKLE} ${BOLD}${WHITE}Setup Complete!${RESET} ${SYMBOL_SPARKLE}"
    echo -e "${BOLD}${GREEN}╚════════════════════════════════════════════════════════════╝${RESET}"
    echo ""
    echo -e "  ${SYMBOL_ROCKET} ${BOLD}Next steps:${RESET}"
    echo -e "     1. Restart your terminal (or run: ${CYAN}source ~/.zshrc${RESET})"
    echo -e "     2. Enjoy your new setup!"
    echo ""
}
