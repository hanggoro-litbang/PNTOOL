#!/bin/bash
#
#  WRF 초기자료 시간 입력
start_yyyymmddhh=$1
wuudir=$2
echo "run2_wps start time : $start_yyyymmddhh"
yyyymmdd=${start_yyyymmddhh:0:8}
hh=${start_yyyymmddhh:8:2}
#
echo " 001"
user=$(whoami)
#wuudir=/home/${user}/WUU
shelldir=${wuudir}/SHEL
# GFS 다운로드 받은 디렉토리
gfsdir=$wuudir/DATA/GFS/$yyyymmdd/$hh
#
cd $wuudir/WPSV4
pwd
# UNGRIB.EXE
echo "step2 ungrib.exe"
rm GRIBFILE* FILE* met_em.d0*
echo "link GFS files"
./link_grib.csh $gfsdir/gfs*
echo "############## run2_wps.sh ###################" 
echo "############## CHECK IO : linked gfs* ###################" 
ls -l GRIBFILE* 
echo "#################################################"  
./ungrib.exe
echo "############## CHECK IO : FILE* ###################"  
ls -l FILE*  
echo "#################################################"  
./metgrid.exe
echo "############## CHECK IO : met* ###################" 
ls -l met*  
echo "#################################################"  
# 
