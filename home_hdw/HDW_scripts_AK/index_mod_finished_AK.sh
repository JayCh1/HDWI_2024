#!/bin/bash

# A. Srock, 6/17
# A. Srock, 7/18 -- updated for Alaska, site rollout, and new function to get completion date/time...

echo "Updated at $(TZ=UTC date '+%H%M %Z / %d %b %Y')" > hdwstatus_AK.txt

# While we're here, let's archive the AKPerc images into a repository.
# Read in the date information from the system time...
yyyy=`date +%Y`
mm=`date +%m`
dd=`date +%d`

/usr/local/bin/aws s3 cp /home/ubuntu/HDW_GEFSplots_AK/AKPerc.png s3://$DATA_BUCKET/HDW_GEFSplots_AK/pastAKPerc/AKPerc${yyyy}${mm}${dd}.png
cp /home/ubuntu/HDW_GEFSplots_AK/AKPerc.png /home/ubuntu/HDW_GEFSplots_AK/pastAKPerc/AKPerc${yyyy}${mm}${dd}.png
/usr/bin/convert -resize 940 /home/ubuntu/HDW_GEFSplots_AK/AKPerc.png /home/ubuntu/HDW_GEFSplots_AK/AKPerc.png
/usr/bin/convert -resize 940 /home/ubuntu/HDW_GEFSplots_AK/AKPercMedian.png /home/ubuntu/HDW_GEFSplots_AK/AKPercMedian.png 
/usr/local/bin/aws s3 cp /home/ubuntu/HDW_GEFSplots_AK/AKPerc.png s3://$DATA_BUCKET/HDW_GEFSplots_AK/AKPerc.png
/usr/local/bin/aws s3 cp /home/ubuntu/HDW_GEFSplots_AK/AKPercMedian.png s3://$DATA_BUCKET/HDW_GEFSplots_AK/AKPercMedian.png

