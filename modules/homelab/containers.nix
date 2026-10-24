{
  modules,
  ...
}:

{
  imports = [ modules.docker ];

  # TODO: switch to rootless-docker when it's ready
  # enable docker
  services.docker = {
    enable = true;

    # TODO: find equivalent in docker wiki
    # setSocketVariable = true;
  };

  # TODO: check if it exists
  # start docker at boot
  # users.users.vye.linger = true;
}
