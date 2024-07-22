#!/bin/bash
run_days=$1
bdy_int=$2
#
nhour_fcst=$(($run_days * 24))
#
echo "run_days = $run_days"
echo "bdy_int = $bdy_int"
echo "nhour_fcst = $nhour_fcst"
#
cp run1_gfs_999.sh run1_gfs.sh
#
bnhour="for nhour in {000..120..6}"
anhour="for nhour in {000..${nhour_fcst}..${bdy_int}}"  
#
sed -i -e "s/${bnhour}/${anhour}/g" ./run1_gfs.sh
#
