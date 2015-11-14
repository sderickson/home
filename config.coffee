sysPath = require 'path'
_ = require 'lodash'

exports.config =
  paths:
    'public': 'public'
    'watched': ['app', 'vendor']

  conventions:
    ignored: (path) -> _.startsWith(sysPath.basename(path), '_')
    vendor: /(vendor|src|bower_components)[\\/]/

  sourceMaps: true

  files:
    javascripts:
      defaultExtension: 'coffee'
      joinTo:
        'javascripts/app.js': /^app/
        'javascripts/vendor.js': /^(vendor|bower_components)(?![\/\\]underscore[\/\\])/

      order:
        before: [
          'bower_components/jquery/dist/jquery.js'
          'bower_components/lodash/lodash.js'
          'bower_components/backbone/backbone.js'
          'bower_components/bootstrap/dist/js/bootstrap.js'
         ]

    stylesheets:
      defaultExtension: 'sass'
      joinTo:
        'stylesheets/app.css': /^(app|vendor|bower_components|src)/
      order:
        before: [
          'app/styles/bootstrap/*'
        ]

    templates:
      defaultExtension: 'jade'
      joinTo: 'javascripts/app.js'

  framework: 'backbone'

  plugins:
    sass:
      mode: 'ruby'
      allowCache: true
