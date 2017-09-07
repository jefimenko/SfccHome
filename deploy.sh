#! /bin/bash
# Usage:
# ./deployment.sh [l]
#
# 'l' command line arg will cause installation/packaging of libraries
# specified in requirements-vendor.txt.

# Assuming *nix like structure convention, and existing /var/www dir
# *causes password prompt where applicable for sudo commands, and
# that this script is run from the directory it is contained in

if [[ -d static_root ]]
then
    mkdir static_root
fi

python manage.py collectstatic
gsutil -m -h "Cache-Control:private" rsync -r  static_root gs://sfcc-home-static

if [[ $1 == 'l' ]]
then
    pip install --upgrade -r requirements-vendor.txt -t lib
fi

gcloud app deploy
