# Étape 1: Build de l'application
FROM node:16 as build
WORKDIR /app
COPY package.json ./
RUN npm install --force
COPY . .
RUN npm run build

# Étape 2: Servir l'application avec NGINX
FROM docker.io/library/nginx:alpine-perl
COPY --from=build /app/dist/ /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
