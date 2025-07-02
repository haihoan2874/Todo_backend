FROM php:8.2-fpm

# Cài các thư viện cần thiết
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    curl \
    git \
    libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql mbstring exif pcntl bcmath gd

# Cài composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Đặt thư mục làm việc
WORKDIR /var/www

# Copy toàn bộ code vào container
COPY . .

# Cài đặt thư viện Laravel
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Cache cấu hình
RUN php artisan config:cache && php artisan route:cache && php artisan view:cache

# Chạy Laravel bằng built-in server
CMD php artisan serve --host=0.0.0.0 --port=8080
