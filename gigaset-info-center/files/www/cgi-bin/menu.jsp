#!/bin/sh
printf "Content-Type: text/html; charset=utf-8\r\n\r\n"

# Вызываем основной скрипт для получения прогноза
WEATHER=$(/usr/bin/gigaset-weather 2>/dev/null)

cat <<EOF
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//OMA//DTD XHTML Mobile 1.2//EN"
  "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <title>Wetter</title>
  <meta http-equiv="refresh" content="3600"/>
</head>
<body>
$(echo "$WEATHER" | while IFS= read -r line; do
    [ -n "$line" ] && printf "<p>%s</p>" "$line"
done)
</body>
</html>
EOF
