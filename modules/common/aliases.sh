# ============================================================================
# Common Aliases
# ============================================================================
# Shared aliases for all systems

# Command replacements
# alias ls="eza -l"
# alias cd="z"
alias cat="bat"
alias top="htop"
alias docker-compose="docker compose"

# Docker shortcuts
alias dcdcu="docker-compose down && docker-compose up -d"
alias dcdcur="docker-compose down && docker-compose pull && docker-compose up -d"

# YouTube downloader
alias ytdlp="yt-dlp -f 'best[ext=mp4]' -o '%(title).100s.%(ext)s'"
