
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/.dotfiles/zsh/"
export ZSH_THEME="rervn"

for function in $ZSH_CUSTOM/functions/*; do
  source $function
done

for config in $ZSH_CUSTOM/configs/*; do
  source $config
done

plugins=(
    git 
    zsh-autosuggestions 
    zsh-completions 
    zsh-history-substring-search 
    zsh-syntax-highlighting
)

[[ -f $ZSH/oh-my-zsh.sh ]] && source $ZSH/oh-my-zsh.sh
[[ -f $ZSH_CUSTOM/aliases ]] && source $ZSH_CUSTOM/aliases