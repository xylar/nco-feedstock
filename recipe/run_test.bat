cd data

ncgen -o in.nc in.cdl || exit 1

ncks -H --trd -v one in.nc || exit 1

ncap2 -O -v -s "erf_one=float(gsl_sf_erf(1.0f));" in.nc foo.nc || exit 1

ncks -v erf_one foo.nc || exit 1

ncks -C -H --trd -s '%6.0f' -d time_udunits,'1999-12-08 18:00:0.0','1999-12-09 12:00:0.0',2 -v time_udunits in.nc
