#!/bin/bash

# Number of minutes to leave as buffer
buffer=32

# Change to base directory
cd $( dirname ${BASH_SOURCE[0]} )/..

# Get a timestamp by:
  # list all ts files ordered by date
  # get the most recent ts file
  # get the timestamp of that file
timestamp=$( ls -t live/ \
  | head -1 \
  | xargs -I {file} stat -c %Y live/{file}
)

# Get a number of minutes by:
  # get the number of seconds the timestamp is from now
  # convert that into minutes
  # add on the buffer time
minutes=$( expr $( date +%s ) - $timestamp \
  | xargs -I {secs} expr {secs} / 60 \
  | xargs -I {mins} expr {mins} + $buffer
)

# Sweep the out of date ts files by:
  # Find all sweepable files
  # and purge em!
find live/ -type f -name '*.ts' -mmin +$minutes -print0 | xargs -r -0 rm
