FROM node:carbon

ENV NPM_CONFIG_LOGLEVEL info
ENV NODE_ENV production

ADD dist /home/node/app/dist
ADD package.json /home/node/app/package.json

ENV MONGODB_URI mongodb://db:27017
ENV JWT_SECRET S8hdjj73DJS8-haf12HA_has9JKDH
ENV SALT_SECRET 10

RUN chown -R node:node /home/node/app 

USER node
WORKDIR /home/node/app
RUN npm install --save

EXPOSE 3000

# CMD node dist/server.js
CMD npm run start
# FROM node:alpine
# WORKDIR /app
# COPY package.json ./
# COPY package-lock.json ./
# COPY ./ ./
# 
# ENV MONGODB_URI mongodb://db:27017
# ENV JWT_SECRET S8hdjj73DJS8-haf12HA_has9JKDH
# ENV SALT_SECRET 10
# 
# RUN npm i
# 
# EXPOSE 3000
# 
# CMD ["npm", "run", "start"]
