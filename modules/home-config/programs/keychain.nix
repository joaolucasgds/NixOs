{...}: 

{
    programs.keychain = {
        enable = true;
        keys = [ "github-signing" ];
    };
}
