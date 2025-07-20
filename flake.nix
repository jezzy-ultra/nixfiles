{
  description = "jezzy's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-programs-sqlite = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    stylix,
    flake-programs-sqlite,
    ...
  } @ inputs: let
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
        home-manager.nixosModules.home-manager
        stylix.nixosModules.stylix
        flake-programs-sqlite.nixosModules.programs-sqlite
      ];
    };
  };
}
