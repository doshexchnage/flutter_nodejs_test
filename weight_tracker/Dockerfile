FROM node:14

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install
RUN npm install nodemon

COPY . .
COPY client/package*.json ./client
RUN cd client && npm install

CMD ["npm","run","dev"]