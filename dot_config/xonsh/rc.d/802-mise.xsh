ldebug(f"[{__file__}] BEGIN")

# copied from: https://mise.jdx.dev/getting-started.html#xonsh
# with small modification (import subprocess, change path)

import subprocess
from pathlib         import Path
from xonsh.built_ins import XSH

try:
  ctx = XSH.ctx
  # i'm using miso installed via cargo - located in ~/.cargo/bin/mise
  mise_init = subprocess.run([Path('~/.cargo/bin/mise').expanduser(),'activate','xonsh'],capture_output=True,encoding="UTF-8").stdout
  XSH.builtins.execx(mise_init,'exec',ctx,filename='mise')
  ldebug('mise installed!')
except:
  # silently ignore exception
  linfo("mise is not installed !")

ldebug(f"[{__file__}] END")
