#!/bin/bash

# Wrapper script for the GEFS HDW data processing for both analysis and forecast...

# A. Srock, 6/17
# A. Srock, 7/18 -- Updated for Alaska domain
# J. Charney, 9/22

# Create/update a log file with timing...
cd /home/hdw/HDW_scripts_AK/
echo "This HDW run started at:" >> zzz_HDW_run_AK.txt
date >> zzz_HDW_run_AK.txt

# Change to data working directory...
cd /home/hdw/HDW_data_AK/

# Copy 30-day archive files from S3 Bucket, moving them back one day
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-1.nc /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-2.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-2.nc /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-3.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-3.nc /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-4.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-4.nc /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-5.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-5.nc /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-6.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-6.nc /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-7.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-7.nc /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-8.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-8.nc /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-9.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-9.nc /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-10.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-10.nc /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-11.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-11.nc /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-12.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-12.nc /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-13.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-13.nc /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-14.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-14.nc /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-15.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-15.nc /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-16.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-16.nc /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-17.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-17.nc /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-18.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-18.nc /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-19.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-19.nc /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-20.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-20.nc /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-21.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-21.nc /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-22.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-22.nc /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-23.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-23.nc /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-24.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-24.nc /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-25.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-25.nc /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-26.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-26.nc /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-27.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-27.nc /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-28.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-28.nc /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-29.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-29.nc /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-30.nc --region us-gov-west-1 --cli-connect-timeout 180

# Change to scripts directory...
cd /home/hdw/HDW_scripts_AK/

# Part 3: GEFS FCST...
#./getGEFS_FCST_AK.sh
./hdw_wrapper_GEFSanl_AK_jay.sh

# Part 2: GEFS ANL...  !! FLIPPED ORDER BECAUSE MODEL ISN'T DONE AT 6Z!!!
#./getGEFS_ANL_AK.sh
./hdw_wrapper_GEFSfcst_AK_jay.sh

# Interlude 1: Update the index web page to notify that plots are updating...
./index_mod_updating_red_AK.sh

# Copy today's outputs from GEFS processing to s3 bucket
/usr/local/bin/aws s3 cp /home/hdw/HDW_data_AK/pastANL/ s3://hdwi-nonprod-datastorage/HDW_data_AK/pastANL/ --recursive --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data_AK/pastFCST/ s3://hdwi-nonprod-datastorage/HDW_data_AK/pastFCST/ --recursive --region us-gov-west-1 --cli-connect-timeout 180

# Copy climo file from S3 bucket to HDW_climo_AK
/usr/local/bin/aws s3 cp s3://hdwi-nonprod-datastorage/HDW_climo_AK/CFSR_MaxDHDW_CLIMO_AK.nc /home/hdw/HDW_climo_AK/ --region us-gov-west-1 --cli-connect-timeout 180

# Part 4: Python Plot GEFS FCST...
/usr/bin/python3.9 -c 'from ForecastPlots import plot_AK;plot_AK(0,20)' &
/usr/bin/python3.9 -c 'from ForecastPlots import plot_AK;plot_AK(20,41)'

# Part 5: Python Plot NA plan map...
/usr/bin/python3.9 -c 'from FrontPagePlots import plot_AK;plot_AK()'
/usr/bin/python3.9 -c 'from ProbabilityPlots import plot_AK;plot_AK()'

# Interlude 2: Update the index web page to notify that plots are complete with a date stamp...
./index_mod_finished_AK.sh

# Part 7: Python Plot GEFS Analysis Archive...
/usr/bin/python3.9 -c 'from ArchivePlots import plot_AK;plot_AK(0,20)' &
/usr/bin/python3.9 -c 'from ArchivePlots import plot_AK;plot_AK(20,41)'

# Save archive files to S3 bucket so everything updates properly with or without container restart
/usr/local/bin/aws s3 cp /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-1.nc s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-1.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-2.nc s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-2.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-3.nc s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-3.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-4.nc s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-4.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-5.nc s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-5.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-6.nc s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-6.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-7.nc s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-7.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-8.nc s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-8.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-9.nc s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-9.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-10.nc s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-10.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-11.nc s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-11.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-12.nc s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-12.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-13.nc s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-13.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-14.nc s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-14.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-15.nc s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-15.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-16.nc s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-16.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-17.nc s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-17.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-18.nc s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-18.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-19.nc s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-19.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-20.nc s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-20.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-21.nc s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-21.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-22.nc s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-22.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-23.nc s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-23.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-24.nc s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-24.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-25.nc s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-25.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-26.nc s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-26.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-27.nc s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-27.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-28.nc s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-28.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-29.nc s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-29.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-30.nc s3://hdwi-nonprod-datastorage/HDW_data_AK/GEFS_HDW_ANL_AK_day-30.nc --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_ARCHplots_AK/ s3://hdwi-nonprod-datastorage/HDW_ARCHplots_AK/ --recursive --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_GEFSplots_AK/ s3://hdwi-nonprod-datastorage/HDW_GEFSplots_AK/ --recursive --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_GEFSprobs_AK/ s3://hdwi-nonprod-datastorage/HDW_GEFSprobs_AK/ --recursive --region us-gov-west-1 --cli-connect-timeout 180
/usr/local/bin/aws s3 cp /home/hdw/HDW_scripts_AK/hdwstatus_AK.txt s3://hdwi-nonprod-datastorage/HDW_scripts_AK/hdwstatus_AK.txt --region us-gov-west-1 --cli-connect-timeout 180

# Update the log file with completion information...
echo "The HDW run finished at:" >> zzz_HDW_run_AK.txt
date >> zzz_HDW_run_AK.txt
