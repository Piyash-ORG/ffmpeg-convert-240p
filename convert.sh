#!/data/data/com.termux/files/usr/bin/bash

# Output base folder
OUTPUT_DIR="/sdcard/Documents/Ffmpeg_Converted"
mkdir -p "$OUTPUT_DIR"

# Ask input path (file or folder)
read -p "Enter input file or folder path (file or folder, e.g., /sdcard/Download/HighS or /sdcard/Download/video.mp4): " INPUT_PATH

# Ask video quality option
echo "Select video quality:"
echo "1) 240p (MPEG4)"
echo "2) 360p (H.264)"
echo "3) 480p (H.264)"
echo "4) 720p HD (H.264)"
echo "5) 1080p FHD (H.264)"
read -p "Enter choice (1-5): " choice

case $choice in
  1)
    SCALE="320:240"
    DAR="4/3"
    VBIT="350k"
    VCODEC="mpeg4"
    ;;
  2)
    SCALE="480:360"
    DAR="4/3"
    VBIT="600k"
    VCODEC="libx264"
    ;;
  3)
    SCALE="854:480"
    DAR="16/9"
    VBIT="1000k"
    VCODEC="libx264"
    ;;
  4)
    SCALE="1280:720"
    DAR="16/9"
    VBIT="2500k"
    VCODEC="libx264"
    ;;
  5)
    SCALE="1920:1080"
    DAR="16/9"
    VBIT="5000k"
    VCODEC="libx264"
    ;;
  *)
    echo "Invalid choice!"
    exit 1
    ;;
esac

# Ask audio bitrate
echo "Select audio bitrate for audio-only file:"
echo "1) 64k"
echo "2) 96k"
echo "3) 128k"
echo "4) 160k"
echo "5) 320k"
read -p "Enter choice (1-5): " achoice

case $achoice in
  1) ABIT="64k" ;;
  2) ABIT="96k" ;;
  3) ABIT="128k" ;;
  4) ABIT="160k" ;;
  5) ABIT="320k" ;;
  *) echo "Invalid audio choice! Using default 128k."; ABIT="128k" ;;
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
  output_audio="$OUTPUT_DIR/${name_noext}.m4a"

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
    echo "Skipping already converted audio: ${name_noext}.m4a"
  else
    echo "Extracting audio-only ($ABIT): ${name_noext}.m4a"
    ffmpeg -i "$file" -vn -c:a aac -b:a $ABIT "$output_audio"
  fi
done

echo "✅ Conversion finished! Files saved in: $OUTPUT_DIR"
