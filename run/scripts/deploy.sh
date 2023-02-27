#!/bin/sh
# update application cache
php artisan optimize

# storageリンク設置
php artisan storage:link

# run db migration
php artisan migrate --force

# run in the background
php artisan schedule:work &

# start the application
php-fpm -D && nginx -g "daemon off;"