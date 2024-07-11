#!/bin/bash

# A. Srock, 6/17
# J Charney, 9/22

# Create/update a log file with timing...
cd /home/hdw/HDW_scripts/
echo "This HDW run started at:" >> zzz_HDW_run.txt
date >> zzz_HDW_run.txt

# Change to data working directory...
cd /home/hdw/HDW_data/

# Copy 30-day archive files from S3 Bucket, moving them back one day
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-1.nc /home/hdw/HDW_data/GEFS_HDW_ANL_day-2.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-2.nc /home/hdw/HDW_data/GEFS_HDW_ANL_day-3.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-3.nc /home/hdw/HDW_data/GEFS_HDW_ANL_day-4.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-4.nc /home/hdw/HDW_data/GEFS_HDW_ANL_day-5.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-5.nc /home/hdw/HDW_data/GEFS_HDW_ANL_day-6.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-6.nc /home/hdw/HDW_data/GEFS_HDW_ANL_day-7.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-7.nc /home/hdw/HDW_data/GEFS_HDW_ANL_day-8.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-8.nc /home/hdw/HDW_data/GEFS_HDW_ANL_day-9.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-9.nc /home/hdw/HDW_data/GEFS_HDW_ANL_day-10.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-10.nc /home/hdw/HDW_data/GEFS_HDW_ANL_day-11.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-11.nc /home/hdw/HDW_data/GEFS_HDW_ANL_day-12.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-12.nc /home/hdw/HDW_data/GEFS_HDW_ANL_day-13.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-13.nc /home/hdw/HDW_data/GEFS_HDW_ANL_day-14.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-14.nc /home/hdw/HDW_data/GEFS_HDW_ANL_day-15.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-15.nc /home/hdw/HDW_data/GEFS_HDW_ANL_day-16.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-16.nc /home/hdw/HDW_data/GEFS_HDW_ANL_day-17.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-17.nc /home/hdw/HDW_data/GEFS_HDW_ANL_day-18.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-18.nc /home/hdw/HDW_data/GEFS_HDW_ANL_day-19.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-19.nc /home/hdw/HDW_data/GEFS_HDW_ANL_day-20.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-20.nc /home/hdw/HDW_data/GEFS_HDW_ANL_day-21.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-21.nc /home/hdw/HDW_data/GEFS_HDW_ANL_day-22.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-22.nc /home/hdw/HDW_data/GEFS_HDW_ANL_day-23.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-23.nc /home/hdw/HDW_data/GEFS_HDW_ANL_day-24.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-24.nc /home/hdw/HDW_data/GEFS_HDW_ANL_day-25.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-25.nc /home/hdw/HDW_data/GEFS_HDW_ANL_day-26.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-26.nc /home/hdw/HDW_data/GEFS_HDW_ANL_day-27.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-27.nc /home/hdw/HDW_data/GEFS_HDW_ANL_day-28.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-28.nc /home/hdw/HDW_data/GEFS_HDW_ANL_day-29.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-29.nc /home/hdw/HDW_data/GEFS_HDW_ANL_day-30.nc --region us-gov-west-1 --cli-connect-timeout 180

# Change to scripts directory...
cd /home/hdw/HDW_scripts/

# Part 2: GEFS ANL...
#./getGEFS_ANL.sh
./hdw_wrapper_GEFSanl_jay.sh

# Part 3: GEFS FCST...
#./getGEFS_FCST.sh
./hdw_wrapper_GEFSfcst_jay.sh

# Interlude 1: Update the index web page to notify that plots are updating...
./index_mod_updating_red.sh

# Copy today's outputs from GEFS processing to s3 bucket
/usr/local/bin/aws s3 cp /home/hdw/HDW_data/pastANL/ s3://hdwi-nonprod-datastorage/HDW_data/pastANL/ --recursive --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data/pastFCST/ s3://hdwi-nonprod-datastorage/HDW_data/pastFCST/ --recursive --region us-gov-west-1 --cli-connect-timeout 180

# Copy climo file from S3 bucket to HDW_climo
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_climo/CFSR_MaxDHDW_CLIMO.nc /home/hdw/HDW_climo/ --region us-gov-west-1 --cli-connect-timeout 180

# Part 4: Python Plot GEFS FCST...
/usr/bin/python3.9 -c 'from ForecastPlots import plot_CONUS;plot_CONUS(0,50)' &
/usr/bin/python3.9 -c 'from ForecastPlots import plot_CONUS;plot_CONUS(50,81)'

# Part 5: Python Plot NA plan map and percentiles...
/usr/bin/python3.9 -c 'from FrontPagePlots import plot_CONUS;plot_CONUS()'
/usr/bin/python3.9 -c 'from ProbabilityPlots import plot_CONUS;plot_CONUS()'

# Part 6: Make percentile grid for Sim/AirFire/smoke use.  Delete old file first...
rm /home/hdw/HDW_data/MaxHDWPercGrid.nc
/usr/bin/python3.9 MakePercGrid.py

# Interlude 2: Update the index web page to notify that plots are complete with a date stamp...
# This step also backs up the image to keep a log of FrontPage plots...
./index_mod_finished.sh

# Part 7: Python Plot GEFS Analysis Archive...
/usr/bin/python3.9 -c 'from ArchivePlots import plot_CONUS;plot_CONUS(0,50)' &
/usr/bin/python3.9 -c 'from ArchivePlots import plot_CONUS;plot_CONUS(50,81)'

# Save archive files to S3 bucket so everything updates properly with or without container restart
/usr/local/bin/aws s3 cp /home/hdw/HDW_data/GEFS_HDW_ANL_day-1.nc s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-1.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data/GEFS_HDW_ANL_day-2.nc s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-2.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data/GEFS_HDW_ANL_day-3.nc s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-3.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data/GEFS_HDW_ANL_day-4.nc s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-4.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data/GEFS_HDW_ANL_day-5.nc s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-5.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data/GEFS_HDW_ANL_day-6.nc s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-6.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data/GEFS_HDW_ANL_day-7.nc s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-7.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data/GEFS_HDW_ANL_day-8.nc s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-8.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data/GEFS_HDW_ANL_day-9.nc s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-9.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data/GEFS_HDW_ANL_day-10.nc s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-10.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data/GEFS_HDW_ANL_day-11.nc s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-11.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data/GEFS_HDW_ANL_day-12.nc s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-12.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data/GEFS_HDW_ANL_day-13.nc s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-13.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data/GEFS_HDW_ANL_day-14.nc s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-14.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data/GEFS_HDW_ANL_day-15.nc s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-15.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data/GEFS_HDW_ANL_day-16.nc s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-16.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data/GEFS_HDW_ANL_day-17.nc s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-17.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data/GEFS_HDW_ANL_day-18.nc s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-18.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data/GEFS_HDW_ANL_day-19.nc s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-19.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data/GEFS_HDW_ANL_day-20.nc s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-20.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data/GEFS_HDW_ANL_day-21.nc s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-21.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data/GEFS_HDW_ANL_day-22.nc s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-22.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data/GEFS_HDW_ANL_day-23.nc s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-23.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data/GEFS_HDW_ANL_day-24.nc s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-24.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data/GEFS_HDW_ANL_day-25.nc s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-25.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data/GEFS_HDW_ANL_day-26.nc s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-26.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data/GEFS_HDW_ANL_day-27.nc s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-27.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data/GEFS_HDW_ANL_day-28.nc s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-28.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data/GEFS_HDW_ANL_day-29.nc s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-29.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data/GEFS_HDW_ANL_day-30.nc s3://hdwi-nonprod-datastorage/HDW_data/GEFS_HDW_ANL_day-30.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_ARCHplots/ s3://hdwi-nonprod-datastorage/HDW_ARCHplots/ --recursive --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_GEFSplots/ s3://hdwi-nonprod-datastorage/HDW_GEFSplots/ --recursive --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_GEFSprobs/ s3://hdwi-nonprod-datastorage/HDW_GEFSprobs/ --recursive --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_scripts/hdwstatus.txt s3://hdwi-nonprod-datastorage/HDW_scripts/hdwstatus.txt --region us-gov-west-1 --cli-connect-timeout 180

# Update the log file with completion information...
echo "The HDW run finished at:" >> zzz_HDW_run.txt
date >> zzz_HDW_run.txt

