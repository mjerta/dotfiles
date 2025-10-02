#!/bin/bash

CLIPBOARD_FILE="$HOME/.saved_clipboard"
# Restore clipboard
if [ -f "$CLIPBOARD_FILE" ]; then
  xclip -i -selection clipboard <"$CLIPBOARD_FILE"
  notify-send "📋 Clipboard Manager" "🔄 Clipboard content restored"
else
  notify-send "📋 Clipboard Manager" "⚠️ No saved clipboard found!"
fi
