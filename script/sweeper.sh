#!/bin/bash

# Number of minutes to leave as buffer
buffer=32

set -x

# Change to base directory
cd $( dirname ${BASH_SOURCE[0]} )/..

# list all ts files ordered by date
  # get the most recent ts file
  # get the timestamp of that file
  # get the num of seconds from now file was created
  # convert that into minutes
  # add on the buffer time
  # find all purgable files
  # and purge em!
ls -t live/ \
  | head -1 \
  | xargs -I {file} stat -c %Y live/{file} \
  | xargs -I {ts} expr $( date +%s ) - {ts} \
  | xargs -I {secs} expr {secs} / 60 \
  | xargs -I {mins} expr {mins} + $buffer \
  | xargs -I {mins} find live/ -type f -name '*.ts' -mmin +{mins} -print0 \
  | xargs -r -o rm