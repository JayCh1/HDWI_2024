	! FORTRAN code to read GEFS analysis files and compute HDWI file a single day for AK
	!
	! To compile in linux using gfortan with recent wgrib2 installed, use the following commands:
	!    LIB="-L/home/mmfire/mikebin/grib2/lib -lwgrib2 -lgfortran -lz -lm"
	!    MOD="-I/home/mmfire/mikebin/grib2/lib"
	!    gfortran -fopenmp HDW_Calc_GEFSanl_jay.f -o HDW_Calc_GEFSanl_jay ${MOD} ${LIB}

        use wgrib2api
	character (len=100) :: in(3), inv(3)
	integer iret(3)
	character (len=200) :: metadata
        integer, allocatable  :: levs(:), levsort(:)
	character (len=30), allocatable :: slevs(:), slevsort(:)

	! variables from GEFS
	real, allocatable :: tmp(:,:),lat(:,:),lon(:,:)
	real, allocatable :: psfc(:,:,:),praw(:,:,:,:)
	real, allocatable :: psfc3d(:,:,:,:)
	real, allocatable :: tsfc(:,:,:),traw(:,:,:,:)
	real, allocatable :: rsfc(:,:,:),rraw(:,:,:,:)
	real, allocatable :: usfc(:,:,:),uraw(:,:,:,:)
	real, allocatable :: vsfc(:,:,:),vraw(:,:,:,:)

	! pre-HDWI prep variables
	real, allocatable :: thraw(:,:,:,:),svpraw(:,:,:,:),essfc(:,:,:)
	real, allocatable :: esraw(:,:,:,:),esfc(:,:,:),eraw(:,:,:,:)
	real, allocatable :: vpdsfc(:,:,:),vpdraw(:,:,:,:),wsfc(:,:,:)
	real, allocatable :: wraw(:,:,:,:) 

	! trimed GEFS variables
	real, allocatable :: tsfct(:,:,:),psfct(:,:,:),prawt(:,:,:,:)

	! HDWI variables
	real, allocatable :: wmax0(:,:,:),vpdmax0(:,:,:),ptop0(:,:,:)
	real, allocatable :: hdw0(:,:,:),hdwmax0(:,:)
	real, allocatable :: wmaxout(:,:),vpdmaxout(:,:)

	integer :: lev, nx, ny, i, j

	!  First, read in all the necesary variables from GEFS files for 1200, 1800, and 0000 (next day)
	!  tinker with the allocatable statements above and skip down to @@@@@@ if you are using other data sources for:

	!  surface pressure (in Pa)
	!  surface (2 m) temperature (in K)
	!  surface (2 m) specific humidity 
	!  surface (10 m) u-wind
	!  surface (10 m) v-wind
	!  vertical pressure (in Pa)
	!  vertical temperature (in K)
	!  vertical relative humidity (in %)
	!  vertical u-wind (in m/s
	!  vertical v-wind (in m/s
	!  All of the sfc/vertical variables should be on the same grid.

        in(1)='GEFS_18.grib2'
        in(2)='GEFS_00.grib2'
        in(3)='GEFS_06.grib2'
        inv(1)='FILE_18.inv'
        inv(2)='FILE_00.inv'
        inv(3)='FILE_06.inv'
        iret(1) = grb2_mk_inv(in(1), inv(1))
        iret(2) = grb2_mk_inv(in(2), inv(2))
        iret(3) = grb2_mk_inv(in(3), inv(3))

        iret(1) = grb2_inq(in(1), inv(1), ':PRES:', ':surface:', 
     1        data2=tmp, nx=nx, ny=ny, lat=lat, lon=lon)

	allocate(psfc(3,nx,ny))
	allocate(tsfc(3,nx,ny))
	allocate(rsfc(3,nx,ny))
	allocate(usfc(3,nx,ny))
	allocate(vsfc(3,nx,ny))

        nlevst = grb2_inq(in(1),inv(1),':TMP:',' mb:')
       ! NOTE:  the levels for r, u, and v are never used; if these differ in strange ways from the t
       !        levels, it could cause errors; user beware...
        nlevsr = grb2_inq(in(1),inv(1),':RH:',' mb:')
        nlevsu = grb2_inq(in(1),inv(1),':UGRD:',' mb:')
        nlevsv = grb2_inq(in(1),inv(1),':VGRD:',' mb:')

	allocate(praw(3,nx,ny,nlevst))
	allocate(psfc3d(3,nx,ny,nlevst))
	allocate(traw(3,nx,ny,nlevst))
	allocate(rraw(3,nx,ny,nlevst))
	allocate(uraw(3,nx,ny,nlevst))
	allocate(vraw(3,nx,ny,nlevst))

        allocate(slevs(nlevst))
        allocate(slevsort(nlevst))
        allocate(levs(nlevst))
        allocate(levsort(nlevst))

        do i = 1,nlevst
           iret(1)=grb2_inq(in(1),inv(1),':TMP:',' mb:',
     1         sequential=i-1,desc=metadata)
           if (iret(1).ne.1) stop 2
           j = index(metadata,':TMP:') + len(':TMP:')
           k = index(metadata," mb:") + len(" mb:")-1
           read(metadata(j:),*) levs(i)
           slevs(i) = metadata(j-1:k)
        enddo
        do i = 1,nlevst
          ii=nlevst-i+1
          levsort(ii)=minval(levs)
          slevsort(ii)=slevs(minloc(levs,1))
          levs(minloc(levs,1))=999999
        enddo

        do iin=1,3

          iret(iin) = grb2_inq(in(iin), inv(iin), 
     1        ':PRES:', ':surface:', data2=tmp)
          psfc(iin,:,:) = tmp
          iret(iin) = grb2_inq(in(iin), inv(iin), 
     1        ':TMP:', ':2 m above ground:', data2=tmp)
          tsfc(iin,:,:) = tmp
          iret(iin) = grb2_inq(in(iin), inv(iin), 
     1        ':RH:', ':2 m above ground:', data2=tmp)
          rsfc(iin,:,:) = tmp
          iret(iin) = grb2_inq(in(iin), inv(iin), 
     1        ':UGRD:', ':10 m above ground:', data2=tmp)
          usfc(iin,:,:) = tmp
          iret(iin) = grb2_inq(in(iin), inv(iin), 
     1        ':VGRD:', ':10 m above ground:', data2=tmp)
          vsfc(iin,:,:) = tmp
 
          do i=1,nlevst
            praw(iin,:,:,i) = levsort(i)*100.
            psfc3d(iin,:,:,i) = psfc(iin,:,:)
            iret(iin) = grb2_inq(in(iin),inv(iin),':TMP:',slevsort(i),
     1         data2=tmp)
            traw(iin,:,:,i) = tmp
          enddo
          do i=1,nlevst
            iret(iin) = grb2_inq(in(iin),inv(iin),':RH:',slevsort(i),
     1         data2=tmp)
            rraw(iin,:,:,i) = tmp
          enddo
          do i=1,nlevst
            iret(iin) = grb2_inq(in(iin),inv(iin),':UGRD:',slevsort(i),
     1         data2=tmp)
            uraw(iin,:,:,i) = tmp
          enddo
          do i=1,nlevst
            iret(iin) = grb2_inq(in(iin),inv(iin),':VGRD:',slevsort(i),
     1         data2=tmp)
            vraw(iin,:,:,i) = tmp
          enddo

        enddo
 
	! @@@@@@@@@@@@@@@@@@@@@@@
	!    done with GEFS reads, here is where the real business of 
 	!    calculating HDWI begins
	! @@@@@@@@@@@@@@@@@@@@@@@

	! First we set up some variables to make the indexing go smoothly
	!   Note: if the vertical (raw) variables do not all have the same 
	!         vertical dimension in the input data (nlevst), this part of the 
	!         code could crash hard.

        !@@@@@@@
        ! this is where I am adding code to trim the global GEFS down to AK
        ! defines nxt and nyt as the trimmed x and y components and uses them from this point forward
        ! for AK, we need to use the following window and grid to figure out the right i and j numbers...
        ! note that GEFS increments starting at 1 at the south pole and at the international date line
        ! Dj :   0.5
        ! Di :   0.5
        ! Lat1 :  52
        ! Lat2 :  72
        ! Lon1 :  190
        ! Lon2 :  230

        ilat1=285
        ilat2=325
        ilon1=381
        ilon2=461
        nxt=ilon2-ilon1+1
        nyt=ilat2-ilat1+1

        !@@@@@@@

	allocate(thraw(3,nxt,nyt,nlevst))
	allocate(svpraw(3,nxt,nyt,nlevst))
	allocate(essfc(3,nxt,nyt))
	allocate(esraw(3,nxt,nyt,nlevst))
	allocate(esfc(3,nxt,nyt))
	allocate(eraw(3,nxt,nyt,nlevst))
	allocate(vpdsfc(3,nxt,nyt))
	allocate(vpdraw(3,nxt,nyt,nlevst))
	allocate(wsfc(3,nxt,nyt))
	allocate(wraw(3,nxt,nyt,nlevst))
	allocate(ptop0(3,nxt,nyt))

        praw = 0.01 * praw  ! convert praw from Pa to hPa

	!Calculate potential temperature of a level brought down to sfc
        thraw = traw(:,ilon1:ilon2,ilat1:ilat2,:)*
     1          (((psfc3d(:,ilon1:ilon2,ilat1:ilat2,:)
     1          /100.)/praw(:,ilon1:ilon2,ilat1:ilat2,:))**0.286)

	!Calculate saturated vapor pressure adjusted to sfc theta of each level
        svpraw = (6.122*exp((17.67*(thraw-273.15))/(thraw-29.65)))

	!Calculate surface and 3d saturated vapor pressure using temperature of each level
        essfc = (6.122*exp((17.67*(tsfc(:,ilon1:ilon2,ilat1:ilat2)
     1           -273.15))
     1         /(tsfc(:,ilon1:ilon2,ilat1:ilat2)-29.65)))
        esraw = (6.122*exp((17.67*(traw(:,ilon1:ilon2,ilat1:ilat2,:)
     1           -273.15))
     1         /(traw(:,ilon1:ilon2,ilat1:ilat2,:)-29.65)))

	!Calculate vapor pressure at sfc and at each level
        esfc = rsfc(:,ilon1:ilon2,ilat1:ilat2)*essfc*0.01
        eraw = rraw(:,ilon1:ilon2,ilat1:ilat2,:)*esraw*0.01

	!Calculate vapor pressure deficit at sfc
        vpdsfc = essfc - esfc
	!Calculate surface adjusted vapor pressure deficit at each level
        vpdraw = svpraw - eraw

	!Calculate wind speed at sfc and at each level
        wsfc = ((usfc(:,ilon1:ilon2,ilat1:ilat2)*
     1          usfc(:,ilon1:ilon2,ilat1:ilat2)) + 
     1         (vsfc(:,ilon1:ilon2,ilat1:ilat2)*
     1          vsfc(:,ilon1:ilon2,ilat1:ilat2)))**0.5
        wraw = ((uraw(:,ilon1:ilon2,ilat1:ilat2,:)*
     1          uraw(:,ilon1:ilon2,ilat1:ilat2,:)) + 
     1         (vraw(:,ilon1:ilon2,ilat1:ilat2,:)*
     1          vraw(:,ilon1:ilon2,ilat1:ilat2,:)))**0.5

	! Now calculate full HDWI

	! Set pressure difference of HDWI layer in hPa (assumption is that 1 hPa ~ 10 m, so for default HDWI pdiff = 50)
	!   Note that we decided to include any model layer whose base is below the top of the HDWI layer. So all HDWI
	!   values in this calculation include model data that is valid for the top of the HDWI layer and a certain distance
	!   above that level. Thus, small changes in pdiff should have little or no effect on HDWI values using GEFS data.
	!   Differences >= 50 should always mean that at least one additional GEFS model level is included in the HDWI
	!   calculation.

        pdiff0 = 50

	! determine press at top of HDWI layer
        ptop0 = (psfc(:,ilon1:ilon2,ilat1:ilat2)/100.) - pdiff0

	! this is the theta diff for the updated HDWI that adds in a stability check
        thdiff = 1.0

	! allocate the final HDWI variables
        allocate(wmax0(3,nxt,nyt))
        allocate(vpdmax0(3,nxt,nyt))
        allocate(hdw0(3,nxt,nyt))
        allocate(hdwmax0(nxt,nyt))
        allocate(vpdmaxout(nxt,nyt))
        allocate(wmaxout(nxt,nyt))

	! allocate trimmed versions of certain variables
        allocate(tsfct(3,nxt,nyt))
        allocate(psfct(3,nxt,nyt))
        allocate(prawt(3,nxt,nyt,nlevst))

        tsfct = tsfc(:,ilon1:ilon2,ilat1:ilat2)
        psfct = psfc(:,ilon1:ilon2,ilat1:ilat2)
        prawt = praw(:,ilon1:ilon2,ilat1:ilat2,:)

        do iin = 1, 3
        do i = 1, nxt
        do j = 1, nyt
	! start with sfc wind and vpd
          f4w = wsfc(iin,i,j)
          f4v = vpdsfc(iin,i,j)
	! now find levels that fall between psfc and ptop
          do k = nlevst, 1, -1
            if (psfct(iin,i,j)/100.gt.prawt(iin,i,j,k).and.
     1          ptop0(iin,i,j).lt.prawt(iin,i,j,k)) then
	! here is where the stability check comes in
            if ((thraw(iin,i,j,k)-tsfct(iin,i,j)).lt.thdiff) then  
	! if vpd or wind greater than sfc, replace with new value
              if (wraw(iin,i,j,k).gt.f4w) then
                 f4w = wraw(iin,i,j,k)
              endif
              if (vpdraw(iin,i,j,k).gt.f4v) then
                 f4v = vpdraw(iin,i,j,k)
              endif
            endif
            endif
            if (ptop0(iin,i,j).ge.prawt(iin,i,j,k)) then
	!  here is where the stability check comes in
              if ((thraw(iin,i,j,k)-tsfct(iin,i,j)).lt.thdiff) then 
	! if vpd or wind greater than sfc, replace with new value
                if (wraw(iin,i,j,k).gt.f4w) then
                 f4w = wraw(iin,i,j,k)
                endif
                if (vpdraw(iin,i,j,k).gt.f4v) then
                  f4v = vpdraw(iin,i,j,k)
                endif
              endif
              wmax0(iin,i,j) = f4w
              vpdmax0(iin,i,j) = f4v
	! break out of the k loop once pressure is less than ptop
              exit
            endif
          enddo

        enddo
        enddo
        enddo

	! here is hdw for each time, finally!!
        hdw0 = wmax0*vpdmax0

	! find the daily max value of hdw
	! Reset grid to zero; that way, no fail.
        hdwmax0=0  
        hdwmax0 = maxval(hdw0,dim=1)
        do i = 1, nxt
        do j = 1, nyt
          itime=maxloc(hdw0(:,i,j),dim=1)
          vpdmaxout(i,j)=vpdmax0(itime,i,j)
          wmaxout(i,j)=wmax0(itime,i,j)
        enddo
        enddo

        ! write out binary file
        open(10,file="hdwiout.bin",form="unformatted",status="UNKNOWN")
        write(10) hdwmax0
        write(10) vpdmaxout
        write(10) wmaxout

	!all done!

	stop
	end
