{ pkgs, ... }:

{
    dconf.settings = {
        # Automatically activate extensions
        "org/gnome/shell" = {
            disable-user-extensions = false;

            enabled-extensions = with pkgs.gnomeExtensions; [
                blur-my-shell.extensionUuid
                caffeine.extensionUuid
                clipboard-indicator.extensionUuid
                gsconnect.extensionUuid
                coverflow-alt-tab.extensionUuid
                reboottouefi.extensionUuid
                dynamic-panel.extensionUuid
                gamebar-overlay.extensionUuid
                hide-top-bar.extensionUuid
                hide-the-dock-in-overview.extensionUuid
                search-light.extensionUuid
                brightness-control-using-ddcutil.extensionUuid
                do-not-disturb-while-screen-sharing-or-recording.extensionUuid
                focus-follows-workspace.extensionUuid
            ];
        };

        # Config Extensions
        "org/gnome/shell/extensions/blur-my-shell/panel" = {
            blur = false;
        };

        "org/gnome/shell/extensions/blur-my-shell/applications" = {
            blur = true;
            dynamic-opacity = false;
            enable-all = false;
            sigma = 10;
            whitelist = [ "Alacritty" ];
        };

        "org/gnome/shell/extensions/clipboard-indicator" = {
            excluded-apps = [ "Proton Pass" ];
        };

        "org/gnome/shell/extensions/search-light" = {
            shortcut-search = [ "<Control><Alt>a" ];
        };

        "org/gnome/shell/extensions/gamebar-overlay" = {
            show-indicator = false;
        };

        "org/gnome/shell/extensions/display-brightness-ddcutil" = {
            button-location = 1;
            ddcutil-binary-path = "${pkgs.ddcutil}/bin/ddcutil";
            ddcutil-queue-ms = 130.0;
            ddcutil-sleep-multiplier = 40.0;
            decrease-brightness-shortcut = [ "<Control>XF86MonBrightnessDown" ];
            hide-system-indicator = true;
            increase-brightness-shortcut = [ "<Control>XF86MonBrightnessUp" ];
            position-system-menu = 4.0;
            show-all-slider = false;
            show-display-name = false;
            show-internal-slider = false;
            show-osd = true;
            show-value-label = false;
            step-change-keyboard = 2.0;
        };

        # Config Custom Keybinds   There must be a better way of doing this instead of repeating myself like this  
        "org/gnome/settings-daemon/plugins/media-keys" = {
            custom-keybindings = [
                "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
                "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
                "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
                "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
                "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/"
                "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/"
                "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom6/"
                "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom7/"
                "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom8/"
            ];
        };

        # Terminal
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
            name = "Terminal";
            command = "alacritty";
            binding = "<Control><Alt>t";
        };

        # Browser
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
            name = "Browser";
            command = "flatpak run app.zen_browser.zen";
            binding = "<Control><Alt>n";
        };

        # ProtonPass
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
            name = "ProtonPass";
            command = "proton-pass";
            binding = "<Control><Alt>p";
        };

        # Discord (Vesktop)
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
            name = "Discord";
            command = "vesktop"; 
            binding = "<Control><Alt>d";
        };

        # Neovim
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4" = {
            name = "Neovim";
            command = "nvim"; 
            binding = "<Control><Alt>v";
        };

        # Kodi
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5" = {
            name = "Kodi";
            command = "kodi";
            binding = "<Control><Alt>k";
        };

        # Files
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom6" = {
            name = "Files";
            command = "nautilus";
            binding = "<Control><Alt>f";
        };

        # Settings
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom7" = {
            name = "Settings";
            command = "gnome-control-center";
            binding = "<Control><Alt>s";
        };

        # ProtonVPN
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom8" = {
            name = "ProtonVPN";
            command = "protonvpn-app";
            binding = "<Control><Alt>j";
        };

        # GNOME CORE & INTERFACE

        # Search Provider Order (Calculator First)
        "org/gnome/desktop/search-providers" = {
            sort-order = [
                "org.gnome.Calculator.desktop"
                "org.gnome.Settings.desktop"
                "org.gnome.Contacts.desktop"
                "org.gnome.Nautilus.desktop"
            ];
        };

        # Disable Mouse Acceleration
        "org/gnome/desktop/peripherals/mouse" = {
            accel-profile = "flat";
        };

        # Interface: Dark Mode, Blue Accent, 12h Clock
        "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
            accent-color = "blue";
            clock-format = "12h";
        };
    };
}
