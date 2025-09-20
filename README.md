# 🎥 FFmpeg Video Converter (Termux)

A tiny **interactive FFmpeg converter script** for Termux (Android).  
Quickly convert a folder of videos to chosen resolution + codec while preserving filenames.

---

## 🚀 Highlights
- Interactive: asks for **input folder** and **quality** at runtime  
- Saves outputs to: **`/sdcard/Documents/Ffmpeg_Converted/`**  
- Skips already-converted files (same filename)  
- Uses **MPEG4** for 240p (retro / low-end), **H.264 (libx264)** for higher qualities  

---

## 🛠 Requirements
- Termux (Android)
- FFmpeg installed in Termux

Install FFmpeg (Copy button enabled):
```bash
pkg update && pkg upgrade -y
pkg install ffmpeg -y


---

📥 One-line Clone & Run

git clone https://github.com/Piyash-ORG/ffmpeg-video-converter.git
cd ffmpeg-video-converter
chmod +x convert.sh
./convert.sh

> Only these commands have Copy for usage in Terumx.

---

▶️ Interactive Usage

When you run ./convert.sh the script will ask:

1. Input folder path — e.g. /sdcard/Download/HighS  
2. Quality option — choose number (1–5)

Example (non-copyable):

Select quality option:
1) 240p (MPEG4)
2) 360p (H.264)
3) 480p (H.264)
4) 720p HD (H.264)
5) 1080p FHD (H.264)

Converted files saved to:

/sdcard/Documents/Ffmpeg_Converted/

---

🎚 Quality Settings (non-copyable)

#	Name	Resolution	Video codec	Video bitrate	Audio	Notes

1	240p (MPEG4)	320×240	mpeg4	350k	AAC 96k	Low-end devices
2	360p (H.264)	480×360	libx264	600k	AAC 96k	Phones / low bandwidth
3	480p (H.264)	854×480	libx264	1000k	AAC 128k	Standard web/mobile
4	720p (H.264)	1280×720	libx264	2500k	AAC 128k	Good quality
5	1080p (H.264)	1920×1080	libx264	5000k	AAC 192k	High quality FHD



---

⚙️ Script Behaviour & Notes (non-copyable)

Original filenames preserved. Already converted files skipped.

240p uses mpeg4, higher resolutions use libx264.

Audio is AAC. Bitrate depends on resolution.

Uses -preset ultrafast for speed. You can edit convert.sh for better compression (-preset medium) or CRF-based control.



---

❗ Troubleshooting (non-copyable)

Permission denied on /sdcard → run:


termux-setup-storage

ffmpeg: command not found → install ffmpeg in Termux.


