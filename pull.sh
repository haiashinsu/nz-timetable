#!/bin/bash
#This script downloads GTFS data from Metlink website.
#Alternatively can be run in a schedule like cron, so that data files are always updated.
#
#Copyright © 2017 Hyacinth Cruz <http://hyacinth.me>
#
#This work is free. You can redistribute it and/or modify it under the
#terms of the Do What The Fuck You Want To Public License, Version 2,
#as published by Sam Hocevar. See http://www.wtfpl.net/ for more details.

DATA_FILE_LOCATION="https://www.metlink.org.nz/assets/Google_Transit/google-transit.zip"
TMPFILE=`mktemp`
PUSH_DATA=true

#Download data file
wget "$DATA_FILE_LOCATION" -O $TMPFILE

#Create folder for data files
mkdir -p gtfs_data

#Unzip files
unzip $TMPFILE -d gtfs_data

#Remove temp file
rm $TMPFILE

#Add data files and commit
if ( "${PUSH_DATA}" = true ); then
     COMMIT_MESSAGE="Updated gtfs data files"
     git add gtfs_data/*.*
     git commit -am "${COMMIT_MESSAGE}"
     git push origin master
fi
