#!/bin/bash
#
#  WRF 초기자료 시간 입력
start_yyyymmddhh=$1
wuudir=$2
Lat_N=$3
Lat_S=$4
Lon_E=$5
Lon_W=$6
#end_yyyymmddhh=$2
echo "run1_gfs start time : $start_yyyymmddhh"
#echo "run1_gfs   end time : $end_yyyymmddhh"
yyyymmdd=${start_yyyymmddhh:0:8}
hh=${start_yyyymmddhh:8:2}
#
user=$(whoami)
#wuudir=/home/${user}/WUU
shelldir="${wuudir}/SHEL"
#
echo -n "GFS download starting time:" 
date 
echo " ========================================="
echo " ========================================="
echo " ========================================="
echo " dir check"
echo $shelldir

###################################################################################################################
gfsdir="https://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl?dir=%2Fgfs."
#gfsdadir="https://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/gdas."
gfsdadir="https://nomads.ncep.noaa.gov/pub/data/nccf/com/obsproc/prod/gdas."

file1="gfs.t"$hh"z.pgrb2.0p25.f"
fileda1="gdas.t"$hh"z.prepbufr.nr"
fileda2="gdas.t"$hh"z.gpsro.tm00.bufr_d.nr"

datadir=$gfsdir$yyyymmdd$"%2F${hh}%2Fatmos&file="
datalonlat="&all_var=on&all_lev=on&subregion=&toplat=${Lat_N}&leftlon=${Lon_W}&rightlon=${Lon_E}&bottomlat=${Lat_S}"
#datadadir=$gfsdadir$yyyymmdd$"/"$hh"/atmos/"
datadadir=$gfsdadir$yyyymmdd$"/"

mkdir -p ${wuudir}/DATA/GFS/$yyyymmdd/$hh
#
filedan1=$fileda1
filedan2=$fileda2
filedafull1=$datadadir$filedan1
filedafull2=$datadadir$filedan2
echo "filedan1: $filedan1"
echo "filedafull1: $filedafull1"
echo "filedan2: $filedan2"
echo "filedafull2: $filedafull2"
#
cd ${wuudir}/DATA/GFS/$yyyymmdd/$hh
#
CONDA_PATH=$(conda info | grep -i 'base environment' | awk '{print $4}')
source $CONDA_PATH/etc/profile.d/conda.sh

conda deactivate
#
     while true; do
      echo "downloading :  $filedafull1" 
      curl --fail -o $filedan1 $filedafull1 && break
     done
     while true; do
      echo "downloading :  $filedafull2" 
      curl --fail -o $filedan2 $filedafull2 && break
     done
#
 for nhour in {000..24..24}  # 1일=24시간, 6시간 간격
  do 
    filen=$file1$nhour
    filefull=$datadir$filen$datalonlat
     while true; do
      echo "downloading :  $filefull" 
      curl --fail -o $filen $filefull && break
     done
  done
conda activate ncl_stable
echo "############## run1_gfs.sh ################################"  
echo "############## CHECK IO FILES : downloaded gfs* ###################"  
ls -l gfs*   
echo "#################################################"  
#
