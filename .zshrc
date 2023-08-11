############### global ###############
# Install Oh My Zsh if it is not already installed
if [[ ! -d $HOME/.oh-my-zsh ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install the zsh-autosuggestions plugin if it is not already installed
if [[ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi

# Install the zsh-syntax-highlighting plugin if it is not already installed
if [[ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="ys"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh
bindkey '^[[Z' autosuggest-accept


############### linux ###############
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
alias tlmgr='/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode'
alias manim='/home/ding/.local/bin/manim'

############### macos ###############
#export PATH=/opt/homebrew/bin:$PATH
#alias python3.11=python3
#alias vim=/opt/homebrew/bin/vim
