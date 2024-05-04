ldebug(f"[{__file__}] BEGIN")


####################################################################################
# extra paths
####################################################################################

# nix
# $PATH.add('~/.nix-profile/bin/', front=True, replace=True)

# miniforge3
$PATH.add('~/miniforge3/bin/', front=True, replace=True)

# rust/cargo
$PATH.add('~/.cargo/bin/', front=True, replace=True)

# set shell to be used for all xonsh sub-shell
$SHELL=$(which `xonsh`)
ldebug(p"shell = {$SHELL}")

# set prompot
$PROMPT="{env_name}{BOLD_GREEN}{user}@{hostname}{BOLD_BLUE} {cwd}{branch_color}{curr_branch: {}}{RESET} {RED}{last_return_code_if_nonzero:[{BOLD_INTENSE_RED}{}{RED}] }{RESET}{BOLD_BLUE}xsh:{prompt_end}{RESET} "
ldebug(f"[{__file__}] END")
