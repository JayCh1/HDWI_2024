#!/bin/bash

# Shell script that sets up loops over dates, times to calculate HDW from GEFS forecast
# data (on the NAmer extracted grid from Lifeng via Alan).

# A. Srock, 3/15
# A. Srock, 5/17 -- updated for CFSR Climo for Jessie
# J. Charney, 5/20 -- updated for GEFS forecast for hdwindex.org
# J. Charney, 11/20 -- updated for global GEFS forecast for hdwindex.org

# Since this will run in a crontab, need to source the proper .bashrc...
source /home/hdw/.bashrc
export NCARG_ROOT="/home/hdw/software/NCL"
export PATH="/home/hdw/software/anaconda3/bin/:/home/hdw/software/grib2/wgrib2:/home/hdw/software/NCL/bin:$PATH"

# DELETE ALL OF THE OLD FILES, DAMMIT.  This works better...
rm GEFS_HDW_p??_day?_AK.nc GEFS_HDW_FCST_AK.nc
rm /home/hdw/HDW_data_AK/GEFS_HDW_FCST_AK.nc 

# Read in the date information from the system time...
yyyy=`date +%Y`
mm=`date +%m`
dd=`date +%d`

invar=${yyyy}${mm}${dd}

# JayEdit: lazy way to make files exist so we don't get error messages
touch FILE_18.inv
touch FILE_21.inv
touch FILE_00.inv
touch FILE_03.inv
touch FILE_06.inv
touch FILE_09.inv

time1=(018 042 066 090 114 138 162)
time2=(033 057 081 105 129 153 177)
fgrb=(18 21 00 03 06 09)
outday=(1 2 3 4 5 6 7)
hh=00

# Start loops to get all necessary files.  Note that pulling the 00-z data is hard-coded into the download links...

for pnum in `seq -w 00 20` ; do
for iday in 0 1 2 3 4 5 6; do
  igrb=0
  for fhr in `seq -w ${time1[iday]} 3 ${time2[iday]}`; do
    if [ "$pnum" == "00" ] ; then
      #wget -O gefs_a_c00_${fhr}.grib2 https://nomads.ncep.noaa.gov/pub/data/nccf/com/gens/prod/gefs.${yyyy}${mm}${dd}/${hh}/atmos/pgrb2ap5/gec00.t${hh}z.pgrb2a.0p50.f${fhr}
      #wget -O gefs_b_c00_${fhr}.grib2 https://nomads.ncep.noaa.gov/pub/data/nccf/com/gens/prod/gefs.${yyyy}${mm}${dd}/${hh}/atmos/pgrb2bp5/gec00.t${hh}z.pgrb2b.0p50.f${fhr}
      /usr/local/bin/aws s3 --region us-east-1 --no-sign-request cp s3://noaa-gefs-pds/gefs.${yyyy}${mm}${dd}/${hh}/atmos/pgrb2ap5/gec00.t${hh}z.pgrb2a.0p50.f${fhr} gefs_a_c00_${fhr}.grib2 
      /usr/local/bin/aws s3 --region us-east-1 --no-sign-request cp s3://noaa-gefs-pds/gefs.${yyyy}${mm}${dd}/${hh}/atmos/pgrb2bp5/gec00.t${hh}z.pgrb2b.0p50.f${fhr} gefs_b_c00_${fhr}.grib2 
      cat gefs_a_c00_${fhr}.grib2 gefs_b_c00_${fhr}.grib2 > GEFS_${fgrb[igrb]}.grib2 
    else
      #wget -O gefs_a_p${pnum}_${fhr}.grib2 https://nomads.ncep.noaa.gov/pub/data/nccf/com/gens/prod/gefs.${yyyy}${mm}${dd}/${hh}/atmos/pgrb2ap5/gep${pnum}.t${hh}z.pgrb2a.0p50.f${fhr}
      #wget -O gefs_b_p${pnum}_${fhr}.grib2 https://nomads.ncep.noaa.gov/pub/data/nccf/com/gens/prod/gefs.${yyyy}${mm}${dd}/${hh}/atmos/pgrb2bp5/gep${pnum}.t${hh}z.pgrb2b.0p50.f${fhr}
      /usr/local/bin/aws s3 --region us-east-1 --no-sign-request cp s3://noaa-gefs-pds/gefs.${yyyy}${mm}${dd}/${hh}/atmos/pgrb2ap5/gep${pnum}.t${hh}z.pgrb2a.0p50.f${fhr} gefs_a_p${pnum}_${fhr}.grib2 
      /usr/local/bin/aws s3 --region us-east-1 --no-sign-request cp s3://noaa-gefs-pds/gefs.${yyyy}${mm}${dd}/${hh}/atmos/pgrb2bp5/gep${pnum}.t${hh}z.pgrb2b.0p50.f${fhr} gefs_b_p${pnum}_${fhr}.grib2 
      cat gefs_a_p${pnum}_${fhr}.grib2 gefs_b_p${pnum}_${fhr}.grib2 > GEFS_${fgrb[igrb]}.grib2
    fi

    let igrb=$igrb+1

done  # Close fhr loop...

# JayEdit no longer creating our own small file...using a saved version for untrimmed processing
cp jay_small_saved_AK.nc small_${invar}.nc

  rm FILE_18.inv
  rm FILE_21.inv
  rm FILE_00.inv
  rm FILE_03.inv
  rm FILE_06.inv
  rm FILE_09.inv

  /home/hdw/HDW_scripts_AK/HDW_Calc_GEFSfcst_AK_jay_untrimmed.exe
  ncl yyyy=${yyyy} mm=${mm} dd=${dd} /home/hdw/HDW_scripts_AK/HDW_Calc_GEFS_jay.ncl

# JayEdit just save HDW,VPD,U now and then get rid of "small" netcdf file
  ncks -v HDW,VPD,U small_${invar}.nc GEFS_HDW_p${pnum}_day${outday[iday]}_AK.nc
  rm small_${invar}.nc *.grib2 hdwiout.bin 

done  # Close iday loop...
done  # Close pnum loop...
rm *.inv

# Finally, make the array of the forecast data...
ncl /home/hdw/HDW_scripts_AK/HDW_arrayize_GEFS_FCST_AK_jay.ncl

cp GEFS_HDW_FCST_AK.nc /home/hdw/HDW_data_AK/pastFCST/GEFS_HDW_FCST_${yyyy}${mm}${dd}_AK.nc
cp GEFS_HDW_FCST_AK.nc /home/hdw/HDW_data_AK/

