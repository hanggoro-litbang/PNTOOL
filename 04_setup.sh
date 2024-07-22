#!/bin/bash
#
# install R and harp
sudo apt install r-base
sudo apt install libeccodes-dev
sudo apt install proj-bin 
sudo apt install libproj-dev
sudo apt install netcdf-bin
sudo apt install sqlite3
sudo gdebi rstudio-2023.12.1-402-amd64.deb
# install R packages
token=""
cp ~/.Renviron .Renviron_save
echo $token >> ~/.Renviron
Rscript install_harp.r

