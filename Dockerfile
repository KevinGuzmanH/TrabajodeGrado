# Etapa 1: Construcción
FROM node:20 AS build

WORKDIR /app
COPY . .
RUN yarn install
RUN yarn build

# Etapa 2: Servidor Nginx para producción
FROM nginx:alpine
COPY --from=build /app/dist/angular-movie-app-v2 /usr/share/nginx/html

# Copia el archivo de configuración de Nginx
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
