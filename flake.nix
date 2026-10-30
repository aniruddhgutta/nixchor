{
  description = "oceanicc's petrichor but nix-ified";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    finix.url = "github:finix-community/finix";
    community-modules.url = "github:aniruddhgutta/community-modules";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
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
            # ./modules/flatpak.nix
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
