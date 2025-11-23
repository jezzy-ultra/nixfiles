{
  description = "jezzy's nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
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
      specialArgs = {inherit inputs attrs;};
      modules = [
        ./config.nix
        home-manager.nixosModules.home-manager
        flake-programs-sqlite.nixosModules.programs-sqlite
      ];
    };
  };
}
