;*****************************************************

;load "/usr/share/ncarg/nclscripts/csm/gsn_code.ncl"
;load "/usr/share/ncarg/nclscripts/csm/gsn_csm.ncl"
;load "/usr/share/ncarg/nclscripts/csm/shea_util.ncl"

;load "/home/hdw/software/NCL/lib/ncarg/nclex/gsun/gsn_code.ncl"
;load "/home/hdw/software/NCL/lib/ncarg/nclex/gsun/gsn_csm.ncl"
;load "/home/hdw/software/NCL/lib/ncarg/nclscripts/csm/shea_util.ncl"

;***************************************

begin

;;;;
;;; read data from grib files
;;;;
;;;note on input files - this version of the script assumes that we are using the three CFSR input times that 
;     most closely correspond to the burning period for a given location for each day.  For CONUS, this will 
;     be 12, 18, and 00 the next day. Adjust for other locations/applications. If we eventually want to include
;     all four CFSR times, the do loop below and the iinc variable will need to be adjusted as well.

; keep leading zeros in month and day
imm = sprinti("%0.2i",mm)
idd = sprinti("%0.2i",dd)

; read in netcdf file to add HDW, VPD, WSPD to in the end
infilex=addfile("small_"+yyyy+imm+idd+".nc","w")

; read in variable from small file to bring along metadata
pressout = infilex->PRES_surface(0,:,:)

; find the daily max value of hdw 
  hdwmax0=pressout
  vpdmax0=pressout
  wmax0=pressout
  dims=dimsizes(hdwmax0)

  hdwmax0@units="HDW"
  hdwmax0@long_name="Hot-Dry-Windy Index"
  hdwmax0@short_name="HDW Index"
  hdwmax0@level="nearsurface"
  hdwmax0@_FillValue=-9999
  hdwmax0=0  ; Reset grid to zero; that way, no fail.

  vpdmax0@units="hPa"
  vpdmax0@long_name="Maximum Vapor Pressure Deficit"
  vpdmax0@short_name="VPDmax"
  vpdmax0@level="nearsurface"
  vpdmax0@_FillValue=-9999
  vpdmax0=0  ; Reset grid to zero; that way, no fail.

  wmax0@units="m/s"
  wmax0@long_name="Maxumum Wind Speed"
  wmax0@short_name="Uma"
  wmax0@level="nearsurface"
  wmax0@_FillValue=-9999
  wmax0=0  ; Reset grid to zero; that way, no fail.

;read binary file from fortran output
   t0   = fbinrecread ("hdwiout.bin",0, (/dims(0),dims(1)/),"float")
   t1   = fbinrecread ("hdwiout.bin",1, (/dims(0),dims(1)/),"float")
   t2   = fbinrecread ("hdwiout.bin",2, (/dims(0),dims(1)/),"float")
   hdwmax0=(/t0/)
   vpdmax0=(/t1/)
   wmax0=(/t2/)

infilex->HDWANL=hdwmax0
infilex->HDW=hdwmax0
infilex->VPD=vpdmax0
infilex->U=wmax0

end

