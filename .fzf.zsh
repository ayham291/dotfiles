# Setup fzf
# ---------
if [[ ! "$PATH" == */home/ayham/.local/share/nvim/site/pack/packer/start/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/ayham/.local/share/nvim/site/pack/packer/start/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/ayham/.local/share/nvim/site/pack/packer/start/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/ayham/.local/share/nvim/site/pack/packer/start/fzf/shell/key-bindings.zsh"
