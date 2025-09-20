#!/data/data/com.termux/files/usr/bin/bash

# Output base folder
OUTPUT_DIR="/sdcard/Documents/Ffmpeg_Converted"
mkdir -p "$OUTPUT_DIR"

# Ask input path (file or folder)
read -p "Enter input file or folder path (e.g., /sdcard/Download/HighS or /sdcard/Download/video.mp4): " INPUT_PATH

# Ask quality option
echo "Select quality option:"
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
    ABIT="96k"
    ;;
  2)
    SCALE="480:360"
    DAR="4/3"
    VBIT="600k"
    VCODEC="libx264"
    ABIT="96k"
    ;;
  3)
    SCALE="854:480"
    DAR="16/9"
    VBIT="1000k"
    VCODEC="libx264"
    ABIT="128k"
    ;;
  4)
    SCALE="1280:720"
    DAR="16/9"
    VBIT="2500k"
    VCODEC="libx264"
    ABIT="128k"
    ;;
  5)
    SCALE="1920:1080"
    DAR="16/9"
    VBIT="5000k"
    VCODEC="libx264"
    ABIT="192k"
    ;;
  *)
    echo "Invalid choice!"
    exit 1
    ;;
esac

# Prepare files array
if [ -f "$INPUT_PATH" ]; then
    # Single file
    files=("$INPUT_PATH")
elif [ -d "$INPUT_PATH" ]; then
    # Folder
    files=("$INPUT_PATH"/*)
else
    echo "Error: $INPUT_PATH not found!"
    exit 1
fi

# Conversion loop
for file in "${files[@]}"; do
  # Skip if not a file
  [ ! -f "$file" ] && continue

  filename=$(basename "$file")
  output="$OUTPUT_DIR/$filename"

  if [ -f "$output" ]; then
    echo "Skipping already converted: $filename"
    continue
  fi

  echo "Converting ($SCALE, $VCODEC): $filename"
  ffmpeg -i "$file" \
    -vf "scale=$SCALE,setdar=$DAR" \
    -c:v $VCODEC -preset ultrafast -b:v $VBIT -r 25 \
    -c:a aac -b:a $ABIT -ar 44100 \
    "$output"
done

echo "✅ Conversion finished! Files saved in: $OUTPUT_DIR"
