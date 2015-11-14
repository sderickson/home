e = process.env

module.exports = config = {
  port: e.HOME_NODE_PORT or 3080
  isProduction: e.HOME_IS_PRODUCTION or false
  cookie_secret: e.HOME_COOKIE_SECRET or 'chips ahoy'
}
