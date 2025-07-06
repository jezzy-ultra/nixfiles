{
  description = "jezzy's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
  let
    attrs = {
      stateVersion = "25.05";
      hostname = "Jezzlappy";
      username = "jezzy";
    };
  in {
    nixosConfigurations.${attrs.hostname} = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs attrs; };
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager.extraSpecialArgs = { inherit attrs; };
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${attrs.username} = ./home.nix;
        }
      ];
    };
  };
}
