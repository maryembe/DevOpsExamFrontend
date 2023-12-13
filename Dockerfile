# Utiliser l'image Node.js officielle en tant qu'image de base pour la construction
FROM node:16-alpine as build

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers du projet dans le répertoire de travail
COPY . .

# Installer les dépendances
RUN npm install --verbose
# Construire l'application Angular
RUN npm install -g @angular/cli@16.0.2
RUN ng build --configuration production

# Utiliser l'image Nginx officielle en tant qu'image de base pour le déploiement
FROM nginx:alpine

# Copier les fichiers construits depuis l'image de construction vers le répertoire Nginx
COPY --from=build /app/dist/angular-16-crud /usr/share/nginx/html

# Exposer le port 80
EXPOSE 80

# La commande par défaut pour démarrer Nginx est prise en charge par l'image officielle Nginx