if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  SESSION_TYPE=remote/ssh
else
  case $(ps -o comm= -p "$PPID") in
    sshd|*/sshd) SESSION_TYPE=remote/ssh;;
  esac
fi

if [ "$SESSION_TYPE" != "remote/ssh" ]; then
  fastfetch
fi


eval "$(oh-my-posh init zsh --config ~/.config/zsh/omp.toml)"

# completion
autoload -Uz compinit ; compinit
TRAPUSR1() { rehash }

# third-party
source "$ZDOTDIR/third-party.zsh"

# options
setopt no_beep
setopt append_history hist_find_no_dups hist_ignore_dups hist_reduce_blanks share_history

# styles
zstyle ':completion:*' menu no # select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# variables
HISTFILE="$ZDOTDIR/.histfile"
HISTSIZE=10000
SAVEHIST=10000
export FZF_DEFAULT_OPTS="--exact --ignore-case"
AUTO_NOTIFY_THRESHOLD=10
AUTO_NOTIFY_IGNORE+=("paru" "code")

# aliases
alias ls='lsd --human-readable --group-directories-first --classify'
# alias zsh-bench="$THIRD_PARTY/zsh-bench/zsh-bench"
alias lnav-journalctl='journalctl -f --no-tail -o json -b | lnav'
alias screenshot='~/Documents/scripts/screenshot.sh'
alias yadm-code='yadm enter code ~'
alias code-platform='code ~/repos/CELA-PHIL-NPO-PD-NonprofitPlatform'
alias code-services='code ~/repos/CELA-PHIL-NPO-PD-NonprofitServices'
alias t0='tmux new -As0'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(fc -ln -1 | sed -e '\''s/^\s*//;s/[;&|]\s*alert$//'\'')"'

# lesspipe
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# BEGIN Agency MANAGED BLOCK
if [[ ":${PATH}:" != *":/home/stranger/.config/agency/CurrentVersion:"* ]]; then
    export PATH="/home/stranger/.config/agency/CurrentVersion:${PATH}"
fi
# END Agency MANAGED BLOCK

# bindings
source "$ZDOTDIR/bindings.zsh"
