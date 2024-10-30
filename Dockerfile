# Stage 1 - Run-time environment
FROM nginx:1.21.1-alpine

# Copia a pasta build já existente para o Nginx
COPY build/web /usr/share/nginx/html
