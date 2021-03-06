program AFM
	implicit none
	!---------------------------------------------------------------------------
	integer , parameter   :: DP=8
	!---------------------------------------------------------------------------
	integer               :: i, j, n, fid
	integer               :: smooth_type
	!---------------------------------------------------------------------------
	real(DP)              :: smooth_sigma
	real(DP), allocatable :: z (:), df (:)
	real(DP), allocatable :: zs(:), dfs(:)           
	!---------------------------------------------------------------------------
	character(200)        :: finp, fout, dfreq_file
	integer , external    :: number_of_lines
	!---------------------------------------------------------------------------
	namelist /control/ dfreq_file, smooth_type, smooth_sigma
	!---------------------------------------------------------------------------
	fid=1
	fout="out.dat"
	!---------------------------------------------------------------------------
	call getarg(1, finp)
	open(fid, file=finp, status="old")
        read(fid,control)
	close(fid)
	!---------------------------------------------------------------------------
	open(fid, file=dfreq_file, status="old")
	    n=number_of_lines(fid)
	    allocate(z  (n))
	    allocate(df (n))
        allocate(zs (n))
        allocate(dfs(n))
	    rewind(fid)
	    do i=1, n
	        read(fid,*) z(i), df(i)
	    end do
	close(fid)
	zs  = z
	dfs = df
    !---------------------------------------------------------------------------
    call smooth(n, zs, dfs, smooth_type, smooth_sigma)
    !---------------------------------------------------------------------------
    !---------------------------------------------------------------------------
	do i=1, n
	    !write(*,'(2es15.5)') z(i), df(i)
	end do
	!---------------------------------------------------------------------------
	!---------------------------------------------------------------------------
	!---------------------------------------------------------------------------
	open(fid, file=fout)
		do i=1, n
			write(fid,'(3es15.5)') z(i), df(i), dfs(i)
		end do
	close(fid)
	!---------------------------------------------------------------------------
	deallocate(z  )
	deallocate(df )
    deallocate(zs )
    deallocate(dfs)
	!---------------------------------------------------------------------------
	stop
end