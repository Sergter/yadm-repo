THIRD_PARTY="$ZDOTDIR/third-party"

if [ ! -d "$THIRD_PARTY" ]; then
  mkdir "$THIRD_PARTY"
  pushd "$THIRD_PARTY"
  git clone --depth=1 https://github.com/Aloxaf/fzf-tab.git
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git
  # git clone --depth=1 https://github.com/zsh-users/zsh-history-substring-search.git
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git
  git clone --depth=1 https://github.com/MichaelAquilina/zsh-auto-notify.git
  git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git
  git clone --depth=1 https://github.com/trapd00r/LS_COLORS.git
  # git clone --depth=1 https://github.com/romkatv/zsh-bench.git
  popd
fi

source <(fzf --zsh)
source "$THIRD_PARTY/fzf-tab/fzf-tab.plugin.zsh"
source "$THIRD_PARTY/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$THIRD_PARTY/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
# source "$THIRD_PARTY/zsh-history-substring-search/zsh-history-substring-search.zsh"
source "$THIRD_PARTY/zsh-auto-notify/auto-notify.plugin.zsh"
source "$THIRD_PARTY/ohmyzsh/plugins/dirhistory/dirhistory.plugin.zsh"
source "$THIRD_PARTY/ohmyzsh/plugins/sudo/sudo.plugin.zsh"
source "$THIRD_PARTY/LS_COLORS/lscolors.sh"
