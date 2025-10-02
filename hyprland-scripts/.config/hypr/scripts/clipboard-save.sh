#!/bin/bash

CLIPBOARD_FILE="$HOME/.saved_clipboard"
# Save current clipboard
xclip -o -selection clipboard >"$CLIPBOARD_FILE"
notify-send "📋 Clipboard Manager" "✅ Clipboard content saved"
