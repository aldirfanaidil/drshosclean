FROM php:8.1-apache

# Install dependencies
RUN apt-get update && apt-get install -y curl unzip libpng-dev libonig-dev libxml2-dev \
    && docker-php-ext-install pdo_mysql mysqli gd \
    && a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

# Copy all project files
COPY . .

# Download Tailwind Standalone Binary
RUN curl -sLo /usr/local/bin/tailwindcss https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-linux-x64 \
    && chmod +x /usr/local/bin/tailwindcss

# Build CSS
RUN tailwindcss -i ./assets/css/tailwind.css -o ./assets/css/style.css --minify

# Permissions
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80

CMD ["apache2-foreground"]
