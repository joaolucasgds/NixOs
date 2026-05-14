{ pkgs, ... }:

let
    email = "joaolucasgdesouza@gmail.com";
    pubKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIASYEnzXMUbCIlJ/lENE3bWvVWoQAtc9XjTLEz5ZxOV jl@NixOs";
in

{
    programs.git = {
        enable = true;

        settings = {
            user = {
                name = "Joao Lucas Gomes de Souza";
                email = email;
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
        ${email} ${pubKey}
    '';
}
