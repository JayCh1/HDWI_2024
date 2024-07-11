#!/bin/bash

# A. Srock, 6/17
# A. Srock, 7/18 -- updated for site rollout and new function to get completion date/time...

echo "Updated at $(TZ=UTC date '+%H%M %Z / %d %b %Y')" > hdwstatus.txt

# While we're here, let's archive the ConusPerc images into a repository.
# Read in the date information from the system time...
yyyy=`date +%Y`
mm=`date +%m`
dd=`date +%d`

/usr/local/bin/aws s3 cp /home/hdw/HDW_GEFSplots/ConusPerc.png s3://hdwi-nonprod-datastorage/HDW_GEFSplots/pastConusPerc/ConusPerc${yyyy}${mm}${dd}.png
/usr/bin/convert -resize 940 /home/hdw/HDW_GEFSplots/ConusPerc.png /home/hdw/HDW_GEFSplots/ConusPerc.png
/usr/bin/convert -resize 940 /home/hdw/HDW_GEFSplots/ConusPercMedian.png /home/hdw/HDW_GEFSplots/ConusPercMedian.png

