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
    };
}

