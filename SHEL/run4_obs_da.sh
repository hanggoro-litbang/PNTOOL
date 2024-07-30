#!/bin/bash
#
# run da_wrfvar.exe
#
start_yyyymmddhh=$1
wuudir=$2
domain=$3
#
yyyymmdd=${start_yyyymmddhh:0:8}
hh=${start_yyyymmddhh:8:2}

echo " check wuudir : $wuudir"
datadir=${wuudir}/DATA/GFS/${yyyymmdd}/${hh}
echo " check datadir : $datadir"
asimdir=${wuudir}/DATA/Asimilate/${yyyymmdd}${hh}
echo " check asimdir : $asimdir"
#
cd $wuudir/WRFDA
#
#rm ./fg ./ob.bufr
#
./csv2littleR.R ${start_yyyymmddhh} ${asimdir}
#
#ln -sf $wuudir/WRFV4/run/wrfinput_d0${domain} ./fg
#ln -sf $datadir/gdas.t${hh}z.prepbufr.nr ./ob.bufr
#ln -sf $datadir/gdas.t${hh}z.gpsro.tm00.bufr_d.nr ./gpsro.bufr
#
#rm ./wrfvar_output
#./da_wrfvar.exe 
#
#mv $wuudir/WRFV4/run/wrfinput_d0${domain} $wuudir/WRFV4/run/bg_wrfinput_d0${domain}
#ln -sf $wuudir/WRFDA/wrfvar_output $wuudir/WRFV4/run/wrfinput_d0${domain}
#
# update lbc
#echo " after 3dvar update lateral boundary condition"
#cp $wuudir/WRFV4/run/wrfbdy_d01 $wuudir/WRFV4/run/bg_wrfbdy_d01
#./da_update_bc.exe
#
#echo "############## run4_da.sh #######################"   
#ls -l wrfvar*   
#echo "#################################################"  
#
