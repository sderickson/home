class Collection extends Backbone.Collection

  state: 'standby' # or 'fetching'

  fetch: (options) ->
    @state = 'fetching'
    options = app.wrapBackboneRequestCallbacks(options)
    return super(options)


module.exports = Collection
