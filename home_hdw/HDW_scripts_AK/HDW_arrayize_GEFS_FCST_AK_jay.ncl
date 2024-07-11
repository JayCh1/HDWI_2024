; This script will take HDW output from HDW_Calc_GEFS_wRH and convert the individual files into one.

; A. Srock, 5/17
; A. Srock, 6/17 -- Updated to work in GEFS forecast mode...
; J. Charney, 5/20 -- updated for GEFS forecast for hdwindex.org

;load "/usr/share/ncarg/nclscripts/csm/gsn_code.ncl"
;load "/usr/share/ncarg/nclscripts/csm/gsn_csm.ncl"
;load "/usr/share/ncarg/nclscripts/csm/shea_util.ncl"
;load "/usr/share/ncarg/nclscripts/csm/contributed.ncl"
;load "/home/hdw/software/NCL/lib/ncarg/nclscripts/csm/contributed.ncl"

begin

; We need to create a blank array.  We need to grab lat and lon dimension information from
; an input file, though, so open one of those...

; First, open a random data file to get grid info...
infilex=addfile("/home/hdw/HDW_scripts_AK/GEFS_HDW_p00_day1_AK.nc","r")
hdwx = infilex->HDW  ; Read grid for testing
latx = infilex->latitude
lonx = infilex->longitude
dims=dimsizes(hdwx)
dimlat=dims(0)  ; To loop over latitudes...
dimlon=dims(1)  ; To loop over longitudes...

; Create a new file for the output...
outfilex=addfile("/home/hdw/HDW_scripts_AK/GEFS_HDW_FCST_AK.nc","c")

; We want 7 forecast days and 21 perturbations (20 pert + 1 control) in our array.  Create the array now...
;hdwfcst=new((/7,21,dimlat,dimlon/),float)
hdwfcst=new((/7,21,dimlat,dimlon/),float)
hdwfcst!2="latitude"
hdwfcst!3="longitude"
hdwfcst&latitude=latx
hdwfcst&longitude=lonx
vpdfcst=new((/7,21,dimlat,dimlon/),float)
vpdfcst!2="latitude"
vpdfcst!3="longitude"
vpdfcst&latitude=latx
vpdfcst&longitude=lonx
ufcst=new((/7,21,dimlat,dimlon/),float)
ufcst!2="latitude"
ufcst!3="longitude"
ufcst&latitude=latx
ufcst&longitude=lonx

; Now we can begin to populate the array.  Start loops over perturbations, forecast days...
do pnum=0,20,1
  do dayx=1,7,1
    pnumx=sprinti("%0.2i",pnum)
    filey=addfile("GEFS_HDW_p"+pnumx+"_day"+dayx+"_AK.nc","r")
    hdw = filey->HDW  ; Read grid for testing
    vpd = filey->VPD  ; Read grid for testing
    u = filey->U  ; Read grid for testing
    do lat=0,dimlat-1,1
      do lon=0,dimlon-1,1
        ; There are six entries below for 12z to 03z for each period (i.e., 12, 15, 18, 21, 00, 03)...
        hdwfcst(dayx-1,pnum,lat,lon)=(/hdw(lat,lon)/)
        vpdfcst(dayx-1,pnum,lat,lon)=(/vpd(lat,lon)/)
        ufcst(dayx-1,pnum,lat,lon)=(/u(lat,lon)/)
      end do  ; lat
    end do  ; lon
    delete(hdw)
    delete(vpd)
    delete(u)
  end do  ; dayx
end do  ; pnum

; Write the output file with the new HDW array...
outfilex->HDWFCST=hdwfcst
outfilex->VPDFCST=vpdfcst
outfilex->UFCST=ufcst

end
