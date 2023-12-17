FROM node:15 AS backend

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY server.js ./
COPY .env ./
COPY like.js ./



EXPOSE 3000

CMD [ "npm", "start" ]