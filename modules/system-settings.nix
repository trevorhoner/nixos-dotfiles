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
  
  services.gnome.gnome-keyring.enable = true;

  #Drive-Detection & ProtonVPN fix-------------------------
  security.polkit.extraConfig= ''
    polkit.addRule(function(action, subject) {
      if (
        (action.id == "org.freedesktop.udisks2.filesystem-mount-system" ||
        action.id == "org.freedesktop.udisks2.filesystem-mount" ||
        action.id == "org.freedesktop.udisks2.filesystem-unmount-others" ||
        action.id == "org.freedesktop.udisks2.eject-media" ||
        action.id == "org.freedesktop.udisks2.power-off-drive") &&
        subject.isInGroup("wheel")
      ) {
        return polkit.Result.YES;
      }
      
      if (action.id.indexOf("org.freedesktop.NetworkManager.") == 0 &&
        subject.user == "trevor") {
        return polkit.Result.YES;
        }
    });
  '';

  #Networking configurations
  networking = {
    wireless.iwd.enable = true;
    wireless.enable = false;

    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
      ethernet.macAddress = "02:11:22:33:44:55";
      wifi.macAddress = "02:aa:bb:cc:dd:ee";
    };

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

  #allow unfree packages
  nixpkgs = {
    config.allowUnfree = true;

    config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) 
    [ "steam" "steam-unwrapped" ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "26.05"; 
}
