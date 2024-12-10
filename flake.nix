{
  description = "A very basic flake";
   
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/nixos-wsl";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs"; 
    
    /* Dev Shell */
    # Rust
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-wsl, home-manager, rust-overlay, ... }: {
     nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
       system = "x86_64-linux";
       modules = [
         ./configuration.nix
         nixos-wsl.nixosModules.wsl

         home-manager.nixosModules.home-manager
         {
           home-manager.useGlobalPkgs = true;
           home-manager.useUserPackages = true;
         }
	 # ({ pkgs, ... }: {
         #   nixpkgs.overlays = [ rust-overlay.overlays.default ];
         #   environment.systemPackages = with pkgs; [
         #     ( rust-bin.stable.latest.default.override {
         #       extensions = [ "rust-src" "rust-analyzer" "rustfmt" "clippy" ]; 
         #     })
         #   gcc
         #   pkg-config
         #   ];
	 # })
       ];
     };
     # devShells.x86_64-linux.default = let
     #   pkgs = import nixpkgs {
     #     system = "x86-64-linux";
     #     overlays = [ rust-overlay.overlays.default ];
     #   };
     # in pkgs.mkShell {
     #   buildInputs = with pkgs; [
     #     ( rust-bin.stable.latest.default.overrid {
     #       extensions = [ "rust-src" "rust-analyzer" "rustfmt" "clippy" ];
     #     })
     #     pkg-config
     #   ];
     # };
  };
}
