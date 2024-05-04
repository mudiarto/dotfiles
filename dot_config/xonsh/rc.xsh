#
# initial setup
#

import logging
logger = logging.getLogger('xonsh')

def ldebug(*args, **kwargs):
  logger.debug(*args, **kwargs)

def linfo(*args, **kwargs):
  logger.info(*args, **kwargs)

def lwarning(*args, **kwargs):
  logger.warning(*args, **kwargs)


$UPDATE_OS_ENVIRON=True

ldebug(f"[{__file__}] BEGIN")

# NOTE: this should be temporary place for xonsh scripts - once it work, put it in the rc.d for better organization


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
