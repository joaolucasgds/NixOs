{ pkgs, ... }:

let
    nvf = import (builtins.fetchTarball {
        url = "https://github.com/NotAShelf/nvf/archive/refs/tags/v0.8.tar.gz";
    });
in

{
    imports = [ nvf.homeManagerModules.nvf ];

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
                    # Standard Telescope Keybinds
                    "<leader>ff" = { action = ":Telescope find_files<CR>"; desc = "Find Files"; };
                    "<leader>fg" = { action = ":Telescope live_grep<CR>";  desc = "Live Grep"; };
                    "<leader>fb" = { action = ":Telescope buffers<CR>";    desc = "Buffers"; };
                    "<leader>fh" = { action = ":Telescope help_tags<CR>";  desc = "Help Tags"; };
                };
		
		# --- Helper Plugins --- #
		lsp.enable = true;

		languages = {
                    enableTreesitter = true;

                    nix.enable = true;
                    rust.enable = true;
                    clang.enable = true;
                    lua.enable = true;
                };

		telescope = {
                    enable = true;
                    setupOpts = {
                        defaults = {
                            prompt_prefix = " ";
                            selection_caret = " ";
                        };
                    };
                };
		
		# test harpoon soon
		autocomplete.blink-cmp.enable = true;
	    };
	};
    };
}

