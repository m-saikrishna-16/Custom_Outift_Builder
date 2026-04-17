#!/usr/bin/env bash
set -o errexit

pip install -r requirements.txt

python manage.py collectstatic --no-input
python manage.py makemigrations
python manage.py migrate

# ✅ CREATE SUPERUSER (only if not exists)
echo "from django.contrib.auth import get_user_model;
User = get_user_model();
import os;
username = os.getenv('DJANGO_SUPERUSER_USERNAME');
email = os.getenv('DJANGO_SUPERUSER_EMAIL');
password = os.getenv('DJANGO_SUPERUSER_PASSWORD');
if username and not User.objects.filter(username=username).exists():
    User.objects.create_superuser(username, email, password)
" | python manage.py shell
