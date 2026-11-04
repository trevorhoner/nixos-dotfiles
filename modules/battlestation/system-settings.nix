{ lib, pkgs, ... }:
{

  hardware.xpadneo.enable = true;

  #boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev"; 
  boot.loader.grub.useOSProber = true;

  #IWD configurations
  networking.networkmanager.wifi.backend = "iwd";
  networking.wireless.iwd.enable = true;
  networking.wireless.enable = false;

  time.timeZone = "America/New_York";

  #Upgrades-----------------------------
  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
  };

  #Rust Support-------------------------
  boot.kernelPatches = [
    {
      name = "Rust Support";
      patch = null;
      features = {
        rust = true;
      };
    }
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  #Services-----------------------------
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.udisks2.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;
    fade = false;
    shadow = false;
  };

  security.sudo.wheelNeedsPassword = false;
  security.rtkit.enable = true;
  programs.firefox.enable = true;

  fonts.packages = with pkgs; [
#     nerd-fonts.caskaydia-cove
     nerd-fonts.jetbrains-mono
  ];

  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) 
  [ "steam" "steam-unwrapped" ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "26.05"; 
}
