#! /bin/bash
python manage.py collectstatic

gsutil rsync -R static/ gs://sfcc-home-static/

pip install --upgrade -r requirements-vendor.txt -t lib

gcloud app deploy

