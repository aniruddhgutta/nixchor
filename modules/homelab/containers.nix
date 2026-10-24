{
  # enable rootless docker
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # start docker at boot
  users.users.vye.linger = true;
}
