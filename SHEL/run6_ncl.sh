#!/bin/bash
#
# run ncl to create figures
#
start_yyyymmddhh=$1
domain=$2
wuudir=$3
#
yyyymmdd=${start_yyyymmddhh:0:8}
syear=${start_yyyymmddhh:0:4}
smon=${start_yyyymmddhh:4:2}
sday=${start_yyyymmddhh:6:2}
shh=${start_yyyymmddhh:8:2}
#
user=$(whoami)
#wuudir=/home/${user}/WUU
ncldir="${wuudir}/NCL"
figdir="${wuudir}/FIGS"
wrfdir="${wuudir}/WRFV4/run"
shelldir="${wuudir}/SHEL"
#
mkdir -p ${figdir}/${yyyymmdd}/${shh}
#
cd ${figdir}/${yyyymmdd}/${shh}
pwd
#
ln -sf ${ncldir}/plot_slprain.ncl .
ln -sf ${ncldir}/plot_skewt.ncl .
ln -sf ${ncldir}/plot_plevels.ncl .
ls -ltr
echo
echo "link wrfout"
echo "ls -ltr"
ls -ltr
ln -sf ${wrfdir}/wrfout_d0${domain}_${syear}-${smon}-${sday}_${shh}:00:00 input
#
echo "############## run5_ncl.sh ##########################"  
echo "############## CHECK IO : NCL #######################" 
echo "ncl input file ${wrfdir}/wrfout_d01_${syear}-${smon}-${sday}_${shh}:00:00" 
ls -l  
echo "#################################################"   
#
ncl ./plot_slprain.ncl
ncl ./plot_plevels.ncl
ncl ./plot_skewt.ncl
#
# convert -delay 10 -loop 0 precipitation*.png precp_anim.gif
#
