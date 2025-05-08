#!/bin/bash

# Settings
OUTPUT_DIR="$HOME/Videos"
PID_FILE="/tmp/record_screen_ffmpeg.pid"

start_recording() {
    FILENAME="$OUTPUT_DIR/recording_$(date +%Y-%m-%d_%H-%M-%S).mp4"
    mkdir -p "$OUTPUT_DIR"

    ffmpeg \
    -f x11grab -s 1280x1024 -r 60 -i :0.0 \
    -f pulse -i alsa_output.pci-0000_00_1f.3.analog-stereo.monitor \
    -f pulse -i alsa_input.pci-0000_00_1f.3.analog-stereo \
    -filter_complex "[1:a][2:a]amix=inputs=2[a]" \
    -map 0:v -map "[a]" \
    -c:v libx264 -preset veryfast -crf 23 \
    -c:a aac -b:a 192k \
    "$FILENAME" > /dev/null 2>&1 &

    echo $! > "$PID_FILE"
    notify-send "🎬 Recording started"
}

stop_recording() {
    if [[ -f "$PID_FILE" ]]; then
        PID=$(cat "$PID_FILE")
        kill -INT "$PID"
        rm "$PID_FILE"
        notify-send "🛑 Recording stopped"
    else
        notify-send "⚠️ No active recording"
    fi
}

open_folder() {
    alacritty -e yazi "$OUTPUT_DIR"
}

# Menu options
CHOICE=$(printf "Start Recording\nStop Recording\nOpen Recordings Folder\nExit" | dmenu -i -p "Screen Recorder")

case "$CHOICE" in
    "Start Recording")
        start_recording
        ;;
    "Stop Recording")
        stop_recording
        ;;
    "Open Recordings Folder")
        open_folder
        ;;
    *)
        exit 0
        ;;
esac

