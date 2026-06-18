{
  description = "Giuseppe's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-hardware,
      home-manager,
      stylix,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        giuseppeg = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };

          modules = [
            ./hosts/giuseppeg/configuration.nix

            # Hardware foundation for this laptop (Intel ThinkPad T14). Gen-
            # agnostic module — upstream has no T14-Intel-Gen4-specific one.
            # Pulls in ThinkPad common quirks: native backlight, trackpoint/
            # trackpad fixes, SSD TRIM, firmware, throttling fix.
            nixos-hardware.nixosModules.lenovo-thinkpad-t14

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.giuseppeg = {
                imports = [
                  ./home/giuseppeg/home.nix
                  stylix.homeModules.stylix
                ];
              };
            }
          ];
        };
      };
    };
}
