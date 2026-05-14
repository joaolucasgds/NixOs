{...}: 

{
    programs.keychain = {
        enable = true;
        enableBashIntegration = false;
        keys = [ "github-signing" ];
    };
}
