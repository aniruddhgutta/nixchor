{
  description = "oceanicc's petrichor but nix-ified";

  inputs = {
    # nixpkgs (unstable)
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # finix-related inputs
    finix.url = "github:finix-community/finix";
    community-modules.url = "github:aniruddhgutta/community-modules/intel-lpmd";

    # flake for helium (uses upstream's .deb releases)
    helium = {
      url = "github:aniruddhgutta/helium-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # flake for chimerautils
    chimerautils = {
      url = "github:aniruddhgutta/chimerautils-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # flake for davinci-resolve-studio (definitely paid)
    davinci.url = "github:aniruddhgutta/davinci-nix";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      finix,
      community-modules,
      ...
    }:
    # remove boilerplate
    let
      mkHost =
        {
          hostname,
          system ? "x86_64-linux",
          extraModules ? [ ],
        }:
        finix.lib.finixSystem {
          inherit (nixpkgs) lib;

          specialArgs = {
            inherit inputs;
            community = community-modules.nixosModules;
          };

          modules = [
            {
              # configure nixpkgs
              nixpkgs.pkgs = import nixpkgs {
                inherit system;
                config.allowUnfree = true;
                overlays = import ./overlays inputs;
              };

              # hostname
              networking.hostName = hostname;
            }

            # default modules
            ./modules/common
            ./hosts/${hostname}
          ]
          ++ extraModules;
        };
    in
    {
      nixosConfigurations = {
        # laptop
        nixey = mkHost {
          hostname = "nixey";
          extraModules = [
            ./modules/niri
            ./modules/flatpak.nix
            # ./modules/gaming.nix
          ];
        };

        # homelab
        misato = mkHost {
          hostname = "misato";
          extraModules = [
            ./modules/homelab
          ];
        };

      };
    };

}
