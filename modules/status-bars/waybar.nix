{ pkgs, ... }:

{
  programs.waybar.enable = true;
  programs.waybar.package = pkgs.waybar;
      
  environment.systemPackages = [
    pkgs.nerd-fonts.caskaydia-cove
  ];
}
