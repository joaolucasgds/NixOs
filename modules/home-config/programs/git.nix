{ pkgs, ... }:

{
    programs.git = {
	    enable = true;
        settings = {
            user = {
                name = "Joao Lucas Gomes de Souza";
                email = "joaolucasgdesouza@gmail.com";
            };
        };

        signing = {
            key = "~/.ssh/github-signing.pub";
            signByDefault = true;
        };

        extraConfig = {
            gpg.format = "ssh";
            "gpg \"ssh\"".program = "${pkgs.openssh}/bin/ssh-keygen"; # Explicitly use the SSH binary
        };

    };
}

