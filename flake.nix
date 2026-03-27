{
    description = "NixOS config - Laptop";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        zen-browser = {
            url = "github:0xc000022070/zen-browser-flake";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, ... }:
    let
        system = "x86_64-linux";
    in {
        nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
            ./config.nix
            home-manager.nixosModules.home-manager {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.tonuser = import ./home.nix;
                home-manager.extraSpecialArgs = { inherit zen-browser system; };
            }
        ];
        };
    };
}