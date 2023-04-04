FROM node:14.20.0-alpine AS build-step
RUN mkdir -p /app
WORKDIR /app
COPY package.json /app
RUN npm install
COPY . /app
RUN npm run build
#STEP 2 build docker image
FROM nginx:1.20.1
COPY --from=build-step /app/dist /usr/share/nginx/html
EXPOSE 8085:80
