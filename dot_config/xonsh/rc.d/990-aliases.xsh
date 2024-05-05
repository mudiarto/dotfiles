ldebug(f"[{__file__}] BEGIN")

####################################################################################
# aliases
####################################################################################

# init aliases - without this, the rest may encounter error
aliases['reload'] = 'source ~/.xonshrc'

aliases.update({

  # 
  # dir tools
  #
  '..': 'cd ..',
  '...': 'cd ../..',
  '....': 'cd ../../..',
  '.....': 'cd ../../../..',
  '......': 'cd ../../../../..',
  'll': 'ls -al',
  'lld': 'ls -ald',

  #
  # chezmoi
  # 
  'cm': "chezmoi",
  'cme': "chezmoi edit --apply",
  'cmadd': "chezmoi add --follow",
  'cma': "chezmoi apply",
  'cmcd': "cd ~/.local/share/chezmoi",
  'cmg': "chezmoi git",

  #
  # conda
  #
  'c': "conda",

  #
  # docker
  #
  'doc': "docker",
  'docc': "docker compose",


  #
  # git
  #
  'g': 'git',

  #
  # nix
  # * using flakes
  # * refs: https://tech.aufomm.com/my-nix-journey-use-nix-with-ubuntu/
  #
  'nix.search': 'nix search nixpkgs',

  #
  # tmux
  #
  'tmn': 'tmux new -A -s',
  'tml': 'tmux ls',
  'tmj': 'tmux attach -d -t',

  #
  # zellij
  #
  'zl': 'zellij',

})


ldebug(f"[{__file__}] END")
