cd data

ncgen -o in.nc in.cdl

ncap2 -O -v -s 'erf_one=float(gsl_sf_erf(1.0f));print(erf_one,"%g")' in.nc foo.nc

ncks -H --trd -v one in.nc
if errorlevel 1 exit 1
