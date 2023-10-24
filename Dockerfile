# Utiliser une image Node.js plus récente
FROM node:16 as build
WORKDIR /app
COPY package*.json ./
RUN npm install -g @angular/cli
RUN npm install
COPY . .
RUN ng build --configuration=production

# Utiliser une image NGINX pour servir l'application
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 4200
CMD ["nginx", "-g", "daemon off;"]
