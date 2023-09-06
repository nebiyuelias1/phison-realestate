#!/bin/bash

# This script is used to build and deploy the app.

# Install the dependencies.
pip install -r requirements.txt

# Collect the static files.
python manage.py collectstatic --noinput --settings settings.production