# Autostarting stuff
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    exec Hyprland
fi
# if [[ -z $TMUX ]]; then
#     if uwsm check may-start; then
# 	exec uwsm start hyprland.desktop
#     fi
# fi

# Make general or attach to it if it's already running
if [[ -z $(tmux list-sessions) ]]; then
    tmux new-session -s general
elif [[ -z $(tmux list-clients) ]]; then
    tmux new-session -A -s general
fi

# Sending commands on terminal launch
fastfetch											# Shows a sick ass fetch
stty -ixon											# Disables XON/XOFF flow control
stty -ixoff											# Disables sending of start/stop characters

# Functions
stopwatch() {
    start=$(date +%s)
    while true; do
	time="$(($(date +%s) - $start))"
	printf '%s\r' "$(date -u -d "@$time" +%H:%M:%S)"
    done
}
countdown() {
    start="$(( $(date '+%s') + $1))"
    while [ $start -ge $(date +%s) ]; do
	time="$(( $start - $(date +%s) ))"
	printf '%s\r' "$(date -u -d "@$time" +%H:%M:%S)"
	sleep 0.1
    done
    notify-send Countdown Completed!
}

# Zinit stuff
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"				# Set the directory we want to store zinit and plugins
if [ ! -d "$ZINIT_HOME" ]; then									# Download Zinit, if it's not there yet
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"								# Source/Load zinit

# Checks a dir exists & is not in path, then prepends to PATH
add_paths() {
  for directory in "$@"; do
    [[ -d "$directory" && ! "$PATH" =~ (^|:)$directory(:|$) ]] && PATH="$directory:$PATH"
  done
}
add_paths ~/.local/bin

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
# zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
# zinit light sindresorhus/pure

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# System FZF settings
export FZF_CTRL_T_COMMAND="fd --hidden --strip-cwd-prefix --exclude git"
export FZF_DEFAULT_OPTS="--preview-window=up:70% --bind=ctrl-d:page-down,ctrl-u:page-up --color=query:#89b4fa,hl:#f7b3e2,hl:#cba6f7,hl+:#cba6f7,selected-hl:#89b4fa,fg:#89b4fa,fg+:#89b4fa,bg+:#313244,info:#cba6f7,border:#cba6f7,pointer:#cba6f7,marker:#cba6f7"

# Completion
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# Disable prompt and use menu selection
zstyle ':completion:*' list-prompt ''
zstyle ':completion:*' menu select=long
# fzf-tab settings
zstyle ':fzf-tab:*' fzf-preview '[[ -d $realpath ]] && eza -1 --icons=auto $realpath || bat --paging=never --style=plain --color=always $realpath' # Shows ls or bat based on context
zstyle ':fzf-tab:*' default-color "" # Color when there is no group
zstyle ':fzf-tab:*' fzf-flags --color="query:#89b4fa,hl:#f7b3e2,hl:#cba6f7,hl+:#cba6f7,selected-hl:#89b4fa,fg:#89b4fa,fg+:#89b4fa,bg+:#313244,info:#cba6f7,border:#cba6f7,pointer:#cba6f7,marker:#cba6f7" # Catppuccin colors
zstyle ':fzf-tab:*' fzf-bindings 'ctrl-d:page-down' 'ctrl-u:page-up'
zstyle ':fzf-tab:*' fzf-min-height 20 # Opens in tmux popup window
# zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup # Opens in tmux popup window
# zstyle ':fzf-tab:*' popup-smart-tab no # Opens in tmux popup window
# zstyle ':fzf-tab:*' popup-min-size 200 40 # Sizes for tmux window
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word' # Systemctl status
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview 'echo ${(P)word}' # Environment variables

# Prompt styling
# zstyle :prompt:pure:git:stash show yes
# zstyle ':prompt:pure:prompt:success' color '#cba6f7'
# zstyle ':prompt:pure:prompt:error' color '#f38ba8'
# zstyle ':prompt:pure:prompt:continuation' color '#cba6f7'
# zstyle ':prompt:pure:git:branch' color '#b4befe'
# zstyle ':prompt:pure:git:dirty' color '#f2cdcd'

# Keybindings
WORDCHARS=${WORDCHARS/\/}							# Allows deleting up to / as a word
bindkey -e
bindkey -r "^S"									# Unbind incremental search forward (unneeded)
bindkey '^[[H' beginning-of-line						# Home
bindkey '^[[F' end-of-line							# End
bindkey '^[[1~' beginning-of-line						# Home tmux
bindkey '^[[4~' end-of-line							# End tmux
bindkey '\e[3~' delete-char							# Del

# History
HISTSIZE=10000
HISTFILE=$HOME/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt inc_append_history
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

setopt extended_glob 
setopt autocd

# Helpful aliases
alias c='clear'									# Clear terminal
alias l='eza -lh --icons=auto'							# Long list
alias ls='eza -1 --icons=auto'							# Short list
alias ll='eza -lhag --icons=auto --sort=name --group-directories-first'		# Long list all
alias ld='eza -lhD --icons=auto'						# Long list dirs
alias lc='eza --icons=auto --sort=created --long --created --header --no-permissions --no-filesize --no-user'		# Sorts most recently created at the top
alias lm='eza --icons=auto --sort=modified --long --modified --header --no-permissions --no-filesize --no-user'		# Sorts most recently modified at the top

#pacman -Qeq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'
#pacman -Qdtq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(sudo pacman -Rns {})'
#pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'


# Handy change dir shortcuts
alias -- -='cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'

alias mkdir='mkdir -p'								# Always mkdir a path (this doesn't inhibit functionality to make a single dir)
alias cp='cp -r'								# Same for cp
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"			# Fixes "Error opening terminal: xterm-kitty" when using the default kitty term to open some programs through ssh

# Custom aliases
alias homeserver='~/.secrets/homeserver'
alias oraclebox='~/.secrets/oraclebox'
alias sudo='sudo '
alias vi='nvim'
alias ffplay="ffplay -fflags nobuffer -flags low_delay -probesize 32 -analyzeduration 1"
alias tree='eza --tree --icons=auto'								# Same as tree but with colours
alias cat='bat --paging=never --style=plain'					# Cat but with colors
alias diff='diff --color'							# Enables color for diffs
alias info='info --vi-keys'
alias fd-aged='fd -0 -t d | xargs -0 stat --format "%Y %n" | sort -n'
# Yolk aliases
alias ygst='yolk git status'
alias yga='yolk git add'
alias ygc='yolk git commit --verbose'
alias ygca='yolk git commit --all --verbose'
alias ygf='yolk git fetch'
alias ygl='yolk git log --decorate --graph --all'
# alias yglo='yolk git log --oneline --decorate --graph --all'
alias yglo='yolk git log --graph --pretty="%C(#89b4fa)%h%Creset -%C(auto)%d%Creset %s %C(#a6e3a1)(%ad) %C(bold #cba6f7)<%an>%Creset"'
alias glo='git log --graph --pretty="%C(#89b4fa)%h%Creset -%C(auto)%d%Creset %s %C(#a6e3a1)(%ad) %C(bold #cba6f7)<%an>%Creset"'

# Load completions (Must be done after fzf-tab)
autoload -Uz compinit && compinit
zinit cdreplay -q

# Loading prompt
# autoload -U promptinit; promptinit
# prompt pure

# Configuring my prompt
autoload -Uz vcs_info
precmd_vcs_info() {
  if command git rev-parse --is-inside-work-tree &>/dev/null; then
    vcs_info
  else
    vcs_info_msg_0_=''
  fi
}
precmd_show_status() {
    local exit_code=$?
    if [[ $exit_code -eq 1 ]]; then
	LAST_EXIT="%F{red}$exit_code%f "
    elif [[ $exit_code -ne 0 ]]; then
	LAST_EXIT="%F{yellow}$exit_code%f "
    else
	LAST_EXIT=""
    fi
}
precmd_functions+=(precmd_vcs_info precmd_show_status)
setopt prompt_subst
PROMPT=$'\n''%F{#89b4fa}%~%f ${LAST_EXIT}'$'\n''%F{#cba6f7}%f '
RPROMPT="${vcs_info_msg_0_}"
zstyle ':vcs_info:git:*' formats '%F{240}%b %f %F{237}%r%f'
zstyle ':vcs_info:*' enable git

# Uses bat as manpager (replaces bat-extras package)
export MANPAGER="sh -c 'awk '\''{ gsub(/\x1B\[[0-9;]*m/, \"\", \$0); gsub(/.\x08/, \"\", \$0); print }'\'' | bat -p -lman'"

# Shell integrations
eval "$(fzf --zsh)"
