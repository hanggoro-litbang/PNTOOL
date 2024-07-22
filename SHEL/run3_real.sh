#!/bin/bash
#
#  WRF 초기자료 시간 입력
#
user=$(whoami)
#wuudir=/home/${user}/WUU
wuudir=$1
shelldir="${wuudir}/SHEL"
#
cd $wuudir/WRFV4/run
rm met_em.d0*
ln -sf $wuudir/WPSV4/met* .
echo "############## run3_real.sh ###################"   
echo "############## CHECK IO : lined met* ###################"  
ls -l met*   
echo "#################################################"   
rm ./wrfinput_d* ./wrfbdy_d01
./real.exe
echo "############## CHECK IO : wrfinput and wrfbdy ##########"   
ls -l wrfinput_* wrfbdy_*   
echo "#################################################"   
echo ""
# 
