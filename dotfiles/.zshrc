## Zsh configuration file.

## Loading modules.

stty -ixon  # Disable ^S

## Run passnag (before p10k so it always outputs).
if command -v passnag >/dev/null 2>&1; then
	passnag nag
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
POWERLEVEL9K_INSTANT_PROMPT=quiet
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

load_module() {
	local gh_user="$1"
	local name="$2"
	local extension="$3"
	local filename="$name.$extension"
	local dir="$HOME/.zsh/$name"
	local filepath="$dir/$filename"
	mkdir -p "$HOME/.zsh"
	if type git >/dev/null && ! [ -f "$filepath" ]; then
		echo "Plugin '$name' is not found, installing..."
		git clone --depth=1 "https://github.com/$gh_user/$name.git" "$dir"
	fi
	if [ -f "$filepath" ]; then
		source "$filepath"
	fi
}

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'
load_module romkatv powerlevel10k zsh-theme
load_module zsh-users zsh-autosuggestions zsh
load_module zsh-users zsh-syntax-highlighting zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if type doas >/dev/null; then
	function doasedit() {
		doas env HOME="$HOME" "$EDITOR" "$@"
	}

	function doash() {
		doas sh -lc "$*"
	}
fi

## Add local files to PATH
PATH=$PATH:$HOME/.local/bin:$HOME/.cargo/bin

## Variables by default
[ -z "$PAGER" ] && export PAGER=less
if command -v nvim >/dev/null 2>&1; then
	[ -z "$MANPAGER" ] && export MANPAGER="$(command -v nvim)"' +Man!'
	export EDITOR="$(command -v nvim)"
else
	export EDITOR=vim
fi
alias vim='$EDITOR'
[ -z "$SUDO_PROMPT" ] && export SUDO_PROMPT="Enter password: "
function cargo() {
	if [ "$1" = "publish" ]; then
		env CARGO_REGISTRY_TOKEN="$(pass show crates-io)" cargo "$@"
	else
		command cargo "$@"
	fi
}
function glab() {
	env GITLAB_TOKEN="$(pass show glab)" glab "$@"
}
# https://consoledonottrack.com/
export DO_NOT_TRACK=1

## Enabling history.
setopt histignorealldups
setopt histignorespace
setopt histreduceblanks
setopt appendhistory

## Autocomplete initialization & automatic rehash & manual rehash.
autoload -U compinit && compinit
zstyle ":completion:*" rehash true
setopt nohashdirs
rehash

## Other shell options.
setopt autocd
setopt interactivecomments
zstyle ':completion:*' menu select
[ -f /etc/DIR_COLORS ] && eval $(dircolors -b /etc/DIR_COLORS)
export ZLSCOLORS="${LS_COLORS}"
zmodload zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*:processes' command 'ps -ax'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;32'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always
zstyle ':completion:*:processes-names' command 'ps -e -o comm='
zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*'   force-list always

if [ "$TERM" = "xterm-256color" ] || [ "$TERM" = "alacritty" ] || [ "$TERM" = "foot" ]; then
	precmd() {
		# Set title.
		print -Pn "\e]0;$(whoami) [$(print -rD $PWD)] @ $(hostname)\a";
		if [ "$TERM" = "foot" ]; then
			# Mark prompt for foot.
			print -Pn "\e]133;A\e\\"
			# Mark current directory for foot.
			setopt extendedglob
			LC_ALL=C printf '\e]7;file://%s%s\e\' $HOST ${PWD//(#m)([^@-Za-z&-;_~])/%${(l:2::0:)$(([##16]#MATCH))}}
			setopt noextendedglob
		fi
	}
fi

## Aliases.
alias ls="LC_COLLATE=C ls --color=auto -hF --group-directories-first"
alias la="ls -A"
alias ll="ls -Al"
alias fucking=sudo
alias LS=sl
alias less="less -M"
alias fuck='sudo $(history -1 | sed "s/^\s*[0-9]*\s*//" -)'

export CARGO_MOMMYS_LITTLE='boy/girl/enby/eldritch entity'
export CARGO_MOMMYS_MOODS='chill/ominous/thirsty'
alias mommy='cargo mommy'

## Git aliases
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gs='git status'
alias gd='git diff'
alias gdd='git diff --staged'
alias gpl='git pull'
alias gps='git push'
alias gt='git tag'
alias gch='git checkout'
function ]() {
	git commit -m "$*"
}
alias ]='noglob ]'

## Enables 'cd -$n' command.
setopt autopushd
setopt pushdminus
setopt pushdignoredups
setopt pushdsilent
alias cd="cd >/dev/null"

## Commands options
#
## Key bindings.
bindkey -e
typeset -A key
key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
#key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}
key[ControlLeft]=';5D'
key[ControlRight]=';5C'
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history
bindkey "${key[ControlLeft]}" backward-word
bindkey "${key[ControlRight]}" forward-word
bindkey '^ ' autosuggest-accept
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

ctrl-z-fg() {
    fg
}
zle -N ctrl-z-fg
bindkey '^Z' ctrl-z-fg
