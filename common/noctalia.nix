{ inputs, ... }:
{
  imports = [
#     inputs.noctalia.nixosModules.default
      inputs.mangowm.nixosModules.mango
  ];

  programs.xwayland.enable = true;
  programs.mango.enable = true;
  services.displayManager.defaultSession = "mango";
#    programs.noctalia = {
#      enable = true;
#      systemd.enable = true;

      # Enables NetworkManger, Bluetooth, UPower, and a power profile service.
#      recommendedServices.enable = true;
#    }
  home-manager.users.trevor = {
    imports = [
      inputs.noctalia.homeModules.default
    ];

    programs.noctalia = {
      enable = true;  
      systemd.enable = true;
      settings = { # This may also be a string or path to a .toml file.
        shell.launch_apps_as_systemd_services = true;

        theme = {
          mode = "dark";
          source = "builtin";
          builtin = "Catppuccin";
        };

        wallpaper = {
          enabled = true;
          default.path = "/home/trevor/Wallpapers/glacier_nationalpark.jpg";
        };
      };
    };
  };
}


