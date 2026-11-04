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
}
