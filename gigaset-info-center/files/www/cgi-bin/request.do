#!/bin/sh
printf "Content-Type: text/plain; charset=utf-8\r\n\r\n"

# Только первый день — для бегущей строки на экране ожидания
API_KEY=$(uci -q get gigaset-info-center.settings.api_key)
LAT=$(uci -q get gigaset-info-center.settings.latitude)
LON=$(uci -q get gigaset-info-center.settings.longitude)
LANG=$(uci -q get gigaset-info-center.settings.lang 2>/dev/null)
LANG=${LANG:-de}

TMP=$(mktemp /tmp/gigaset-req.XXXXXX)
uclient-fetch -q -O "$TMP" \
  "https://api.openweathermap.org/data/2.5/weather?lat=${LAT}&lon=${LON}&appid=${API_KEY}&units=metric&lang=${LANG}" \
  2>/dev/null

TEMP=$(jsonfilter -i "$TMP" -e '@.main.temp' 2>/dev/null)
DESC=$(jsonfilter -i "$TMP" -e '@.weather[0].description' 2>/dev/null)
CITY=$(jsonfilter -i "$TMP" -e '@.name' 2>/dev/null)
rm -f "$TMP"

# Одна строка для бегущей строки: "Berlin: 18°C, Leichter Regen"
printf "%s: %.0f°C, %s\n" "$CITY" "$TEMP" "$DESC"
