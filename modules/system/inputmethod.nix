{ pkgs, ... }:

{
    i18n.inputMethod = {
        enable = true;
        type = "fcitx5";
        fcitx5.waylandFrontend = true;
        fcitx5.addons = with pkgs; [
            fcitx5-mozc             # Japanese
            fcitx5-chewing # Zhuyin
            fcitx5-gtk              # Essential for GTK applications
        ];
    };
}
