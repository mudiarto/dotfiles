print(f"[{__file__}] BEGIN")

####################################################################################
# extra paths
####################################################################################

# nix
# $PATH.add('~/.nix-profile/bin/', front=True, replace=True)

# miniforge3
$PATH.add('~/miniforge3/bin/', front=True, replace=True)

# rust/cargo
$PATH.add('~/.cargo/bin/', front=True, replace=True)


print(f"[{__file__}] END")
