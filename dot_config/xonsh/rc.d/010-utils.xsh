ldebug(f"[{__file__}] BEGIN")


@aliases.register("mcd")
def _mcd(path):
  mkdir path
  cd path

ldebug(f"[{__file__}] END")
