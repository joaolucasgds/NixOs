__:
{
    programs.concord = {
        enable = true;
        settings = {
            display = {
                animate_previews = "always";
                attachment_viewer_quality = "original";
                circular_avatars = false;
                disable_image_preview = false;
                hour_format_24 = false;
                image_preview_quality = "balanced";
                image_protocol = "kitty";
                media_playback = false;
                show_avatars = true;
                show_custom_emoji = true;
                show_images = true;
            };

            composer = {
                emojis_as_links = false;
            };

            reactions = {
            };

            presence = {
                share_rich_presence = true;
            };

            credentials = {
                store = "keychain";
            };

            notifications = {
                desktop_notifications = true;
            };

            voice = {
                allow_microphone_transmit = true;
                microphone_sensitivity = -30;
                microphone_volume = 100;
                noise_suppression = true;
                push_to_talk = false;
                push_to_talk_shortcut = "F8";
                self_deaf = false;
                self_mute = false;
                voice_output_volume = 100;
            };
        };
    };
}
