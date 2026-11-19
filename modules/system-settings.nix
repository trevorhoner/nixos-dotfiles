{ lib, pkgs, ... }:
{

  #Boot-loader settings -----------------
  boot = {
    loader = {
      #systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      grub.efiSupport = true;
      grub.device = "nodev"; 
      grub.useOSProber = true;
    };
    
    #Linux Kernel = Bleeding-edge
    kernelPackages = pkgs.linuxPackages_latest;

    #Rust Support-------------------------
    kernelPatches = [
      {
        name = "Rust Support";
        patch = null;
        features = {
          rust = true;
        };
      }
    ];

  };

  #Networking configurations
  networking = {
    networkmanager.wifi.backend = "iwd";
    wireless.iwd.enable = true;
    wireless.enable = false;
  };

  time.timeZone = "America/New_York";

  #Upgrades-----------------------------
  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
  };

  #service-settings -----------------------------
  services = {
    gvfs.enable = true;
    tumbler.enable = true;
    blueman.enable = true;
    udisks2.enable = true;
    power-profiles-daemon.enable = true;
    upower.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    picom = {
      enable = true;
      backend = "glx";
      vSync = true;
      fade = false;
      shadow = false;
    };
  };

  #hardware-support ----------------
  hardware = {
    xpadneo.enable = true;
    bluetooth.enable = true;
  };

  security = {
    sudo.wheelNeedsPassword = false;
    rtkit.enable = true;
  };

  programs.firefox.enable = true;

  fonts.packages = with pkgs; [
     #nerd-fonts.caskaydia-cove
     nerd-fonts.jetbrains-mono
  ];

  #Allow unfree packages
  nixpkgs = {
    config.allowUnfree = true;

    config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) 
    [ "steam" "steam-unwrapped" ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "26.05"; 
}
