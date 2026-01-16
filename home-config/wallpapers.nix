{ inputs, ... }:

{
    home.file."Pictures/Wallpapers".source = inputs.wallpaperRepo;

    home.file.".local/share/backgrounds".source = inputs.wallpaperRepo;
}

