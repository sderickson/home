FROM mhart/alpine-node:0.10
MAINTAINER Scott Erickson <sderickson@gmail.com>

WORKDIR /src

COPY package.json package.json
RUN npm install --production
COPY . .

EXPOSE 3080
CMD ["npm", "run", "forever","index.js"]