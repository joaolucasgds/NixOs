{ inputs, ... }:

{
    home.file."Pictures/Wallpapers".source = inputs.wallpapers;

    home.file.".local/share/backgrounds".source = inputs.wallpapers;
}

