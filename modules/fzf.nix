{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    fzf
    fzf-zsh-plugin
    fzf-obc
    fzf-make
    fzf-git-sh
    fzf-preview
    fzy
    ytfzf
  ];
}
