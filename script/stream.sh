#!/bin/bash

stamp=$( date +%Y%m%d-%H%M%S )
session="live-$stamp"
fifo="live.fifo.h264"

set -x

# Change to base directory
cd $( dirname "${BASH_SOURCE[0]}" )/..

# Setup session
mkdir "$session"
rm -f "$fifo" live www/live
ln -s "$PWD/$session" live
ln -s "$PWD/$session" www/live


# Pump raspivid into fifo
# fifos seem to work more reliably than pipes
mkfifo "$fifo"
raspivid \
  -w 1024 -h 576 -fps 25 -b 500000 \
  -t 86400000 -hf -vf -o - | psips > "$fifo" &


# Crank up ffmpeg
# Spit segments into session path
ffmpeg -y \
  -f h264 \
  -i "$fifo" \
  -c:v copy \
  -map 0:0 \
  -f segment \
  -segment_time 2 \
  -segment_format mpegts \
  -segment_list www/live/live.m3u8 \
  -segment_list_size 900 \
  -segment_list_flags live \
  -segment_list_type m3u8 \
  "live/%08d.ts" < /dev/null
