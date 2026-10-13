{
  config,
  pkgs,
  ...
}:

{
  users = {
    # set default shell to yash
    defaultUserShell = pkgs.yash;
    users.root.shell = config.users.defaultUserShell;

    # configure vye
    users.vye = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      initialPassword = "vye";
    };
  };
}
