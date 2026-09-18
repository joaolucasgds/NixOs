{ pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellScriptBin "gsr-toggle" ''
      #!/usr/bin/env bash

      VIDEO_CODEC="hevc_10bit"
      RECORD_BITRATE="40000"
      REPLAY_BITRATE="60000"

      MODE="''${1:-record}" # Options: record, replay, save
      MIC="''${2:-nomic}"   # Options: m, nomic

      if [ "$MODE" = "save" ]; then
        killall -SIGUSR1 gpu-screen-recorder && gsr-notify --text 'Clip saved' --timeout 3 --icon replay &
        exit 0
      fi

      if killall -0 gpu-screen-recorder 2>/dev/null; then
        killall -SIGINT gpu-screen-recorder

        NOTIFICATION_TEXT="Recording ended"
        ICON="record"

        if [ "$MODE" = "replay" ]; then
          NOTIFICATION_TEXT="Replay buffer ended"
          ICON="replay"
        fi

        if [ "$MIC" = "m" ]; then
          NOTIFICATION_TEXT="$NOTIFICATION_TEXT - MIC"
        fi

        gsr-notify --text "$NOTIFICATION_TEXT" --timeout 3 --icon "$ICON" &
        exit 0
      fi

      NOTIFICATION_TEXT="Recording started"
      ICON="record"

      if [ "$MODE" = "replay" ]; then
        NOTIFICATION_TEXT="Replay buffer started"
        ICON="replay"
      fi

      if [ "$MIC" = "m" ]; then
        NOTIFICATION_TEXT="$NOTIFICATION_TEXT - MIC"
      fi

      gsr-notify --text "$NOTIFICATION_TEXT" --timeout 3 --icon "$ICON" &

      MONITOR=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')

      AUDIO_ARGS=(-a "app-inverse:")
      if [ "$MIC" = "m" ]; then
        AUDIO_ARGS=(-a "$(pactl get-default-source)" -a "app-inverse:")
      fi

      if [ "$MODE" = "replay" ]; then
        exec gpu-screen-recorder \
          -w "$MONITOR" \
          "''${AUDIO_ARGS[@]}" \
          -c mp4 -ac opus -cursor yes -cr full -fm cfr \
          -k "$VIDEO_CODEC" -encoder gpu -f 60 -r 180 -v no \
          -o "$HOME/Videos/Games" \
          -restart-replay-on-save yes -replay-storage ram \
          -bm cbr -q "$REPLAY_BITRATE" -restore-portal-session yes \
          -ro "$HOME/Videos/Temporary"
      else
        exec gpu-screen-recorder \
          -w "$MONITOR" \
          "''${AUDIO_ARGS[@]}" \
          -c mp4 -ac opus -cursor yes -cr full -fm cfr \
          -k "$VIDEO_CODEC" -encoder gpu -f 60 -v no \
          -o "$HOME/Videos/Temporary/Video_$(date +%Y-%m-%d_%H-%M-%S).mp4" \
          -bm cbr -q "$RECORD_BITRATE" -restore-portal-session yes
      fi
    '')
  ];
}
