{ pkgs, ... }:

let
    wallpaperRepo = builtins.fetchGit {
	url = "https://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@github.com/JoaoLucasGdS/Wallpapers.git";
	ref = "main";
	shallow = true;
    };
in
{
    home.file."Pictures/Wallpapers".source = wallpaperRepo;

    home.file.".local/share/backgrounds".source = wallpaperRepo;
}

