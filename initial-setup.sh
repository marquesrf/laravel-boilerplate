#!/bin/bash
# filepath: laravel-setup.sh

# Exit on error
set -e

# Get project folder name
PROJECT_NAME=$(basename "$PWD")

# Install PHP dependencies
composer install

# Copy .env file
cp .env.example .env

# Generate app key
php artisan key:generate

# Edit .env for PostgreSQL
sed -i \
    -e 's/^DB_CONNECTION=sqlite/DB_CONNECTION=pgsql/' \
    -e 's/^# DB_HOST=127.0.0.1/DB_HOST=127.0.0.1/' \
    -e 's/^# DB_PORT=3306/DB_PORT=5432/' \
    -e "s/^# DB_DATABASE=laravel/DB_DATABASE=${PROJECT_NAME}/" \
    -e 's/^# DB_USERNAME=root/DB_USERNAME=postgres/' \
    -e 's/^# DB_PASSWORD=/DB_PASSWORD=/' \
    .env

# Run migrations
php artisan migrate

# Install JS dependencies
npm install

echo "Laravel project setup complete!"
