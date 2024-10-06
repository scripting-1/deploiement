# Utiliser une image de base PHP avec Apache
FROM php:8.1-apache

# Installer les extensions PHP nécessaires
RUN docker-php-ext-install pdo pdo_mysql

# Copier Composer à partir de son image officielle
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Définir le répertoire de travail
WORKDIR /var/www/html

# Copier le contenu de votre projet Laravel dans le conteneur
COPY . .

# Installer les dépendances Laravel via Composer
RUN composer install

# Donner les permissions nécessaires pour les répertoires de stockage et de cache
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Exposer le port 80 (port par défaut d'Apache)
EXPOSE 80

# Démarrer Apache
CMD ["apache2-foreground"]
