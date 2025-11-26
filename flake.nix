{
  description = "Resnox OS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ...}@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { 
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in {
      nixosConfigurations = {
        resnox-os = nixpkgs.lib.nixosSystem {
          pkgs = pkgs;

          specialArgs = { inherit inputs system; };

          modules = [
            ./configuration.nix
          ];
        };
      };
    };
}
