{ ... }:

{
    programs.yazi = {
	    enable = true;

        settings = {
            opener = {
                edit = [
                    { run = ''nvim "$@"''; block = true; desc = "Neovim"; }
                ];
                play = [
                    { run = ''mpv "$@"''; orphan = true; desc = "mpv"; }
                ];
            };
            open = {
                rules = [
                    { mime = "text/*"; use = "edit"; }
                    { mime = "video/*"; use = "play"; }
                    { mime = "image/*"; use = "play"; }
                    
                    # Catch-all for files without a specific mime rule
                    { mime = "*"; use = "edit"; }
                ];
            };
        };
    };
}
