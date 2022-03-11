# Setup fzf
# ---------
if [[ ! "$PATH" == */home/ayham/.vim/plugged/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/ayham/.vim/plugged/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/ayham/.vim/plugged/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/ayham/.vim/plugged/fzf/shell/key-bindings.zsh"
