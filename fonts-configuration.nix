{ config, pkgs, ... }:

{
  fonts.fontDir.enable = true;

  fonts.packages = with pkgs; [
    #Alacritty
    nerd-fonts.fira-code

    #Japanese / Chinese / Korean Support (CJK)
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif

    noto-fonts-color-emoji
    roboto
    ubuntu-classic
  ];
}
