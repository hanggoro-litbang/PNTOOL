#!/bin/bash
#
#######################################################
# user modification
#######################################################
 #start_time=2021011100
 #end_time=2021011200
 #run_days=1
start_time=$(date +"%Y%m%d")
run_days=1
end_time=$(date +"%Y%m%d" -d "+$run_days days")
cc=00
# for 3dvar start_da = start_time - 1, end_da=satrt_time + 1 
 start_da=2021011023
 end_da=2021011101
 bdy_int=6
 case=DOM1
 wuudir=~/PNTOOL
 num_proc=1
 domain=1
#
 run_name=true   # namelist setupt
 run_gfs=true    # download gfs forecast data
 run_wps=true    # preprocess (ungrib, metgrid)
 run_real=true   # make initial condition
 run_wrfda=true  # data assimilation
 run_wrf=true    # run wrf  (num_proc=?)
 run_ncl=true    # create figures
#######################################################
# end of user modification
###############################################
user=$(whoami)
#wuudir=/home/${user}/WUU
shelldir="${wuudir}/SHEL"
#
#----------------------------------------------
# step0 : modify namelist
#----------------------------------------------
 if ($run_name) ; then
   echo "main_shell start: prepare namelist"
#   bash ./run0_namelist_2dom.sh $start_time $end_time $run_days $bdy_int
   bash ./run0_namelist.sh $start_time$cc $end_time$cc $run_days $bdy_int $wuudir $case $start_da $end_da $domain
   echo "main_shell end: prepare namelist"
 else
   echo "skip namelist modification"
 fi
#
#----------------------------------------------
# step1 : download GFS
#----------------------------------------------
 if ($run_gfs) ; then
   echo "main_shell start: gfs download"
   bash ./run1_gfs_prepare.sh $run_days $bdy_int
   bash ./run1_gfs.sh $start_time$cc $wuudir
   echo "main_shell end: gfs download"
 else
   echo "skip to download GFS data"
 fi
#
#----------------------------------------------
# step2 : run WPS
#----------------------------------------------
 if ($run_wps) ; then
   echo "main_shell start: wps"
   bash ./run2_wps.sh $start_time$cc $wuudir
   echo "main_shell end: wps"
 else
   echo "skip to run WPS(ungrib, metgrid)"
 fi
#----------------------------------------------
# step3 : run real
#----------------------------------------------
 if ($run_real) ; then
   echo "main_shell start: wrf"
   bash ./run3_real.sh $wuudir
   echo "main_shell end: wrf"
 else
   echo "skip to run real"
 fi
#----------------------------------------------
# step4 : run wrfda
#----------------------------------------------
 if ($run_wrfda) ; then
   echo "main_shell start: wrfda 3dvar"
   bash ./run4_da.sh $start_time$cc $wuudir $domain
   echo "main_shell end: wrfda 3dvar"
 else
   echo "skip to run real"
 fi
#----------------------------------------------
# step5 : run WRF
#----------------------------------------------
 if ($run_wrf) ; then
   echo "main_shell start: wrf"
   bash ./run5_wrf.sh ${num_proc} $wuudir
   echo "main_shell end: wrf"
 else
   echo "skip to run wrf"
 fi
#
#----------------------------------------------
# step6 : run NCL
#----------------------------------------------
 if ($run_ncl) ; then
   echo "main_shell start: ncl"
   bash ./run6_ncl.sh $start_time$cc $domain $wuudir
   echo "main_shell end: ncl"
 else
   echo "skip to run ncl"
 fi
##############################################
