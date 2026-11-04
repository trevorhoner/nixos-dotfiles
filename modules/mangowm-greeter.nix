{ pkgs, ... }:
{

  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "mango";
        user = "trevor";
      };
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd mango";
        user = "greeter";
      };
    };
  };
}
