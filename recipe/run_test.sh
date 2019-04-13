#!/bin/bash

ncgen -o data/in.nc data/in.cdl
fin=data/in.nc

ncap2 -O -v -s 'erf_one=float(gsl_sf_erf(1.0f));print(erf_one,"%g")' $fin fooo.nc

ncks -H --trd -v one $fin

echo "ncks 1"
ncks -O --rgr skl=skl_t42.nc \
        --rgr grid=grd_t42.nc \
        --rgr latlon=64,128 \
        --rgr lat_typ=gss \
        --rgr lon_typ=Grn_ctr \
        $fin \
        foo.nc

echo "ncks 2"
ncks -O --rgr grid=grd_2x2.nc \
        --rgr latlon=90,180 \
        --rgr lat_typ=eqa \
        --rgr lon_typ=Grn_wst \
        -D 3 \
        $fin \
        foo.nc


echo "ncap2"
ncap2 -O -s 'tst[lat,lon]=1.0f' skl_t42.nc dat_t42.nc

echo "ncremap 1"
ncremap -a conserve -s grd_t42.nc -g grd_2x2.nc -m map_t42_to_2x2.nc
echo "ncremap 2"
ncremap -i dat_t42.nc -m map_t42_to_2x2.nc -o dat_2x2.nc
echo "ncremap 3"
ncremap -a tempest -s grd_t42.nc -g grd_2x2.nc -m map_tempest_t42_to_2x2.nc
echo "ncremap 4"
ncremap -i dat_t42.nc -m map_tempest_t42_to_2x2.nc -o dat_tempest_2x2.nc
echo "ncwa"
ncwa -O dat_2x2.nc dat_avg.nc
echo "ncks 3"
ncks -C -H -v tst dat_avg.nc
