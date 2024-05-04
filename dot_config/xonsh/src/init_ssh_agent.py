"""
start ssh-agent and keep it across terminal sessions.

copied from: https://github.com/theRealBithive/xontrib-init-ssh-agent
"""

import os
import subprocess

__all__ = ()

# Launches the ssh-agent if the socket path cannot be found

if not os.path.exists('/tmp/xontrib_init_ssh_agent.sock'):
    output = subprocess.check_output(['ssh-agent', '-a', '/tmp/xontrib_init_ssh_agent.sock'])
    output = output.decode("utf-8")
    output = output.split(';')
    # Split the output on ; which seperates the commands resulting in a List that looks like this:
    # ['SSH_AUTH_SOCK=/tmp/ssh-XXXXXXIOvdyN/agent.20259', ' export SSH_AUTH_SOCK', '\nSSH_AGENT_PID=20260', ' export SSH_AGENT_PID', '\necho Agent pid 20260', '\n']

    SSH_AUTH_SOCK = output[0].split('=')[1]
    SSH_AGENT_PID = output[2].split('=')[1]

    __xonsh__.env['SSH_AUTH_SOCK'] = '/tmp/xontrib_init_ssh_agent.sock'
    __xonsh__.env['SSH_AGENT_PID'] = SSH_AGENT_PID

else:

    __xonsh__.env['SSH_AUTH_SOCK'] = '/tmp/xontrib_init_ssh_agent.sock'
    __xonsh__.env['SSH_AGENT_PID'] = subprocess.check_output(['pidof', 'ssh-agent']).decode('utf-8').replace('\n', "")
