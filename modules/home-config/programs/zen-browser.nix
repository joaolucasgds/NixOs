{ inputs, ... }:

{
    imports = [ inputs.zen-browser.homeModules.default ]; #Defaults is beta btw

    programs.zen-browser = {
        enable = true;

        policies = {

            DefaultSearchEngine = "DuckDuckGo";

            AutofillAddressEnabled = true;
            AutofillCreditCardEnabled = false;
            DisableAppUpdate = true;
            DisableFeedbackCommands = true;
            DisableFirefoxStudies = true;
            DisablePocket = true;
            DisableTelemetry = true;
            DontCheckDefaultBrowser = true;
            NoDefaultBookmarks = true;
            OfferToSaveLogins = false;
            EnableTrackingProtection = {
                Value = true;
                Locked = true;
                Cryptomining = true;
                Fingerprinting = true;
            };

            ExtensionSettings = {
                "uBlock0@raymondhill.net" = {
                    install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
                    installation_mode = "force_installed";
                };

                "{6b733b82-9261-47ee-a595-2dda294a4d08}" = {
                    install_url = "https://addons.mozilla.org/firefox/downloads/latest/yomitan/latest.xpi";
                    installation_mode = "force_installed";
                };

                "addon@darkreader.org" = {
                    install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
                    installation_mode = "force_installed";
                };
                
                "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
                    install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
                    installation_mode = "force_installed";
                };
            };
        };
    };

}

