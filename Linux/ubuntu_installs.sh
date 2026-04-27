#!/bin/bash
# Ubuntu setup script — bootstraps a fresh install to a working state.
# Idempotent: safe to re-run individual sections.
set -euo pipefail

# ---------- apt base ----------
sudo apt update && sudo apt upgrade -y
sudo apt install -y \
    curl wget git vim tmux zsh \
    build-essential ca-certificates pkg-config \
    unzip zip jq \
    vlc

# ---------- Mozilla VPN ----------
if ! command -v mozillavpn >/dev/null 2>&1; then
    sudo add-apt-repository -y ppa:mozillacorp/mozillavpn
    sudo apt update
    sudo apt install -y mozillavpn
fi

# ---------- oh-my-zsh + plugins + powerlevel10k ----------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    RUNZSH=no CHSH=no \
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
[ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] || \
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
[ -d "$ZSH_CUSTOM/plugins/zsh-history-substring-search" ] || \
    git clone https://github.com/zsh-users/zsh-history-substring-search \
        "$ZSH_CUSTOM/plugins/zsh-history-substring-search"
[ -d "$ZSH_CUSTOM/themes/powerlevel10k" ] || \
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
        "$ZSH_CUSTOM/themes/powerlevel10k"

# ---------- rust toolchain (cargo / rustc / rustup) ----------
if ! command -v cargo >/dev/null 2>&1; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \
        | sh -s -- -y --default-toolchain stable
fi

# ---------- uv (python package + project manager) ----------
if ! command -v uv >/dev/null 2>&1; then
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi

# ---------- nvm + node (v0.40.x) ----------
if [ ! -d "$HOME/.nvm" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash
    # shellcheck disable=SC1091
    export NVM_DIR="$HOME/.nvm"
    . "$NVM_DIR/nvm.sh"
    nvm install --lts
fi

# ---------- rclone (used by backup scripts; gdrive remote must be re-auth'd) ----------
if ! command -v rclone >/dev/null 2>&1; then
    sudo -v && curl https://rclone.org/install.sh | sudo bash
fi

# ---------- Claude Code ----------
if ! command -v claude >/dev/null 2>&1; then
    curl -fsSL https://claude.ai/install.sh | bash
fi

# ---------- dotfiles + crontab ----------
cat <<'EOF'

==========================================================================
Tool install complete. Manual steps remaining:

1. Copy dotfiles (review first — may want to merge instead of overwrite):
     for f in .zshrc .zshenv .bashrc .bash_aliases .profile \
              .p10k.zsh .vimrc .tmux.conf; do
         cp -i "Linux/$f" "$HOME/$f"
     done

2. Restore crontab:
     crontab Linux/.crontab

3. Re-auth rclone gdrive remote (config is intentionally NOT in this
   repo — it contains OAuth tokens and a client_secret):
     rclone config
     # n (new) -> name: gdrive -> type: drive -> follow OAuth flow
     # When done: rclone listremotes  # should print "gdrive:"

4. Restore data from gdrive (after rclone is set up):
     rclone copy gdrive:Back_up_Files/notes      "$HOME/workspace/notes"
     rclone copy gdrive:Back_up_Files/Pictures   "$HOME/Pictures"
     rclone copy gdrive:Back_up_Files/Music      "$HOME/Music"
     rclone copy gdrive:Back_up_Files/Documents  "$HOME/Documents"
     rclone copy gdrive:Back_up_Files/ssh        "$HOME/.ssh"
     # …etc per gdrive:Back_up_Files/ layout

5. Install backup scripts (e.g. notes hourly sync):
     mkdir -p "$HOME/workspace/.gdrive_sync"
     cp Linux/backups/backup_notes.sh "$HOME/workspace/.gdrive_sync/"
     chmod +x "$HOME/workspace/.gdrive_sync/backup_notes.sh"

6. Set zsh as default shell:
     chsh -s "$(command -v zsh)"

7. Reboot or log out/in.
==========================================================================
EOF
