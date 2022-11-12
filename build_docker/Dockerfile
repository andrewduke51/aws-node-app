FROM node:16

# Create app directory
WORKDIR /usr/src/app
COPY weather-station .

RUN npm install

EXPOSE 8080
CMD [ "node", "index.js" ]