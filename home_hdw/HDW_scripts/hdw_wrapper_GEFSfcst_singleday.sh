#!/bin/bash

# Shell script that sets up loops over dates, times to calculate HDW from GEFS analysis
# data (on the NAmer extracted grid from Lifeng via Alan).

# A. Srock, 3/15
# A. Srock, 5/17 -- updated for CFSR Climo for Jessie
# J. Charney, 5/20 -- updated for GEFS analysis for hdwindex.org
# J. Charney, 10/20 -- updated for global GEFS analysis for hdwindex.org

# DELETE ALL OF THE OLD FILES, DAMMIT.  This works beter...
rm GEFS_HDW_p??_day?.nc GEFS_HDW_FCST.nc

#make namelist.inp with number of times, grib files for each time, arbitrary names of inv files for each time
echo "6" > namelist.inp
echo "GEFS_12.grib2" >> namelist.inp
echo "GEFS_15.grib2" >> namelist.inp
echo "GEFS_18.grib2" >> namelist.inp
echo "GEFS_21.grib2" >> namelist.inp
echo "GEFS_00.grib2" >> namelist.inp
echo "GEFS_03.grib2" >> namelist.inp
echo "FILE_12.inv" >> namelist.inp
echo "FILE_15.inv" >> namelist.inp
echo "FILE_18.inv" >> namelist.inp
echo "FILE_21.inv" >> namelist.inp
echo "FILE_00.inv" >> namelist.inp
echo "FILE_03.inv" >> namelist.inp

touch FILE_12.inv
touch FILE_15.inv
touch FILE_18.inv
touch FILE_21.inv
touch FILE_00.inv
touch FILE_03.inv

# Read in the date information from the system time...
yyyy=`date +%Y`
mm=`date +%m`
dd=`date +%d`

time1=(012 036 060 84 108 132 156)
time2=(027 051 075 099 123 147 171)
fgrb=(12 15 18 21 00 03)
outday=(1 2 3 4 5 6 7)
hh=00

# Start loops to get all necessary files.  Note that pulling the 00-z data is hard-coded into the download links...

for iday in 0 1 2 3 4 5 6; do
for pnum in `seq -w 00 20` ; do
  igrb=0
  for fhr in `seq -w ${time1[iday]} 3 ${time2[iday]}`; do
    if [ "$pnum" == "00" ] ; then
      #wget -nv -O gefs_a_c00_${fhr}.grib2 https://nomads.ncep.noaa.gov/pub/data/nccf/com/gens/prod/gefs.${yyyy}${mm}${dd}/${hh}/atmos/pgrb2ap5/gec00.t${hh}z.pgrb2a.0p50.f${fhr}
      /usr/local/bin/aws s3 --region us-east-1 --no-sign-request cp s3://noaa-gefs-pds/gefs.${yyyy}${mm}${dd}/${hh}/atmos/pgrb2ap5/gec00.t${hh}z.pgrb2a.0p50.f${fhr} gefs_a_c00_${fhr}.grib2
      #wget -nv -O gefs_b_c00_${fhr}.grib2 https://nomads.ncep.noaa.gov/pub/data/nccf/com/gens/prod/gefs.${yyyy}${mm}${dd}/${hh}/atmos/pgrb2bp5/gec00.t${hh}z.pgrb2b.0p50.f${fhr}
      /usr/local/bin/aws s3 --region us-east-1 --no-sign-request cp s3://noaa-gefs-pds/gefs.${yyyy}${mm}${dd}/${hh}/atmos/pgrb2bp5/gec00.t${hh}z.pgrb2b.0p50.f${fhr} gefs_b_c00_${fhr}.grib2
      cat gefs_a_c00_${fhr}.grib2 gefs_b_c00_${fhr}.grib2 > GEFS_${fgrb[igrb]}.grib2
    else
      #wget -nv -O gefs_a_p${pnum}_${fhr}.grib2 https://nomads.ncep.noaa.gov/pub/data/nccf/com/gens/prod/gefs.${yyyy}${mm}${dd}/${hh}/atmos/pgrb2ap5/gep${pnum}.t${hh}z.pgrb2a.0p50.f${fhr}
      /usr/local/bin/aws s3 --region us-east-1 --no-sign-request cp s3://noaa-gefs-pds/gefs.${yyyy}${mm}${dd}/${hh}/atmos/pgrb2ap5/gep${pnum}.t${hh}z.pgrb2a.0p50.f${fhr} gefs_a_p${pnum}_${fhr}.grib2
      #wget -nv -O gefs_b_p${pnum}_${fhr}.grib2 https://nomads.ncep.noaa.gov/pub/data/nccf/com/gens/prod/gefs.${yyyy}${mm}${dd}/${hh}/atmos/pgrb2bp5/gep${pnum}.t${hh}z.pgrb2b.0p50.f${fhr}
      /usr/local/bin/aws s3 --region us-east-1 --no-sign-request cp s3://noaa-gefs-pds/gefs.${yyyy}${mm}${dd}/${hh}/atmos/pgrb2bp5/gep${pnum}.t${hh}z.pgrb2b.0p50.f${fhr} gefs_b_p${pnum}_${fhr}.grib2
      cat gefs_a_p${pnum}_${fhr}.grib2 gefs_b_p${pnum}_${fhr}.grib2 > GEFS_${fgrb[igrb]}.grib2
    fi

    let igrb=$igrb+1

done  # Close fhr loop...

rm FILE_12.inv
rm FILE_15.inv
rm FILE_18.inv
rm FILE_21.inv
rm FILE_00.inv
rm FILE_03.inv

gfortran -fopenmp HDW_Calc_GEFS_singleday.f -o HDW_Calc_GEFS_singleday.exe -L/home/ubuntu/grib2/lib -lwgrib2 -lgfortran -lz -lm  -I/home/ubuntu/grib2/lib
./HDW_Calc_GEFS_singleday.exe < namelist.inp > data.cdl

# Change the last character of each output line from a comma to a semicolon. Do this by
# reversing each line, changing the first occurrence, then reversing again.
# Also, add a closing curly bracket to the data file:
rev data.cdl | sed 's/\,/\;/' | rev > data2.cdl
echo } >> data2.cdl

# make cdl file for each day, ensemble member
cat HDWI_header.cdl data2.cdl > out${iday}_${pnum}.cdl
ncgen -o out${iday}_${pnum}.nc out${iday}_${pnum}.cdl

# Clean up files
rm *.grib2 data.cdl data2.cdl 

done  # Close pnum loop...

# Now, we can use ncecat to combine the members together into a single file.
# We'll also use ncrename to change the default output record variable, record,
# to member.
ncecat out${iday}_*nc out${iday}.nc
ncrename -h -d record,member out${iday}.nc

done  # Close iday loop...
rm *.inv namelist.inp

# Do the same concatenate trick to get all the days in one file...
ncecat out?.nc GEFS_HDW_FCST.nc
ncrename -h -d record,day GEFS_HDW_FCST.nc

# Clean up the mess...
rm out*.cdl out*.nc HDW_Calc_GEFS_singleday.exe

cp GEFS_HDW_FCST.nc /home/ubuntu/HDW_data/pastFCST/GEFS_HDW_FCST_${yyyy}${mm}${dd}.nc
mv GEFS_HDW_FCST.nc /home/ubuntu/HDW_data/
