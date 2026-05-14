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

        theme = {
            filetype = {
                rules = [
                    # 1. Use 'url = "*/"' to catch all directories
                    # 2. Put 'fg' at the top level (no nested style block)
                    { url = "*/"; fg = "#8a8a8a"; }
                    
                    # also keep the mime rule just to be perfectly safe
                    { mime = "inode/directory"; fg = "#8a8a8a"; }
                ];
            };
        };
    };
}
