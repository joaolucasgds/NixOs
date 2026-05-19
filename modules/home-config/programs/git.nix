{ pkgs, hostvars, ... }:

let
    email = "joaolucasgdesouza@gmail.com";
in

{
    programs.git = {
        enable = true;

        settings = {
            user = {
                name = "Joao Lucas Gomes de Souza";
                inherit email;
            };

            gpg = {
                format = "ssh";
                ssh.allowedSignersFile = "~/.config/git/allowed_signers";
            };

            "gpg \"ssh\"".program = "${pkgs.openssh}/bin/ssh-keygen";
        };

        signing = {
            key = "~/.ssh/github-signing.pub";
            signByDefault = true;
        };
    };

    home.file.".config/git/allowed_signers".text = ''
        ${email} ${hostvars.gitSigningPubKey}
    '';
}
