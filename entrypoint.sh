#!/bin/sh
APP_PORT=${PORT:-8000}
/opt/venv/bin/python manage.py migrate --no-input
/opt/venv/bin/python manage.py collectstatic --no-input

/opt/venv/bin/gunicorn core.wsgi:application --bind "0.0.0.0:${APP_PORT}"
