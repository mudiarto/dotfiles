#
# initial setup
#

import logging
logger = logging.getLogger('xonsh')

#
# logging
# 
# NOTE: big reason for logging is to allow mutagen access from my laptop to my desktop with xonsh as main shell
# - apparently mutagen uses something like this: `ssh user@host uname -sm` and expect result like: "Linux x86_64"
# - it work fine with zsh, even though I echo a lot of things during bootup, somehow it doesn't get returned to ssh
# - however it failed with xonsh. Apparently everything that I printed got returned. Not sure if it is because 
#   I am putting xonsh script on incorrect run level (e.g. interactive vs non-interactive), or something else.
# - In any case, now I put everything using log which can be controlled using log level
#
def ldebug(*args, **kwargs):
  logger.debug(*args, **kwargs)

def linfo(*args, **kwargs):
  logger.info(*args, **kwargs)

def lwarning(*args, **kwargs):
  logger.warning(*args, **kwargs)

ldebug(f"[{__file__}] BEGIN")

#
# NOTE: this should be temporary place for xonsh scripts - once it work, put it in the rc.d for better organization
#


# https://github.com/anki-code/xontrib-rc-awesome/blob/main/xontrib/rc_awesome.xsh
# Alias to get Xonsh Context.
# Read more: https://github.com/anki-code/xonsh-cheatsheet/blob/main/README.md#install-xonsh-with-package-and-environment-management-system
@aliases.register("xc")
def _alias_xc():
    """Get xonsh context."""
    print('xpython:', imp.sys.executable, '#', $(xpy -V).strip())
    print('xpip:', $(which xpip).strip())  # xpip - xonsh's builtin to install packages in current session xonsh environment.
    print('')
    print('xonsh:', $(which xonsh))
    print('python:', $(which python), '#' ,$(python -V).strip())
    print('pip:', $(which pip))
    print('')
    envs = ['CONDA_DEFAULT_ENV']
    for ev in envs:
        if (val := __xonsh__.env.get(ev)):
            print(f'{ev}:', val)



ldebug(f"[{__file__}] END")
