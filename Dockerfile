# Etapa 1: Construir la aplicación Angular
FROM node:20 AS build

WORKDIR /app

COPY package.json yarn.lock ./
RUN yarn install

COPY . .
RUN yarn build --prod

# Etapa 2: Servidor Nginx para producción
FROM nginx:alpine

COPY --from=build /app/dist/angular-movie-app-v2 /usr/share/nginx/html

# Copia tu configuración personalizada de Nginx si es necesario
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
