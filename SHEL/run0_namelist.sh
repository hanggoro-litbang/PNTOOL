#!/bin/bash
#
#  WRF 초기자료 시간 입력
echo " kpark **************** start  run0"
start_yyyymmddhh=$1
end_yyyymmddhh=$2
run_days=$3
bdy_int=$4
wuudir=$5
case=$6
start_da=$7
end_da=$8
domain=$9
bdy_int_s=$(($bdy_int * 3600))
echo "bdy_int = $bdy_int"
echo "bdy_int_s = ${bdy_int_s}"
#
echo "run0_name start time : $start_yyyymmddhh"
echo "run0_name   end time : $end_yyyymmddhh"
#
# dir 
#
user=$(whoami)
wpsdir="${wuudir}/WPSV4"
wrfdir="${wuudir}/WRFV4/run"
wrfdadir="${wuudir}/WRFDA"
# geo and namelist files
kordir="${wuudir}/SHEL/CASE/${case}"
#
syear=${start_yyyymmddhh:0:4}
smon=${start_yyyymmddhh:4:2}
sday=${start_yyyymmddhh:6:2}
shh=${start_yyyymmddhh:8:2}
#
eyear=${end_yyyymmddhh:0:4}
emon=${end_yyyymmddhh:4:2}
eday=${end_yyyymmddhh:6:2}
ehh=${end_yyyymmddhh:8:2}
#
# parameters to be modified
#
before_time_start="start_date = 'YYYY-MM-DD_HH:MM:SS','YYYY-MM-DD_HH:MM:SS','YYYY-MM-DD_HH:MM:SS',"
before_time_end="end_date   = 'YYYY-MM-DD_HH:MM:SS','YYYY-MM-DD_HH:MM:SS','YYYY-MM-DD_HH:MM:SS',"
#before_time_start="start_date = 'YYYY-MM-DD_HH:MM:SS','YYYY-MM-DD_HH:MM:SS','YYYY-MM-DD_HH:MM:SS','YYYY-MM-DD_HH:MM:SS','YYYY-MM-DD_HH:MM:SS',"
#before_time_end="end_date   = 'YYYY-MM-DD_HH:MM:SS','YYYY-MM-DD_HH:MM:SS','YYYY-MM-DD_HH:MM:SS','YYYY-MM-DD_HH:MM:SS','YYYY-MM-DD_HH:MM:SS',"
before_interval_s="interval_seconds = SSSSS"
#
#
#after_time_start="start_date = '${syear}-${smon}-${sday}_${shh}:00:00','${syear}-${smon}-${sday}_${shh}:00:00','${syear}-${smon}-${sday}_${shh}:00:00',"
#after_time_end="end_date = '${eyear}-${emon}-${eday}_${ehh}:00:00','${eyear}-${emon}-${eday}_${ehh}:00:00','${eyear}-${emon}-${eday}_${ehh}:00:00',"
after_time_start="start_date = '${syear}-${smon}-${sday}_${shh}:00:00','${syear}-${smon}-${sday}_${shh}:00:00','${syear}-${smon}-${sday}_${shh}:00:00','${syear}-${smon}-${sday}_${shh}:00:00','${syear}-${smon}-${sday}_${shh}:00:00',"
after_time_end="end_date = '${eyear}-${emon}-${eday}_${ehh}:00:00','${eyear}-${emon}-${eday}_${ehh}:00:00','${eyear}-${emon}-${eday}_${ehh}:00:00','${eyear}-${emon}-${eday}_${ehh}:00:00','${eyear}-${emon}-${eday}_${ehh}:00:00',"
after_interval_s="interval_seconds = ${bdy_int_s}"
#
# for WRF namelist.input
brundays=" run_days                            = 1,"
bsyear=" start_year                          = YYYS, YYYS, YYYS,"
bsmonth=" start_month                         = MS,   MS,   MS,"
bsday=" start_day                           = DS,   DS,   DS,"
bshour=" start_hour                          = HS,   HS,   HS,"
beyear=" end_year                            = YYYE, YYYE, YYYE,"
bemonth=" end_month                           = ME,   ME,   ME,"
beday=" end_day                             = DE,   DE,   DE,"
behour=" end_hour                            = HE,   HE,   HE,"
#bsyear=" start_year                          = YYYS, YYYS, YYYS, YYYS, YYYS,"
#bsmonth=" start_month                         = MS,   MS,   MS,   MS,   MS,"
#bsday=" start_day                           = DS,   DS,   DS,   DS,   DS,"
#bshour=" start_hour                          = HS,   HS,   HS,   HS,   HS,"
#beyear=" end_year                            = YYYE, YYYE, YYYE, YYYE, YYYE,"
#bemonth=" end_month                           = ME,   ME,   ME,   ME,   ME,"
#beday=" end_day                             = DE,   DE,   DE,   DE,   DE,"
#behour=" end_hour                            = HE,   HE,   HE,   HE,   HE,"
bintsec="interval_seconds                    = SSSSS"
#
arundays=" run_days                            = ${run_days},"
#asyear=" start_year                          = ${syear}, ${syear}, ${syear},"
#asmonth=" start_month                         = ${smon},   ${smon},   ${smon},"
#asday=" start_day                           = ${sday},   ${sday},   ${sday},"
#ashour=" start_hour                          = ${shh},   ${shh},   ${shh},"
#aeyear=" end_year                            = ${eyear}, ${eyear}, ${eyear},"
#aemonth=" end_month                           = ${emon},   ${emon},   ${emon},"
#aeday=" end_day                             = ${eday},   ${eday},   ${eday},"
#aehour=" end_hour                            = ${ehh},   ${ehh},   ${ehh},"
asyear=" start_year                          = ${syear}, ${syear}, ${syear}, ${syear}, ${syear},"
asmonth=" start_month                         = ${smon},   ${smon},   ${smon},   ${smon},   ${smon},"
asday=" start_day                           = ${sday},   ${sday},   ${sday},   ${sday},   ${sday},"
ashour=" start_hour                          = ${shh},   ${shh},   ${shh},   ${shh},   ${shh},"
aeyear=" end_year                            = ${eyear}, ${eyear}, ${eyear}, ${eyear}, ${eyear},"
aemonth=" end_month                           = ${emon},   ${emon},   ${emon},   ${emon},   ${emon},"
aeday=" end_day                             = ${eday},   ${eday},   ${eday},   ${eday},   ${eday},"
aehour=" end_hour                            = ${ehh},   ${ehh},   ${ehh},   ${ehh},   ${ehh},"
aintsec="interval_seconds                    = ${bdy_int_s}"
#
echo $after_time_start
echo $after_time_end
#-------------------------------------------------------
# WPSV4/namelist.input
#-------------------------------------------------------
cp ${kordir}/geo_em.d0*.nc ${wpsdir}/
#
mv ${wpsdir}/namelist.wps ${wpsdir}/namelist.wps_bk
cp ${kordir}/namelist.wps ${wpsdir}/namelist.wps_tmp
#
# namelist
#
sed -i -e "s/${before_time_start}/${after_time_start}/g" ${wpsdir}/namelist.wps_tmp
sed -i -e "s/${before_time_end}/${after_time_end}/g" ${wpsdir}/namelist.wps_tmp
sed -i -e "s/${before_interval_s}/${after_interval_s}/g" ${wpsdir}/namelist.wps_tmp
#
cp ${wpsdir}/namelist.wps_tmp ${wpsdir}/namelist.wps
#------------------------------------------
# WRFV4/run/namelist.input
#------------------------------------------
cp ${wrfdir}/namelist.input ${wrfdir}/namelist.input_bk
cp ${kordir}/namelist.input_wrf ${wrfdir}/namelist.input_tmp
sed -i -e "s/${brundays}/${arundays}/g" ${wrfdir}/namelist.input_tmp

sed -i -e "s/${bsyear}/${asyear}/g" ${wrfdir}/namelist.input_tmp
sed -i -e "s/${bsmonth}/${asmonth}/g" ${wrfdir}/namelist.input_tmp
sed -i -e "s/${bsday}/${asday}/g" ${wrfdir}/namelist.input_tmp
sed -i -e "s/${bshour}/${ashour}/g" ${wrfdir}/namelist.input_tmp

sed -i -e "s/${beyear}/${aeyear}/g" ${wrfdir}/namelist.input_tmp
sed -i -e "s/${bemonth}/${aemonth}/g" ${wrfdir}/namelist.input_tmp
sed -i -e "s/${beday}/${aeday}/g" ${wrfdir}/namelist.input_tmp
sed -i -e "s/${behour}/${aehour}/g" ${wrfdir}/namelist.input_tmp
#
sed -i -e "s/${bintsec}/${aintsec}/g" ${wrfdir}/namelist.input_tmp
#
cp ${wrfdir}/namelist.input_tmp ${wrfdir}/namelist.input
#
#------------------------------------------
# WRFDA/namelist.input BUFR
#------------------------------------------
#
# for WRFDA namelist.input
#
#
#run_wrfda_obs=true
sw_year=${start_da:0:4}
sw_month=${start_da:4:2}
sw_day=${start_da:6:2}
sw_hour=${start_da:8:2}
#
ew_year=${end_da:0:4}
ew_month=${end_da:4:2}
ew_day=${end_da:6:2}
ew_hour=${end_da:8:2}
#
b_start_year="start_year=yyyy,"
b_start_month="start_month=mm,"
b_start_day="start_day=dd,"
b_start_hour="start_hour=hh,"
b_end_year="end_year=yyyy,"
b_end_month="end_month=mm,"
b_end_day="end_day=dd,"
b_end_hour="end_hour=hh,"

a_start_year="start_year=${sw_year},"
a_start_month="start_month=${sw_month},"
a_start_day="start_day=${sw_day},"
a_start_hour="start_hour=${sw_hour},"
a_end_year="end_year=${ew_year},"
a_end_month="end_month=${ew_month},"
a_end_day="end_day=${ew_day},"
a_end_hour="end_hour=${ew_hour},"
#
b_analtime="aaaa-aa-aa_aa"
a_analtime="${syear}-${smon}-${sday}_${shh}"
#
b_timewindow_min="ssss-ss-ss_ss"
b_timewindow_max="eeee-ee-ee_ee"
a_timewindow_min="${sw_year}-${sw_month}-${sw_day}_${sw_hour}"
a_timewindow_max="${ew_year}-${ew_month}-${ew_day}_${ew_hour}"
#
cp ${wrfdadir}/namelist.input ${wrfdadir}/namelist.input_bk
cp ${kordir}/namelist.input_wrfda_buf_dom${domain} ${wrfdadir}/namelist.input_tmp
#
sed -i -e "s/${b_start_year}/${a_start_year}/g" ${wrfdadir}/namelist.input_tmp
sed -i -e "s/${b_start_month}/${a_start_month}/g" ${wrfdadir}/namelist.input_tmp
sed -i -e "s/${b_start_day}/${a_start_day}/g" ${wrfdadir}/namelist.input_tmp
sed -i -e "s/${b_start_hour}/${a_start_hour}/g" ${wrfdadir}/namelist.input_tmp
sed -i -e "s/${b_end_year}/${a_end_year}/g" ${wrfdadir}/namelist.input_tmp
sed -i -e "s/${b_end_month}/${a_end_month}/g" ${wrfdadir}/namelist.input_tmp
sed -i -e "s/${b_end_day}/${a_end_day}/g" ${wrfdadir}/namelist.input_tmp
sed -i -e "s/${b_end_hour}/${a_end_hour}/g" ${wrfdadir}/namelist.input_tmp
#
sed -i -e "s/${b_analtime}/${a_analtime}/g" ${wrfdadir}/namelist.input_tmp
sed -i -e "s/${b_timewindow_min}/${a_timewindow_min}/g" ${wrfdadir}/namelist.input_tmp
sed -i -e "s/${b_timewindow_max}/${a_timewindow_max}/g" ${wrfdadir}/namelist.input_tmp
#
cp ${wrfdadir}/namelist.input_tmp ${wrfdadir}/namelist.input
#
#------------------------------------------
# WRFDA/namelist.input OBS
#------------------------------------------
#
# for WRFDA namelist.input
#
#
sw_year=${start_da:0:4}
sw_month=${start_da:4:2}
sw_day=${start_da:6:2}
sw_hour=${start_da:8:2}
#
ew_year=${end_da:0:4}
ew_month=${end_da:4:2}
ew_day=${end_da:6:2}
ew_hour=${end_da:8:2}
#
b_start_year="start_year=yyyy,"
b_start_month="start_month=mm,"
b_start_day="start_day=dd,"
b_start_hour="start_hour=hh,"
b_end_year="end_year=yyyy,"
b_end_month="end_month=mm,"
b_end_day="end_day=dd,"
b_end_hour="end_hour=hh,"

a_start_year="start_year=${sw_year},"
a_start_month="start_month=${sw_month},"
a_start_day="start_day=${sw_day},"
a_start_hour="start_hour=${sw_hour},"
a_end_year="end_year=${ew_year},"
a_end_month="end_month=${ew_month},"
a_end_day="end_day=${ew_day},"
a_end_hour="end_hour=${ew_hour},"
#
b_analtime="aaaa-aa-aa_aa"
a_analtime="${syear}-${smon}-${sday}_${shh}"
#
b_timewindow_min="ssss-ss-ss_ss"
b_timewindow_max="eeee-ee-ee_ee"
a_timewindow_min="${sw_year}-${sw_month}-${sw_day}_${sw_hour}"
a_timewindow_max="${ew_year}-${ew_month}-${ew_day}_${ew_hour}"
#
cp ${wrfdadir}/namelist.input ${wrfdadir}/namelist.input_bk
cp ${kordir}/namelist.input_wrfda_obs_dom${domain} ${wrfdadir}/namelist.input_tmp
#
sed -i -e "s/${b_start_year}/${a_start_year}/g" ${wrfdadir}/namelist.input_tmp
sed -i -e "s/${b_start_month}/${a_start_month}/g" ${wrfdadir}/namelist.input_tmp
sed -i -e "s/${b_start_day}/${a_start_day}/g" ${wrfdadir}/namelist.input_tmp
sed -i -e "s/${b_start_hour}/${a_start_hour}/g" ${wrfdadir}/namelist.input_tmp
sed -i -e "s/${b_end_year}/${a_end_year}/g" ${wrfdadir}/namelist.input_tmp
sed -i -e "s/${b_end_month}/${a_end_month}/g" ${wrfdadir}/namelist.input_tmp
sed -i -e "s/${b_end_day}/${a_end_day}/g" ${wrfdadir}/namelist.input_tmp
sed -i -e "s/${b_end_hour}/${a_end_hour}/g" ${wrfdadir}/namelist.input_tmp
#
sed -i -e "s/${b_analtime}/${a_analtime}/g" ${wrfdadir}/namelist.input_tmp
sed -i -e "s/${b_timewindow_min}/${a_timewindow_min}/g" ${wrfdadir}/namelist.input_tmp
sed -i -e "s/${b_timewindow_max}/${a_timewindow_max}/g" ${wrfdadir}/namelist.input_tmp
#
cp ${wrfdadir}/namelist.input_tmp ${wrfdadir}/namelist.input
#
