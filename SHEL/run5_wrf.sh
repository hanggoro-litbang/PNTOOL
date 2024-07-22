#!/bin/bash
#
# run wrf.exe with multiple CPSs/COREs
#
num_proc=$1
user=$(whoami)
wuudir=$2
#wuudir=/home/${user}/WUU
shelldir="${wuudir}/SHEL"
#
cd $wuudir/WRFV4/run
#
echo "mpirun -np ${num_proc} ./wrf_mpi.exe"
rm rsl.out* rsl.error.*
#mpirun -np ${num_proc} ./wrf_mpi.exe >& wrfexe.log &
mpirun -np ${num_proc} ./wrf_mpi.exe    
#./wrf.exe
echo "############## run4_wrf.sh #######################"   
echo "############## CHECK IO : wrfout #######################"   
ls -l wrfout*   
echo "#################################################" 
cp wrfout* $wuudir/SHEL/CASE/$case
#
