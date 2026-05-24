{ ... }:

{
    programs.yazi = {
	    enable = true;
        shellWrapperName = "y";

        settings = {
            opener = {
                edit = [
                    { run = ''nvim "$@"''; block = true; desc = "Neovim"; }
                ];
                play = [
                    { run = ''mpv "$@"''; orphan = true; desc = "mpv"; }
                ];
                browser = [
                    { run = ''zen-beta "$@"''; orphan = true; desc = "Browser"; }
                ];
            };
            open = {
                rules = [
                    { mime = "text/*"; use = "edit"; }
                    { mime = "video/*"; use = "play"; }
                    { mime = "image/*"; use = "play"; }
                    { mime = "application/pdf"; use = "browser"; }
                    { mime = "text/html"; use = "browser"; }
                    
                    # Catch-all for files without a specific mime rule
                    { mime = "*"; use = "edit"; }
                ];
            };
        };

        theme = {
            icon = {
                prepend_dirs = [
                    { name = "Documents"; text = ""; fg = "#8a8a8a"; }
                    { name = "Downloads"; text = ""; fg = "#8a8a8a"; }
                    { name = "Pictures";  text = ""; fg = "#8a8a8a"; }
                    { name = "Public";    text = ""; fg = "#8a8a8a"; }
                    { name = "Music";     text = ""; fg = "#8a8a8a"; }
                    { name = "Videos";    text = ""; fg = "#8a8a8a"; }
                    { name = "Projects";  text = "󰏗"; fg = "#8a8a8a"; }
                ];
                
                prepend_conds = [
                    { "if" = "dir"; text = ""; fg = "#8a8a8a"; }
                ];
            };
        };
    };
}
