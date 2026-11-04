{ ... }:

{
  imports = [
    ../../modules/user-packages.nix
    ../../modules/config-settings.nix
  ];

    programs.git= {
      enable = true;
      settings = {
        user.name = "Trevor";
        user.email = "thoner1@protonmail.com";
        init.defaultBranch = "main";
        url."git@github.com:".insteadOf = "https://github.com";
      };

      lfs.enable = true;

    };

    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings."*".AddKeysToAgent = "yes";
      extraConfig = ''
        Host github.com
          HostName ssh.github.com
          Port 443
          User git
          IdentityFile ~/.ssh/Battlestation
          IdentitiesOnly yes
        '';
    };

    programs.bash = {
	    enable = true;
	    shellAliases = { 
	      btw = "echo I use nixos, btw";
        nrs = "sudo nixos-rebuild switch --flake ~/.nixos-dotfiles#battlestation"; 
        nrs-dry = "sudo nixos-rebuild test --flake ~/.nixos-dotfiles#battlestation"; 
	    };
      initExtra = ''
        fastfetch
      '';
      };
}
