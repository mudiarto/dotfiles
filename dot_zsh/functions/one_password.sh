# one password function

function op.signin() {
    eval $(op signin)
}

function op.ensure_signedin() {
    op whoami >/dev/null 2>&1
    retVal=$?
    if [ $retVal -ne 0 ]; then
        op.signin
    fi
}

function ssh-add.load_keys() {
    op.ensure_signedin
    echo "loading specified keys from 1Password"
    # load all specified ssh-keys
    ssh-add - <<< `op read "op://Keys/20221016_mudiarto_at_gmail_com/id_ed25519"`
}