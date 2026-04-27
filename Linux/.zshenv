. "$HOME/.cargo/env"
export PATH="/home/steven/workspace/android-studio/bin":$PATH
export ANDROID_HOME=/home/steven/Android/Sdk
export NDK_HOME=$(ls -d /home/steven/Android/Sdk/ndk/*/ | sort -V | tail -n 1)

export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin

alias npx='nocorrect npx '

alias fooyin="flatpak run org.fooyin.fooyin"
export FLYCTL_INSTALL="/home/steven/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

export HISTSIZE=1000000
export SAVEHIST=1000000


# --- FAR AI Flamingo cluster ---
export FLAMINGO_ROOT="/home/steven/workspace/farAI/flamingo/"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:${HOME}/.local/bin:$PATH"
export KUBECONFIG="${HOME}/.kube/config:${HOME}/.kube/far-config:${FLAMINGO_ROOT}/kubeconfig"
alias k="kubectl"
export DOCKER_DEFAULT_PLATFORM=linux/amd64
