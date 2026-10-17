{ inputs, pkgs, ... }:
let
  waybarFromFlake = inputs.waybar.packages.${pkgs.system}.waybar;
in
{
  programs.waybar = {
    enable = true;
    package = waybarFromFlake // {
      override = _args:waybarFromFlake;
    };
  };
      
  fonts.packages = with pkgs; [
    font-awesome_4
    font-awesome_6
    nerd-fonts.caskaydia-cove
  ];
}
