{
  description = ''
    not A very basic flake

    Forget everything you know about nix, this is just a framework to configure apps and dotfiles.
  '';

  # Inputs are used to declare package definitions and modules to fetch from the internet
  inputs = {
    # For stable packages definitions
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    # For packages not yet in nixpkgs
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # For latest bleeding edge packages - daily* updated with: $ nix flake update nixpkgs-latest
    nixpkgs-latest.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";

    catppuccin-bat.url = "github:catppuccin/bat";
    catppuccin-bat.flake = false;
    codex-flake.url = "github:castrozan/codex-flake";
    codex-flake.inputs.flake-utils.follows = "flake-utils";
  };

  # Outputs are used to define apps and dotfiles configuration for different systems and users
  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-unstable,
      nixpkgs-latest,
      home-manager,
      determinate,
      ...
    }:
    # let in notation to declare local variables for output scope
    let
      system = "x86_64-linux"; # linux system architecture
      home-version = "25.05";
      # Configure nixpkgs then attribute it to pkgs at the same time
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      latest = import nixpkgs-latest {
        inherit system;
        config.allowUnfree = true;
      };
      # Args for dependency injection
      specialArgsBase = {
        # Fake inheritance, this is just composition
        inherit
          home-version
          inputs
          unstable
          latest
          ;
      };
    in
    {
      # homeConfigurations.${username}@${system} is a standalone home manager configuration for any non-nixos systems
      # nix run home-manager/master -- --flake $HOME/.dotfiles/nixos#${username}@${system} switch -b backup
      homeConfigurations =
        let
          username = "lucas.zanoni";
          # Real inheritance
          specialArgs = specialArgsBase // {
            inherit username;
          };
        in
        {
          "${username}@${system}" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            extraSpecialArgs = specialArgs;

            modules = [ ./users/${username}/home.nix ];
          };
        };

      # nixosConfigurations.${username} is a NixOS system configuration
      # nixos-rebuild switch --flake ~/.dotfiles/nixos#${username}
      nixosConfigurations =
        let
          username = "zanoni";
          specialArgs = specialArgsBase // {
            inherit username;
          };
        in
        {
          "${username}" = nixpkgs.lib.nixosSystem {
            inherit specialArgs;
            inherit system;

            modules = [
              ./hosts/dellg15
              ./users/${username}/nixos.nix
              home-manager.nixosModules.home-manager
              (import ./users/${username}/nixos-home-config.nix)
              determinate.nixosModules.default
            ];
          };
        };
    };
}
