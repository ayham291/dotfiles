{
  description = "Ayham's LARBS-style dots → NixOS + Wayland (dwl)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true; # brave, etc.
      };
    in
    {
      nixosConfigurations.example-laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./nix/hosts/example-laptop.nix
          home-manager.nixosModules.home-manager
          {
            nixpkgs.config.allowUnfree = true;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ayham = import ./nix/home/default.nix;
          }
        ];
      };

      # Standalone HM (optional): use while still on Arch before full NixOS.
      homeConfigurations."ayham@example-laptop" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./nix/home/default.nix ];
      };

      packages.${system}.dwl = pkgs.callPackage ./nix/pkgs/dwl.nix { };

      formatter.${system} = pkgs.nixfmt-rfc-style;
    };
}