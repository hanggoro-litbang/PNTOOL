#!/bin/bash
#
# WRF에 필요한 다음의 프로그램 패키지를 설치합니다.
# : csh, gfortran, m4, mpich, gcc-7, g++-7 
#
cd ~
#
tar -zxvf ~/Downloads/BMKG/pntool_bmkg.tar.gz
tar -zxvf ~/Downloads/BMKG/geog_low_res_mandatory.tar.gz --directory ~/PNTOOL
mv ~/PNTOOL/WPS_GEOG_LOW_RES ~/PNTOOL/WPS_GEOG
#
mv ~/.bashrc ~/.bashrc_save
cp ~/PNTOOL/TMP/.bashrc ~/.bashrc
#
#
sudo add-apt-repository -y universe
#
sudo apt-get -y update
sudo apt-get -y install csh
sudo apt-get -y install gfortran
sudo apt-get -y install m4
sudo apt-get -y install mpich
sudo apt-get -y install build-essential
sudo apt-get -y install gcc-7 g++-7
sudo apt-get -y install gfortran-7
#
sudo apt-get install -y ncview
sudo apt install -y fim
sudo apt install -y curl
sudo apt-get -y install imagemagick
#
