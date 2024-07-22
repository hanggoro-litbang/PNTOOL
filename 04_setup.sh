#!/bin/bash
#
# install R and harp
usernya=`whoami`
sudo usermod -a -G staff $usernya
sudo apt install r-base
sudo apt install libeccodes-dev
sudo apt install proj-bin 
sudo apt install libproj-dev
sudo apt install netcdf-bin
sudo apt install sqlite3
sudo apt install gdebi
sudo gdebi rstudio-2023.12.1-402-amd64.deb
# install R packages
# please fill your own github token
token="GITHUB_PAT="
mv ~/.Renviron .Renviron_save
touch ~/.Renviron
echo $token >> ~/.Renviron
Rscript install_harp.r

