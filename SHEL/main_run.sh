#!/bin/bash
#
#######################################################
#
# start and end date and time
#
 date_input=$(zenity --forms --text='start and end date'\
 --add-calendar='start date' --add-calendar='end date')
 echo ${date_input}
 yy1=${date_input:6:2}
 yy2=${date_input:15:2}
 mm1=${date_input:3:2}
 mm2=${date_input:12:2}
 dd1=${date_input:0:2}
 dd2=${date_input:9:2}
 start_date=`date -d $yy1$mm1$dd1 +'%Y%m%d'`
 end_date=`date -d $yy2$mm2$dd2 +'%Y%m%d'`
#
# start time in UTC
#
 hh=$(zenity --list --radiolist --text "<b>start time in UTC</b> " \
 --hide-header --column "Buy" --column "Item" TRUE "00UTC" FALSE "06UTC" \
 FALSE "12UTC" FALSE "18UTC")
 echo $hh
#
# boundary condition interval in hour 
#
 bdy_int=$(zenity --list --radiolist --text "<b>lateral boundary inteval (hours)</b> " \
 --hide-header --column "Buy" --column "Item" FALSE "1" FALSE "3" \
 TRUE "6" FALSE "12" FALSE "24")
 echo "bdy_int=" $bdy_int
#
# case selection
#
 export case=$(zenity --list --radiolist --text "<b>Select case</b> " \
 --hide-header --column "Buy" --column "Item" TRUE "ID1" FALSE "ID2" FALSE "ID3" FALSE "ID4")
 echo "case=" $case
#
# select procedures to be run
#
wuudir_tmp=$(pwd)
wuudir="${wuudir_tmp:0:-5}"
echo "in main shel wuudir=" $wuudir
 echo "wuudir=" $wuudir
#
# convert to yyyymmdd format
#
 echo $hh
 echo "date_input2=" $date_input
 echo "start_date=" $start_date
 echo "end_date=" $end_date
#
# convert to yyyymmddhh format
#
 start_time="${start_date}${hh:0:2}"
 end_time="${end_date}${hh:0:2}"
 echo "start time =" $start_time
 echo "end time =" $end_time
#
# forecast periods in days
#
 let run_days=(`date +%s -d ${end_date}`-`date +%s -d ${start_date}`)/86400
 echo "run_days=" $run_days
#
 tempval=$(echo $start_time | sed 's/\(.\{8\}\)/\1 /g')
 tempval1=$(echo "$tempval -1 hour")
 start_da=$(date -d "$tempval1" +%Y%m%d%H)
 tempval2=$(echo "$tempval +1 hour")
 end_da=$(date -d "$tempval2" +%Y%m%d%H)
 echo "start_da=" $start_da
 echo "end_da=" $end_da
#

#Domain boarder coordinates menu for input
# default values
default_Lat_N="20"
default_Lat_S="-25"
default_Lon_E="155"
default_Lon_W="85"
#
choice=$(zenity --forms --text="Click OK to keep given values:" \
--add-entry='Lat_N= 20' --add-entry='Lat_S= -25' --add-entry='Lon_E= 155' --add-entry='Lon_W= 85' --separator=" ")
#
##
#Split the user's input into seperate variables
#read -r  Lat_N Lat_S Lon_E Lon_W <<< "$choice"
echo $choice
#
if [[ $? -eq 0 ]]; then
    # User canceled the dialog, use default values
    Lat_N="$default_Lat_N"
    Lat_S="$default_Lat_S"
    Lon_E="$default_Lon_E"
    Lon_W="$default_Lon_W"
else
    # User provided input, split and store the values
    read -r Lat_N Lat_S Lon_E Lon_W <<< "$choice"
fi
#
#Display the entered values
echo "Domain boarder coordinates:"
echo "Lat_N: $Lat_N"
echo "Lat_S: $Lat_S"
echo "Lon_E: $Lon_E"
echo "Lon_W: $Lon_W"
# select processes to be run :  select true or false
#
proc_1="namelist"
proc_2="download"
proc_3="ungrib&metgrid"
proc_4="initialization"
proc_5="WRFDA"
proc_6="forecast"
proc_7="NCL"
#
proc_choices=$(zenity --list --checklist --title="Run 선택" --column="" \
--column="내용" TRUE ${proc_1} TRUE ${proc_2} \
TRUE ${proc_3} TRUE ${proc_4} TRUE ${proc_5} TRUE ${proc_6} TRUE ${proc_7})
#
echo "proc_choices" $proc_choices
#
 num_proc=2    # number of cores for parallel run 
 domain=1      # domain to DA and NCL
 num_proc=$(zenity --list --radiolist --text "<b> Pallelization </b> number of CPU core" \
 --hide-header --column "Buy" --column "Item" \
TRUE "1" FALSE "2" FALSE "4" FALSE "8" FALSE "16")
 domain=$(zenity --list --radiolist --text " \
<b>Data assimilation</b> choose the domain for DA" \
 --hide-header --column "Buy" --column "Item" \
TRUE "1" FALSE "2" FALSE "3" FALSE "4")
echo "num_proc=" $num_proc
echo "domain=" $domain
#
 run_name=true   # namelist setupt
 run_gfs=true    # download gfs forecast data
 run_wps=true    # preprocess (ungrib, metgrid)
 run_real=true   # make initial condition
 run_wrfda=true  # data assimilation
 run_wrf=true    # run wrf  (num_proc=?)
 run_ncl=true    # create figures
#
if [[ $proc_choices == *$proc_1* ]]; then
 echo "selected : " $proc_1
 run_name=true   
else
 run_name=false   
fi
#
if [[ $proc_choices == *$proc_2* ]]; then
 echo "selected : " $proc_2
 run_gfs=true
else
 run_gfs=false
fi
#
if [[ $proc_choices == *$proc_3* ]]; then
 echo "selected : " $proc_3
 run_wps=true 
else
 run_wps=false
fi
#
if [[ $proc_choices == *$proc_4* ]]; then
 echo "selected : " $proc_4
 run_real=true
else
 run_real=false
fi
#
if [[ $proc_choices == *$proc_5* ]]; then
 echo "selected : " $proc_5
 run_wrfda=true
else
 run_wrfda=false
fi
#
if [[ $proc_choices == *$proc_6* ]]; then
 echo "selected : " $proc_6
 run_wrf=true 
else
 run_wrf=false
fi
#
if [[ $proc_choices == *$proc_7* ]]; then
 echo "selected : " $proc_7
 run_ncl=true 
else
 run_ncl=false
fi
#
# num_proc=2      # number of cores for parallel run 
# dom_plot=1      # domain to make graphics
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
   bash ./run0_namelist.sh $start_time $end_time $run_days $bdy_int $wuudir $case $start_da $end_da $domain
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
   bash ./run1_gfs.sh $start_time $wuudir $Lat_N $Lat_S $Lon_E $Lon_W
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
   bash ./run2_wps.sh $start_time $wuudir
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
   bash ./run4_da.sh $start_time $wuudir $domain
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
   bash ./run6_ncl.sh $start_time $domain $wuudir
   echo "main_shell end: ncl"
 else
   echo "skip to run ncl"
 fi
##############################################
echo "========================================================"
echo "          FINISHED"
echo "========================================================"

