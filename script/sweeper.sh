#!/bin/bash

# Add this to your crontab. Something like:
# 0,31 * * * * /home/pi/pi-cam/script/sweeper.sh

# Number of minutes to leave as buffer
buffer=31

# Change to base directory
cd $( dirname "${BASH_SOURCE[0]}" )/..

# If the live directory exists,
# get the timestamp of the most recent ts file
if [[ -d live/ ]]; then
  # list all ts files ordered by date
  # get the most recent ts file
  # get the timestamp of that file
  timestamp=$( ls -t live/ \
    | head -1 \
    | xargs -I {file} stat -c %Y live/{file}
  )
fi

# If the timestamp has been set,
# convert it to a number of minutes to find files from
if [[ -n $timestamp ]]; then
  # get the number of seconds the timestamp is from now
  # convert that into minutes
  # add on the buffer time
  minutes=$( expr $( date +%s ) - "$timestamp" \
    | xargs -I {secs} expr {secs} / 60 \
    | xargs -I {mins} expr {mins} + "$buffer"
  )
fi

# If the minutes integer has been set
# find all sweepable files, and sweep em away!
if [[ -n $minutes ]]; then
  find live/ -type f -name '*.ts' -mmin "+$minutes" -print0 | xargs -r -0 rm
fi
