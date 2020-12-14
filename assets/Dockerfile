FROM node:12

#Create the app directory
WORKDIR /usr/src/app

# Install app dependencies
COPY package*.json ./

RUN cat /etc/resolv.conf

RUN npm install

# Bundle source
COPY . .

EXPOSE 3000

CMD [ "node", "index.js" ]