#! /usr/bin/env bash
# chezmoi aliases & utils

# based from: https://github.com/mass8326/zsh-chezmoi

# Ensure chezmoi is available
if ! command -v chezmoi &> /dev/null; then
  return 0
fi

# Completion
# source <(chezmoi completion zsh)
eval "$(chezmoi completion zsh)"


# Status
alias cm="chezmoi"
alias cmd="chezmoi diff"
alias cmcd="chezmoi cd"
alias cmst="chezmoi status"
alias cmdoc="chezmoi doctor"

# Editing source
alias cma="chezmoi add"
alias cmr="chezmoi re-add"
alias cme="chezmoi edit"
alias cmea="chezmoi edit --apply"
alias chcd="chezmoi cd"
alias cmvi="chezmoi cd && vi . && chezmoi apply && exit"

# Updating target
alias cmap="chezmoi apply"
alias cmup="chezmoi update"
alias cmug="chezmoi upgrade"

# git
alias cmg="chezmoi git"


# helpers
alias zshrc="chezmoi edit --apply ~/.zshrc && omz reload"
