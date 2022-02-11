FROM node:alpine
WORKDIR /app
COPY package.json ./
COPY package-lock.json ./
COPY ./ ./

RUN npm update
RUN npm i

ENV NODE_OPTIONS=--openssl-legacy-provider

EXPOSE 5000

CMD ["npm", "run", "start"]
