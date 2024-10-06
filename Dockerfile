# Utiliser une image de base PHP avec Apache
FROM php:8.1-apache

# Installer les extensions PHP nécessaires pour Laravel
RUN docker-php-ext-install pdo pdo_mysql

# Installer Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Définir le répertoire de travail
WORKDIR /var/www/html

# Copier le contenu du projet dans le conteneur
COPY . .

# Installer les dépendances Laravel
RUN composer install

# Donner les permissions nécessaires au répertoire de stockage de Laravel
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Exposer le port 80 pour Apache
EXPOSE 80

# Commande pour démarrer Apache (assurez-vous que Apache utilise le port 80)
CMD ["apache2-foreground"]
