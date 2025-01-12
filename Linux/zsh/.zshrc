# Start Tmux if not already in Tmux and not using VSCode terminal
if [[ -z "$TMUX" && ! "$(ps -o comm= -p $PPID)" =~ "code" ]]; then
    # Attach to session if it already exists, else create a new one
    tmux attach-session || tmux new-session
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="$PATH:/media/shared/Code/Scripts"
export ZSH_PLUGINS="/home/david/.config/zsh/plugins"
export EDITOR="nvim"

WORDCHARS=${WORDCHARS//[\/&.;]/}                                 # Don't consider certain characters part of the word

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source $ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH_PLUGINS/fzf-tab/fzf-tab.plugin.zsh

fpath=($ZSH_PLUGINS/zsh-completions/src $fpath)

autoload -Uz compinit colors zcalc
compinit -d
colors

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $ZDOTDIR/.p10k.zsh ]] || source $ZDOTDIR/.p10k.zsh

bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Navigate words with ctrl+arrow keys
bindkey '^[Oc' forward-word
bindkey '^[Od' backward-word
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^H' backward-kill-word                                 # delete previous word with ctrl+backspace
bindkey '^[[Z' undo                                             # Shift+tab undo last action

# Persist History
HISTSIZE=10000
HISTFILE=$ZDOTDIR/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

setopt correct                                                  # Auto correct mistakes
setopt extendedglob                                             # Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt autocd                                                   # if only directory path is entered, cd there.

zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true                              # automatically find new executables in path

# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# ZSH_HIGHLIGHT_STYLES[path]='none'

alias sudo='nocorrect sudo '

alias update-all="yay -Syu && flatpak update -y"
alias cleanup="yay -Yc --noconfirm && yay -Sc --noconfirm && flatpak uninstall --unused -y"

alias cat="bat"

alias cp="cp -i"                                                # Confirm before overwriting something
alias mv="mv -i"
alias rm="rm -i"
alias ln="ln -i"
alias mkdir="mkdir -pv"

alias vim="nvim"
alias v="fd --type f --hidden --exclude .git | fzf-tmux -p --reverse | xargs nvim"
alias vi="\vim" 						                        # '\' disables alias
alias edit-nvim="cd ~/.config/nvim && nvim ."

alias reload-zsh="source ~/.config/zsh/.zshrc"
alias edit-zsh="nvim ~/.config/zsh/.zshrc"

alias reload-tmux="source ~/.config/tmux/tmux.conf"
alias edit-tmux="nvim ~/.config/tmux/tmux.conf"

alias ls="eza --icons --color=always"
alias ll="eza --long --header --group --icons --all --color=always"
alias lt="eza --tree --icons --color=always"

compdef eza=ls
compdef ll=eza
compdef lt=eza

# Fzf Config
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_DEFAULT_OPTS="--extended"

PREVIEW_LOGIC="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview '$PREVIEW_LOGIC'"

export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi"

# Nvm Config
export NVM_DIR="/usr/share/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Vim cursor fix
_fix_cursor() {
   echo -ne '\e[5 q'
}

precmd_functions+=(_fix_cursor)

eval "$(dircolors -b)"
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
