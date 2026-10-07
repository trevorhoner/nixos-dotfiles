{ inputs, ... }:
{
  home-manager.users.drfoobar = {
    imports = [
      inputs.noctalia.homeModules.default
    ];

    programs.xwayland.enable = true;

    #Using MangoWM-----
    programs.mango.enable = true;
    programs.noctalia = {
      enable = true;

      # Enables NetworkManger, Bluetooth, UPower, and a power profile service.
      recommendedServices.enable = true;

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


