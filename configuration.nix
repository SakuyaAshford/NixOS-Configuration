# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, inputs, ... }:

{
  
  wsl = {
    enable = true;
    defaultUser = "nixos";
    startMenuLaunchers = true;
    
  };

  # Experimental Features; Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 
  
  # Kernel Modules
  boot.kernelModules = [ "i2c-dev" "i2c=piix4" "cpufreq_powersave" ];

  # Enable CUPS to print documents.
  services.printing.enable = true;
  
  # Enable bluetooth
  hardware.bluetooth.enable = true;
  
  # Enable networking
  networking.networkmanager.enable = true;


  # Enable sound with pipewire
  # sound.enable = true;
  # hardware.pulseaudio.enable = false;
  # security.rtkit.enable = true;
  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   alsa.support32Bit = true;
  #   pulse.enable = true;
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
  
  users.users.nixos = {
    isNormalUser = true;
    shell = pkgs.zsh;
  };
  
  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
    powerline
  ]; 

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = { 
      "nixos" = import ./home.nix;
    };
  };
  

  nixpkgs.config.allowUnfree = true;  
  environment.systemPackages = with pkgs; [
    fzf
    git
    neovim
    # tmux
    vim

    # lang
    rustup
  ];

  programs.zsh.enable = true;
  # programs.tmux.enable = true; 

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}

