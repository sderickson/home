require('./globals').setup()

winston = require 'winston'
morgan = require 'morgan'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'

mongoose = require 'mongoose'
Grid = require 'gridfs-stream'
express = require 'express'
compressible = require 'compressible'
path = require 'path'
useragent = require 'express-useragent'
fs = require 'graceful-fs'
http = require 'http'

config = require './server-config'

module.exports.start = (readyCallback) ->
  return if @server

  #- setup logging
  winston.remove(winston.transports.Console)
  winston.add(winston.transports.Console,
    colorize: true,
    timestamp: true
  )

  #- express creation, config
  app = express()
  app.set 'port', config.port
  app.set 'env', if config.isProduction then 'production' else 'development'
  app.use(express.static(path.join(__dirname, '../public')))
  app.use(express.static(path.join(__dirname, '../bower_components/bootstrap')))
  app.use(morgan('dev'))
  app.use(useragent.express())
  app.use(cookieParser(config.cookie_secret))
  app.use(bodyParser.json())
  app.use(bodyParser.urlencoded({ extended: true }))

  #- passport middlware
  authentication = require('passport')
  app.use(authentication.initialize())
  app.use(authentication.session())

  #- Serve index.html
  app.all '*', (req, res) ->
    mainHTML = fs.readFileSync(path.join(__dirname, '../public', 'index.html'), 'utf8')
    res.status(200).send(mainHTML)

  @server = http.createServer(app).listen app.get('port'), ->
    winston.info('Express server listening on port ' + app.get('port'))
    readyCallback?()


module.exports.close = ->
  @server?.close()
  @server = null