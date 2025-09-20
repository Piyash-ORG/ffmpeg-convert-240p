#!/data/data/com.termux/files/usr/bin/bash

# Output folder
OUTPUT_DIR="/sdcard/Documents/Ffmpeg_Converted"
mkdir -p "$OUTPUT_DIR"

# Example input file (user can change)
EXAMPLE_INPUT="/sdcard/Download/video.mp4"

echo "Example input file: $EXAMPLE_INPUT"
read -p "Enter input file or folder path (or leave blank to use example): " INPUT_PATH
INPUT_PATH=${INPUT_PATH:-$EXAMPLE_INPUT}

# Download temporary cover image for album art
COVER_URL="https://i.ibb.co.com/21TLbNbV/org-thum-s2.png"
COVER_FILE="/data/data/com.termux/files/usr/tmp_cover.png"
curl -s -L "$COVER_URL" -o "$COVER_FILE"

# Show menu
echo "Select conversion option:"
echo "1) 240p Video + Audio"
echo "2) 360p Video + Audio"
echo "3) 480p Video + Audio"
echo "4) 720p Video + Audio"
echo "5) 1080p Video + Audio"
echo "6) Audio-only 64k"
echo "7) Audio-only 96k"
echo "8) Audio-only 128k"
echo "9) Audio-only 160k"
echo "10) Audio-only 320k"
read -p "Enter choice (1-10): " choice

# Set defaults
SCALE=""
DAR=""
VBIT=""
VCODEC=""
ABIT=""
MODE=""

case $choice in
  1) SCALE="320:240"; DAR="4/3"; VBIT="350k"; VCODEC="mpeg4"; ABIT="128k"; MODE="video";;
  2) SCALE="480:360"; DAR="4/3"; VBIT="600k"; VCODEC="libx264"; ABIT="128k"; MODE="video";;
  3) SCALE="854:480"; DAR="16/9"; VBIT="1000k"; VCODEC="libx264"; ABIT="128k"; MODE="video";;
  4) SCALE="1280:720"; DAR="16/9"; VBIT="2500k"; VCODEC="libx264"; ABIT="128k"; MODE="video";;
  5) SCALE="1920:1080"; DAR="16/9"; VBIT="5000k"; VCODEC="libx264"; ABIT="128k"; MODE="video";;
  6) ABIT="64k"; MODE="audio";;
  7) ABIT="96k"; MODE="audio";;
  8) ABIT="128k"; MODE="audio";;
  9) ABIT="160k"; MODE="audio";;
  10) ABIT="320k"; MODE="audio";;
  *) echo "Invalid choice!"; exit 1;;
esac

# Prepare files array
if [ -f "$INPUT_PATH" ]; then
    files=("$INPUT_PATH")
elif [ -d "$INPUT_PATH" ]; then
    files=("$INPUT_PATH"/*)
else
    echo "Error: $INPUT_PATH not found!"
    exit 1
fi

# Conversion loop
for file in "${files[@]}"; do
  [ ! -f "$file" ] && continue

  filename=$(basename "$file")
  name_noext="${filename%.*}"
  output_video="$OUTPUT_DIR/$filename"
  output_audio="$OUTPUT_DIR/${name_noext}.mp3"

  if [ "$MODE" = "video" ]; then
      # Video + Audio
      if [ -f "$output_video" ]; then
          echo "Skipping already converted video: $filename"
      else
          echo "Converting video ($SCALE, $VCODEC): $filename"
          ffmpeg -i "$file" \
            -vf "scale=$SCALE,setdar=$DAR" \
            -c:v $VCODEC -preset ultrafast -b:v $VBIT -r 25 \
            -c:a aac -b:a $ABIT -ar 44100 \
            "$output_video"
      fi

      if [ -f "$output_audio" ]; then
          echo "Skipping already converted audio: ${name_noext}.mp3"
      else
          echo "Extracting audio-only with album art ($ABIT): ${name_noext}.mp3"
          ffmpeg -i "$file" -vn -i "$COVER_FILE" \
            -map 0:a -map 1 -c:a libmp3lame -b:a $ABIT \
            -id3v2_version 3 -metadata:s:v title="Album cover" -metadata:s:v comment="Cover" \
            -disposition:v attached_pic "$output_audio"
      fi

  else
      # Audio-only (MP3) with album art
      if [ -f "$output_audio" ]; then
          echo "Skipping already converted audio: ${name_noext}.mp3"
      else
          echo "Converting audio-only MP3 with album art ($ABIT): ${name_noext}.mp3"
          ffmpeg -i "$file" -vn -i "$COVER_FILE" \
            -map 0:a -map 1 -c:a libmp3lame -b:a $ABIT \
            -id3v2_version 3 -metadata:s:v title="Album cover" -metadata:s:v comment="Cover" \
            -disposition:v attached_pic "$output_audio"
      fi
  fi

done

# Remove temporary cover
rm -f "$COVER_FILE"

echo "✅ Conversion finished! Files saved in: $OUTPUT_DIR"
