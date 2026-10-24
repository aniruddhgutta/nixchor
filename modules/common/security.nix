{
  modules,
  ...
}:

{
  imports = with modules; [
    doas
    polkit
  ];

  # configure doas
  programs.doas = {
    enable = true;
    keepEnv = true;
    persist = true;

    # TODO: port extra rules / settings
    # extraRules = [
    #   {
    #     # allow passwordless 'tee' for changing conservation mode (lenovo-only)
    #     groups = [ "wheel" ];
    #     noPass = true;
    #     cmd = "tee";
    #     args = [ "/sys/bus/platform/devices/VPC2004:00/conservation_mode" ];
    #   }
    # ];
  };

  # enable polkit
  services.polkit.enable = true;
}
