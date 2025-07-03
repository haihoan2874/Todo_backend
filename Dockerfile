FROM php:8.2-apache

# Cài các extension cần thiết cho Laravel
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    git \
    curl \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Cài Composer
COPY --from=composer:2.2 /usr/bin/composer /usr/bin/composer

# Copy code vào container
COPY . /var/www/html

# Phân quyền cho Laravel
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 777 /var/www/html/storage /var/www/html/bootstrap/cache

# Enable mod_rewrite
RUN a2enmod rewrite

# Chỉ định thư mục public là root
WORKDIR /var/www/html

EXPOSE 80
