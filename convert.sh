#!/data/data/com.termux/files/usr/bin/bash

mkdir -p /sdcard/Movies/HighS_240p

for file in /sdcard/Download/HighS/*; do
  filename=$(basename "$file")
  output="/sdcard/Movies/HighS_240p/$filename"

  if [ -f "$output" ]; then
    echo "Skipping already converted: $filename"
    continue
  fi

  echo "Converting (240p): $filename"
  ffmpeg -i "$file" \
    -vf "scale=320:240,setdar=4/3" \
    -c:v mpeg4 -preset ultrafast -b:v 350k -r 25 \
    -c:a aac -b:a 96k -ar 44100 \
    "$output"
done
