#!/bin/bash

source /home/phisonrealestate/virtualenv/repositories/phison-realestate/phison_realestate_backend/3.8/bin/activate && cd /home/phisonrealestate/repositories/phison-realestate/phison_realestate_backend
python manage.py sendnotification --settings config.settings.production
