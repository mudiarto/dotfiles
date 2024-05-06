ldebug(f"[{__file__}] BEGIN")


# this code is from the output of `~/.cargo/bin/mise activate xonsh`
# alternatively we supposedly can use this: execx($(~/.cargo/bin/mise activate xonsh))
# but I got this error: No such file or directory: 'command'
# so I wanted to experiment and remove the 'command' in the beginning

from os               import environ
import subprocess
from xonsh.built_ins  import XSH
from pathlib import Path

mise_exec = Path("~/.cargo/bin/mise")
if mise_exec.expanduser().is_file():
  ldebug('mise is installed!')

  def listen_prompt(): # Hook Events
    execx($(~/.cargo/bin/mise hook-env -s xonsh))


  envx = XSH.env
  envx[   'MISE_SHELL'] = 'xonsh'
  environ['MISE_SHELL'] = envx.get_detyped('MISE_SHELL')
  XSH.builtins.events.on_pre_prompt(listen_prompt) # Activate hook: before showing the prompt

  def _mise(args):
    if args and args[0] in ('deactivate', 'shell', 'sh'):
      # original - execx(subprocess.run(['command', 'mise', *args], stdout=subprocess.PIPE).stdout.decode())
      execx(subprocess.run(['mise', *args], stdout=subprocess.PIPE).stdout.decode())
    else:
      # original - subprocess.run(['command', 'mise', *args])
      subprocess.run(['mise', *args])

  XSH.aliases['mise'] = _mise

else:
  lwarning('mise is NOT installed! skipping ...')

ldebug(f"[{__file__}] END")
