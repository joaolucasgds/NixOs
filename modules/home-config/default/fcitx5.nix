{ ... }:

{
    xdg.configFile."fcitx5/profile" = {
        force = true;
        text = ''
            [Groups/0]
            Name=Default
            Default Layout=br-nodeadkeys
            DefaultIM=mozc

            [Groups/0/Items/0]
            Name=keyboard-br-nodeadkeys
            Layout=

            [Groups/0/Items/1]
            Name=mozc
            Layout=

            [Groups/0/Items/2]
            Name=chewing
            Layout=

            [GroupOrder]
            0=Default
        '';
    };

    xdg.configFile."fcitx5/config" = {
        force = true;
        text = ''
            [Hotkey]
            EnumerateWithTriggerKeys=True
            EnumerateSkipFirst=False
            ModifierOnlyKeyTimeout=250

            [Hotkey/TriggerKeys]
            0=Control+space

            [Behavior]
            ActiveByDefault=False
            ShowInputMethodInformation=True
            PreloadInputMethod=True
        '';
    };

    # Hardcoding the Chewing layout to Phonetic/Pinyin
    xdg.configFile."fcitx5/conf/chewing.conf" = {
        force = true;
        text = ''
            SelectionKey=1234567890
            SelectCandidateWithArrowKey=True
            PageSize=10
            CandidateLayout=Horizontal
            SpaceAsSelection=True
            Layout="Default Keyboard"
        '';
    };

    # Hardcoding the Traditional to Simplified Toggle
    xdg.configFile."fcitx5/conf/chttrans.conf" = {
        force = true;
        text = ''
            Engine=OpenCC
            OpenCCS2TProfile=default
            OpenCCT2SProfile=default

            [Hotkey]
            0=Control+Shift+F
        '';
    };
}
