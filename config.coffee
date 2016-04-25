exports.config =
  paths:
    'public': 'public'
    'watched': ['app', 'vendor']

  sourceMaps: true

  files:
    javascripts:
      defaultExtension: 'coffee'
      joinTo:
        'app.js': /^app/
        'vendor.js': /^(?!app)/

    stylesheets:
      joinTo: 'app.css'

    templates:
      defaultExtension: 'jade'
      joinTo: 'app.js'

  framework: 'backbone'

  plugins:
    sass:
      mode: 'ruby'
      allowCache: true

    uglify:
      mangle: true

  overrides:
    production:
      optimize: true
