{
  # enable openssh
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      AcceptEnv = [
        "LANG LC_*"
        "TERM COLORTERM"
      ];
    };
  };

  # enable terminfo
  environment.enableAllTerminfo = true;
}
