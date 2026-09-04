# flake.nix
{
  description = "oceanicc's petrichor but nix-ified";

  inputs = {
    # pin nixpkgs to unstable
    nixpkgs.url = "nixpkgs/nixos-26.05";
  };

  outputs = { self, nixpkgs, ...}@inputs: {
    nixosConfigurations."nixey" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./modules/nix.nix
        ./modules/boot.nix
        ./modules/security.nix
        ./modules/users.nix
        ./modules/graphics.nix
        ./modules/networking.nix
        ./modules/power.nix
        ./modules/audio.nix
        ./modules/fonts.nix
        ./modules/desktop.nix
        ./modules/packages.nix

        ./hosts/nixey
      ];
    };
  };
}
