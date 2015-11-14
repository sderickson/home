FROM mhart/alpine-node:0.10
MAINTAINER Scott Erickson <sderickson@gmail.com>

WORKDIR /src

RUN npm install async@^1.5.0
RUN npm install body-parser@^1.14.1
RUN npm install coffee-script@^1.10.0
RUN npm install connect@^3.4.0
RUN npm install cookie-parser@^1.4.0
RUN npm install express@^4.13.3
RUN npm install express-useragent@^0.2.0
RUN npm install forever@^0.15.1
RUN npm install lodash@^3.10.1
RUN npm install moment@^2.10.6
RUN npm install mongodb@^2.0.48
RUN npm install mongoose@^4.2.5
RUN npm install mongoose-text-search@0.0.2
RUN npm install morgan@^1.6.1
RUN npm install passport@^0.3.2
RUN npm install passport-local@^1.0.0
RUN npm install request@^2.65.0
RUN npm install winston@^2.1.0

COPY package.json package.json
RUN npm install --production
COPY . .

EXPOSE 3080
CMD ["npm", "run", "forever","index.js"]