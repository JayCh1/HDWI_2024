#!/bin/bash

# Shell script that sets up loops over dates, times to calculate HDW from GEFS analysis
# data (on the NAmer extracted grid from Lifeng via Alan).

# A. Srock, 3/15
# A. Srock, 5/17 -- updated for CFSR Climo for Jessie
# J. Charney, 5/20 -- updated for GEFS analysis for hdwindex.org
# J. Charney, 10/20 -- updated for global GEFS analysis for hdwindex.org

# DELETE THE OLD FILE, DAMMIT.  This works beter...
rm GEFS_HDW_ANL.nc

touch GEFS_12.grib2
touch GEFS_18.grib2
touch GEFS_00.grib2
touch FILE_12.inv
touch FILE_18.inv
touch FILE_00.inv

# Read in the date information from the system time...
yyyy2=`date +%Y`
mm2=`date +%m`
dd2=`date +%d`

# JayEdit: need to figure out yesterday's date here for not very bright ncl code

last_date=$(date +%m-%d-%Y -d "$yyyy2-$mm2-$dd2 - 1 day")
yyyy=`echo $last_date | awk ' { print substr($0,7,4) } ' `
mm=`echo $last_date | awk ' { print substr($0,1,2) } ' `
dd=`echo $last_date | awk ' { print substr($0,4,2) } ' `

# NOTE THAT THE 12, 18, AND 00 ARE TO SEPARATE THE ANALYSIS TIMES, NOT THE PERTURBATIONS AS BEFORE!!!

# 12z data...
#wget -O gefs_a_c12_000.grib2 https://nomads.ncep.noaa.gov/pub/data/nccf/com/gens/prod/gefs.${yyyy}${mm}${dd}/12/atmos/pgrb2ap5/gec00.t12z.pgrb2a.0p50.f000
#wget -O gefs_b_c12_000.grib2 https://nomads.ncep.noaa.gov/pub/data/nccf/com/gens/prod/gefs.${yyyy}${mm}${dd}/12/atmos/pgrb2bp5/gec00.t12z.pgrb2b.0p50.f000
/usr/local/bin/aws s3 --region us-east-1 --no-sign-request cp s3://noaa-gefs-pds/gefs.${yyyy}${mm}${dd}/12/atmos/pgrb2ap5/gec00.t12z.pgrb2a.0p50.f000 gefs_a_c12_000.grib2
/usr/local/bin/aws s3 --region us-east-1 --no-sign-request cp s3://noaa-gefs-pds/gefs.${yyyy}${mm}${dd}/12/atmos/pgrb2bp5/gec00.t12z.pgrb2b.0p50.f000 gefs_b_c12_000.grib2
cat gefs_a_c12_000.grib2 gefs_b_c12_000.grib2 > GEFS_12.grib2  

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

invar=${yyyy}${mm}${dd}
invar2=${yyyy2}${mm2}${dd2}

# JayEdit no longer creating our own small file...using a saved version for untrimmed processing
cp jay_small_saved.nc small_${invar}.nc

rm FILE_12.inv
rm FILE_18.inv
rm FILE_00.inv

/home/hdw/HDW_scripts/HDW_Calc_GEFSanl_jay_untrimmed.exe
ncl yyyy=${yyyy} mm=${mm} dd=${dd} /home/hdw/HDW_scripts/HDW_Calc_GEFS_jay.ncl

# JayEdit just save HDW,VPD,U now and then get rid of "small" netcdf file
ncks -v HDWANL,VPD,U small_${invar}.nc GEFS_HDW_ANL.nc
rm small_${invar}.nc gefs_a*.grib2 gefs_b*.grib2 FILE*.inv GEFS_12.grib2 GEFS_18.grib2 GEFS_00.grib2 hdwiout.bin

cp GEFS_HDW_ANL.nc /home/hdw/HDW_data/pastANL/GEFS_HDW_ANL_${yyyy}${mm}${dd}.nc
mv GEFS_HDW_ANL.nc /home/hdw/HDW_data/GEFS_HDW_ANL_day-1.nc

#added to produce ANL files for SOPFEU after all is done...here's hoping it does not mess anything up
#ncks -d latitude,44.,60. -d longitude,-80.,-60. /home/hdw/HDW_data/pastANL/GEFS_HDW_ANL_${yyyy}${mm}${dd}.nc -O /var/www/html/HDW/sopfeu/sopfeu_GEFSanl_${yyyy}${mm}${dd}.nc
