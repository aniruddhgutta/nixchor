{ pkgs, ... }:

{
  users = {
    users.vye = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      initialPassword = "vye";
      shell = pkgs.yash;
    };

    extraUsers.root = {
      shell = pkgs.yash;
    };
  };
}
