# 🎥 FFmpeg Video Converter (Termux)

A tiny **interactive FFmpeg converter script** for Termux (Android).  
Quickly convert a whole folder of videos to chosen resolution + codec while preserving filenames.

---

## 🚀 Highlights
- Interactive: asks for **input folder** and **quality** at runtime  
- Saves outputs to: **`/sdcard/Documents/Ffmpeg_Converted/`**  
- Skips already-converted files (same filename)  
- Uses **MPEG4** for 240p (retro / low-end), **H.264 (libx264)** for higher qualities  
- Simple, one-command install & run

---

## 🛠 Requirements
- Termux (Android)
- FFmpeg installed in Termux

Install FFmpeg:
```bash
pkg update && pkg upgrade -y
pkg install ffmpeg -y


---

📥 One-line Clone & Run (one-tap copy on GitHub)

On GitHub the code block below shows a Copy button — click it to copy the whole command and run in Termux:

git clone https://github.com/Piyash-ORG/ffmpeg-video-converter.git \
&& cd ffmpeg-video-converter \
&& chmod +x convert.sh

Then run:

./convert.sh


---

▶️ Interactive Usage

When you run ./convert.sh the script will ask:

1. Input folder path — e.g. /sdcard/Download/HighS


2. Quality option — choose number (1–5)



Options shown:

Select quality option:
1) 240p (MPEG4)
2) 360p (H.264)
3) 480p (H.264)
4) 720p HD (H.264)
5) 1080p FHD (H.264)

Converted files saved to:

/sdcard/Documents/Ffmpeg_Converted/


---

🎚 Improved Quality Settings (recommended)

#	Name	Resolution	Video codec	Video bitrate / mode	Audio	Notes

1	240p (MPEG4)	320×240	mpeg4	-b:v 350k	AAC 96k	Best for very small file size / old devices
2	360p (H.264)	480×360	libx264	-b:v 600k (or use -crf 28)	AAC 96k	Good for phones, low bandwidth
3	480p (H.264)	854×480	libx264	-b:v 1000k (or -crf 26)	AAC 128k	Standard web/mobile
4	720p HD (H.264)	1280×720	libx264	-b:v 2500k (or -crf 23)	AAC 128k	Good balance quality / size
5	1080p FHD (H.264)	1920×1080	libx264	-b:v 5000k (or -crf 20)	AAC 192k	High quality FHD output


> Tip: For libx264 you can remove -b:v and use -crf <value> + -preset <preset> for quality-based control (lower crf → better quality). The script uses bitrate targets for simplicity.




---

⚙️ Script behaviour & notes

The script preserves the original filename. If a file with the same name already exists in the output folder, it is skipped.

240p uses mpeg4 codec as requested; other qualities use libx264.

Audio is encoded to AAC with reasonable bitrates per resolution.

The script sets -preset ultrafast so conversion is faster (but larger). You can edit convert.sh and change -preset to superfast / medium etc. to improve compression at the cost of CPU time.



---

🔧 Quick customization pointers

Change output folder:

OUTPUT_DIR="/sdcard/Documents/Ffmpeg_Converted"

Switch H.264 mode to CRF-based (better quality control), replace -b:v $VBIT with:

-crf 23 -preset medium

If your source contains subtitle streams and you want to copy them, add -c:s copy to the ffmpeg command.



---

❗ Troubleshooting

Permission denied on /sdcard paths: make sure Termux has storage permission:

termux-setup-storage

Then re-open Termux and retry.

ffmpeg: command not found → install ffmpeg in Termux (see Requirements).

If output files are corrupt or fail to play, try changing codec/preset or use -c:v copy to skip re-encoding.

