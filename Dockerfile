# Utilise Nginx comme serveur web
FROM nginx:alpine

# Copie tout le contenu de ton projet dans le répertoire web par défaut de Nginx
COPY . /usr/share/nginx/html

# Expose le port 80 pour le serveur web
EXPOSE 80
