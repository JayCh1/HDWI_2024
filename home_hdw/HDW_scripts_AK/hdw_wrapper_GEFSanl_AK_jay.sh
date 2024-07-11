#!/bin/bash

# Shell script that sets up loops over dates, times to calculate HDW from GEFS analysis
# data (on the NAmer extracted grid from Lifeng via Alan).

# A. Srock, 3/15
# A. Srock, 5/17 -- updated for CFSR Climo for Jessie
# J. Charney, 5/20 -- updated for GEFS analysis for hdwindex.org
# J. Charney, 11/20 -- updated for global GEFS analysis for hdwindex.org

# DELETE THE OLD FILE, DAMMIT.  This works better...
rm GEFS_HDW_AK_ANL.nc

touch GEFS_18.grib2
touch GEFS_00.grib2
touch GEFS_06.grib2
touch FILE_18.inv
touch FILE_00.inv
touch FILE_06.inv

# Read in the date information from the system time...
yyyy2=`date +%Y`
mm2=`date +%m`
dd2=`date +%d`

# JayEdit: need to figure out yesterday's date here for not very bright ncl code

next_date=$(date +%m-%d-%Y -d "$yyyy-$mm-$dd - 1 day")
yyyy=`echo $next_date | awk ' { print substr($0,7,4) } ' `
mm=`echo $next_date | awk ' { print substr($0,1,2) } ' `
dd=`echo $next_date | awk ' { print substr($0,4,2) } ' `

# NOTE THAT THE 18, 00, AND 06 ARE TO SEPARATE THE ANALYSIS TIMES, NOT THE PERTURBATIONS AS BEFORE!!!

# 18z data...

#wget -O gefs_a_c18_000.grib2 https://nomads.ncep.noaa.gov/pub/data/nccf/com/gens/prod/gefs.${yyyy}${mm}${dd}/18/atmos/pgrb2ap5/gec00.t18z.pgrb2a.0p50.f000
#wget -O gefs_b_c18_000.grib2 https://nomads.ncep.noaa.gov/pub/data/nccf/com/gens/prod/gefs.${yyyy}${mm}${dd}/18/atmos/pgrb2bp5/gec00.t18z.pgrb2b.0p50.f000
/usr/local/bin/aws s3 --region us-east-1 --no-sign-request cp s3://noaa-gefs-pds/gefs.${yyyy}${mm}${dd}/18/atmos/pgrb2ap5/gec00.t18z.pgrb2a.0p50.f000 gefs_a_c18_000.grib2
/usr/local/bin/aws s3 --region us-east-1 --no-sign-request cp s3://noaa-gefs-pds/gefs.${yyyy}${mm}${dd}/18/atmos/pgrb2bp5/gec00.t18z.pgrb2b.0p50.f000 gefs_b_c18_000.grib2
cat gefs_a_c18_000.grib2 gefs_b_c18_000.grib2 > GEFS_18.grib2  

# 00z data...
#wget -O gefs_a_c00_000.grib2 https://nomads.ncep.noaa.gov/pub/data/nccf/com/gens/prod/gefs.${yyyy2}${mm2}${dd2}/00/atmos/pgrb2ap5/gec00.t00z.pgrb2a.0p50.f000
#wget -O gefs_b_c00_000.grib2 https://nomads.ncep.noaa.gov/pub/data/nccf/com/gens/prod/gefs.${yyyy2}${mm2}${dd2}/00/atmos/pgrb2bp5/gec00.t00z.pgrb2b.0p50.f000
/usr/local/bin/aws s3 --region us-east-1 --no-sign-request cp s3://noaa-gefs-pds/gefs.${yyyy2}${mm2}${dd2}/00/atmos/pgrb2ap5/gec00.t00z.pgrb2a.0p50.f000 gefs_a_c00_000.grib2
/usr/local/bin/aws s3 --region us-east-1 --no-sign-request cp s3://noaa-gefs-pds/gefs.${yyyy2}${mm2}${dd2}/00/atmos/pgrb2bp5/gec00.t00z.pgrb2b.0p50.f000 gefs_b_c00_000.grib2
cat gefs_a_c00_000.grib2 gefs_b_c00_000.grib2 > GEFS_00.grib2  

# 06z data...
#wget -O gefs_a_c06_000.grib2 https://nomads.ncep.noaa.gov/pub/data/nccf/com/gens/prod/gefs.${yyyy2}${mm2}${dd2}/06/atmos/pgrb2ap5/gec00.t06z.pgrb2a.0p50.f000
#wget -O gefs_b_c06_000.grib2 https://nomads.ncep.noaa.gov/pub/data/nccf/com/gens/prod/gefs.${yyyy2}${mm2}${dd2}/06/atmos/pgrb2bp5/gec00.t06z.pgrb2b.0p50.f000
/usr/local/bin/aws s3 --region us-east-1 --no-sign-request cp s3://noaa-gefs-pds/gefs.${yyyy2}${mm2}${dd2}/06/atmos/pgrb2ap5/gec00.t06z.pgrb2a.0p50.f000 gefs_a_c06_000.grib2
/usr/local/bin/aws s3 --region us-east-1 --no-sign-request cp s3://noaa-gefs-pds/gefs.${yyyy2}${mm2}${dd2}/06/atmos/pgrb2bp5/gec00.t06z.pgrb2b.0p50.f000 gefs_b_c06_000.grib2
cat gefs_a_c06_000.grib2 gefs_b_c06_000.grib2 > GEFS_06.grib2  

invar=${yyyy}${mm}${dd}
invar2=${yyyy2}${mm2}${dd2}

# JayEdit no longer creating our own small file...using a saved version for untrimmed processing
cp jay_small_saved_AK.nc small_${invar}.nc

rm FILE_18.inv
rm FILE_00.inv
rm FILE_06.inv

/home/hdw/HDW_scripts_AK/HDW_Calc_GEFSanl_AK_jay_untrimmed.exe
ncl yyyy=${yyyy} mm=${mm} dd=${dd} /home/hdw/HDW_scripts_AK/HDW_Calc_GEFS_jay.ncl

# JayEdit just save HDW,VPD,U now and then get rid of "small" netcdf file
ncks -v HDWANL,VPD,U small_${invar}.nc GEFS_HDW_AK_ANL.nc
rm small_${invar}.nc gefs_a*.grib2 gefs_b*.grib2 FILE*.inv GEFS_18.grib2 GEFS_00.grib2 GEFS_06.grib2 hdwiout.bin

cp GEFS_HDW_AK_ANL.nc /home/hdw/HDW_data_AK/pastANL/GEFS_HDW_ANL_${yyyy}${mm}${dd}_AK.nc
mv GEFS_HDW_AK_ANL.nc /home/hdw/HDW_data_AK/GEFS_HDW_ANL_AK_day-1.nc

