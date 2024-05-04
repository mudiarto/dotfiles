ldebug(f"[{__file__}] BEGIN")


@aliases.register("op.signin")
def _op_signin():
    result = $(op signin)
    # the content will be something like:
    # export OP_SESSION_SOME_SESSION_ID="SOME_TOKEN"
    # # This command is meant to be used with your shell's eval function.
    # # Run 'eval $(op signin --account YOUR_ACCOUNT)' to sign in to your 1Password account.
    #  # Use the --raw flag to only output the session token.

    # split, get the first line, remove all quotes
    results = result.split("\n")
    for envs in results:
        if envs.startswith("export "):
           env_strs =  [env.strip().strip('"') for env in envs.removeprefix("export ").split("=")]
           ldebug(f"Setting {env_strs[0]}")
           ${env_strs[0]} = env_strs[1]

def _op_ensure_signedin():
    me = !(op whoami)
    if me.returncode != 0:
        # not signed in
        _op_signin()

@aliases.register("ssh-add.load_keys")
def _ssh_add_load_keys():
    """ load all my keys """
    _ssh_add_load_key_mudiarto()


@aliases.register("ssh-add.load_mudiarto")
def _ssh_add_load_key_mudiarto():
    _op_ensure_signedin()
    op read "op://Keys/20221016_mudiarto_at_gmail_com/id_ed25519" | ssh-add -


"""
}
~ % which ssh-add.load_keys
ssh-add.load_keys () {
        op.ensure_signedin
        echo "loading specified keys from 1Password"
        ssh-add - <<< `op read "op://Keys/20221019_kusno_mudiarto_at_coupa_com/id_ed25519"`
        ssh-add - <<< `op read "op://Keys/20221016_mudiarto_at_gmail_com/id_ed25519"`
}
~ % which op.ensure_signedin
op.ensure_signedin () {
        op whoami > /dev/null 2>&1
        retVal=$?
        if [ $retVal -ne 0 ]
        then
                op.signin
        fi
}
"""

# aliases |= {
#  'op.signin': 'op signin',
# }

# load vi mode
# source ~/.config/xonsh/src/prompt_vi_mode.xsh

ldebug(f"[{__file__}] END")
