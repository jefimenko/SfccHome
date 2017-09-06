#! /bin/bash
# Usage:
# ./deployment.sh [l]
#
# l command line arg will cause installation/packaging of libraries
# specified in requirements-vendor.txt.
python manage.py collectstatic

gsutil rsync -R /var/www/sfcc/home/static/ gs://sfcc-home-static/

if [[ $1 == 'l' ]]
then
    pip install --upgrade -r requirements-vendor.txt -t lib
fi

gcloud app deploy
