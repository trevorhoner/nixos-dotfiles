{ inputs, ... }:
{

  imports = [
      inputs.mangowm.nixosModules.mango 
  ];

  programs.xwayland.enable = true;
  programs.mango.enable = true; 
  services.displayManager.defaultSession = "mango";
}
