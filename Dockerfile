# Usa Alpine 3.19.1 come immagine base
FROM alpine:3.19.1
# Setta le variabili d'ambiente
ENV NODE_ENV=production
# Aggiorna il sistema e installa le dipendenze necessarie
RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
    nodejs \
    npm \
    nginx
# Crea la directory di lavoro nel container
WORKDIR /usr/src/app
# Copia i file del progetto nella directory di lavoro
COPY package*.json ./
COPY . .
# Installa le dipendenze del progetto
RUN npm install
# Copia la configurazione di Nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY .htpasswd /etc/nginx/.htpasswd
# Esponi la porta 80 per Nginx
EXPOSE 80
# Avvia Nginx, l'app Node.js e la shell ash
CMD nginx -g 'daemon off;' & node main.js && /bin/ash
