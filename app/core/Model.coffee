class Model extends Backbone.Model

  constructor: (attributes, options) ->
    super(attributes, options)
    @on 'add', @onAdded, @
    @on 'invalid', @onInvalid, @

  state: 'standby' # or 'fetching', 'saving'

  created: -> new Date(parseInt(@id.substring(0, 8), 16) * 1000)

  onAdded: -> @state = 'standby'

  schema: ->
    s = @constructor.schema
    if _.isString s then app.ajv.getSchema(s)?.schema else s

  onInvalid: ->
    console.debug "Validation failed for #{@constructor.className or @}: '#{@get('name') or @}'."
    for error in @validationError
      console.debug "\t", error.dataPath, ':', error.message

  set: (attributes, options) ->
    if (@state isnt 'standby') and not (options.xhr or options.headers)
      throw new Error('Cannot set while fetching or saving.')

    return super(attributes, options)

#  getValidationErrors: ->
#    valid = app.ajv.validate(@constructor.schema or {}, @attributes)
#    return app.ajv.errors if not valid
#
#  validate: -> @getValidationErrors()

  save: (attrs, options) ->
    options = app.wrapBackboneRequestCallbacks(options)
    result = super(attrs, options)
    @state = 'saving' if result
    return result

  fetch: (options) ->
    options = app.wrapBackboneRequestCallbacks(options)
    @state = 'fetching'
    return super(options)



module.exports = Model