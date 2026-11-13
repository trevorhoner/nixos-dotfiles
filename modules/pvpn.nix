{inputs, ...}:
{
  imports = [
    inputs.nur.repos.claymorwan.nixosModules.pvpn
  ];

  programs.pvpn = {
    enable = true;
    # Add yourself to user in the pvpn group
    users = [
      "trevor"
    ];
  };

  systemd.tmpfiles.settings."pvpn" = {
    "/etc/pvpn".d = {
      mode = "0750";
      user = "root";
      group = "pvpn";
    };

    "/var/lib/pvpn".d = {
      mode = "0700";
      user = "root";
      group = "root";
    };
  };
}
