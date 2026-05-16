{ inputs, pkgs, ... }:

{
    imports = [ inputs.nvf.homeManagerModules.nvf ];

    programs.nvf = {
	    enable = true;

        settings = {
            vim = {
                # --- Core --- #
                globals = {
                    mapleader = " ";
                    maplocalleader = "\\";
                };

                options = {
                    shiftwidth = 4;
                    tabstop = 4;
                    softtabstop = 4;
                    expandtab = true;
                    number = true;
                };

                maps.normal = {
                    # Telescope Keybinds
                    "<leader>ff" = { action = ":Telescope find_files<CR>"; desc = "Find Files"; };
                    "<leader>fg" = { action = ":Telescope live_grep<CR>";  desc = "Live Grep"; };
                    "<leader>fb" = { action = ":Telescope buffers<CR>";    desc = "Buffers"; };
                    "<leader>fh" = { action = ":Telescope help_tags<CR>";  desc = "Help Tags"; };
                    "<leader>fd" = { action = ":Telescope diagnostics<CR>"; desc = "Find Diagnostics"; };
                    "<leader>e"  = { action = ":lua vim.diagnostic.open_float()<CR>"; desc = "Show Line Diagnostics"; };
                    "<leader>fv" = { action = ":Telescope file_browser path=%:p:h select_buffer=true<CR>"; desc = "File Browser"; };
                };
            
                # --- Helper Plugins --- #
                lsp.enable = true;

                languages = {
                    enableTreesitter = true;

                    nix = {
                        enable = true;
                        extraDiagnostics.enable = true;

                        lsp.setupOpts = {
                            settings = {
                                "nil" = {
                                    nix = {
                                        flake = {
                                            autoArchive = true;
                                        };
                                    };
                                };
                            };
                        };

                    };

                    rust.enable = true;
                    clang.enable = true;
                    lua.enable = true;
                    java.enable = true;
                };

                treesitter = {
                    context.enable = true; #Gotta test this a little more
                };

                telescope = {
                    enable = true;
                    setupOpts = {
                        defaults = {
                            prompt_prefix = " ";
                            selection_caret = " ";
                        };
                    };

                    extensions = [
                        {
                            name = "file_browser";
                            packages = [ pkgs.vimPlugins.telescope-file-browser-nvim ];

                            setup = {
                                file_browser = {
                                    theme = "ivy";        # Makes it open as a bottom drawer 
                                    hijack_netrw = true;
                                };
                            };
                        }
                    ];
                };

                clipboard = {
                    enable = true;
                    providers.wl-copy.enable = true;
                    registers = "unnamedplus";
                };
            
                #test harpoon soon
                autocomplete.blink-cmp.enable = true;

                # --- Beauty plugins --- #
                theme = {
                    enable = true;
                    name = "base16"; 
                    style = "dark";
                    transparent = false; 
                    
                    #theme "evergarden" base16 colors aquired from "https://github.com/everviolet/base16/blob/main/themes/evergarden-fall.yaml";

                    base16-colors = { 
                        base00 = "#232a2e";
                        base01 = "#2b3337";
                        base02 = "#323c41";
                        base03 = "#96b4aa";
                        base04 = "#d5d6c8";
                        base05 = "#f8f9e8";
                        base06 = "#e0e2d0";
                        base07 = "#ffffff";
                        base08 = "#f57f82";
                        base09 = "#b3e3ca"; #Was a orangeish yellow which i didnt like so its cyan now
                        base0A = "#f5d098";
                        base0B = "#cbe3b3"; 
                        base0C = "#b3e3ca"; 
                        base0D = "#cbe3b3"; 
                        base0E = "#f5d098"; #Was a purpleish blue but made the LSP warn sign be odd so i changed it to a bright yellow
                        base0F = "#f3c0e5"; 
                    };
                };

                statusline.lualine = {
                    enable = true;
                    theme = "base16";
                    componentSeparator = { left = ""; right = ""; };
                    sectionSeparator = { left = ""; right = ""; };
                };
    
                visuals.nvim-web-devicons.enable = true;

                visuals.indent-blankline = {
                    enable = true;
                    setupOpts = {
                        scope.enabled = true;
                    };
                };

                presence.neocord.enable = true;

            };
        };
    };
}

