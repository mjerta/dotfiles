#!/usr/bin/env bash

coordinates=$(curl -s https://ipinfo.io/loc)

LAT=$(echo "$coordinates" | awk -F',' '{print $1}')
LON=$(echo "$coordinates" | awk -F',' '{print $2}')

resp=$(curl -s "https://api.open-meteo.com/v1/forecast?latitude=${LAT}&longitude=${LON}&current_weather=true")

# Check if response looks okay
if [[ -z "$resp" ]]; then
  echo '{"text":"⚠️","tooltip":"No weather data"}'
  exit 1
fi

# Parse data
temp=$(echo "$resp" | jq '.current_weather.temperature')
wind=$(echo "$resp" | jq '.current_weather.windspeed')
weathercode=$(echo "$resp" | jq '.current_weather.weathercode')

# Map weathercode to emoji
emoji=$(case "$weathercode" in
  0) echo "☀️";;
  1|2|3) echo "⛅";;
  45|48) echo "🌫️";;
  51|53|55|56|57) echo "🌦️";;
  61|63|65|66|67) echo "🌧️";;
  71|73|75|77|85|86) echo "❄️";;
  80|81|82) echo "🌧️";;
  95|96|99) echo "⛈️";;
  *) echo "🌡️";;
esac)

# Output JSON for Waybar
echo "{\"text\": \"${emoji} ${temp}°C\", \"tooltip\": \"Temp: ${temp}°C\\nWind: ${wind} km/h\"}"

