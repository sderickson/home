e = process.env

module.exports = config = {
  port: e.HOME_NODE_PORT or 3080
  sslPort: e.HOME_SSL_NODE_PORT or 3443
  salt: e.HOME_SALT or 'pepper'
  cookie_secret: e.HOME_COOKIE_SECRET or 'chips ahoy'

  mongo:
    port: e.HOME_MONGO_PORT or 27017
    host: e.HOME_MONGO_HOST or 'localhost'
    db: e.HOME_MONGO_DATABASE_NAME or 'HOME'
    username: e.HOME_MONGO_USERNAME or ''
    password: e.HOME_MONGO_PASSWORD or ''
}

config.isProduction = config.mongo.host isnt 'localhost'
