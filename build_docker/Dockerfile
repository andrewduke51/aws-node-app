FROM node:16

# Create app directory
WORKDIR /usr/src/app
COPY app .

RUN npm install
RUN npm test

EXPOSE 8080
CMD [ "node", "index.js" ]