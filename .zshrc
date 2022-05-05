export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="ys"

plugins=(git)
source $ZSH/oh-my-zsh.sh

source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

bindkey '^[[Z' autosuggest-accept
