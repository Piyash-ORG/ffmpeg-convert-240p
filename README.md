
📘 README.md

# 🎥 FFmpeg Video Converter (Termux)

A simple **interactive FFmpeg video converter script** for Termux (Android).  
It allows you to convert videos to different resolutions with one command.

---

## 🚀 Features
- Choose input folder interactively
- Select output quality (240p, 360p, 480p, 720p, 1080p)
- Saves converted files in:  
  **`/sdcard/Documents/Ffmpeg_Converted/`**
- Skips already converted files
- Uses **MPEG4** for 240p and **H.264 (libx264)** for higher qualities
- Preserves original filenames

---

## 🛠 Requirements
- Install Termux  
- Install FFmpeg inside Termux:
  ```bash
  pkg update && pkg upgrade
  pkg install ffmpeg


---

📥 Installation

Clone this repo in Termux:

git clone https://github.com/your-username/ffmpeg-video-converter.git
cd ffmpeg-video-converter
chmod +x convert.sh


---

▶️ Usage

Run the script:

./convert.sh

You will be asked for:

1. Input folder path (e.g. /sdcard/Download/HighS)


2. Quality option



Example:

Select quality option:
1) 240p (MPEG4)
2) 360p (H.264)
3) 480p (H.264)
4) 720p HD (H.264)
5) 1080p FHD (H.264)


---

🎚 Quality Settings

Option	Resolution	Codec	Video Bitrate	Audio Bitrate

1	320×240	MPEG4	350k	96k
2	480×360	H.264	600k	96k
3	854×480	H.264	1000k	128k
4	1280×720	H.264	2500k	128k
5	1920×1080	H.264	5000k	192k



---

📂 Output

All converted files will be saved here:

/sdcard/Documents/Ffmpeg_Converted/

