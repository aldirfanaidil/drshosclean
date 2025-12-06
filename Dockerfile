FROM php:8.1-apache

RUN apt-get update && apt-get install -y \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install pdo_mysql mysqli gd
RUN a2enmod rewrite

WORKDIR /var/www/html

# Copy project dulu sebelum install node modules
COPY . .

# Install Tailwind dependencies
RUN npm install
RUN npm install -D tailwindcss postcss autoprefixer

# Build CSS
RUN npx tailwindcss -i ./assets/css/tailwind.css -o ./assets/css/style.css
# Hapus --watch karena mode build Docker tidak mendukung watch
# RUN npm run build-css
