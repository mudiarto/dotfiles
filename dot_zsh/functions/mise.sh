#! /usr/bin/env bash
# shellcheck disable=all
# note: shellcheck disable=all is used to disable all warnings - since this is motly generated file

# load mise
eval "$(mise activate zsh)"

# mise-en-place autocompletion
# from: https://mise.jdx.dev/installing-mise.html#autocompletion
# require mise usage to be installed: mise use -g usage
# this code was generated from: mise completion zsh >> <this file>

#compdef mise
local curcontext="$curcontext"

# caching config
_usage_mise_cache_policy() {
  if [[ -z "${lifetime}" ]]; then
    lifetime=$((60*60*4)) # 4 hours
  fi
  local -a oldp
  oldp=( "$1"(Nms+${lifetime}) )
  (( $#oldp ))
}

_mise() {
  typeset -A opt_args
  local curcontext="$curcontext" spec cache_policy

  if ! command -v usage &> /dev/null; then
      echo >&2
      echo "Error: usage CLI not found. This is required for completions to work in mise." >&2
      echo "See https://usage.jdx.dev for more information." >&2
      return 1
  fi

  zstyle -s ":completion:${curcontext}:" cache-policy cache_policy
  if [[ -z $cache_policy ]]; then
    zstyle ":completion:${curcontext}:" cache-policy _usage_mise_cache_policy
  fi

  if ( [[ -z "${_usage_spec_mise:-}" ]] || _cache_invalid _usage_spec_mise ) \
      && ! _retrieve_cache _usage_spec_mise;
  then
    spec="$(mise usage)"
    _store_cache _usage_spec_mise spec
  fi

  _arguments "*: :(($(usage complete-word --shell zsh -s "$spec" -- "${words[@]}" )))"
  return 0
}

if [ "$funcstack[1]" = "_mise" ]; then
    _mise "$@"
else
    compdef _mise mise
fi

# vim: noet ci pi sts=0 sw=4 ts=4
