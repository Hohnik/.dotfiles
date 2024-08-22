# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# ----- Plugins & Settings -----
plugins=(git zsh-autosuggestions zsh-syntax-highlighting macos z)


# ----- Shell Settings -----
export ZSH="$HOME/.oh-my-zsh" # Path to your oh-my-zsh installation.
ZSH_THEME="powerlevel10k/powerlevel10k" # See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
source $ZSH/oh-my-zsh.sh
zstyle ':completion:*' menu select
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export EDITOR="nvim"

# ----- Alias -----
alias catcat='bat'
alias showvim='vim $(fzf)'
alias gs='git status --short'
alias gl='git log --graph'
alias ls='colorls -1'
alias tree='ls --tree'
alias vim='nvim'


# ----- Path Variables -----
export PATH=/opt/homebrew/sbin:$PATH
export PATH=/opt/homebrew/bin:$PATH


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/niklas/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/niklas/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/niklas/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/niklas/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/Users/niklas/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/Users/niklas/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<


# pip zsh completion start
#compdef -P pip[0-9.]#
__pip() {
  compadd $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$((CURRENT-1)) \
             PIP_AUTO_COMPLETE=1 $words[1] 2>/dev/null )
}
if [[ $zsh_eval_context[-1] == loadautofunc ]]; then
  # autoload from fpath, call function directly
  __pip "$@"
else
  # eval/source/. command, register function for later
  compdef __pip -P 'pip[0-9.]#'
fi
# pip zsh completion end

# yazi -> yy
function yy() {
 	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
#yazi -> yy

# ----- Auto Commands -----
# source ~/bin/auto_activate_conda_env.sh


