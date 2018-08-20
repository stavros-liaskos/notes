## Convert/compress all videos in mp4 and webm format

```bash
#!/bin/bash

mkdir output

for i in *.mov;  
  do name=`echo $i | cut -d'.' -f1`;
  echo $name;

  ffmpeg -i "$i" -vcodec libvpx -qmin 0 -qmax 50 -crf 20 -b:v 1M -acodec libvorbis "./output/$name.webm";
done

for i in *.mov;  
  do name=`echo $i | cut -d'.' -f1`;
  echo $name;

  ffmpeg -i "$i" -vcodec h264 -acodec aac -strict -2 -crf 28 "./output/$name.mp4";
done

# mv output/* ./  
# rm -rf *.m4v .mov output
```

VP9
```bash
ffmpeg -i video.mov -vf scale=-1:720 -c:v libvpx-vp9 -pass 2 -pix_fmt yuv420p -b:v 0 -crf 15 -threads 2 -speed 2 -tile-columns 6 -frame-parallel 1 -auto-alt-ref 1 -lag-in-frames 25 -c:a libopus -b:a 320k -f webm video_vp9_scale=1:720.webm
video_vp9_scale=1:720.webm

ffmpeg -i video.mov -vf scale=720:-1 -c:v libvpx-vp9 -pass 2 -pix_fmt yuv420p -b:v 0 -crf 15 -threads 2 -speed 2 -tile-columns 6 -frame-parallel 1 -auto-alt-ref 1 -lag-in-frames 25 -c:a libopus -b:a 320k -f webm video_vp9_scale=720:-1.webm
video_vp9_scale=720:-1.webm
```

VP8 WEBM
```bash
ffmpeg -i video.mov -vcodec libvpx -qmin 0 -qmax 50 -crf 20 -b:v 1M -acodec libvorbis video-crf20-b:v1M.webm

```

MP4
```bash
ffmpeg -i video.mov -vcodec h264 -acodec aac -strict -2 -crf 28 video-crf28.mp4

```

COMPAT MODE MP4
```bash
ffmpeg -an -i video.mov -vcodec libx264 -pix_fmt yuv420p -crf 28 -profile:v baseline -level 3 video-28compat.mp4
```