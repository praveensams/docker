FROM praveensam/node

# Create app directory
WORKDIR /AZVOL/sailapi

# Install app dependencies
COPY package.json /usr/src/app/
#RUN npm install

# Bundle app source
COPY . /usr/src/app

EXPOSE 4001
