#! /bin/bash
# Usage:
# ./deployment.sh [l]
#
# 'l' command line arg will cause installation/packaging of libraries
# specified in requirements-vendor.txt.

# Assuming *nix like structure convention, and existing /var/www dir
# *causes password prompt where applicable for sudo commands
if [[ -d /var/www/sfcc ]]
then
    sudo mkdir /var/www/sfcc
fi
if [[ -d /var/www/sfcc/home ]]
then
    sudo mkdir /var/www/sfcc/home
fi
if [[ -d /var/www/sfcc/home/static ]]
then
    sudo mkdir /var/www/sfcc/home/static
fi

LOCAL_USER=$(whoami)
sudo chown -R $LOCAL_USER:$LOCAL_USER /var/www/sfcc

python manage.py collectstatic
gsutil rsync -R /var/www/sfcc/home/static/ gs://sfcc-home-static/


if [[ $1 == 'l' ]]
then
    pip install --upgrade -r requirements-vendor.txt -t lib
fi


gcloud app deploy
